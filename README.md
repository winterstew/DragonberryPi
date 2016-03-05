# DragonberryPi
Dynamic RPG adventure map management for table top gaming 
via a Raspberry Pi based server.

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

Once you have the scale you want click on either the PC mode or DM mode links.
The DM mode link opens a new tab, so what I suggest for this walk through it to
bring up both modes and have both tabs visible on your desktop so you can see
how they work together.

## Installation
``
install jessie on card
sudo rasi-config
expand filesystem
international options
turn on ssh
passwd?

sudo apt-get update
sudo apt-get upgrade
#Gnome WebKit's Web does not work well for DragonberryPi

sudo apt-get install iceweasel
#iceweasel seems to work pretty well

sudo apt-get intstall mariadb-server phpmyadmin mysql-workbench php5 apache2 gimp python-sqlalchemy
# enter a root password for mariadb
# point phpmyadmin to use apache

git clone https://github.com/winterstew/DragonberryPi

mysql-workbench DragonberryPi/share/mysql/DragonberryPi.mwb
# open Local instance 3306
# ignore error
# Go to Users and Privileges
#  new Login => `dragon` password `berry` on localhost
#  Administrative Roles => DBDesigner
#  Schema Privileges => DragonberryPi: Everything but GRANT

cd DragonberryPi/share/mysql
# install empty dungeon schema
mysql -u dragon -p < DragonberryPi.sql
# install example dungeon schema
mysql -u dragon -p < ExampleDungeon.sql
# or to install it with higher timestamp resolution
sed 's/timestamp/timestamp(3)/' ExampleDungeon.sql | mysql -u dragon -p DragonberryPi

cd ~/DragonberryPi/share/config
sudo cp DragonberryPi /etc/apache2/sites-available/DragonberryPi.conf
sudo a2enmod rewrite
# had to edit DragonberryPi.conf for apache 2.4
# Require all granted
# instead of
# Order allow,deny
# Allow from all

Try is out with firefox
http://x.x.x.x/DragonberryPi
sudo a2ensite DragonberryPi
sudo service apache2 reload

mysql -u
``
