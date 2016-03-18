import os,re,sys,subprocess,argparse,tempfile,shutil
from sqlalchemy import *
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.ext.compiler import compiles
from sqlalchemy.schema import DDLElement
from connection import *

def addImageLocation(arg,dirname,fnames):
    print dirname

def depthCount(myDir,myDepth=0,mySplit=[]):
    t,s = os.path.split(myDir)
    if s == '':
        return (myDepth,mySplit)
    else:
        return depthCount(t,myDepth+1,[s] + mySplit)

class NoLocationEntry(Exception):
    pass
class UnsupportedImageFomart(Exception):
    pass

def digUp(myParent,mySplit):
    if len(mySplit) > 0:
        newParents = tLocation.select( and_(
                         tLocation.c.idParent == myParent.idLocation,
                         tLocation.c.name == "/%s" % mySplit[0])).execute()
        #print myParent.idLocation,mySplit[0],newParents.rowcount
        if newParents.rowcount == 0:
            raise NoLocationEntry,(myParent,mySplit)
        if newParents.rowcount > 1:
            raise Exception,"%d is a bad number of rows" % newParents.rowcount
        else:
            return digUp(newParents.fetchone(),mySplit[1:])
    else:
        return (myParent,mySplit)

def getDirName(engine,idLoc,depthLoc):
    sql = text("""
    SELECT n0 as dir0, id0, n1 as dir1, id1
    , CONCAT(n1, n2) as dir2, id2
    , CONCAT(n1, CONCAT(n2,n3)) as dir3, id3
    , CONCAT(n1, CONCAT(n2,CONCAT(n3,n4))) as dir4, id4
    , CONCAT(n1, CONCAT(n2,CONCAT(n3,CONCAT(n4,n5)))) as dir5, id5
    , CONCAT(n1, CONCAT(n2,CONCAT(n3,CONCAT(n4,CONCAT(n5, l6.name))))) as dir6, l6.idLocation as id6 
    FROM ( SELECT n0, id0, n1, id1, n2, id2, n3, id3, n4, id4, l5.name as n5, l5.idLocation as id5 
    FROM ( SELECT n0, id0, n1, id1, n2, id2, n3, id3, l4.name as n4, l4.idLocation as id4 
    FROM ( SELECT n0, id0, n1, id1, n2, id2, l3.name as n3, l3.idLocation as id3 
    FROM ( SELECT n0, id0, n1, id1, l2.name as n2, l2.idLocation as id2 
    FROM ( SELECT l0.name as n0, l0.idLocation as id0, l1.name as n1, l1.idLocation as id1 
    FROM Location as l0 left join Location as l1 ON l0.idLocation = l1.idParent 
    WHERE l0.depth = 0) as l12 
    LEFT JOIN Location as l2 ON id1 = l2.idParent) as l23 
    LEFT JOIN Location as l3 ON id2 = l3.idParent) as l34 
    LEFT JOIN Location as l4 ON id3 = l4.idParent) as l45 
    LEFT JOIN Location as l5 ON id4 = l5.idParent) as l56 
    LEFT JOIN Location as l6 ON id5 = l6.idParent 
    """)
    sql = "%s WHERE id%d = %d" % (sql,depthLoc,idLoc)
    result = engine.execute(sql).fetchone()
    return (result["dir0"],result["dir%d" % depthLoc])
    #return engine.execute(sql)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="""
This script is meant to be run after an adventure is built in the database.  
That is with all the pawnGrid, overviewMap, and illustration Tiles figured out.

Its purpose is to scale down needlessly large images to make client downloads
easier.

