from sqlalchemy import *

engine = create_engine('mysql://dragon:berry@localhost/DragonberryPi',echo=False)
meta = MetaData()
meta.bind = engine
meta.create_all()
tMap = Table('Map', meta, autoload=True)
tTile = Table('Tile', meta, autoload=True)
tPawn = Table('Pawn', meta, autoload=True)
tRole = Table('Role', meta, autoload=True)
tImage = Table('Image', meta, autoload=True)
tLocation = Table('Location', meta, autoload=True)
tSource = Table('Source', meta, autoload=True)
tAdventure = Table('Adventure', meta, autoload=True)
tAdventureMap = Table('AdventureMap', meta, autoload=True)
