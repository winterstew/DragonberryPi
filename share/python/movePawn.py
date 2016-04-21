import os,re,sys,subprocess,argparse
from sqlalchemy import *
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.ext.compiler import compiles
from sqlalchemy.schema import DDLElement
from connection import *

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="""
This script moves a Pawn (a Pawn and the rest in its Role 
group which share the Map) to Map 0, or to the Map given 
with the -m argument
""")
    parser.add_argument('--group','-g',action='store_true',
        help='Move all the members of the Pawn\'s group (i.e. same Role)')
    parser.add_argument('--map','-m',type=int,action='store',
        default=0,
        help='idMap to which to move the Pawn')
    parser.add_argument('--targetPawn','-p',type=int,action='store',
        default=0,
        help='Pawn to use as target location')
    parser.add_argument('idPawn', type=str, 
        help='Pawn "name" or "idPawn"')
    # parse the command line arguments and options
    args = parser.parse_args()

    # select the named or id'd Pawn
    try:
        pVal = int(args.idPawn)
        rPawn = tPawn.select(tPawn.c.idPawn==pVal).execute()
    except ValueError:
        pVal = args.idPawn
        rPawn = tPawn.select(tPawn.c.name==pVal).execute()
    if rPawn.rowcount == 1:
        mainPawn = rPawn.fetchone()
    else: 
        raise "More than one Pawn matches"

    modX = 0
    modY = 0
    if (args.targetPawn > 0):
        pVal = int(args.targetPawn)
        rPawn = tPawn.select(tPawn.c.idPawn==pVal).execute()
        if rPawn.rowcount == 1:
            myTarget = rPawn.fetchone()
            modX = myTarget["translateX"] - mainPawn["translateX"]
            modY = myTarget["translateY"] - mainPawn["translateY"]

    if (args.group):
        result = tPawn.update().where( and_(
                    tPawn.c.idRole==mainPawn['idRole'],
                    tPawn.c.idMap==mainPawn['idMap'])).values(
                    idMap=args.map,
                    translateX=tPawn.c.translateX + modX,
                    translateY=tPawn.c.translateY + modY).execute()
    else:
        result = tPawn.update().where(
             tPawn.c.idPawn==mainPawn['idPawn']).values(
             idMap=args.map,
             translateX=mainPawn["translateX"] + modX,
             translateY=mainPawn["translateY"] + modY).execute()