It takes any Tile which has its image scaled down by more than 75% and copies 
the record.  The new record will have a scale of > 0.75, a translateX 
and translateY modified to relect the new scale, and it will now point to a 
new Image record pointing to a rescaled image.
""")
    parser.add_argument('--aId','-a',type=int, action='store',
        default=0,
        help='Adventure idAdventure')
    parser.add_argument('--tId','-t',type=int, action='store',
        default=0,
        help='Tile idTile')
    args = parser.parse_args()

    # find all Tiles which have a low scale and are not SVG images
    rTile = tTileImageSourceLocation.select(
                     and_(tTileImageSourceLocation.c.scale < 0.75,
                          tTileImageSourceLocation.c.imageType != "SVG",
                          tTileImageSourceLocation.c.imageType != "svg")).execute()
    # if a specific idTile was given, use this tile use this instead
    if (args.tId > 0):
        rTile = tTileImageSourceLocation.select(tTileImageSourceLocation.c.idTile == args.tId).execute()
    if rTile.rowcount > 0:
        for eTile in rTile.fetchall():
            # only look at overviewMaps and illustrations
            for table in (tAdventureOverviewMap,tAdventureIllustration):
                # get the records from the table which are part of the adventure and have the tile in question
                r = table.select(
                            and_(table.c.idAdventure==args.aId,
                                 table.c.idMap==eTile.idMap)).execute()
                if r.rowcount > 0:
                    e = r.fetchone()
                    #print e['mapName'],eTile['idTile'],eTile['name'],eTile['scale']*eTile['imageWidth'],eTile['scale']*eTile['imageHeight'],eTile['rotate'],getDirName(engine,eTile['idLocation'],eTile['treeDepth'])
                    print "Image %d,'%s' from Tile %d,'%s' Map %d,'%s' has scale %f(%dx%d)" % (
                           eTile['idImage'],eTile['filename'],eTile['idTile'],eTile['name'],
                           e['idMap'],e['mapName'],eTile['scale'],eTile['imageWidth'],eTile['imageHeight']) 
                    top,root = getDirName(engine,eTile['idLocation'],eTile['treeDepth'])
                    if root.startswith(os.sep): root = root[1:]
                    myFile = eTile['filename']
                    myFileBase,myFileExt = os.path.splitext(myFile)
                    tempDescriptor,tempFile = tempfile.mkstemp(suffix=myFileExt)
                    # resize the image 
                    try:
                       convertOut = subprocess.check_output(["convert","-filter","Lanczos","-adaptive-resize","%dx%d" % 
                                                (float(eTile['scale'])*float(eTile['imageWidth']),float(eTile['scale'])*float(eTile['imageHeight'])),
                                                os.path.join( top, root, myFile ),tempFile])
                    except:
                        raise
                    # figure out new image size
                    myWidth,myHeight = (0,0)
                    myType = ''
                    try:
                        fileIdent = subprocess.check_output(["identify",tempFile])[len(tempFile):].split()
                        if (re.match('\[[0-9]+\]',fileIdent[0])):
                            fileIdent.reverse()
                            fileIdent.pop()
                            fileIdent.reverse()
                        myType = fileIdent[0];
                        #if myType == "XCF": raise UnsupportedImageFomart
                        #print result.rowcount," ",childId," ",myFile,myType
                        myWidth,myHeight = fileIdent[1].split('x')
                        #print myWidth,myHeight,float(eTile['scale'])/(float(myWidth)/float(eTile['imageWidth'])/2.0 + float(myHeight)/float(eTile['imageHeight'])/2.0)
                    except:
                        raise
                    newFile = myFileBase + "-%dx%d" % (int(myWidth),int(myHeight)) + myFileExt
                    # search for and existing file with the same name,location,width,height,and type
                    rImage = tImage.select(and_(
                                tImage.c.filename == newFile,
                                tImage.c.type == myType,
                                tImage.c.width == myWidth,
                                tImage.c.height == myHeight)).execute()
                    # if there is a matching rescaled image already get its Id
                    if rImage.rowcount > 0:
                        # find id of smaller image
                        idImage = rImage.fetchone().idImage
                    else:
                        # if not, move the rescaled image to the same directory
                        shutil.copy(tempFile,os.path.join( top, root, newFile ))
                        shutil.copymode(os.path.join( top, root, myFile ),os.path.join( top, root, newFile ))
                        # grab the current image record 
                        bigImage = tImage.select(tImage.c.idImage == eTile['idImage']).execute().fetchone()
                        # insert the new Image record
                        result = tImage.insert().values( idLocation=bigImage['idLocation'],
                                              filename=newFile,
                                              type=bigImage['type'],
                                              width=myWidth,
                                              height=myHeight,
                                              ruleLink=bigImage['ruleLink'],
                                              idSource=bigImage['idSource']).execute()
                        idImage = result.inserted_primary_key[0]
                    print "'%s'(%d) ==>  '%s'(%d)" % (os.path.join( top, root, myFile ),eTile['idImage'],newFile,idImage)
                    # replace image reference in Tile recrod with new image
                    # and the scale with 1.0
                    result = tTile.update().where(tTile.c.idTile==eTile['idTile']).values(
                                              idImage = idImage, scale = 1.0 ).execute()


