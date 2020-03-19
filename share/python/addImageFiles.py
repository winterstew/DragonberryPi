import os,re,sys,subprocess,argparse
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

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="""
This script adds Images and Locations to the database

This script locates the directory tree based on what is 
stored in the Location table.  At least the first two rows in
the table are required.  Where:
 idLocation==1,depth=0,idParent=NULL,name = <full path to the top public directory>
 idLocation==2,depth=1,idParent=1,name = <single directory starting with "/" for images>

Any other subdirectories and files under these two will be automatically added

Image format and size are determined by calling identify from ImageMagick.

An integer reference to the idSource in the Source table can be provided,
as well as an URL for the rule link. 

Any images already entered are skipped.

""")
    parser.add_argument('--ruleLink','-l',action='store',
        help='Image ruleLink  (default is null)')
    parser.add_argument('--idSource','-s', type=int,action='store',
        default=1,
        help='idSource for the images (default 1: unknown source)')
    args = parser.parse_args()
    if (not args.ruleLink): args.ruleLink = null()

    s = text("""
      select n0,n1,n2,n3,n4,n5,l6.name as n6 from (
       select n0,n1,n2,n3,n4,l5.name as n5,l5.idLocation as id5 from (
        select n0,n1,n2,n3,l4.name as n4,l4.idLocation as id4 from (
         select n0,n1,n2,l3.name as n3,l3.idLocation as id3 from (
          select n0,n1,l2.name as n2,l2.idLocation as id2 from (
           select l0.name as n0,l1.name as n1,l1.idLocation as id1 from Location as l0 left join Location as l1 on l0.idLocation = l1.idParent where l0.depth = 0
          ) as l12 left join Location as l2 on id1 = l2.idParent
         ) as l23 left join Location as l3 on id2 = l3.idParent
        ) as l34 left join Location as l4 on id3 = l4.idParent
       ) as l45 left join Location as l5 on id4 = l5.idParent
      ) as l56 left join Location as l6 on id5 = l6.idParent
      """)
    
    mountDir = tLocation.select(tLocation.c.depth==0).execute().fetchone()
    topDirSelect = tLocation.select( and_(tLocation.c.depth==1,tLocation.c.idParent==1))
    
    
    for topDir in topDirSelect.execute():
        if os.path.isdir(mountDir.name+topDir.name):
            #os.path.walk(topDir.name,addImageLocation,"")
            parentId = mountDir.idLocation
            childId = topDir.idLocation
            for root,dirs,files in os.walk(mountDir.name+topDir.name,topdown=True):
                # This section inserts any missing directories
                # and retrieves the current directories id from the database
                topSub = root[len(mountDir.name+topDir.name)+1:]
                depth,split = depthCount(topSub)
                #if depth == 1:
                #    parentId = topDir.idLocation
                if depth > 0:
                    try:
                        (child,finalSplit) = digUp(topDir,split)
                        parentId = child.idParent
                        childId = child.idLocation
                    except NoLocationEntry:
                        parent = sys.exc_value[0]
                        childName = "/%s" % sys.exc_value[1][0]
                        #print "No entry for %s depth=%d and parent=%s" % (childName,depth,parent)
                        parentId = parent.idLocation
                        result = tLocation.insert().values(name=childName,depth=depth+1,idParent=parentId).execute()
                        childId = result.inserted_primary_key[0]
                #print "****",topSub,depth,split,"*",parentId,childId
                # This is where I an insert files
                files.sort()
                for myFile in files:
                    if childId:
                        result = tImage.select(and_(tImage.c.filename==myFile,
                                          tImage.c.idLocation==childId)).execute()
                        if result.rowcount == 0:
                            try:
                                fileIdent = subprocess.check_output(["identify",os.path.join(root,myFile)])[len(os.path.join(root,myFile)):].split()
                                if (re.match('\[[0-9]+\]',fileIdent[0])):
                                    fileIdent.reverse()
                                    fileIdent.pop()
                                    fileIdent.reverse()
                                myType = fileIdent[0];
                                if myType in ["XCF","DGO","JSON","PY"]: raise UnsupportedImageFomart
                                print result.rowcount," ",childId," ",myFile,myType
                                myWidth,myHeight = fileIdent[1].split('x')
                                result = tImage.insert().values(idLocation=childId,
                                                      filename=myFile,
                                                      type=myType,
                                                      width=myWidth,
                                                      height=myHeight,
                                                      ruleLink=args.ruleLink,
                                                      idSource=args.idSource).execute()
                            except UnsupportedImageFomart:
                                pass
                            except subprocess.CalledProcessError:
                                pass
                        else:
                            print result.rowcount," ",result.fetchone().idImage," ",childId," ",myFile
    
    
