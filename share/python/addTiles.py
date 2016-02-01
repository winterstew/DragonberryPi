import os,re,sys,subprocess,argparse
from sqlalchemy import *
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.ext.compiler import compiles
from sqlalchemy.schema import DDLElement
from connection import *

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="""
This script adds Tile entries for a list of Image idImage values.  The
resultant tiles are associated with no Map entries 

There is only one Image per Tile, but there often needs to be multiple Tile
entries for a given Image, so that a Tile containing the Image can be
associated with multiple Map entries or multiple places in the same Map.

* A new Tile entry will only be created if one does not exist for an image.  
* the --force,-f option overides this and created new Tile enrties regardless

""")
    parser.add_argument('--force','-f',action='store_true',
        help='force creation of new Tile entries')
    parser.add_argument('--tName','-n',action='store',
        help='Tile name  (default is to take if from the image name)')
    parser.add_argument('--tRotate','-r',type=float,action='store',
        default=0,
        help='Tile rotate  (default is 0)')
    parser.add_argument('--tScale','-s',type=float,action='store',
        default=1,
        help='Tile scale  (default is 1)')
    parser.add_argument('--tX','-x',type=float,action='store',
        help='Tile translateX  (default is 0+10*imageN)')
    parser.add_argument('--tY','-y',type=float,action='store',
        help='Tile translateY  (default is 0+10*imageN)')
    parser.add_argument('--tDepth','-d',type=float,action='store',
        help='Tile depth (default is 10+imageN)')
    parser.add_argument('--tBackColor','-b',action='store',
        help='Tile backgroundColor  (default is null)')
    parser.add_argument('--tLink','-l',action='store',
        help='Tile ruleLink  (default is null)')
    parser.add_argument('--tMap','-m',type=int,action='store',
        help='Tile idMap  (default is null)')
    parser.add_argument('idImage', type=int, nargs="+",
        help='Image idImage numbers to be Tiles')
    # parse the command line arguments and options
    args = parser.parse_args()
    if (not args.tBackColor): args.tBackColor = null()
    if (not args.tLink): args.tLink = null()
    # if an idMap was provided check that it exists and get the name
    if (args.tMap):
        rMap = tMap.select(tMap.c.idMap==args.tMap).execute()
        if rMap.rowcount == 1:
            eMap = rMap.fetchone()
            eMapIdMap = eMap.idMap
        else:
            args.tMap = None
    # if an idMap was not provided or did not exist set the null values
    if (not args.tMap): 
        eMapIdMap = null()
        args.tMap = null()

    eTiles = [];
    #print args
    for idImage in args.idImage:
        eImage = None;
        eTile = None;
        #print idImage
        rImage = tImage.select(tImage.c.idImage==idImage).execute()
        # Is there an image with the given Id?  If not, skip the entry.
        if rImage.rowcount == 1:
            eImage = rImage.fetchone()
            # set special default for tName based on Image filename
            tName = args.tName or os.path.splitext(eImage.filename)[0]
            # set special default for tX based on current Tile count
            tX = args.tX or 0.0+10.0*len(eTiles)
            # set special default for tY based on current Tile count
            tY = args.tY or 0.0+10.0*len(eTiles)
            # set special default for tDepth based on current Tile count
            tDepth = args.tDepth or 10.0+len(eTiles)
            #print eImage.filename
            rTile = tTile.select(tTile.c.idImage==eImage.idImage).execute()
            # Is there already a Tile for this Image?  If so, 
            #  do not make a new one unless the force option is true
            if rTile.rowcount < 1 or args.force:
                riTile = tTile.insert().values(name=tName,
                                               rotate=args.tRotate,
                                               scale=args.tScale,
                                               translateX=tX,
                                               translateY=tY,
                                               visible=0,
                                               dmVisible=1,
                                               depth=tDepth,
                                               backgroundColor=args.tBackColor,
                                               ruleLink=args.tLink,
                                               idImage=eImage.idImage,
                                               idMap=eMapIdMap).execute()
                newIdTile = riTile.inserted_primary_key[0]
                eTile = tTile.select(tTile.c.idTile==newIdTile).execute().fetchone()
            else:
                eTile = rTile.fetchone()
            # append the Tile entry to my running list
            eTiles.append(eTile)
            # get the Map Name if the Map entry exists
            rMap = tMap.select(tMap.c.idMap==eTile.idMap).execute()
            if rMap.rowcount == 1:
                eMap = rMap.fetchone()
                eMapName = eMap.name
            else:
                eMapName = "None"
            # output the results
            print "Map `%s`(%s) has Tile `%s`(%d) of Image `%s`(%d)" % (
                        eMapName,
                        eTile.idMap,
                        eTile.name,
                        eTile.idTile,
                        eImage.filename,
                        eImage.idImage)
