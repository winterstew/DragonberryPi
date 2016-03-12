# DragonberryPi

Dynamic RPG adventure map management for table top gaming 
via a Raspberry Pi based server.

* [Backstory](#backstory)
* [Introduction](#introduction)
* [Installation](#installation)
* [Usage](#usage)
* [DatabaseDesign](#database-design)
* [Adventure Prep](#adventure-prep)

## Backstory

Recently my daughter came across my old AD&D books at her grandma's house, and
she got interested in playing.  I thought it would be fun to GM a game for her,
but I wanted to use a newer rule system with lots of published content
available (I do not have as much time to create worlds nowadays).  I decided on
[Pathfinder][] and we started with the beginner box (along with a geeky friend
of mine and his wife who were both willing to join me on this little
midlife-geek-crisis).  As we moved on to the full rule system, I found that
every book was $50 for print, but like $10 for PDF.  As I like the idea of a
table top map and pawns, but not the idea of paying a lot of money for them I
wrote DragonberryPi.

[Pathfinder]: http://paizo.com

## Introduction

DragonberryPi (along with my flat-screen TV laid down on my table) allows me to
use content I purchased without making it available to anybody else.  This is
different than using some sort of remote table-top RPG service.  My intention
is to just replace the map, pawns, and pawn markers in my game.  DragonberryPi
does that with minimal alteration to the rest of the RPG experience.

DragonberryPi installs on a [Raspberry Pi] where it uses the [Apache]2 web
server and MySQL or MariaDB database to display the maps and pawns.  It is a
fully dynamic AJAX web app, which allows the GM to view the full map, PC, NPC,
and monser pawns, while gradually reveling it to the players.  It
simultaneously allows the players to view and control there pawns and move them
where they want.  It is nothing that a good remote table-top service like
[Roll20] cannot do.  It just runs on your own home network where you control
any access to it.

[Raspberry Pi]: https://www.raspberrypi.org/
[Apache]: http://www.apache.org/
[MySQL]: http://www.mysql.com/
[MariaDB]: https://mariadb.org/
[Roll20]: https://roll20.net/
[donjon]: http://donjon.bin.sh/

## Installation

[Install jessie][pi-install] on the Raspberry Pi.

### raspi-config

in a terminal type

    sudo rasi-config

* then in rasi-config do the following:

    * choose *expand filesystem*
    * set you international options based on what you want
    * turn on ssh.  This is useful for access if you want to do your adventure prep from a PC and just copy files over
    * reset your password
    * reboot
    
### Install necessary packages

You will want to make sure everything is up to date and install the packages
DragonberryPi needs

    sudo apt-get update
    sudo apt-get upgrade

Gnome WebKit's Web does not work well for DragonberryPi, better to use
Iceweasel.  Likewise Firefox is the best browser for viewing from a PC.
Mysql-workbench, phpmyadm, and python-sqlalchemy are ways to work with the
database of adventure prep (i.e. adding content).  I do not have custom
browser-apps for that.  I use Gimp for slicing up the map into tiles, but
typically I do it on the PC anyway.
    
    sudo apt-get install iceweasel
    sudo apt-get intstall mariadb-server phpmyadmin mysql-workbench php5 apache2 gimp python-sqlalchemy python-mysqldb imagemagick
    # enter a root password for mariadb
    # point phpmyadmin to use apache
    
### Install DragonberryPi

first clone the code

    git clone https://github.com/winterstew/DragonberryPi
    
then create the user for installing the database.  I like mysql-workbench for
this: 

    mysql-workbench

* with mysql-workbench do the following:

    * open Local instance 3306
    * ignore error
    * Go to Users and Privileges
    *  new Login => `dragon` password `berry` on localhost
    *  Administrative Roles => DBDesigner
    *  Schema Privileges => DragonberryPi: Everything but GRANT

You can also use mysql-workbench to take a look at the database design layout,
if you like.  

    mysql-workbench DragonberryPi/share/mysql/DragonberryPi.mwb
    
Install the database and/or the example dungeon.  If you are using MariaDB on
jesse, you can have higher time resolution on the save states.

    cd DragonberryPi/share/mysql
    # install empty dungeon schema
    mysql -u dragon -p < DragonberryPi.sql
    # install example dungeon schema
    mysql -u dragon -p < ExampleDungeon.sql
    # or to install it with higher timestamp resolution
    sed 's/timestamp/timestamp(3)/' ExampleDungeon.sql | mysql -u dragon -p DragonberryPi
    
Install Apache configuration 

    cd ~/DragonberryPi/share/config
    sudo cp DragonberryPi /etc/apache2/sites-available/DragonberryPi.conf
    sudo a2enmod rewrite
    sudo a2ensite DragonberryPi
    sudo service apache2 reload
    
Try is out with firefox

    http://x.x.x.x/DragonberryPi

[pi-install]: https://www.raspberrypi.org/documentation/installation/installing-images/README.md

## Usage

Of course if you have fully your own content or open content, you can use it on
your own website (assuming you have one and that it supports MySQL and PHP).
Take a look at http://dragonberrypi.winterstew.com/ as an example.

You are first greeted with a scale calibration page.  If you are viewing it on
a laptop for testing or as the GM then the default is probably fine.  However
if you are using it as your playing board, then it is nice for one inch to
actually be one inch.  I lay my TV down on the table, put a clear acrylic
pane over it to protect the screen from scratches and then lay a ruler down
on the grid and adjust the scale to match.

Once you have the scale you want click on either the PC mode or DM mode links
in the green box.  The DM mode link opens a new tab, so what I suggest for this
walk through it to bring up both modes and have both tabs visible on your
desktop so you can see how they work together.  Controls for the various
elements are shown if you mouse over the orange box.

The way I use it is to have my touch-screen laptop open to the DM screen.  With
touching tiles and the keyboard commands, I do not need to use my mouse very
much.  This makes it easier to switch from rolling dice and taking notes to
moving a pawn or turning a tile visible.  

For the players, I have an second Raspberry Pi running Iceweasel to display the
pc version of the map.  It is a bit too much work for my Raspberry Pi2 to serve
up apache and MariaDB while also having graphics and javascript to worry about,
hence the second Pi.  I have it hooked to my TV which is laying flat on the
table, and have a tiny, remote-control-sized wireless keyboard which the
players hand around the table to control their PCs.

## Database Design

![Database Diagram][database]

[database]: share/mysql/DragonberryPi.png "DragonberryPi Database Diagram"

The center of the design is the Map table.  Basically anything on the display
is a Map.   The MapType defines whether it is a grid for the Pawns, an overview
map, or and illustration.  The Display table defines divisions of the browser
within which the Maps are displayed.  The Adventure and AdventureMap tables
define which Maps will be available from which the DM can select.  

Each Map is made up of Tiles which can be individually scaled and positioned
and selectively revealed.  Also on  the Map are Pawns which can be members of a
group as defined by their Role.  The Pawns also have Modifiers which define
their state.  The SVG images which make up these modifiers are stored directly
in the Modifier table.  

Both Tiles and Pawns get their images from the Image table which used the self
referential Location table to define their location on disk.  There is also a
Source table to record who generated the images.

### Display table

Each of the Display records layout a portion of the browser via CSS div
entries.  Additionally some records have special names which define how they
are used.  The pawnGridList, illustrationList, and overviewMapList displays
provide a location for the DM lists of each type of Map to turn on and off.
The modifierSelectors display provides a location for the list of modifiers for
the DM to turn on and off for a selected Pawn.  The pawnStats, pawnStatsUp, and
pawnStatsDown provide a location for the display of a selected Pawns stats for
the players.

### Map table

A Map record is attached to a particular Display via its idDisplay column, and
is linked to a particular Adventure via records in the AdventureMap table.
MapTypes which resolve to the name pawnGrid are moveable via the mouse in the
final rendering.  Also if pixelsPerFoot and feetPerInch are defined, then the
size of the display is decided based on this and the widthInches and
heighInches.  These two will be chosen to match the monitor you use for the
game.  The size of other MapTypes are set based on the Display size and the Map
scale.  If dmVisible is true, then the Map will show up on the DMs list of
available Maps in the various \*List displays.  The visible column is toggled by
the DM interface during game play.

### Tile table

Tile records define the parts of the Map referenced by the idMap column.  In
the case of illustrations or overviewMaps, this may be a single Tile.  In the
case of a pawnGrid, this will likely be many overlapping Tiles defining the
whole dungeon.  A Tile is made up of a single Image referenced by the idImage
column.  The scale and orientation of the Tile is decided by the record, and
the visibility columns determine if the Tile shows up on the PC and/or DM
interface.  The ruleLink column provides a means to reference a URL for any
available rules relating to the Tile (if defined, it overrides the ruleLink
defined by the Image).

### Pawn table

The Pawn table is similar to the Tile table in that they can only be associated
with one Map.  To use the "same" Pawn on multiple maps, just change the record
or make duplicates.  The latter method means that your Pawn Locations are saved
for each Map.  The sizeFeet column works in conjunction with the pawnGrid scale
options to determine the size of the Pawn on the Map.  The selectKey is the
shortcut key used to select the Pawn during game play.  The height,
attackRange, and attackType are dynamically changed by the interface during
game play, and the visibility columns work the same as those for the Tile
records.  The Image which can be defined for a Pawn will be clipped to fit
within the Pawn, and its scale and location are decided my the imageX, imageY,
and imageScale columns.  A Pawn is identified as being part of a group based on
its like to the Role table.  The Modifiers table links a Pawn to a list of SVG
tokens from the Modifier table which mark the status of a Mondifiersparticular
Pawn.

## Adventure Prep

There is a group of [python scripts][share/python] (one of which is a
[Gimp][] plugin.  However, at this time a fair amount of manual record
entry needs to be done to prepare for an adventure.  For this I prefer either
[Mysql Workbench][] or [phpMyAdmin][].  Typically I
use [Putty][] to SSH into the Pi from my laptop and tunnel the MySQL port
(3306), then use workbench on my laptop.  I also typically use [Gimp][] on my
laptop as well and [SCP][WinSCP] the images over to the Pi when they are ready.

[Gimp]: http://www.gimp.us.com
[Mysql Workbench]: https://www.mysql.com/products/workbench/
[Putty]: http://www.putty.org
[phpMyAdmin]: https://www.phpmyadmin.net/
[WinSCP]: https://winscp.net/

For a pawnGrid map I use [Gimp][] to cut an image in to tiles (each on a
separate layer); see [Dangerous
Dungeon.xcf][app/public/images/Dangerous%20Dungeon.xcf] for an example.  Then I
use the plugin [Export Layers][] to save each one as an image.  I transfer
these images (and any others which I want to use as illustrations) to the
``app/public/images`` sub-directories.  

The first record in the Location table defines where this images directory
exists on the Raspberry Pi's file system.  The second record typically will be
``/images``, defining where the images are relative to the application's root
public directory.  Any images and sub-directories created are up to you, they
can all be added to the table with the [addImageFiles][] script.  This will
create both Image records and Location records, however it does need
``imagemagick`` to be installed to determine the image size.  Only images which
do not already have a record will be added (no duplicates).  Running
[addImageFiles][] a second time will give the idImage for each record for use
in the other scripts.

Next for pawnGrid Maps, and assuming the tile layers are all the same size as
the original map image and the pieces have not been used, my plugin
[json_export][] will create a JSON file which can be used as an import for
[addTiles][].  For pawnGrids, a Map record should already exist, and then can
be references by [addTiles].  Other Tiles can be added with
[addIllustrations][], this script can also add its own Map record.  The
[addPawns][] record can be used to add Pawns to a Map with or without images
for the Pawn.  All of the scripts take options including `-h` to get help on
usage.

[Export Layers]: http://registry.gimp.org/node/28268
[addIllustrations]: share/python/addIllustrations.py
[addImageFiles]: share/python/addImageFiles.py
[addPawns]: share/python/addPawns.py
[addTiles]: share/python/addTiles.py
[json_export]: share/python/json_export.py
