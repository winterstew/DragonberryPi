import os,re,sys,subprocess,argparse
from sqlalchemy import *
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.ext.compiler import compiles
from sqlalchemy.schema import DDLElement
from connection import *

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="""
This script adds Pawn entries for a list of Image idImage values.  The
resultant pawns are associated with no Map entries 

There is only one Image per Pawn, but there often needs to be multiple Pawn
entries for a given Image, so that a Pawn containing the Image can be
associated with multiple Map entries or multiple places in the same Map.

* A new Pawn entry will only be created if one does not exist for an image.  
* the --force,-f option overides this and created new Pawn enrties regardless

""")
    parser.add_argument('--force','-f',action='store_true',
        help='force creation of new Pawn entries')
    parser.add_argument('--pName','-n',action='store',
        help='Pawn name  (default is to take if from the image name)')
    parser.add_argument('--pKey','-k',action='store',
        help='Pawn selectKey  (default null)')
    parser.add_argument('--pRotate','-r',type=float,action='store',
        default=0,
        help='Pawn rotate  (default is 0)')
    parser.add_argument('--pSize','-s',type=float,action='store',
        default=5,
        help='Pawn sizeFeet  (default is 5)')
    parser.add_argument('--pX','-x',type=float,action='store',
        help='Pawn translateX  (default is 0+10*imageN)')
    parser.add_argument('--pY','-y',type=float,action='store',
        help='Pawn translateY  (default is 0+10*imageN)')
    parser.add_argument('--pA','-a',type=float,action='store',
        default=0,
        help='Pawn height  (i.e. character altitude, default is 0)')
    parser.add_argument('--pColor','-c',action='store',
        default="#A0A0A0",
        help='Pawn color  (default is #AAAAAAA)')
    parser.add_argument('--pDepth','-d',type=float,action='store',
        default=1,
        help='Pawn depth  (i.e. layer depth, default is 1)')
    parser.add_argument('--pBackColor','-b',action='store',
        default="#FFFFFF",
        help='Pawn backgroundColor  (default is #FFFFFF)')
    parser.add_argument('--pLink','-l',action='store',
        help='Pawn ruleLink  (default is null)')
    parser.add_argument('--pMap','-m',type=int,action='store',
        help='Pawn idMap (default is null)')
    parser.add_argument('--pRole','-o',type=int,action='store',
        default=3,
        help='Pawn idRole (default is 3)')
    parser.add_argument('idImage', type=int, nargs="+",
        help='Image idImage numbers to be Pawns')
    # parse the command line arguments and options
    args = parser.parse_args()
    if (not args.pKey): args.pKey = null()
    if (not args.pLink): args.pLink = null()
    # if an idMap was provided check that it exists and get the name
    if (args.pMap):
        rMap = tMap.select(tMap.c.idMap==args.pMap).execute()
        if rMap.rowcount == 1:
            eMap = rMap.fetchone()
            eMapIdMap = eMap.idMap
            eMapName = eMap.name
        else:
            args.pMap = None
    # if an idMap was not provided or did not exist set the null values
    if (not args.pMap): 
        eMapIdMap = null()
        eMapName = "None"
        args.pMap = null()

    ePawns = [];
    #print args
    for idImage in args.idImage:
        eImage = None;
        ePawn = None;
        #print idImage
        rImage = tImage.select(tImage.c.idImage==idImage).execute()
        # Is there an image with the given Id?  If not, skip the entry.
        if rImage.rowcount == 1:
            eImage = rImage.fetchone()
            # set special default for pName based on Image filename
            pName = args.pName or os.path.splitext(eImage.filename)[0]
            # set special default for pX based on current Pawn count
            pX = args.pX or 0.0+10.0*len(ePawns)
            # set special default for pY based on current Pawn count
            pY = args.pY or 0.0+10.0*len(ePawns)
            #print eImage.filename
            rPawn = tPawn.select(tPawn.c.idImage==eImage.idImage).execute()
            # Is there already a Pawn for this Image?  If so, 
            #  do not make a new one unless the force option is true
            if rPawn.rowcount < 1 or args.force:
                riPawn = tPawn.insert().values(name=pName,
                                               selectKey=args.pKey,
                                               rotate=args.pRotate,
                                               sizeFeet=args.pSize,
                                               translateX=pX,
                                               translateY=pY,
                                               height=args.pA,
                                               color=args.pColor,
                                               visible=0,
                                               dmVisible=1,
                                               depth=args.pDepth,
                                               backgroundColor=args.pBackColor,
                                               ruleLink=args.pLink,
                                               idImage=eImage.idImage,
                                               idMap=eMapIdMap,
                                               idRole=args.pRole).execute()
                newIdPawn = riPawn.inserted_primary_key[0]
                ePawn = tPawn.select(tPawn.c.idPawn==newIdPawn).execute().fetchone()
            else:
                ePawn = rPawn.fetchone()
            # append the Pawn entry to my running list
            ePawns.append(ePawn)
            # get the Map Name if the Map entry exists
            rMap = tMap.select(tMap.c.idMap==ePawn.idMap).execute()
            if rMap.rowcount == 1:
                eMap = rMap.fetchone()
                eMapName = eMap.name
            # get the role Name
            eRoleName = "NONE"
            rRole = tRole.select(tRole.c.idRole==ePawn.idRole).execute()
            if rRole.rowcount == 1:
                eRole = rRole.fetchone()
                eRoleName = eRole.name
            # output the results
            print "Map `%s`(%s) has Pawn `%s`(%d) of Image `%s`(%d) as `%s`(%d)" % (
                        eMapName,
                        ePawn.idMap,
                        ePawn.name,
                        ePawn.idPawn,
                        eImage.filename,
                        eImage.idImage,
                        eRoleName,
                        ePawn.idRole)
