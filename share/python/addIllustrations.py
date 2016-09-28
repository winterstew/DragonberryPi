import os,re,sys,subprocess,argparse
from sqlalchemy import *
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.ext.compiler import compiles
from sqlalchemy.schema import DDLElement
from connection import *

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="""
This script adds illustration type maps to and adventure.

All that is necessary is an Adventure idAdventure index and a list of Image
idIndex indices.  This is because all tiles are one Image per Tile, most
illustration type maps are one Tile per Map, and in most cases illustration
type maps can be linked to multiple adventures via AdventureMap entries.

* A new Tile entry will only be created if one does not exist for an image.  
* A new Map entry will only be created if the Tile does not exist on any other
  Map.
* A new AdventureMap entry will be created for the Map if one does not exist
  for the Adventure.

""")
    parser.add_argument('--aId','-a',type=int, action='store',
        default=0,
        help='Adventure idAdventure')
    parser.add_argument('--mDisplay','-w',type=int,action='store',
        default=2,
        help='Map idDisplay (default is 2)')
    parser.add_argument('--mName','-m',action='store',
        help='Map name  (default is to take if from the image name)')
    parser.add_argument('--mRotate','-r',type=float,action='store',
        default=0,
        help='Map rotate  (default is 0)')
    parser.add_argument('--mDepth','-d',type=float,action='store',
        default=1,
        help='Map depth  (default is 1)')
    parser.add_argument('--tName','-t',action='store',
        help='Tile name  (default is to take if from the image name)')
    parser.add_argument('--tScale','-s',type=float,action='store',
        default=1,
        help='Tile scale  (default is 1)')
    parser.add_argument('--tX','-x',type=float,action='store',
        default=0,
        help='Tile translateX  (default is 0)')
    parser.add_argument('--tY','-y',type=float,action='store',
        default=0,
        help='Tile translateY  (default is 0)')
    parser.add_argument('--tLink','-l',action='store',
        help='Tile ruleLink  (default is null)')
    parser.add_argument('idImage', type=int, nargs="+",
        help='Image idImage numbers to be Tiles')
    # parse the command line arguments and options
    args = parser.parse_args()
    if (not args.tLink): args.tLink = null()

    # If we are given a range of idImages use them all
    for i in args.idImage:
        if (type(i) == str and '..' in i):
            st,ed = re.split('\.\.',i)
            c = args.idImage.index(i) + 1
            args.idImage.insert(c,int(ed))
            for r in range(int(st),int(ed)):
                args.idImage.insert(c,r)
                c += 1
            args.idImage.remove(i)

    #print args
    for idImage in args.idImage:
        idImage = int(idImage)
        eImage = None;
        eTile = None;
        eMap = None;
        eAdventure = None;
        eAdventureMap = None;
        #print idImage
        rImage = tImage.select(tImage.c.idImage==idImage).execute()
        # Is there an image with the given Id?  If not, skip the entry.
        if rImage.rowcount == 1:
            eImage = rImage.fetchone()
            # set special default for tName based on Image filename
            tName = args.tName or os.path.splitext(eImage.filename)[0]
            # set special default for mName based on Image filename
            mName = args.mName or os.path.splitext(eImage.filename)[0]
            #print eImage.filename
            rTile = tTile.select(tTile.c.idImage==eImage.idImage).execute()
            # Is there already a Tile for this Image?  If so use it.
            if rTile.rowcount > 0:
                eTile = rTile.fetchone()
                rMap = tMap.select(tMap.c.idMap==eTile.idMap).execute()
                # So there already is a Tile, but does it have a Map?  If so use it.
                if rMap.rowcount > 0:
                    eMap = rMap.fetchone()
            # Is there a Map yet?  If not create it.
            if (not eMap):
                riMap = tMap.insert().values(name=mName,
                                             pixelsPerFoot=null(),
                                             feetPerInch=null(),
                                             widthInches=null(),
                                             heightInches=null(),
                                             rotate=args.mRotate,
                                             scale=1,
                                             translateX=0,
                                             translateY=0,
                                             visible=0,
                                             dmVisible=1,
                                             depth=args.mDepth,
                                             backgroundColor=null(),
                                             idDisplay=args.mDisplay,
                                             idMapType=3).execute()
                newIdMap = riMap.inserted_primary_key[0]
                eMap = tMap.select(tMap.c.idMap==newIdMap).execute().fetchone()
            # Is there a Tile yet?  If not create it.
            if (not eTile):
                riTile = tTile.insert().values(name=tName,
                                               rotate=0,
                                               scale=args.tScale,
                                               translateX=args.tX,
                                               translateY=args.tY,
                                               visible=1,
                                               dmVisible=1,
                                               depth=10,
                                               backgroundColor=null(),
                                               ruleLink=args.tLink,
                                               idImage=eImage.idImage,
                                               idMap=eMap.idMap).execute()
                newIdTile = riTile.inserted_primary_key[0]
                eTile = tTile.select(tTile.c.idTile==newIdTile).execute().fetchone()
            rAdventure = tAdventure.select(tAdventure.c.idAdventure==args.aId).execute()
            # Is there an Adventure that matches the given id?  If so move to link it with AdventureMap
            if rAdventure.rowcount > 0:
              eAdventure = rAdventure.fetchone()
              rAdventureMap = tAdventureMap.select(
                                and_(tAdventureMap.c.idAdventure==eAdventure.idAdventure,
                                     tAdventureMap.c.idMap==eMap.idMap)).execute()
              # Is the Map already linked with the Adventure?  If not add an AdventureMap entry.
              if rAdventureMap.rowcount < 1:
                  riAdventureMap = tAdventureMap.insert().values(idAdventure=args.aId,
                                                                 idMap=eMap.idMap).execute()
                  newIdAdventureMap = riAdventureMap.inserted_primary_key[0]
                  eAdventureMap = tAdventureMap.select(tAdventureMap.c.idAdventureMap==newIdAdventureMap).execute().fetchone()
              else:
                  eAdventureMap = rAdventureMap.fetchone()
        # output the results
        print "`%s`(%d) has Map `%s`(%d) with Tile `%s`(%d) of Image `%s`(%d)" % (
                    eAdventure.name,
                    eAdventure.idAdventure,
                    eMap.name,
                    eMap.idMap,
                    eTile.name,
                    eTile.idTile,
                    eImage.filename,
                    eImage.idImage)

