-- MySQL dump 10.15  Distrib 10.0.29-MariaDB, for debian-linux-gnueabihf (armv7l)
--
-- Host: DragonberryPi    Database: DragonberryPi
-- ------------------------------------------------------
-- Server version	10.0.29-MariaDB-0+deb8u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Adventure`
--

DROP TABLE IF EXISTS `Adventure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Adventure` (
  `idAdventure` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(320) DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`idAdventure`),
  KEY `updated` (`updated`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Adventure`
--

LOCK TABLES `Adventure` WRITE;
/*!40000 ALTER TABLE `Adventure` DISABLE KEYS */;
INSERT INTO `Adventure` (`idAdventure`, `name`, `description`, `updated`, `updatedBy`) VALUES (1,'Dangerous Dungeon','Example Dungeon','2016-01-31 18:22:55',NULL);
/*!40000 ALTER TABLE `Adventure` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `AdventureIllustration`
--

DROP TABLE IF EXISTS `AdventureIllustration`;
/*!50001 DROP VIEW IF EXISTS `AdventureIllustration`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `AdventureIllustration` (
  `idAdventure` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `idMap` tinyint NOT NULL,
  `mapName` tinyint NOT NULL,
  `pixelsPerFoot` tinyint NOT NULL,
  `feetPerInch` tinyint NOT NULL,
  `widthInches` tinyint NOT NULL,
  `heightInches` tinyint NOT NULL,
  `rotate` tinyint NOT NULL,
  `scale` tinyint NOT NULL,
  `scaleY` tinyint NOT NULL,
  `translateX` tinyint NOT NULL,
  `translateY` tinyint NOT NULL,
  `visible` tinyint NOT NULL,
  `dmVisible` tinyint NOT NULL,
  `showName` tinyint NOT NULL,
  `dmShowName` tinyint NOT NULL,
  `depth` tinyint NOT NULL,
  `backgroundColor` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `AdventureMap`
--

DROP TABLE IF EXISTS `AdventureMap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `AdventureMap` (
  `idAdventureMap` smallint(6) NOT NULL AUTO_INCREMENT,
  `idAdventure` smallint(6) NOT NULL,
  `idMap` smallint(6) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`idAdventureMap`),
  KEY `idAdventure` (`idAdventure`),
  KEY `idMap` (`idMap`),
  KEY `updated` (`updated`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Linking table between adventures and maps.\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `AdventureMap`
--

LOCK TABLES `AdventureMap` WRITE;
/*!40000 ALTER TABLE `AdventureMap` DISABLE KEYS */;
INSERT INTO `AdventureMap` (`idAdventureMap`, `idAdventure`, `idMap`, `updated`, `updatedBy`) VALUES (1,1,1,'2016-01-31 18:24:46',NULL),(2,1,2,'2016-01-31 18:24:46',NULL),(3,1,3,'2016-02-05 20:04:01',NULL),(4,1,4,'2016-02-05 20:04:01',NULL),(5,1,5,'2016-03-12 15:51:50',NULL);
/*!40000 ALTER TABLE `AdventureMap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `AdventureOverviewMap`
--

DROP TABLE IF EXISTS `AdventureOverviewMap`;
/*!50001 DROP VIEW IF EXISTS `AdventureOverviewMap`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `AdventureOverviewMap` (
  `idAdventure` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `idMap` tinyint NOT NULL,
  `mapName` tinyint NOT NULL,
  `pixelsPerFoot` tinyint NOT NULL,
  `feetPerInch` tinyint NOT NULL,
  `widthInches` tinyint NOT NULL,
  `heightInches` tinyint NOT NULL,
  `rotate` tinyint NOT NULL,
  `scale` tinyint NOT NULL,
  `scaleY` tinyint NOT NULL,
  `translateX` tinyint NOT NULL,
  `translateY` tinyint NOT NULL,
  `visible` tinyint NOT NULL,
  `dmVisible` tinyint NOT NULL,
  `showName` tinyint NOT NULL,
  `dmShowName` tinyint NOT NULL,
  `depth` tinyint NOT NULL,
  `backgroundColor` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `AdventurePawnGrid`
--

DROP TABLE IF EXISTS `AdventurePawnGrid`;
/*!50001 DROP VIEW IF EXISTS `AdventurePawnGrid`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `AdventurePawnGrid` (
  `idAdventure` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `description` tinyint NOT NULL,
  `idMap` tinyint NOT NULL,
  `mapName` tinyint NOT NULL,
  `pixelsPerFoot` tinyint NOT NULL,
  `feetPerInch` tinyint NOT NULL,
  `widthInches` tinyint NOT NULL,
  `heightInches` tinyint NOT NULL,
  `rotate` tinyint NOT NULL,
  `scale` tinyint NOT NULL,
  `scaleY` tinyint NOT NULL,
  `translateX` tinyint NOT NULL,
  `translateY` tinyint NOT NULL,
  `visible` tinyint NOT NULL,
  `dmVisible` tinyint NOT NULL,
  `showName` tinyint NOT NULL,
  `dmShowName` tinyint NOT NULL,
  `depth` tinyint NOT NULL,
  `backgroundColor` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `AllAdventureMap`
--

DROP TABLE IF EXISTS `AllAdventureMap`;
/*!50001 DROP VIEW IF EXISTS `AllAdventureMap`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `AllAdventureMap` (
  `idAdventure` tinyint NOT NULL,
  `adventureName` tinyint NOT NULL,
  `adventureDescription` tinyint NOT NULL,
  `idMap` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `pixelsPerFoot` tinyint NOT NULL,
  `feetPerInch` tinyint NOT NULL,
  `widthInches` tinyint NOT NULL,
  `heightInches` tinyint NOT NULL,
  `rotate` tinyint NOT NULL,
  `scale` tinyint NOT NULL,
  `scaleY` tinyint NOT NULL,
  `translateX` tinyint NOT NULL,
  `translateY` tinyint NOT NULL,
  `visible` tinyint NOT NULL,
  `dmVisible` tinyint NOT NULL,
  `showName` tinyint NOT NULL,
  `dmShowName` tinyint NOT NULL,
  `depth` tinyint NOT NULL,
  `backgroundColor` tinyint NOT NULL,
  `idDisplay` tinyint NOT NULL,
  `idMapType` tinyint NOT NULL,
  `updated` tinyint NOT NULL,
  `updatedBy` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Display`
--

DROP TABLE IF EXISTS `Display`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Display` (
  `idDisplay` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `position` varchar(45) DEFAULT 'fixed',
  `width` varchar(45) DEFAULT '100%',
  `height` varchar(45) DEFAULT '100%',
  `top` varchar(45) DEFAULT NULL,
  `bottom` varchar(45) DEFAULT NULL,
  `left` varchar(45) DEFAULT NULL,
  `right` varchar(45) DEFAULT NULL,
  `transform` varchar(45) DEFAULT NULL,
  `backgroundColor` varchar(45) DEFAULT 'white',
  `depth` double NOT NULL DEFAULT '1',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`idDisplay`),
  KEY `updated` (`updated`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='The Display will be a portion of the browser as a <DIV> element.\nThe properties will be defined as part of a CSS style sheet.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Display`
--

LOCK TABLES `Display` WRITE;
/*!40000 ALTER TABLE `Display` DISABLE KEYS */;
INSERT INTO `Display` (`idDisplay`, `name`, `position`, `width`, `height`, `top`, `bottom`, `left`, `right`, `transform`, `backgroundColor`, `depth`, `updated`, `updatedBy`) VALUES (1,'Main Map','fixed','90%','100%','0',NULL,'10%',NULL,NULL,NULL,10,'2016-02-07 10:36:19',NULL),(2,'TL Inset','fixed','200px','200px','0',NULL,'0',NULL,NULL,NULL,1,'2016-02-05 20:28:21',NULL),(3,'BL Inset','fixed','200px','200px',NULL,'0','0',NULL,NULL,NULL,1,'2016-02-05 20:28:21',NULL),(4,'CL Inset','fixed','300px','300px','50%',NULL,'0',NULL,'translateY(-50%)',NULL,2,'2016-02-05 20:28:21',NULL),(5,'pawnGridList','fixed','140px','5%','0',NULL,NULL,'60px',NULL,NULL,6,'2016-03-02 01:00:08',NULL),(6,'illustrationList','fixed','140px','80%','5%',NULL,NULL,'60px',NULL,NULL,5,'2016-03-02 01:00:08',NULL),(7,'overviewMapList','fixed','140px','15%','85%','0',NULL,'60px',NULL,NULL,4,'2016-03-02 01:00:08',NULL),(8,'modifierSelectors','fixed','60px','100%','0',NULL,NULL,'0',NULL,NULL,3,'2016-03-02 00:40:02',NULL),(9,'pawnStatsDown','fixed','70%','30px',NULL,'15px','20%',NULL,NULL,'rgba(211, 211, 211, 0.5)',8,'2016-02-09 00:01:26',NULL),(10,'pawnStatsUp','fixed','70%','30px','15px',NULL,'20%',NULL,NULL,'rgba(211, 211, 211, 0.5)',8,'2016-02-09 00:01:26',NULL);
/*!40000 ALTER TABLE `Display` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Image`
--

DROP TABLE IF EXISTS `Image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Image` (
  `idImage` smallint(6) NOT NULL AUTO_INCREMENT,
  `idLocation` smallint(6) NOT NULL,
  `filename` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL DEFAULT 'PNG',
  `width` smallint(6) NOT NULL DEFAULT '0',
  `height` smallint(6) NOT NULL DEFAULT '0',
  `ruleLink` tinytext COMMENT 'URL to any rules information related to the image',
  `idSource` smallint(6) NOT NULL DEFAULT '1',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`idImage`),
  KEY `idLocation` (`idLocation`),
  KEY `idSource` (`idSource`),
  KEY `updated` (`updated`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='Location of image files on disk.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Image`
--

LOCK TABLES `Image` WRITE;
/*!40000 ALTER TABLE `Image` DISABLE KEYS */;
INSERT INTO `Image` (`idImage`, `idLocation`, `filename`, `type`, `width`, `height`, `ruleLink`, `idSource`, `updated`, `updatedBy`) VALUES (1,2,'blank.png','PNG',570,700,NULL,1,'2016-01-31 15:46:40',NULL),(2,4,'overview.jpg','JPEG',600,350,'http://donjon.bin.sh/code/world/',2,'2016-01-31 18:20:00',NULL),(3,5,'Corridor 1.png','PNG',223,306,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:19',NULL),(4,5,'Corridor 2a.png','PNG',530,114,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:19',NULL),(5,5,'Corridor 2b.png','PNG',132,296,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:19',NULL),(6,5,'Corridor 2c.png','PNG',501,101,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:19',NULL),(7,5,'Corridor 2d.png','PNG',490,99,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:19',NULL),(8,5,'Corridor 2e.png','PNG',94,189,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:19',NULL),(9,5,'Corridor 3a.png','PNG',118,300,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:19',NULL),(10,5,'Corridor 3b.png','PNG',200,150,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(11,5,'Corridor 4.png','PNG',106,190,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(12,5,'Corridor 5a.png','PNG',107,513,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(13,5,'Corridor 5b.png','PNG',413,114,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(14,5,'Corridor 5c.png','PNG',115,205,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(15,5,'Corridor 5d.png','PNG',107,202,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(16,5,'Corridor 6a.png','PNG',219,107,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(17,5,'Corridor 6b.png','PNG',95,407,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(18,5,'Dangerous Dungeon.png','PNG',1151,1451,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(19,5,'Entry.png','PNG',625,125,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(20,5,'Locked Door 1.png','PNG',101,103,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(21,5,'Room 1.png','PNG',531,228,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(22,5,'Room 2.png','PNG',309,298,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(23,5,'Room 3.png','PNG',598,302,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(24,5,'Room 4.png','PNG',210,201,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(25,5,'Room 5.png','PNG',410,498,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(26,5,'Room 6.png','PNG',211,402,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(27,5,'Secret Door 1.png','PNG',114,107,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(28,5,'Stair Down.png','PNG',491,108,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:20',NULL),(29,5,'Stair Up.png','PNG',118,197,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-02-05 06:17:30',NULL),(30,5,'Trapped Door 1.png','PNG',104,106,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:21',NULL),(31,5,'Trapped Door 2.png','PNG',93,98,'http://donjon.bin.sh/fantasy/dungeon/',2,'2016-01-31 18:19:21',NULL),(32,3,'bullrog_ogre_street_mage_by_xaarex.png','PNG',1006,659,'http://xaarex.deviantart.com/art/Bullrog-Ogre-Street-Mage-397799952',6,'2016-03-12 15:36:57',NULL),(33,3,'orc_render_wip_2_2_by_whitekidz-d8ospmi.jpg','JPEG',627,837,'http://whitekidz.deviantart.com/art/Orc-Render-Wip-2-2-525379770',5,'2016-03-12 15:36:57',NULL),(34,3,'orc_warrior_by_puppeli.png','PNG',492,694,'http://puppeli.deviantart.com/art/orc-warrior-58162296',4,'2016-03-12 15:36:57',NULL),(35,3,'ogre.png','PNG',244,242,NULL,1,'2016-03-12 16:11:13',NULL),(36,2,'B.png','PNG',570,700,NULL,1,'2016-03-12 16:23:58',NULL),(37,2,'F.png','PNG',570,700,NULL,1,'2016-03-12 16:23:59',NULL),(38,2,'G.png','PNG',570,700,NULL,1,'2016-03-12 16:24:00',NULL),(39,3,'goblin.png','PNG',580,596,NULL,1,'2016-03-12 18:47:53',NULL);
/*!40000 ALTER TABLE `Image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Location`
--

DROP TABLE IF EXISTS `Location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Location` (
  `idLocation` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` tinyblob NOT NULL,
  `depth` tinyint(4) NOT NULL DEFAULT '0',
  `idParent` smallint(6) DEFAULT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`idLocation`),
  KEY `idParent` (`idParent`),
  KEY `updated` (`updated`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='Directory Location';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Location`
--

LOCK TABLES `Location` WRITE;
/*!40000 ALTER TABLE `Location` DISABLE KEYS */;
INSERT INTO `Location` (`idLocation`, `name`, `depth`, `idParent`, `updated`, `updatedBy`) VALUES (1,'/home/pi/DragonberryPi/app/public',0,NULL,'2016-01-31 15:44:55',NULL),(2,'/images',1,1,'2016-01-31 15:44:55',NULL),(3,'/Monsters',2,2,'2016-01-31 18:19:19',NULL),(4,'/Illustrations',2,2,'2016-01-31 18:19:19',NULL),(5,'/Map Tiles',2,2,'2016-01-31 18:19:19',NULL);
/*!40000 ALTER TABLE `Location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Map`
--

DROP TABLE IF EXISTS `Map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Map` (
  `idMap` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `pixelsPerFoot` double DEFAULT '10' COMMENT 'pixels per map square before scaling\n',
  `feetPerInch` double DEFAULT '5',
  `widthInches` double DEFAULT '10',
  `heightInches` double DEFAULT '10',
  `rotate` double NOT NULL DEFAULT '0',
  `scale` double NOT NULL DEFAULT '1',
  `scaleY` double DEFAULT NULL,
  `translateX` double NOT NULL DEFAULT '0',
  `translateY` double NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `dmVisible` tinyint(1) NOT NULL DEFAULT '1',
  `showName` tinyint(1) NOT NULL DEFAULT '0',
  `dmShowName` tinyint(1) NOT NULL DEFAULT '1',
  `depth` double NOT NULL DEFAULT '1',
  `backgroundColor` varchar(45) DEFAULT NULL,
  `idDisplay` smallint(6) DEFAULT NULL,
  `idMapType` smallint(6) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`idMap`),
  KEY `idDisplay` (`idDisplay`),
  KEY `idMapType` (`idMapType`),
  KEY `updated` (`updated`),
  KEY `dmVisible` (`dmVisible`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='define a map made up of tiles.  Every Map will be layed out in squares index by letter and number where A,0 is the upper left (before rotation).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Map`
--

LOCK TABLES `Map` WRITE;
/*!40000 ALTER TABLE `Map` DISABLE KEYS */;
INSERT INTO `Map` (`idMap`, `name`, `pixelsPerFoot`, `feetPerInch`, `widthInches`, `heightInches`, `rotate`, `scale`, `scaleY`, `translateX`, `translateY`, `visible`, `dmVisible`, `showName`, `dmShowName`, `depth`, `backgroundColor`, `idDisplay`, `idMapType`, `updated`, `updatedBy`) VALUES (1,'Deadly Dungeon',10,5,32,20,-90,1,NULL,0,0,1,1,0,1,5,NULL,1,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(2,'Port View',NULL,NULL,NULL,NULL,-90,1,NULL,0,0,1,1,0,1,2,NULL,4,2,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(3,'goblin',NULL,NULL,NULL,NULL,0,1,NULL,0,0,0,0,0,1,1,NULL,2,3,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(4,'Ogre',NULL,NULL,NULL,NULL,-90,1,NULL,0,0,0,1,0,1,1,NULL,3,3,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(5,'Orc',NULL,NULL,NULL,NULL,-90,1,NULL,0,0,0,1,0,1,1,NULL,2,3,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36');
/*!40000 ALTER TABLE `Map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `MapDmVisibleOnDisplay`
--

DROP TABLE IF EXISTS `MapDmVisibleOnDisplay`;
/*!50001 DROP VIEW IF EXISTS `MapDmVisibleOnDisplay`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `MapDmVisibleOnDisplay` (
  `idDisplay` tinyint NOT NULL,
  `dName` tinyint NOT NULL,
  `dPos` tinyint NOT NULL,
  `dWidth` tinyint NOT NULL,
  `dHeight` tinyint NOT NULL,
  `dTop` tinyint NOT NULL,
  `dBot` tinyint NOT NULL,
  `dLeft` tinyint NOT NULL,
  `dRight` tinyint NOT NULL,
  `dBackC` tinyint NOT NULL,
  `dDepth` tinyint NOT NULL,
  `idAdventure` tinyint NOT NULL,
  `adventureName` tinyint NOT NULL,
  `idMap` tinyint NOT NULL,
  `mName` tinyint NOT NULL,
  `mPPF` tinyint NOT NULL,
  `mFPI` tinyint NOT NULL,
  `mWidth` tinyint NOT NULL,
  `mHeight` tinyint NOT NULL,
  `mRot` tinyint NOT NULL,
  `mScale` tinyint NOT NULL,
  `mScaleY` tinyint NOT NULL,
  `mX` tinyint NOT NULL,
  `mY` tinyint NOT NULL,
  `mVis` tinyint NOT NULL,
  `mDmVis` tinyint NOT NULL,
  `mSName` tinyint NOT NULL,
  `mDmSName` tinyint NOT NULL,
  `mDepth` tinyint NOT NULL,
  `mBackC` tinyint NOT NULL,
  `idMapType` tinyint NOT NULL,
  `mtName` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `MapMapType`
--

DROP TABLE IF EXISTS `MapMapType`;
/*!50001 DROP VIEW IF EXISTS `MapMapType`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `MapMapType` (
  `idAdventure` tinyint NOT NULL,
  `adventureName` tinyint NOT NULL,
  `idMap` tinyint NOT NULL,
  `mapName` tinyint NOT NULL,
  `pixelsPerFoot` tinyint NOT NULL,
  `feetPerInch` tinyint NOT NULL,
  `widthInches` tinyint NOT NULL,
  `heightInches` tinyint NOT NULL,
  `rotate` tinyint NOT NULL,
  `scale` tinyint NOT NULL,
  `scaleY` tinyint NOT NULL,
  `translateX` tinyint NOT NULL,
  `translateY` tinyint NOT NULL,
  `visible` tinyint NOT NULL,
  `dmVisible` tinyint NOT NULL,
  `showName` tinyint NOT NULL,
  `dmShowName` tinyint NOT NULL,
  `depth` tinyint NOT NULL,
  `backgroundColor` tinyint NOT NULL,
  `idDisplay` tinyint NOT NULL,
  `updated` tinyint NOT NULL,
  `updatedBy` tinyint NOT NULL,
  `mapType` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `MapPointer`
--

DROP TABLE IF EXISTS `MapPointer`;
/*!50001 DROP VIEW IF EXISTS `MapPointer`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `MapPointer` (
  `idPointers` tinyint NOT NULL,
  `rotate` tinyint NOT NULL,
  `scale` tinyint NOT NULL,
  `translateX` tinyint NOT NULL,
  `translateY` tinyint NOT NULL,
  `visible` tinyint NOT NULL,
  `idMap` tinyint NOT NULL,
  `updated` tinyint NOT NULL,
  `updatedBy` tinyint NOT NULL,
  `idPointer` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `selectKey` tinyint NOT NULL,
  `shapeSvg` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `MapType`
--

DROP TABLE IF EXISTS `MapType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MapType` (
  `idMapType` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` char(16) NOT NULL,
  `description` text,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`idMapType`),
  KEY `mapTypeName` (`name`),
  KEY `updated` (`updated`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='Type of "Map", is it a PawnGrid, an OverviewMap, or a Headshot';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MapType`
--

LOCK TABLES `MapType` WRITE;
/*!40000 ALTER TABLE `MapType` DISABLE KEYS */;
INSERT INTO `MapType` (`idMapType`, `name`, `description`, `updated`, `updatedBy`) VALUES (1,'pawnGrid','Grid for pawn movement encounters','2016-01-31 15:44:55',NULL),(2,'overviewMap','Overview map of region','2016-01-31 15:44:55',NULL),(3,'illustration','NPC or monster head shot or picture','2016-01-31 15:44:55',NULL);
/*!40000 ALTER TABLE `MapType` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Modifier`
--

DROP TABLE IF EXISTS `Modifier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Modifier` (
  `idModifier` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `shapeSvg` blob NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`idModifier`),
  KEY `updated` (`updated`)
) ENGINE=MyISAM AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Modifier`
--

LOCK TABLES `Modifier` WRITE;
/*!40000 ALTER TABLE `Modifier` DISABLE KEYS */;
INSERT INTO `Modifier` (`idModifier`, `name`, `shapeSvg`, `updated`, `updatedBy`) VALUES (1,'bleed','    <g\n       id=\"bleed\"\n       transform=\"matrix(2,0,0,2,-558.83275,-340.72075)\">\n      <path\n         style=\"fill:url(#radialGradient4150);fill-opacity:1;stroke:#740000;stroke-width:2px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n         d=\"m 524.83275,285.57432 c 0,0 -40,40 -40,80 0,40 80,40 80,0 0,-40 -40,-80 -40,-80\"\n         id=\"path3370\"\n         inkscape:connector-curvature=\"0\"\n         sodipodi:nodetypes=\"czzc\">\n        <title\n           id=\"title4319\">bleed</title>\n      </path>\n    </g>\n','2016-01-25 20:16:00',NULL),(2,'blinded','    <g\n       id=\"blinded\"\n       transform=\"matrix(4,0,0,4,-1610.083,-2004.7308)\">\n      <title\n         id=\"title4321\">blinded</title>\n      <path\n         sodipodi:nodetypes=\"czczc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4152\"\n         d=\"m 485.10163,609.99973 c 0,0 10,-20 30,-20 20,0 30,20 30,20 0,0 -10,20 -30,20 -20,0 -30,-20 -30,-20 z\"\n         style=\"fill:url(#radialGradient4184);fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <circle\n         id=\"path4154\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:url(#radialGradient4186);fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"515.10162\"\n         cy=\"609.99976\"\n         r=\"18.101557\" />\n    </g>\n','2016-01-25 20:16:00',NULL),(3,'confused','    <g\n       transform=\"matrix(4,0,0,4,-1961.0631,-1901.7314)\"\n       id=\"confused\">\n      <title\n         id=\"title4333\">confused</title>\n      <circle\n         transform=\"matrix(0.8333329,0,0,0.8333329,82.517151,91.66689)\"\n         id=\"path4190-34\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffff00;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.33333342,0,0,0.33333248,333.00707,404.66702)\"\n         id=\"path4190-3-0\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.11666677,0,0,0.11666653,442.57198,538.89384)\"\n         id=\"path4190-3-3-9\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:6.00000668;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.33333342,0,0,0.33333248,357.42127,404.66702)\"\n         id=\"path4190-3-4-4\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <path\n         sodipodi:nodetypes=\"czzzzzzzcc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4253-2\"\n         d=\"m 540.10163,629.99973 c 0,0 -2.64298,5 -5,5 -2.35702,0 -2.64298,-5 -5,-5 -2.35702,0 -2.64298,5 -5,5 -2.35702,0 -2.64298,-5 -5,-5 -2.35702,0 -2.64298,5 -5,5 -2.35702,0 -2.64298,-5 -5,-5 -2.35702,0 -2.64298,5 -5,5 -2.35702,0 -5,-5 -5,-5 l 0,0\"\n         style=\"fill:none;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <circle\n         transform=\"matrix(0.11666677,0,0,0.11666653,475.55281,546.95449)\"\n         id=\"path4190-3-3-7-8\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:6.00000668;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n    </g>','2016-01-25 20:16:00',NULL),(4,'cowering','    <g transform=\"matrix(3.9662114,0.51881304,-0.51881304,3.9662114,647.86642,-3510.3926)\"\n       id=\"cowering\">\n      <title\n         id=\"title10430\">cowering</title>\n      <circle\n         transform=\"matrix(0.65553693,-0.08574961,0.08574961,0.65553693,-371.91066,661.2527)\"\n         id=\"path4190-34-6-4-3\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffff00;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.26221497,-0.03429987,0.03429978,0.26221424,-142.6565,881.69729)\"\n         id=\"path4190-3-0-8-9-0\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.26221497,-0.03429987,0.03429978,0.26221424,-123.4512,879.18507)\"\n         id=\"path4190-3-4-4-2-7-9\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.1677853,-0.02194768,0.02194762,0.16778494,-85.298922,935.57444)\"\n         id=\"path4190-3-3-7-8-3-5-16-2\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#000000;fill-opacity:1;stroke:none;stroke-width:6.00000668;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <path\n         inkscape:connector-curvature=\"0\"\n         id=\"path4460-5-3\"\n         d=\"m 28.192539,1041.3828 c -4.592586,0.5768 -9.011767,2.3857 -13.21349,5.4789 l 27.546578,-3.6033 c -4.9605,-1.799 -9.740502,-2.4523 -14.333088,-1.8756 z\"\n         style=\"fill:#860907;fill-opacity:1;stroke:#000000;stroke-width:0.79334623px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <circle\n         transform=\"matrix(0.1677853,-0.02194768,0.02194762,0.16778494,-65.818433,933.02622)\"\n         id=\"path4190-3-3-7-8-3-5-8-5\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#000000;fill-opacity:1;stroke:none;stroke-width:6.00000668;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <g\n         transform=\"matrix(0.84583986,-0.53343691,0.53343691,0.84583986,-507.37149,165.66535)\"\n         id=\"g10364\">\n        <path\n           style=\"fill:none;stroke:#af8949;stroke-width:5;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n           d=\"m -2.8073012,1019.3989 1.2970326,9.9155\"\n           id=\"path10288\"\n           inkscape:connector-curvature=\"0\" />\n        <path\n           style=\"fill:none;stroke:#af8949;stroke-width:5;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n           d=\"m 2.5638892,1019.9599 1.297032,9.9155\"\n           id=\"path10288-5\"\n           inkscape:connector-curvature=\"0\" />\n        <path\n           style=\"fill:none;stroke:#af8949;stroke-width:5;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n           d=\"m -8.063058,1021.0155 1.2970323,9.9155\"\n           id=\"path10288-5-2\"\n           inkscape:connector-curvature=\"0\" />\n        <path\n           style=\"fill:none;stroke:#af8949;stroke-width:4;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n           d=\"m -12.848893,1024.6792 1.985539,9.8007\"\n           id=\"path10288-5-2-3\"\n           inkscape:connector-curvature=\"0\" />\n        <path\n           style=\"fill:none;stroke:#af8949;stroke-width:5;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n           d=\"m 11.061265,1032.9021 -6.0942031,7.9285\"\n           id=\"path10288-5-3\"\n           inkscape:connector-curvature=\"0\" />\n        <path\n           style=\"fill:#a78548;fill-opacity:1;stroke:none\"\n           d=\"m 5.9128989,1030.5701 c 0,0 1.6987157,9.7731 -0.300192,12.6973 -1.9989093,2.9243 -5.3196225,3.1474 -7.8926786,3.2925 -2.5730561,0.1451 -4.5845417,-0.039 -6.6369916,-1.9267 -2.0524497,-1.8873 -3.5168247,-9.1672 -3.5168247,-9.1672 l 5.2185328,-5.7637 5.9180791,-0.4158 z\"\n           id=\"path10362\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"czzzcccc\" />\n      </g>\n      <g\n         transform=\"matrix(-0.94137607,-0.33735902,-0.33735902,0.94137607,359.65735,71.534639)\"\n         id=\"g10364-2\">\n        <path\n           style=\"fill:none;stroke:#af8949;stroke-width:5;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n           d=\"m -2.8073012,1019.3989 1.2970326,9.9155\"\n           id=\"path10288-1\"\n           inkscape:connector-curvature=\"0\" />\n        <path\n           style=\"fill:none;stroke:#af8949;stroke-width:5;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n           d=\"m 2.5638892,1019.9599 1.297032,9.9155\"\n           id=\"path10288-5-35\"\n           inkscape:connector-curvature=\"0\" />\n        <path\n           style=\"fill:none;stroke:#af8949;stroke-width:5;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n           d=\"m -8.063058,1021.0155 1.2970323,9.9155\"\n           id=\"path10288-5-2-2\"\n           inkscape:connector-curvature=\"0\" />\n        <path\n           style=\"fill:none;stroke:#af8949;stroke-width:4;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n           d=\"m -12.848893,1024.6792 1.985539,9.8007\"\n           id=\"path10288-5-2-3-9\"\n           inkscape:connector-curvature=\"0\" />\n        <path\n           style=\"fill:none;stroke:#af8949;stroke-width:5;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n           d=\"m 11.061265,1032.9021 -6.0942031,7.9285\"\n           id=\"path10288-5-3-5\"\n           inkscape:connector-curvature=\"0\" />\n        <path\n           style=\"fill:#a78548;fill-opacity:1;stroke:none\"\n           d=\"m 5.9128989,1030.5701 c 0,0 1.6987157,9.7731 -0.300192,12.6973 -1.9989093,2.9243 -5.3196225,3.1474 -7.8926786,3.2925 -2.5730561,0.1451 -4.5845417,-0.039 -6.6369916,-1.9267 -2.0524497,-1.8873 -3.5168247,-9.1672 -3.5168247,-9.1672 l 5.2185328,-5.7637 5.9180791,-0.4158 z\"\n           id=\"path10362-7\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"czzzcccc\" />\n      </g>\n    </g>','2016-01-25 20:16:00',NULL),(5,'cursed','    <g\n       transform=\"matrix(5.28,0,0,5.28,77.16968,-5275.8584)\"\n       id=\"cursed\">\n      <title\n         id=\"title4178\">cursed</title>\n      <circle\n         r=\"8\"\n         cy=\"1032.8079\"\n         cx=\"24.890108\"\n         id=\"path4140\"\n         style=\"fill:#000000;fill-opacity:1;stroke:none\" />\n      <path\n         sodipodi:nodetypes=\"zszz\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4142\"\n         d=\"m 32.89011,1032.8079 c 0.42735,7.779 -17.261294,19.3004 -17.261294,19 0,-0.3004 7.141608,-6.2686 9.279609,-12.2051 2.138,-5.9365 7.554335,-14.5739 7.981685,-6.7949 z\"\n         style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <circle\n         transform=\"matrix(-0.5,-0.8660254,0.8660254,-0.5,0,0)\"\n         r=\"8\"\n         cy=\"-482.86218\"\n         cx=\"-894.1889\"\n         id=\"path4140-2\"\n         style=\"fill:#000000;fill-opacity:1;stroke:none\" />\n      <path\n         sodipodi:nodetypes=\"zszz\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4142-1\"\n         d=\"m 24.923638,1008.8942 c 6.523132,-4.2596 25.345266,5.2985 25.085112,5.4487 -0.260154,0.1502 -8.999558,-3.0505 -15.209707,-1.9339 -6.210236,1.1167 -16.398538,0.7447 -9.875405,-3.5148 z\"\n         style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <circle\n         transform=\"matrix(-0.5,0.8660254,-0.8660254,-0.5,0,0)\"\n         r=\"8\"\n         cy=\"-520.17688\"\n         cx=\"877.32123\"\n         id=\"path4140-8\"\n         style=\"fill:#000000;fill-opacity:1;stroke:none\" />\n      <path\n         sodipodi:nodetypes=\"zszz\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4142-6\"\n         d=\"m 7.8258018,1026.799 c -6.95048999,-3.5194 -8.08400199,-24.5989 -7.82384799,-24.4487 0.260154,0.1502 1.85797199,9.3191 5.93009699,14.139 4.0721452,4.8198 8.8441972,13.8292 1.893751,10.3097 z\"\n         style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n    </g>','2016-01-25 20:16:00',NULL),(6,'dazed','    <g\n       id=\"dazed\"\n       transform=\"matrix(4,0,0,4,-1977.9811,-1984.8839)\">\n      <title\n         id=\"title4323\">dazed</title>\n      <circle\n         transform=\"matrix(0.8333329,0,0,0.8333329,82.517151,91.66689)\"\n         id=\"path4190\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffff00;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.33333342,0,0,0.33333248,333.00707,404.66702)\"\n         id=\"path4190-3\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.11666677,0,0,0.11666653,446.57198,542.89384)\"\n         id=\"path4190-3-3\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:6.00000668;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.33333342,0,0,0.33333248,357.42127,404.66702)\"\n         id=\"path4190-3-4\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <path\n         sodipodi:nodetypes=\"czzzzzzzcc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4253\"\n         d=\"m 540.10163,629.99973 c 0,0 -2.64298,5 -5,5 -2.35702,0 -2.64298,-5 -5,-5 -2.35702,0 -2.64298,5 -5,5 -2.35702,0 -2.64298,-5 -5,-5 -2.35702,0 -2.64298,5 -5,5 -2.35702,0 -2.64298,-5 -5,-5 -2.35702,0 -2.64298,5 -5,5 -2.35702,0 -5,-5 -5,-5 l 0,0\"\n         style=\"fill:none;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <circle\n         transform=\"matrix(0.11666677,0,0,0.11666653,471.55281,542.95449)\"\n         id=\"path4190-3-3-7\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:6.00000668;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n    </g>','2016-01-25 20:16:00',NULL),(7,'dazzled','    <g\n       transform=\"matrix(4,0,0,4,-2069.3482,-1720.225)\"\n       id=\"dazzled\">\n      <title\n         id=\"title4476\">dazzled</title>\n      <circle\n         transform=\"matrix(0.8333329,0,0,0.8333329,196.93136,-34.68666)\"\n         id=\"path4190-34-6\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffff00;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.33333342,0,0,0.33333248,447.42128,278.31347)\"\n         id=\"path4190-3-0-8\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.33333342,0,0,0.33333248,471.83548,278.31347)\"\n         id=\"path4190-3-4-4-2\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.02946232,0,0,0.02946226,632.02079,473.02778)\"\n         id=\"path4190-3-3-7-8-3\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#000000;fill-opacity:1;stroke:none;stroke-width:6.00000668;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.02946232,0,0,0.02946226,607.13689,473.02778)\"\n         id=\"path4190-3-3-7-8-3-5\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#000000;fill-opacity:1;stroke:none;stroke-width:6.00000668;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <path\n         style=\"fill:none;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n         d=\"m 525.10163,519.99973 35,0\"\n         id=\"path4460\"\n         inkscape:connector-curvature=\"0\"\n         transform=\"translate(92.353558,-11.999979)\" />\n    </g>','2016-01-25 20:16:00',NULL),(8,'dead','    <g\n       transform=\"translate(266.26274,-683.05427)\"\n       id=\"dead\">\n      <title\n         id=\"title8742\">dead</title>\n      <path\n         inkscape:connector-curvature=\"0\"\n         id=\"path3054-6-5-0-1-0-1\"\n         d=\"m -180.04118,836.72884 395.9798,395.97976\"\n         style=\"fill:none;stroke:url(#linearGradient9795);stroke-width:50;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1\">\n      </path>\n      <path\n         inkscape:connector-curvature=\"0\"\n         id=\"path3054-6-5-0-1-3\"\n         d=\"m 215.93862,836.72883 -395.9798,395.97977\"\n         style=\"fill:none;stroke:url(#linearGradient9797);stroke-width:50;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1\">\n      </path>\n      <path\n         sodipodi:nodetypes=\"cccccccccccczczczccccccccccccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4410-9\"\n         d=\"m 18.06201,1087.4272 0.274725,12.8299 -8.692308,-0.2745 -0.549454,-12.0879 -2.302196,0.2745 0.824175,11.538 -9.3351641,-0.2745 -0.54945,-11.4561 -2.1978,0 0.780219,12.2801 -7.6483529,-0.549 -1.098905,-12.2805 c 0,0 -0.617908,-4.518 -5.576917,-14.643 -4.959009,-10.1246 -17.196858,-9.7335 -21.95055,-17.4447 -10.522925,-37.3739 -16.038465,-96.90657 56.236261,-96.31887 72.274724,0.58815 68.359894,63.83287 60.082414,96.31887 -10.85714,9.9585 -14.5989,6.8022 -21.67582,16.0713 -7.076923,9.2695 -5.851645,16.0164 -5.851645,16.0164 l 0.54945,11.731 -7.41758,0 -1.0989,-11.4561 -1.708798,0 1.0989,12.0051 -9.280215,5e-4 0.274725,-12.0056 -1.747256,-0.2745 0,12.555 -9.516483,0 -0.54945,-12.555 z\"\n         style=\"fill:#ffffff;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.90000004;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"zzzzzzzzz\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4412-66\"\n         d=\"m -33.498432,1047.7844 c -4.401535,-4.8915 -2.373628,-19.2303 -1.186812,-20.6041 1.186817,-1.3739 5.623398,-6.5273 10.186812,-8.7912 4.563414,-2.264 10.905822,-3.6819 16.7362654,-3.5496 5.830443,0.1305 14.8299476,0.9369 17.3076926,4.5 2.477745,3.5631 -0.01125,9.6538 -1.373629,13.3353 -1.362564,3.681 -4.306806,7.2526 -8.2417592,11.2635 -3.9349529,4.0108 -9.0822644,7.6747 -15.1098888,9.099 -6.027624,1.4242 -13.917145,-0.36 -18.318681,-5.2529 z\"\n         style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"zzzzzzzzz\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4412-6-3\"\n         d=\"m 68.705757,1047.8996 c 4.401535,-4.8915 2.37363,-19.2303 1.18681,-20.6041 -1.186815,-1.3739 -5.623395,-6.5273 -10.18681,-8.7912 -4.563415,-2.264 -10.905822,-3.6819 -16.73626,-3.5496 -5.830443,0.1305 -14.829948,0.9369 -17.307693,4.5 -2.477745,3.5631 0.01125,9.6538 1.373629,13.3353 1.362564,3.681 4.306806,7.2526 8.241759,11.2635 3.934953,4.0108 9.082265,7.6747 15.109884,9.099 6.027626,1.4242 13.917146,-0.36 18.318681,-5.2529 z\"\n         style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"ccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4429-1-4\"\n         d=\"m 18.223691,1033.1324 c 5.798133,3.2544 10.021221,21.7067 5.54854,22.766 -6.64195,-2.5371 -10.778166,-21.7967 -5.54854,-22.766 z\"\n         style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"ccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4429-1-2-8\"\n         d=\"m 18.389777,1032.8305 c -5.798133,3.2544 -10.021221,21.7066 -5.548541,22.7659 6.641951,-2.5371 10.778166,-21.7966 5.548541,-22.7659 z\"\n         style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n    </g>\n','2015-12-12 20:35:26',NULL),(9,'deafened','    <g\n       id=\"deafened\"\n       transform=\"matrix(4,0,0,4,1.754436,-3837.075)\">\n      <title\n         id=\"title5091\">deafened</title>\n      <path\n         sodipodi:type=\"spiral\"\n         style=\"fill:url(#linearGradient8478);fill-opacity:1;stroke:#da1eb3;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n         id=\"path4490\"\n         sodipodi:cx=\"25\"\n         sodipodi:cy=\"20\"\n         sodipodi:expansion=\"0.5\"\n         sodipodi:revolution=\"1.0006276\"\n         sodipodi:radius=\"25.680822\"\n         sodipodi:argument=\"-16.898252\"\n         sodipodi:t0=\"0\"\n         d=\"M 25,20 C 21.274011,29.314953 12.56328,22.387088 13.081721,15.232678 13.737165,6.187629 23.577697,1.2963551 31.742011,3.1450076 42.794421,5.6476141 48.609318,17.736078 45.643065,28.257244 42.038713,41.041721 27.855011,47.684025 15.465356,43.836559 c -0.03234,-0.01004 -0.06465,-0.02015 -0.09695,-0.03032\"\n         transform=\"matrix(0.78238629,0,0,0.78238629,2.8467623,1007.9016)\" />\n      <path\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#950000;fill-opacity:1;stroke:none;stroke-width:1;marker:none;enable-background:accumulate\"\n         d=\"M 25,0 C 11.192881,0 0,11.192881 0,25 0,38.807119 11.192881,50 25,50 38.807119,50 50,38.807119 50,25 50,11.192881 38.807119,0 25,0 Z m 0,6.5 c 10.355339,0 18.75,8.394661 18.75,18.75 C 43.75,35.605339 35.355339,44 25,44 14.644661,44 6.25,35.605339 6.25,25.25 6.25,14.894661 14.644661,6.5 25,6.5 Z\"\n         transform=\"translate(0,1002.3622)\"\n         id=\"path5024\"\n         inkscape:connector-curvature=\"0\" />\n      <path\n         style=\"fill:#900000;fill-opacity:1;stroke:none\"\n         d=\"m 37.374369,1011.4827 3.535534,3.5355 -28.284272,28.2843 -3.5355336,-3.5355 28.2842716,-28.2843\"\n         id=\"path5045\"\n         inkscape:connector-curvature=\"0\" />\n    </g>','2016-01-25 20:21:53',NULL),(10,'disabled','    <g\n       id=\"disabled\">\n      <title\n         id=\"title9515\">disabled</title>\n      <path\n         style=\"fill:none;stroke:url(#linearGradient9820);stroke-width:50;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:50, 50;stroke-dashoffset:0\"\n         d=\"m 563.10163,347.99973 -559.9999965,0\"\n         id=\"path3054-6-5\"\n         inkscape:connector-curvature=\"0\">\n      </path>\n    </g>\n ','2015-12-12 20:35:26',NULL),(11,'drained','    <g\n       id=\"drained\"\n       transform=\"matrix(4,0,0,4,-21.639701,-3897.6207)\">\n      <title\n         id=\"title7243\">drained</title>\n      <path\n         style=\"fill:url(#linearGradient8484);fill-opacity:1;stroke:#000000;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 9.5303301,1006.5012 11.5384629,0 0,-3.8462 7.692307,0 0,3.8462 11.538462,0 0,46.1538 -30.7692319,0 z\"\n         id=\"path7147\"\n         inkscape:connector-curvature=\"0\" />\n      <path\n         style=\"fill:#1e821e;fill-opacity:1;stroke:#1e821e;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 10,1042.3622 30,0 0,10 -30,0 z\"\n         id=\"path7159\"\n         inkscape:connector-curvature=\"0\" />\n      <path\n         style=\"fill:#dada00;fill-opacity:1;stroke:none\"\n         d=\"m 35,1010.3622 -20,20 10,0 -10,15 20,-20 -10,0 10,-15\"\n         id=\"path7169\"\n         inkscape:connector-curvature=\"0\" />\n    </g>','2016-01-25 20:21:53',NULL),(12,'dying','    <g\n       id=\"dying\">\n      <title\n         id=\"title9643\">dying</title>\n      <path\n         inkscape:connector-curvature=\"0\"\n         id=\"path3054-6-5-0-1-0\"\n         d=\"M 87.111727,152.00984 483.09153,547.98962\"\n         style=\"fill:none;stroke:url(#linearGradient9614);stroke-width:50;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:50, 50;stroke-dashoffset:0\">\n      </path>\n      <path\n         inkscape:connector-curvature=\"0\"\n         id=\"path3054-6-5-0-1\"\n         d=\"M 483.09153,152.00983 87.111735,547.98963\"\n         style=\"fill:none;stroke:url(#linearGradient9574);stroke-width:50;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:50,50;stroke-dashoffset:0\">\n      </path>\n    </g>\n ','2015-12-12 20:35:26',NULL),(13,'entangled','    <g\n       transform=\"matrix(4,0,0,4,20.796258,-3756.2462)\"\n       id=\"entangled\">\n      <title\n         id=\"title7771\">entangled</title>\n      <path\n         sodipodi:nodetypes=\"cccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path7302-6-6-8-4-4\"\n         d=\"m 5,1013.9182 -3.722202,-4.4336 5.417541,1.9459 z\"\n         style=\"fill:url(#linearGradient7510);fill-opacity:1;stroke:#504524;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path7302-6-6\"\n         d=\"m 31.683631,1032.3622 7.132554,4.3594 -7.996866,-0.5511 z\"\n         style=\"fill:url(#linearGradient7383);fill-opacity:1;stroke:#504524;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"czzzc\"\n         transform=\"translate(0,1002.3622)\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path7290\"\n         d=\"M 45,45 C 45,45 32.357023,44.714045 30,40 27.642977,35.285955 33.973875,31.600229 30,25 26.026125,18.399771 9.8923914,25.775274 5,20 0.10760859,14.224726 9.4194174,6.0606602 9.4194174,6.0606602\"\n         style=\"fill:none;stroke:#007100;stroke-width:2.5;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         transform=\"translate(0,1002.3622)\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path7302\"\n         d=\"M 9.5459416,22.069282 12.374369,15 l 1.06066,6.715729 z\"\n         style=\"fill:url(#linearGradient7318);fill-opacity:1;stroke:#504524;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         inkscape:transform-center-x=\"-3.822214\"\n         sodipodi:nodetypes=\"cccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path7302-6\"\n         d=\"m 30,1028.1567 -5.329108,2.261 2.791483,-5.2293 z\"\n         style=\"fill:url(#linearGradient7338);fill-opacity:1;stroke:#504524;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path7302-6-6-8\"\n         d=\"m 28.805223,1042.3622 -5.715645,-0.9181 5.370434,-2.0725 z\"\n         style=\"fill:url(#linearGradient7420);fill-opacity:1;stroke:#504524;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path7302-6-6-8-4\"\n         d=\"m 37.487788,1046.028 2.692674,-5.1245 0.251834,5.7509 z\"\n         style=\"fill:url(#linearGradient7473);fill-opacity:1;stroke:#504524;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path7302-6-6-8-4-4-9\"\n         d=\"m 36.427798,1038.7247 3.722202,4.4336 -5.417541,-1.9459 z\"\n         style=\"fill:url(#linearGradient7578);fill-opacity:1;stroke:#504524;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path7302-6-6-0\"\n         d=\"m 9.744167,1020.2807 -7.132554,-4.3594 7.996866,0.5511 z\"\n         style=\"fill:url(#linearGradient7383-8);fill-opacity:1;stroke:#504524;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"czzzc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path7290-2\"\n         d=\"m -3.572202,1005.2807 c 0,0 12.642977,0.2859 15,5 2.357023,4.714 -3.973875,8.3997 0,15 3.973875,6.6002 20.107609,-0.7753 25,5 4.892391,5.7752 -4.419417,13.9393 -4.419417,13.9393\"\n         style=\"fill:none;stroke:#007100;stroke-width:2.5;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         inkscape:connector-curvature=\"0\"\n         id=\"path7302-8\"\n         d=\"m 31.881856,1028.2114 -2.828427,7.0693 -1.06066,-6.7158 z\"\n         style=\"fill:url(#linearGradient7318-4);fill-opacity:1;stroke:#504524;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path7302-6-6-8-9\"\n         d=\"m 12.622575,1010.2807 5.715645,0.9181 -5.370434,2.0725 z\"\n         style=\"fill:url(#linearGradient7420-6);fill-opacity:1;stroke:#504524;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path7302-6-6-8-4-1\"\n         d=\"m 3.94001,1006.6149 -2.692674,5.1245 -0.251834,-5.7509 z\"\n         style=\"fill:url(#linearGradient7473-0);fill-opacity:1;stroke:#504524;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"czzzc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path7290-2-2\"\n         d=\"m 12.40192,1005.2663 c 0,0 8.66295,5.9205 8.726892,9.9987 0.06394,4.0782 -2.9441,6.3625 -1.465194,13.9234 1.478907,7.561 10.069902,1.1441 12.693969,8.2436 2.6241,7.0995 14.039526,8.4637 14.039526,8.4637\"\n         style=\"fill:none;stroke:#007100;stroke-width:2.5;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path7302-6-6-0-0\"\n         d=\"m 21.098416,1017.7609 5.656677,6.1546 -7.536083,-2.7315 z\"\n         style=\"fill:url(#linearGradient7695);fill-opacity:1;stroke:#504524;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         inkscape:transform-center-y=\"2.5402\"\n         inkscape:transform-center-x=\"-5.4800776\"\n         sodipodi:nodetypes=\"cccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path7302-6-6-8-4-4-9-0\"\n         d=\"M 19.87679,1011.7267 25,1009.0315 l -3.052506,4.8804 z\"\n         style=\"fill:url(#linearGradient7866);fill-opacity:1;stroke:#504524;stroke-width:0.2;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n    </g>','2016-01-25 20:21:53',NULL),(14,'exhausted','    <g\n       transform=\"matrix(4,0,0,4,319.42392,-3541.3261)\"\n       id=\"exhausted\">\n      <title\n         id=\"title8801\">exhausted</title>\n      <circle\n         transform=\"matrix(0.8333329,0,0,0.8333329,-412.4458,494.02908)\"\n         id=\"path4190-34-8\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffff00;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.33333342,0,0,0.33333248,-161.95588,807.02921)\"\n         id=\"path4190-3-0-9\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.11666677,0,0,0.11666653,-48.39097,949.25603)\"\n         id=\"path4190-3-3-9-0\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:6.00000668;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.33333342,0,0,0.33333248,-137.54168,807.02921)\"\n         id=\"path4190-3-4-4-7\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.11666677,0,0,0.11666653,-23.41014,949.31668)\"\n         id=\"path4190-3-3-7-8-4\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:6.00000668;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <path\n         sodipodi:nodetypes=\"czzzzzccc\"\n         transform=\"translate(0,1002.3622)\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path8734\"\n         d=\"m 14.407301,37.802408 c 0,0 1.173454,1.463922 1.592699,2.740039 0.419245,1.276117 -0.272317,3.783233 0.528621,4.861359 0.800938,1.078126 1.759772,1.394544 2.916816,1.237437 1.157044,-0.157107 2.3799,-0.945622 3.005203,-2.386486 C 23.075943,42.813893 22.41267,40.139055 22,38.686291 21.58733,37.233527 20.417708,35.592699 20.417708,35.592699 l -3.71231,0.795495 z\"\n         style=\"fill:#d317c7;fill-opacity:1;stroke:none\" />\n      <path\n         sodipodi:nodetypes=\"czc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path8605-7\"\n         d=\"m 8.3206214,1043.1577 c 0,0 6.6656016,-5.6236 16.9584456,-5.7955 10.292844,-0.1719 16.620677,5.9912 16.400312,6\"\n         style=\"fill:none;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cc\"\n         transform=\"translate(0,1002.3622)\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path8736\"\n         d=\"M 17,36.388194 C 19.562066,38.155961 19.478183,41.232233 19.533825,43\"\n         style=\"fill:none;stroke:#000000;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         inkscape:connector-curvature=\"0\"\n         id=\"path4190-3-4-4-2-8\"\n         transform=\"translate(0,1002.3622)\"\n         d=\"m 37.5,8 c -5.522849,0 -10,4.477167 -10,10 0,0.82371 0.09345,1.609196 0.28125,2.375 C 28.862005,19.008879 32.810339,18 37.5,18 c 4.689661,0 8.606745,1.008879 9.6875,2.375 C 47.375301,19.609196 47.5,18.82371 47.5,18 47.5,12.477167 43.022849,8 37.5,8 Z M 28.59375,22.5625 C 30.250762,25.794941 33.617924,28 37.5,28 c 3.885719,0 7.250894,-2.20011 8.90625,-5.4375 -1.653779,1.016912 -5.017078,1.71875 -8.90625,1.71875 -3.875659,0 -7.246342,-0.707596 -8.90625,-1.71875 z\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#948932;fill-opacity:1;stroke:#000000;stroke-width:0.33333296px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\" />\n      <path\n         id=\"path4190-3-4-4-2-4\"\n         d=\"m 13.085792,1010.3346 c -5.5228538,0 -10.0000048,4.4771 -10.0000048,10 0,0.8237 0.09345,1.6092 0.28125,2.375 1.080755,-1.3662 5.029089,-2.375 9.7187548,-2.375 4.689661,0 8.606745,1.0088 9.6875,2.375 0.187801,-0.7658 0.3125,-1.5513 0.3125,-2.375 0,-5.5229 -4.477151,-10 -10,-10 z m -8.9062548,14.5625 c 1.657012,3.2324 5.0241758,5.4375 8.9062548,5.4375 3.885719,0 7.250894,-2.2001 8.90625,-5.4375 -1.653779,1.0169 -5.017078,1.7187 -8.90625,1.7187 -3.8756617,0 -7.2463468,-0.7076 -8.9062548,-1.7187 z\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#948932;fill-opacity:1;stroke:#000000;stroke-width:0.33333296px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         inkscape:connector-curvature=\"0\" />\n    </g>','2016-01-25 20:25:11',NULL),(15,'facinated','    <g\n       transform=\"matrix(4,0,0,4,-2000.7112,-1967.996)\"\n       id=\"facinated\">\n      <title\n         id=\"title4395\">facinated</title>\n      <circle\n         transform=\"matrix(0.8333329,0,0,0.8333329,179.87071,28.192022)\"\n         id=\"path4190-34-0\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffff00;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <path\n         style=\"fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n         d=\"m 510.10163,579.99973 0,10 10,0 5,-5 5,5 10,0 0,-10\"\n         id=\"path4384\"\n         inkscape:connector-curvature=\"0\"\n         transform=\"translate(92.353558,-11.999979)\" />\n      <path\n         style=\"fill:#ffff00;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n         d=\"m 505.10163,574.99973 c 0,0 5,10 20,10 15,0 20,-10 20,-10\"\n         id=\"path4382\"\n         inkscape:connector-curvature=\"0\"\n         transform=\"translate(92.353558,-11.999979)\"\n         sodipodi:nodetypes=\"czc\" />\n      <circle\n         transform=\"matrix(0.33333342,0,0,0.33333248,430.36063,341.19217)\"\n         id=\"path4190-3-0-7\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.11666677,0,0,0.11666653,543.92554,479.41899)\"\n         id=\"path4190-3-3-9-2\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:6.00000668;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.33333342,0,0,0.33333248,454.77483,341.19217)\"\n         id=\"path4190-3-4-4-4\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.11666677,0,0,0.11666653,568.90637,479.47964)\"\n         id=\"path4190-3-3-7-8-2\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:6.00000668;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n    </g>','2016-01-25 20:25:11',NULL),(16,'fatigued','    <g\n       transform=\"matrix(4,0,0,4,317.57326,-3542.213)\"\n       id=\"fatigued\">\n      <title\n         id=\"title8679\">fatigued</title>\n      <circle\n         transform=\"matrix(0.8333329,0,0,0.8333329,-412.4458,494.02908)\"\n         id=\"path4190-34-1\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffff00;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.33333342,0,0,0.33333248,-161.95588,807.02921)\"\n         id=\"path4190-3-0-19\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.11666677,0,0,0.11666653,-48.39097,949.25603)\"\n         id=\"path4190-3-3-9-7\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:6.00000668;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.33333342,0,0,0.33333248,-137.54168,807.02921)\"\n         id=\"path4190-3-4-4-27\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.11666677,0,0,0.11666653,-23.41014,949.31668)\"\n         id=\"path4190-3-3-7-8-8\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:6.00000668;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <path\n         sodipodi:nodetypes=\"czc\"\n         transform=\"translate(0,1002.3622)\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path8605\"\n         d=\"M 10,40 C 10,40 20.008604,34.970576 25.279067,35 30.54953,35.029424 40,40 40,40\"\n         style=\"fill:none;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         inkscape:connector-curvature=\"0\"\n         id=\"path4190-3-0-1\"\n         transform=\"translate(0,1002.3622)\"\n         d=\"m 13.0625,8 c -5.5228489,0 -10,4.477167 -10,10 0,0.656047 0.066901,1.285466 0.1875,1.90625 C 4.1253233,17.820546 8.1784648,16.25 13.0625,16.25 c 4.884035,0 8.968427,1.570546 9.84375,3.65625 C 23.026849,19.285466 23.0625,18.656047 23.0625,18 c 0,-5.522833 -4.477151,-10 -10,-10 z M 4.375,22.96875 C 6.0970361,25.984485 9.3410954,28 13.0625,28 16.783905,28 20.059214,25.984485 21.78125,22.96875 20.06031,24.329263 16.786971,25.25 13.0625,25.25 9.3380287,25.25 6.0959397,24.329263 4.375,22.96875 Z\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#b0b319;fill-opacity:1;stroke:#000000;stroke-width:0.33333296px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\" />\n      <path\n         id=\"path4190-3-0-1-8\"\n         d=\"m 37.476659,1010.405 c -5.522848,0 -9.999999,4.4771 -9.999999,10 0,0.656 0.0669,1.2854 0.1875,1.9062 0.875323,-2.0857 4.928465,-3.6562 9.812499,-3.6562 4.884035,0 8.968427,1.5705 9.84375,3.6562 0.120599,-0.6208 0.15625,-1.2502 0.15625,-1.9062 0,-5.5229 -4.477151,-10 -10,-10 z m -8.687499,14.9687 c 1.722036,3.0158 4.966095,5.0313 8.687499,5.0313 3.721405,0 6.996714,-2.0155 8.71875,-5.0313 -1.72094,1.3605 -4.994279,2.2813 -8.71875,2.2813 -3.724471,0 -6.96656,-0.9208 -8.687499,-2.2813 z\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#b0b319;fill-opacity:1;stroke:#000000;stroke-width:0.33333296px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         inkscape:connector-curvature=\"0\" />\n    </g>','2016-01-25 20:25:11',NULL),(17,'frightened','    <g\n       transform=\"matrix(3.9662114,0.51881304,-0.51881304,3.9662114,664.57144,-3540.0817)\"\n       id=\"frightened\">\n      <title\n         id=\"title10066\">frightened</title>\n      <circle\n         transform=\"matrix(0.65553693,-0.08574961,0.08574961,0.65553693,-371.78428,661.10348)\"\n         id=\"path4190-34-6-4\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffff00;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.26221497,-0.03429987,0.03429978,0.26221424,-142.53012,881.54807)\"\n         id=\"path4190-3-0-8-9\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.26221497,-0.03429987,0.03429978,0.26221424,-123.32482,879.03585)\"\n         id=\"path4190-3-4-4-2-7\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.1677853,-0.02194768,0.02194762,0.16778494,-85.172544,935.42522)\"\n         id=\"path4190-3-3-7-8-3-5-16\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#000000;fill-opacity:1;stroke:none;stroke-width:6.00000668;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <path\n         inkscape:connector-curvature=\"0\"\n         id=\"path4460-5\"\n         transform=\"matrix(0.99155285,-0.12970326,0.12970326,0.99155285,-0.48115893,1014.052)\"\n         d=\"m 25.03125,30.6875 c -4.628601,-0.02377 -9.245065,1.196606 -13.8125,3.71875 l 27.78125,0 C 34.314732,31.979103 29.659851,30.71127 25.03125,30.6875 Z\"\n         style=\"fill:#860907;fill-opacity:1;stroke:#000000;stroke-width:0.79334623px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path9885-3\"\n         d=\"m 9.0988633,1022.8839 c -5.3011204,10.4275 -4.9045075,20.4927 3.9270627,30.0216\"\n         style=\"fill:none;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path9885-6-2\"\n         d=\"m 5.697437,1026.9502 c -3.8863502,7.9785 -3.5568965,15.6993 3.013653,23.0388\"\n         style=\"fill:none;stroke:#000000;stroke-width:0.75341046px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path9885-8-3\"\n         d=\"m 42.17754,1018.5566 c 7.804872,8.7132 10.010527,18.5417 3.927081,30.0216\"\n         style=\"fill:none;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path9885-6-7-2\"\n         d=\"m 46.510437,1021.6112 c 5.807783,6.7105 7.475322,14.2562 3.013676,23.0388\"\n         style=\"fill:none;stroke:#000000;stroke-width:0.75341046px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <circle\n         transform=\"matrix(0.1677853,-0.02194768,0.02194762,0.16778494,-65.692055,932.877)\"\n         id=\"path4190-3-3-7-8-3-5-8\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#000000;fill-opacity:1;stroke:none;stroke-width:6.00000668;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n    </g>','2016-01-25 20:25:11',NULL),(18,'grappled','    <g\n       transform=\"matrix(4,0,0,4,-22.962691,-3756.8739)\"\n       id=\"grappled\">\n      <title\n         id=\"title8155\">grappled</title>\n      <path\n         sodipodi:nodetypes=\"ccccc\"\n         transform=\"translate(0,1002.3622)\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path8135\"\n         d=\"M 22.539029,50 6.1871843,5 32.792077,1 41,38.320621 Z\"\n         style=\"fill:url(#linearGradient8143);fill-opacity:1;stroke:none\" />\n      <path\n         sodipodi:nodetypes=\"zszzszz\"\n         transform=\"translate(0,1002.3622)\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path8043\"\n         d=\"M 9.3812816,35 C 10.768054,33.649326 16.450034,26.787331 19.228341,24 22.006648,21.212668 22.323223,21.616117 25,20 c 2.676777,-1.616117 6.5,2.5 4,5 -2.5,2.5 -4,3 -4.649804,3.7187 C 21.738164,31.607672 13.296196,41.444415 12,42.740039 10.703804,44.035663 7.9945096,36.350674 9.3812816,35 Z\"\n         style=\"fill:#b87424;fill-opacity:1;stroke:#845f46;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"zzzzz\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path8043-8\"\n         d=\"m 12.293755,1044.5091 c 2.426397,-2.3216 5.660152,-5.1469 10.034334,-9.4439 4.374181,-4.297 8.748362,0 4.374181,4.297 -4.374181,4.297 -9.43435,9.1614 -11.70227,11.3884 -2.267919,2.2269 -5.132643,-3.92 -2.706245,-6.2415 z\"\n         style=\"fill:#b87424;fill-opacity:1;stroke:#845f46;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"zszzszz\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path8043-1\"\n         d=\"m 7.5684655,1028.766 c 1.3867722,-1.3507 4.9569525,-6.2573 7.2270265,-8.4038 2.270074,-2.1465 2.09099,-1.7097 4.414214,-2.6187 2.323223,-0.909 4.494796,3.2678 3.232233,4.6187 -1.262564,1.3509 -1.572699,0.7203 -3.646447,3 -1.40233,1.5416 -7.291298,9.1411 -8.587493,10.4367 -1.2961963,1.2957 -4.0263055,-5.6822 -2.6395335,-7.0329 z\"\n         style=\"fill:#b87424;fill-opacity:1;stroke:#845f46;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"zzzzz\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path8043-8-3\"\n         d=\"m 7.1602856,1019.4536 c 1.3925191,-1.2088 2.2369857,-1.8372 4.0106194,-2.9348 1.773636,-1.0976 3.956281,3.3738 1.624587,5.6938 -2.331693,2.32 -2.431074,2.2616 -3.9999973,3.9708 -1.5689248,1.7092 -3.0277282,-5.521 -1.6352091,-6.7298 z\"\n         style=\"fill:#b87424;fill-opacity:1;stroke:#845f46;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"zzzzz\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path8043-8-3-6\"\n         d=\"m 37.627132,1019.6698 c -4.434528,0.7231 -4.020111,0.3603 -7.021049,0.2746 -3.000892,-0.086 -4.789514,-6.2105 -0.388752,-7.005 4.400719,-0.7944 3.323778,-0.7652 7.782669,-1.8272 4.458935,-1.0622 4.061659,7.8346 -0.372868,8.5576 z\"\n         style=\"fill:#b87424;fill-opacity:1;stroke:#845f46;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n    </g>','2016-01-25 20:28:02',NULL),(19,'helpless','    <g\n       transform=\"matrix(4,0,0,4,360.25832,-3899.804)\"\n       id=\"helpless\">\n      <title\n         id=\"title8930\">helpless</title>\n      <circle\n         transform=\"translate(0,1002.3622)\"\n         id=\"path8921\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#eeed74;fill-opacity:1;stroke:none;stroke-width:0.5;marker:none;enable-background:accumulate\"\n         cx=\"25\"\n         cy=\"25\"\n         r=\"20.254833\" />\n      <path\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#950000;fill-opacity:1;stroke:none;stroke-width:1;marker:none;enable-background:accumulate\"\n         d=\"m 25.102291,1002.4038 c -13.807119,0 -24.99999995,11.1929 -24.99999995,25 0,13.8071 11.19288095,25 24.99999995,25 13.807119,0 25,-11.1929 25,-25 0,-13.8071 -11.192881,-25 -25,-25 z m 0,6.5 c 10.355339,0 18.75,8.3947 18.75,18.75 0,10.3553 -8.394661,18.75 -18.75,18.75 -10.355339,0 -18.75,-8.3947 -18.75,-18.75 0,-10.3553 8.394661,-18.75 18.75,-18.75 z\"\n         id=\"path5024-1\"\n         inkscape:connector-curvature=\"0\" />\n      <text\n         transform=\"scale(1.0559577,0.94700763)\"\n         sodipodi:linespacing=\"125%\"\n         id=\"text8899\"\n         y=\"1101.2302\"\n         x=\"11.364092\"\n         style=\"font-style:normal;font-weight:normal;font-size:45.50795746px;line-height:125%;font-family:Sans;letter-spacing:0px;word-spacing:0px;fill:#367c1f;fill-opacity:1;stroke:none\"\n         xml:space=\"preserve\"><tspan\n           style=\"font-weight:bold\"\n           y=\"1101.2302\"\n           x=\"11.364092\"\n           id=\"tspan8901\"\n           sodipodi:role=\"line\">?</tspan></text>\n      <path\n         style=\"fill:#900000;fill-opacity:1;stroke:none\"\n         d=\"m 37.47666,1011.5243 3.535534,3.5355 -28.284272,28.2843 -3.5355336,-3.5355 28.2842716,-28.2843\"\n         id=\"path5045-1\"\n         inkscape:connector-curvature=\"0\" />\n    </g>','2016-01-25 20:28:02',NULL),(20,'incorporeal','    <g\n       transform=\"matrix(4.8,0,0,4.8,228.69399,-4830.6313)\"\n       id=\"incorporeal\">\n      <title\n         id=\"title8995\">incorporeal</title>\n      <path\n         sodipodi:nodetypes=\"czzzzzccccccccccccccccccc\"\n         transform=\"translate(0,1002.3622)\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path8968\"\n         d=\"M 5,45 C 5,45 13.523418,39 15.644738,33 17.766058,27 15.601203,14.727127 20,9.7833018 24.398797,4.8394762 30.420838,3.7143211 35.355339,5 40.28984,6.2856789 43.51465,9.0569285 45.343222,15.528544 47.171794,22.000159 42.776216,36.183176 40,40.807612 37.223784,45.432048 35,45 35,45 l 0,-2 -3.268583,2 0.707107,-2.247845 -3.889088,2.651651 L 28,43 25.544233,46.199301 26.516504,42 21,46.729631 22,43 16.351844,46.729631 19.180271,43 14,46.287689 15.733126,43.636039 10,46.729631 12.639534,44 7.5130096,46.552854 8.3085047,43.547651 Z\"\n         style=\"fill:#ffffff;fill-opacity:1;stroke:#636363;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <ellipse\n         transform=\"matrix(0.86677787,0.21195883,-0.30355808,1.1767622,8.143388,992.8819)\"\n         id=\"path8970\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#5f5f5f;fill-opacity:1;stroke:none;stroke-width:0.5;marker:none;enable-background:accumulate\"\n         cx=\"27.5\"\n         cy=\"17.606564\"\n         rx=\"2.5\"\n         ry=\"2.6065633\" />\n      <ellipse\n         transform=\"matrix(0.86677787,0.21195883,-0.30355808,1.1767622,19.504805,993.31021)\"\n         id=\"path8970-3\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#5f5f5f;fill-opacity:1;stroke:none;stroke-width:0.5;marker:none;enable-background:accumulate\"\n         cx=\"27.5\"\n         cy=\"17.606564\"\n         rx=\"2.5\"\n         ry=\"2.6065633\" />\n    </g>','2016-01-25 20:28:02',NULL),(21,'invisible','    <g\n       transform=\"matrix(5.7113444,0.74709078,-0.74709078,5.7113444,898.64958,-5807.7847)\"\n       id=\"invisible\">\n      <title\n         id=\"title9209\">invisible</title>\n      <g\n         id=\"g9173\"\n         transform=\"matrix(0.99155285,-0.12970326,0.12970326,0.99155285,-135.23523,14.726363)\">\n        <path\n           sodipodi:nodetypes=\"czc\"\n           inkscape:connector-curvature=\"0\"\n           id=\"path9153\"\n           d=\"m 33.941127,1045.7331 c 0,0 7.060737,-8.3485 8.838835,-10.1647 1.778098,-1.8162 3.778098,-0.5303 3.778098,-0.5303\"\n           style=\"fill:none;stroke:#005c00;stroke-width:2;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n        <circle\n           transform=\"matrix(1.1483368,0.3387907,-0.28296973,0.95913072,10.21968,996.73964)\"\n           id=\"path9113\"\n           style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#6c6c59;fill-opacity:1;fill-rule:nonzero;stroke:#005c00;stroke-width:0.5;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n           cx=\"27.211456\"\n           cy=\"40.788544\"\n           r=\"3.7885439\" />\n        <path\n           sodipodi:nodetypes=\"czc\"\n           inkscape:connector-curvature=\"0\"\n           id=\"path9153-8\"\n           d=\"m 13.294679,1040.2651 c 0,0 7.060737,-8.3485 8.838835,-10.1647 1.778098,-1.8162 3.778098,-0.5303 3.778098,-0.5303\"\n           style=\"fill:none;stroke:#005c00;stroke-width:2;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n        <circle\n           transform=\"matrix(1.1483368,0.3387907,-0.28296973,0.95913072,-2.8584368,992.86893)\"\n           id=\"path9113-3\"\n           style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#6c6c59;fill-opacity:1;fill-rule:nonzero;stroke:#005c00;stroke-width:0.5;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n           cx=\"27.211456\"\n           cy=\"40.788544\"\n           r=\"3.7885439\" />\n        <path\n           sodipodi:nodetypes=\"czc\"\n           inkscape:connector-curvature=\"0\"\n           id=\"path9151\"\n           d=\"m 21.200456,1041.9118 c 0,0 0.417583,-0.9194 2.393709,-0.5496 1.976127,0.3698 2.195023,1.8887 2.195023,1.8887\"\n           style=\"fill:none;stroke:#005c00;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      </g>\n      <path\n         sodipodi:nodetypes=\"czzcc\"\n         transform=\"translate(0,1002.3622)\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path9058\"\n         d=\"M 45,21.715729 C 45.649123,21.166471 32.076865,33.743808 22.641568,38.008688 13.206271,42.273568 10.914033,40.393575 9.3375127,38.019946 7.7609927,35.646318 12,31.792 12,31.792 Z\"\n         style=\"fill:url(#linearGradient9109);fill-opacity:1;stroke:#000000;stroke-width:0.5;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         id=\"path9029-3\"\n         d=\"m 28.971609,1013.639 c -9.556353,0.1098 -17.375356,7.2613 -17.485189,15.9923 -0.02008,1.5961 0.227936,3.1344 0.691136,4.5813 5.138356,1.8029 12.45584,1.6378 19.666194,-0.8816 6.050075,-2.1141 10.766423,-5.4602 13.404407,-9.0474 -2.208944,-6.2577 -8.630176,-10.7325 -16.276548,-10.6446 z\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:url(#linearGradient9240);fill-opacity:1;stroke:#000000;stroke-width:0.47164211;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         inkscape:connector-curvature=\"0\" />\n    </g>','2016-01-25 20:28:02',NULL),(22,'nauseated','    <g\n       transform=\"matrix(3.9662114,0.51881304,-0.51881304,3.9662114,767.0625,-3523.2433)\"\n       id=\"nauseated\">\n      <title\n         id=\"title9453\">nauseated</title>\n      <circle\n         transform=\"matrix(0.82629361,-0.10808599,0.10808599,0.82629361,-475.36444,563.59282)\"\n         id=\"path4190-34-8-8\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#65ab36;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.3305177,-0.04323443,0.04323431,0.33051677,-186.3933,841.45963)\"\n         id=\"path4190-3-0-9-61\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.11568127,-0.01513206,0.01513203,0.11568103,-55.340413,967.7553)\"\n         id=\"path4190-3-3-9-0-0\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:6.00000668;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.3305177,-0.04323443,0.04323431,0.33051677,-162.18534,838.29303)\"\n         id=\"path4190-3-4-4-7-5\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.11568127,-0.01513206,0.01513203,0.11568103,-30.562733,964.57534)\"\n         id=\"path4190-3-3-7-8-4-8\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:6.00000668;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <path\n         sodipodi:nodetypes=\"sccs\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path8605-7-9\"\n         transform=\"matrix(0.99155285,-0.12970326,0.12970326,0.99155285,-0.48115893,1014.052)\"\n         d=\"M 25.28125,35.09375 C 14.988414,35.265587 8.3125,40.875 8.3125,40.875 c 11.125,-1.67548 22.25,-2.0996 33.375,0.21875 0.220364,-0.0088 -6.113401,-6.171936 -16.40625,-6 z\"\n         style=\"fill:#ac0ba4;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         inkscape:connector-curvature=\"0\"\n         id=\"path4190-3-4-4-2-8-5\"\n         d=\"m 37.750693,1017.205 c -5.476197,0.7163 -9.334825,5.7363 -8.618496,11.2125 0.106838,0.8168 0.301379,1.5835 0.58692,2.3185 0.894435,-1.4948 4.678562,-3.0073 9.328609,-3.6155 4.650046,-0.6083 8.664897,-0.116 9.913713,1.0984 0.08689,-0.7837 0.108653,-1.5787 0.0018,-2.3955 -0.716329,-5.4761 -5.736364,-9.3348 -11.212561,-8.6184 z m -6.942214,15.5946 c 2.062273,2.9902 5.686996,4.7399 9.536279,4.2364 3.852896,-0.504 6.904283,-3.122 8.125756,-6.5467 -1.507912,1.2228 -4.75177,2.3549 -8.60809,2.8594 -3.842921,0.5027 -7.276908,0.2382 -9.053945,-0.5491 z\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#4a6f31;fill-opacity:1;stroke:#000000;stroke-width:0.33333296px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\" />\n      <path\n         id=\"path4190-3-4-4-2-4-44\"\n         d=\"m 13.539136,1020.3442 c -5.4762018,0.7163 -9.3348391,5.7363 -8.618501,11.2126 0.1068366,0.8167 0.3013791,1.5834 0.5869195,2.3184 0.8944251,-1.4948 4.6785625,-3.0072 9.3286135,-3.6155 4.650047,-0.6082 8.664887,-0.116 9.913714,1.0985 0.08689,-0.7837 0.108651,-1.5788 0.0018,-2.3955 -0.716338,-5.4763 -5.736365,-9.3348 -11.212561,-8.6185 z m -6.9422189,15.5947 c 2.0622677,2.9901 5.6869969,4.7399 9.5362839,4.2364 3.852896,-0.504 6.904284,-3.122 8.125756,-6.5468 -1.507914,1.2228 -4.751777,2.3549 -8.608097,2.8594 -3.842923,0.5026 -7.2769135,0.2382 -9.0539429,-0.549 z\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#4a7030;fill-opacity:1;stroke:#000000;stroke-width:0.33333296px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         inkscape:connector-curvature=\"0\" />\n      <path\n         transform=\"matrix(0.99155285,-0.12970326,0.12970326,0.99155285,-0.48115893,1014.052)\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path9432\"\n         d=\"m 23,41 c -0.03581,0.14211 -0.05531,0.289355 -0.107418,0.42633 -0.02937,0.07721 -0.218091,0.161085 -0.265165,0.176777 -0.02795,0.0093 -0.06044,-0.0093 -0.08839,0 -0.320434,0.106811 -0.06291,0.04194 -0.265165,0.176777 -0.05482,0.03654 -0.121961,0.05184 -0.176777,0.08839 -0.03746,0.02498 -0.24688,0.228594 -0.265165,0.265165 -0.01318,0.02635 0.01318,0.06204 0,0.08839 -0.01863,0.03727 -0.06975,0.05112 -0.08839,0.08839 -0.01318,0.02635 0.0093,0.06044 0,0.08839 -0.02083,0.0625 -0.07241,0.112863 -0.08839,0.176777 -0.02144,0.08575 0,0.176776 0,0.265165 0,0.117851 0,0.235702 0,0.353553 0,0.05893 0,0.235702 0,0.176777 0,-0.05893 0,-0.235702 0,-0.176777 0,0.20624 0,0.412479 0,0.618719 0,0.021 0.0099,0.333743 0,0.353553 -0.01863,0.03727 -0.04886,0.07521 -0.08839,0.08839 -0.0559,0.01863 -0.120875,-0.01863 -0.176777,0 -0.03953,0.01318 -0.05893,0.05893 -0.08839,0.08839 -0.05893,0.02946 -0.112863,0.07241 -0.176777,0.08839 -0.05717,0.01429 -0.11961,-0.01429 -0.176777,0 -0.127827,0.03196 -0.231215,0.127842 -0.353553,0.176777 -0.08651,0.0346 -0.178659,0.05379 -0.265165,0.08839 -0.122338,0.04894 -0.235702,0.117851 -0.353553,0.176777 -0.05893,0.02946 -0.121961,0.05184 -0.176777,0.08839 -0.06934,0.04622 -0.107439,0.130552 -0.176777,0.176777 -0.05482,0.03654 -0.12196,0.05184 -0.176776,0.08839 -0.03467,0.02311 -0.05112,0.06976 -0.08839,0.08839 -0.02635,0.01318 -0.06204,-0.01318 -0.08839,0 -0.404519,0.202259 0.375068,-0.03664 -0.265165,0.176776 -0.02795,0.0093 -0.06044,-0.0093 -0.08839,0 -0.0625,0.02083 -0.114276,0.06755 -0.176776,0.08839 -0.02795,0.0093 -0.06204,-0.01318 -0.08839,0 -0.09501,0.04751 -0.174074,0.122122 -0.265165,0.176776 -0.05649,0.0339 -0.12196,0.05185 -0.176776,0.08839 -0.06934,0.04622 -0.117851,0.117851 -0.176777,0.176776 -0.02946,0.02946 -0.05893,0.05893 -0.08839,0.08839 -0.02946,0.02946 -0.06975,0.05112 -0.08839,0.08839 -0.02635,0.05271 0.02635,0.124072 0,0.176777 -0.01863,0.03727 -0.06528,0.05372 -0.08839,0.08839 -0.03654,0.05482 -0.06756,0.114277 -0.08839,0.176777 -0.02305,0.06916 0.037,0.176776 0,0.176776 -0.02946,0 0,-0.117851 0,-0.08839 0,0.05893 -0.01863,0.120875 0,0.176777 0.01318,0.03953 0.06527,0.05372 0.08839,0.08839 0.03654,0.05482 0.05184,0.121961 0.08839,0.176777 0.02311,0.03467 0.05893,0.05892 0.08839,0.08839 0.158222,0.158223 0.368936,0.311314 0.441941,0.53033 0.0093,0.02795 0,0.05893 0,0.08839 0,0.04938 -0.01739,0.389781 0,0.441941 0.02083,0.0625 0.06756,0.114277 0.08839,0.176777 0.01863,0.0559 -0.03269,0.127748 0,0.176777 0.04622,0.06934 0.126776,0.11011 0.176776,0.176776 0.03953,0.0527 0.05185,0.121961 0.08839,0.176777 0.0878,0.131695 0.347621,0.227437 0.441941,0.265165 0.03965,0.01586 0.215221,0 0.265166,0 0.294627,0 0.589255,0 0.883883,0 0.353553,0 0.707107,0 1.06066,0 0.147314,0 0.294628,0 0.441942,0 0.05893,0 0.11961,0.01429 0.176777,0 0.221176,-0.05529 0.522214,-0.42571 0.618718,-0.618718 0.01318,-0.02635 -0.01634,-0.06387 0,-0.08839 0.06934,-0.104006 0.195828,-0.161158 0.265165,-0.265165 0.03654,-0.05482 0.0418,-0.130192 0.08839,-0.176776 0.04659,-0.04659 0.120285,-0.05449 0.176777,-0.08839 0.09109,-0.05465 0.176777,-0.117851 0.265165,-0.176776 0.08839,-0.05893 0.19005,-0.101661 0.265165,-0.176777 0.03168,-0.03168 0.241916,-0.348945 0.265165,-0.441942 0.02609,-0.104345 -0.06855,-0.30124 0.08839,-0.353553 0.08385,-0.02795 0.176776,0 0.265165,0 0.02946,0 0.06204,-0.01318 0.08839,0 0.03727,0.01863 0.06975,0.05112 0.08839,0.08839 0.01318,0.02635 0,0.05893 0,0.08839 0,0.02946 0,0.05893 0,0.08839 0,0.03981 0.01345,0.238265 0,0.265165 -0.01863,0.03727 -0.06975,0.05112 -0.08839,0.08839 -0.01318,0.02635 0,0.05893 0,0.08839 0,0.02946 0,0.05893 0,0.08839 0,0.07236 -0.01909,0.384673 0,0.441942 0.213411,0.640233 -0.02548,-0.139354 0.176777,0.265165 0.02894,0.05788 -0.02615,0.363503 0,0.441941 0.02083,0.0625 0.06755,0.114277 0.08839,0.176777 0.0093,0.02795 -0.0071,0.0598 0,0.08839 0.02875,0.114991 0.103625,0.332214 0.176777,0.441941 0.02212,0.03318 0.333019,0.34842 0.353553,0.353554 0.08575,0.02144 0.176777,0 0.265165,0 0.02946,0 0.05981,0.0071 0.08839,0 0.09039,-0.0226 0.173263,-0.07307 0.265165,-0.08839 0.08718,-0.01453 0.176776,0 0.265165,0 0.294627,0 0.589255,0 0.883883,0 0.176777,0 0.353553,0 0.53033,0 0.05893,0 0.120875,-0.01863 0.176777,0 0.03953,0.01318 0.05112,0.06976 0.08839,0.08839 0.145552,0.07278 0.36502,0.129716 0.53033,0.08839 0.04042,-0.01011 0.05893,-0.117851 0.08839,-0.08839 0.02946,0.02946 -0.08839,0.130055 -0.08839,0.08839 0,-0.09317 0.07012,-0.173805 0.08839,-0.265165 0.03751,-0.187574 -0.04068,-0.251117 -0.08839,-0.441942 -0.0071,-0.02858 0.0093,-0.06044 0,-0.08839 -0.07911,-0.237341 -0.292782,-0.34388 -0.441941,-0.53033 -0.06636,-0.08295 -0.124073,-0.172932 -0.176777,-0.265165 -0.06537,-0.114401 -0.111405,-0.239153 -0.176777,-0.353554 0.0086,-0.195478 -0.18345,-0.23098 -0.265165,-0.353553 -0.03654,-0.05482 -0.05449,-0.120284 -0.08839,-0.176777 -0.05466,-0.09109 -0.12927,-0.17015 -0.176777,-0.265165 -0.01318,-0.02635 0.01318,-0.06204 0,-0.08839 -0.0213,-0.0426 -0.351128,-0.351734 -0.353553,-0.353554 -0.0527,-0.03953 -0.121961,-0.05184 -0.176777,-0.08839 -0.08021,-0.05347 -0.441724,-0.309032 -0.53033,-0.441942 -0.01634,-0.02451 0,-0.05893 0,-0.08839 0,-0.397869 -0.01429,0.08575 0.08839,-0.53033 0.0097,-0.05812 0,-0.117851 0,-0.176777 0,-0.08839 0,-0.176776 0,-0.265165 0,-0.147314 0,-0.294628 0,-0.441942 0,-0.02946 0,-0.05892 0,-0.08839 0,-0.02946 0.01318,-0.06204 0,-0.08839 -0.01863,-0.03727 -0.06975,-0.05112 -0.08839,-0.08839 -0.0038,-0.0075 -0.0038,-0.346018 0,-0.353553 0.01863,-0.03727 0.05892,-0.05893 0.08839,-0.08839 0.02946,-0.02946 0.04886,-0.07521 0.08839,-0.08839 0.04888,-0.01629 0.441318,0 0.53033,0 0.602001,0 -0.138675,-0.01733 0.707106,0.08839 0.266749,0.03334 0.277853,-0.0631 0.530331,0.08839 0.07146,0.04287 0.117851,0.117851 0.176776,0.176777 0.05893,0.05893 0.117851,0.117851 0.176777,0.176776 0.05893,0.05893 0.126777,0.11011 0.176777,0.176777 0.102047,0.136063 0.08839,0.206851 0.08839,0.353554 0,0.05893 -0.01863,0.120875 0,0.176776 0.01318,0.03953 0.06975,0.05112 0.08839,0.08839 0.04167,0.08333 0.04672,0.181831 0.08839,0.265165 0.03727,0.07454 0.150424,0.09772 0.176776,0.176776 0.01863,0.0559 -0.02635,0.124072 0,0.176777 0.08839,0.176777 0.176777,0.132583 0.265165,0.265165 0.03654,0.05482 0.04886,0.124072 0.08839,0.176777 0.075,0.1 0.176776,0.176776 0.265165,0.265165 0.08839,0.08839 0.353553,0.353553 0.441942,0.441942 0.02946,0.02946 0.05372,0.06527 0.08839,0.08839 0.05482,0.03654 0.120284,0.05449 0.176777,0.08839 0.09109,0.05466 0.17015,0.12927 0.265165,0.176777 0.08333,0.04167 0.179528,0.05169 0.265165,0.08839 0.121108,0.0519 0.232445,0.124874 0.353553,0.176777 0.08564,0.0367 0.179529,0.05169 0.265165,0.08839 0.121108,0.0519 0.226862,0.140579 0.353553,0.176777 0.08499,0.02428 0.180178,-0.02428 0.265166,0 0.126691,0.0362 0.228553,0.13511 0.353553,0.176777 0.142522,0.04751 0.295288,0.0558 0.441942,0.08839 0.118585,0.02635 0.235702,0.05893 0.353553,0.08839 0.117851,0.02946 0.238309,0.04997 0.353553,0.08839 0.125,0.04167 0.228554,0.13511 0.353554,0.176776 0.02795,0.0093 0.06204,-0.01318 0.08839,0 0.03727,0.01863 0.05372,0.06528 0.08839,0.08839 0.06994,0.04663 0.452296,0.239154 0.53033,0.265165 0.02795,0.0093 0.06044,-0.0093 0.08839,0 0.288526,0.09617 0.07409,0.115468 0.441942,0.176777 0.08718,0.01453 0.176776,0 0.265165,0 0.32409,0 0.648181,0 0.972272,0 0.176776,0 0.353553,0 0.53033,0 0.05892,0 0.117851,0 0.176776,0 0.02946,0 0.06204,0.01318 0.08839,0 0.03727,-0.01863 0.05893,-0.05893 0.08839,-0.08839 0.02946,-0.02946 0.06976,-0.05112 0.08839,-0.08839 0.01318,-0.02635 0,-0.05893 0,-0.08839 0,-0.05893 0,-0.117851 0,-0.176776 0,-0.02946 -0.01634,-0.06387 0,-0.08839 0.04622,-0.06934 0.126777,-0.11011 0.176777,-0.176776 0.07906,-0.10541 0.09772,-0.248144 0.176777,-0.353554 0.05,-0.06667 0.117851,-0.117851 0.176776,-0.176776 0.05893,-0.05893 0.117852,-0.117851 0.176777,-0.176777 0.02946,-0.02946 0.04886,-0.07521 0.08839,-0.08839 0.0559,-0.01863 0.120875,0.01863 0.176776,0 0.03953,-0.01318 0.05893,-0.05893 0.08839,-0.08839 0.02946,-0.02946 0.06975,-0.05112 0.08839,-0.08839 0.01318,-0.02635 0,-0.05893 0,-0.08839 0,-0.02946 0.0093,-0.06044 0,-0.08839 -0.04113,-0.123386 -0.204652,-0.361257 -0.265165,-0.441942 -0.05551,-0.07402 -0.229,-0.192834 -0.265165,-0.265165 -0.01318,-0.02635 0.01318,-0.06204 0,-0.08839 -0.01863,-0.03727 -0.05893,-0.05893 -0.08839,-0.08839 -0.05893,-0.05893 -0.124718,-0.111705 -0.176776,-0.176777 -0.06636,-0.08295 -0.10877,-0.183557 -0.176777,-0.265165 -0.133372,-0.160046 -0.294628,-0.294628 -0.441942,-0.441942 -0.02946,-0.02946 -0.06527,-0.05372 -0.08839,-0.08839 -0.130417,-0.195625 -0.03578,-0.200631 -0.265165,-0.353553 -0.02452,-0.01634 -0.06204,0.01318 -0.08839,0 -0.19003,-0.09501 -0.345864,-0.248145 -0.53033,-0.353554 -0.114402,-0.06537 -0.243922,-0.103688 -0.353554,-0.176777 -0.06934,-0.04622 -0.111704,-0.124718 -0.176777,-0.176776 -0.08295,-0.06636 -0.180181,-0.113039 -0.265165,-0.176777 -0.03333,-0.025 -0.05506,-0.06339 -0.08839,-0.08839 -0.08498,-0.06374 -0.239401,-0.07372 -0.265165,-0.176777 -0.02021,-0.08084 0.117851,-0.235702 0.176777,-0.176777 0.05892,0.05893 -0.251313,0.214045 -0.176777,0.176777 0.131762,-0.06588 0.233679,-0.179541 0.353553,-0.265165 0.206813,-0.147724 0.438215,-0.261438 0.618719,-0.441942 0.02946,-0.02946 0.07521,-0.04886 0.08839,-0.08839 0.01863,-0.0559 0,-0.117851 0,-0.176777 0,-0.05893 0,-0.117851 0,-0.176777 0,-0.08839 0.03283,-0.183098 0,-0.265165 -0.03095,-0.07737 -0.126777,-0.11011 -0.176777,-0.176776 -0.03953,-0.05271 -0.05184,-0.121961 -0.08839,-0.176777 -0.02311,-0.03467 -0.05892,-0.05893 -0.08839,-0.08839 -0.05893,-0.05893 -0.117851,-0.117851 -0.176777,-0.176777 -0.147314,-0.147314 -0.294628,-0.294628 -0.441942,-0.441942 -0.117851,-0.117851 -0.235702,-0.235702 -0.353553,-0.353553 -0.02946,-0.02946 -0.05112,-0.06976 -0.08839,-0.08839 -0.02635,-0.01318 -0.06482,0.01768 -0.08839,0 -0.1,-0.075 -0.176776,-0.176777 -0.265165,-0.265166 -0.08839,-0.08839 -0.19251,-0.163448 -0.265165,-0.265165 -0.07658,-0.107218 -0.106943,-0.241819 -0.176777,-0.353553 -0.07808,-0.124922 -0.173138,-0.238521 -0.265165,-0.353553 -0.02603,-0.03254 -0.06975,-0.05112 -0.08839,-0.08839 -0.01318,-0.02635 0.01318,-0.06204 0,-0.08839 -0.06052,-0.121039 -0.433878,-0.261133 -0.441942,-0.265165 -0.294627,-0.147314 -0.578039,-0.319604 -0.883883,-0.441942 -0.146353,-0.219514 -0.360312,-0.03171 -0.53033,-0.08839 -0.148535,-0.04951 -0.06225,-0.160627 -0.08839,-0.265165 -0.01598,-0.06391 -0.06392,-0.115608 -0.08839,-0.176777 -0.0346,-0.08651 -0.05379,-0.178659 -0.08839,-0.265165 -0.05876,-0.146888 -0.17623,-0.323361 -0.265165,-0.441942 -0.025,-0.03333 -0.04672,-0.08839 -0.08839,-0.08839 -0.06588,0 -0.113217,0.07105 -0.176776,0.08839 -0.262062,0.07147 -0.526867,0.136483 -0.795495,0.176777 -0.585643,0.08785 -1.181525,0.09303 -1.767767,0.176777 -0.74006,0.105722 -0.167307,0.08839 -0.707107,0.08839 -0.117851,0 -0.236423,0.01301 -0.353554,0 -0.178119,-0.01979 -0.351734,-0.07351 -0.53033,-0.08839 -0.988093,-0.08234 -0.059,0.132569 -1.237437,-0.08839 -0.238795,-0.04477 -0.468069,-0.133315 -0.707106,-0.176776 -0.08696,-0.01581 -0.176777,0 -0.265165,0 -0.05893,0 -0.120875,-0.01863 -0.176777,0 -0.0625,0.02083 -0.114277,0.06755 -0.176777,0.08839 -0.0559,0.01863 -0.124072,-0.02635 -0.176776,0 -0.03727,0.01863 -0.04886,0.07521 -0.08839,0.08839 -0.0559,0.01863 -0.117851,0 -0.176776,0 -0.117852,0 -0.235703,0 -0.353554,0 -0.104881,0 -0.621324,0.01716 -0.707107,0 -0.129203,-0.02584 -0.228553,-0.13511 -0.353553,-0.176776 -0.02795,-0.0093 -0.05893,0 -0.08839,0 -0.08839,0 -0.176777,0 -0.265165,0 -0.294628,0 -0.589256,0 -0.883884,0 -0.294628,0 -0.589256,0 -0.883883,0 -0.102312,0 -0.363031,-0.01973 -0.441942,0 -0.06391,0.01598 -0.117851,0.05893 -0.176777,0.08839 -0.404087,0.202044 0.09136,-0.05482 -0.441942,0.265165 -0.05649,0.03389 -0.12196,0.05184 -0.176776,0.08839 -0.08046,0.05364 -0.186823,0.225994 -0.265165,0.265165 -0.02635,0.01318 -0.06204,-0.01318 -0.08839,0 -0.201184,0.201185 0.01831,0.02336 -0.176776,0.08839 -0.640234,0.213411 0.139353,-0.02548 -0.265165,0.176776 -0.02635,0.01318 -0.06387,-0.01634 -0.08839,0 -0.06934,0.04623 -0.11011,0.126777 -0.176776,0.176777 -0.10541,0.07906 -0.243922,0.103689 -0.353554,0.176777 -0.03467,0.02311 -0.05112,0.06975 -0.08839,0.08839 -0.02635,0.01318 -0.05893,0 -0.08839,0 -0.08839,0 -0.177979,-0.01453 -0.265165,0 -0.0919,0.01532 -0.17558,0.06279 -0.265165,0.08839 -0.116804,0.03337 -0.233728,0.06842 -0.353553,0.08839 -0.05812,0.0097 -0.117851,0 -0.176777,0 -0.02946,0 -0.06204,-0.01318 -0.08839,0 -0.03727,0.01863 -0.05505,0.06339 -0.08839,0.08839 -0.125767,0.09433 -0.34416,0.206881 -0.441942,0.353554 -0.03654,0.05482 -0.05184,0.12196 -0.08839,0.176776 -0.02311,0.03467 -0.06976,0.05112 -0.08839,0.08839 -0.02635,0.0527 0.01863,0.120875 0,0.176776 -0.02083,0.0625 -0.05892,0.117852 -0.08839,0.176777 -0.02946,0.05893 -0.04723,0.125333 -0.08839,0.176777 -0.07809,0.09761 -0.187078,0.167556 -0.265165,0.265165 -0.194734,0.04451 -0.04672,0.181832 -0.08839,0.265165 -0.01863,0.03727 -0.06975,0.05112 -0.08839,0.08839 -0.01318,0.02635 0.0093,0.06044 0,0.08839 -0.182879,0.548635 0.0071,-0.293761 -0.176777,0.441941 -0.01429,0.05717 0,0.117851 0,0.176777 0,0.176777 0,0.353553 0,0.53033 0,0.05893 0,0.117851 0,0.176777 0,0.02946 0.01318,0.06204 0,0.08839 -0.01863,0.03727 -0.05893,0.05893 -0.08839,0.08839 -0.05893,0.05893 -0.117851,0.117852 -0.176777,0.176777 -0.05893,0.05893 -0.111704,0.124719 -0.176777,0.176777 -0.165902,0.132722 -0.353553,0.235702 -0.53033,0.353553 -0.08839,0.05893 -0.180181,0.113039 -0.265165,0.176777 -0.02875,0.02157 -0.257313,0.241609 -0.265165,0.265165 -0.01863,0.0559 0.01863,0.120875 0,0.176777 -0.01318,0.03953 -0.06528,0.05372 -0.08839,0.08839 -0.154463,0.231694 -0.03304,0.154463 -0.176777,0.441942 -0.01863,0.03727 -0.06975,0.05112 -0.08839,0.08839 -0.01318,0.02635 0.01318,0.06204 0,0.08839 -0.01863,0.03727 -0.06975,0.05112 -0.08839,0.08839 -0.01318,0.02635 0,0.05893 0,0.08839 0,0.131559 0.01318,0.112818 -0.08839,0.265165 -0.02311,0.03467 -0.06528,0.05372 -0.08839,0.08839 -0.03654,0.05482 -0.05185,0.12196 -0.08839,0.176776 -0.02311,0.03467 -0.06528,0.05372 -0.08839,0.08839 -0.09763,0.146439 -0.08839,0.200746 -0.08839,0.353553 0,0.02946 -0.01318,0.06204 0,0.08839 0.01863,0.03727 0.04886,0.07521 0.08839,0.08839 0.05065,0.01688 0.358961,0 0.441942,0 0.03981,0 0.238265,0.01345 0.265165,0 0.301776,-0.150889 -0.273361,-0.08839 0.353553,-0.08839 0.441942,0 0.883884,0 1.325825,0 0.08839,0 0.176777,0 0.265165,0 0.05893,0 0.118996,0.01156 0.176777,0 0.09136,-0.01827 0.173805,-0.07012 0.265165,-0.08839 0.05778,-0.01156 0.119611,0.01429 0.176777,0 0.237096,-0.05927 0.352622,-0.299775 0.53033,-0.441942 0.08295,-0.06636 0.17015,-0.129269 0.265165,-0.176776 0.166667,-0.08333 0.363663,-0.09344 0.53033,-0.176777 0.03727,-0.01863 0.05372,-0.06528 0.08839,-0.08839 0.05482,-0.03654 0.121961,-0.05185 0.176777,-0.08839 0.03467,-0.02311 0.05893,-0.05892 0.08839,-0.08839 0.05893,-0.05893 0.117852,-0.117851 0.176777,-0.176777 0.05893,-0.05893 0.126777,-0.11011 0.176777,-0.176777 0.03953,-0.0527 0.05184,-0.12196 0.08839,-0.176776 0.04622,-0.06934 0.139509,-0.102241 0.176777,-0.176777 0.04167,-0.08333 0.05379,-0.178659 0.08839,-0.265165 0.02447,-0.06117 0.07241,-0.112863 0.08839,-0.176777 0.01429,-0.05717 0,-0.117851 0,-0.176776 0,-0.05893 0,-0.117852 0,-0.176777 0,-0.05893 0,-0.117851 0,-0.176777 0,-0.05893 0.01863,-0.120875 0,-0.176776 -0.01318,-0.03953 -0.06975,-0.05112 -0.08839,-0.08839 -0.02811,-0.05621 0.0244,-0.368736 0,-0.441942 -0.01318,-0.03953 -0.06975,-0.05112 -0.08839,-0.08839 -0.01318,-0.02635 0,-0.05892 0,-0.08839 0,-0.08839 -0.02144,-0.179416 0,-0.265165 0.01598,-0.06391 0.05184,-0.121961 0.08839,-0.176777 0.146574,-0.21986 0.02031,-0.01015 0.176777,-0.08839 0.03727,-0.01863 0.04886,-0.07521 0.08839,-0.08839 0.04046,-0.01349 0.392607,0 0.441942,0 0.235702,0 0.471405,0 0.707107,0 0.08839,0 0.177665,0.0125 0.265165,0 1.22805,-0.175435 -0.1947,0.0045 0.53033,-0.176776 0.08575,-0.02144 0.181312,0.02795 0.265165,0 0.0625,-0.02083 0.114277,-0.06755 0.176777,-0.08839 0.02795,-0.0093 0.06204,0.01318 0.08839,0 0.03727,-0.01863 0.04886,-0.07521 0.08839,-0.08839 0.0559,-0.01863 0.118996,0.01156 0.176777,0 0.09136,-0.01827 0.172932,-0.07521 0.265165,-0.08839 0.116667,-0.01667 0.235702,0 0.353554,0 0.117851,0 0.235702,0 0.353553,0 0.117851,0 0.235702,0 0.353553,0 0.05893,0 0.120875,0.01863 0.176777,0 0.159186,0.05095 0.164888,-0.141718 0.265165,-0.176777 C 22.746868,41.031014 22.875806,41.024259 23,41 Z\"\n         style=\"fill:#d9b207;fill-opacity:1;stroke:none\" />\n    </g>','2016-01-25 20:35:06',NULL),(23,'panicked','    <g\n       transform=\"matrix(3.9662114,0.51881304,-0.51881304,3.9662114,669.09381,-3541.2409)\"\n       id=\"panicked\">\n      <title\n         id=\"title10180\">panicked</title>\n      <path\n         inkscape:connector-curvature=\"0\"\n         id=\"path10132\"\n         d=\"m 15.95975,1054.4483 c 0.542075,-0.1835 1.098125,-0.3008 1.62866,-0.5597 1.089401,-0.5317 2.154477,-1.2236 3.197696,-2.0572 1.043219,-0.8335 2.052857,-1.8069 3.053218,-2.9206 1.000362,-1.1138 1.987007,-2.3542 2.947835,-3.7264 -2.48025,-0.8995 -4.908418,-1.5027 -7.297554,-1.8188 -2.389136,-0.3161 -4.739241,-0.3451 -7.035534,-0.057 -2.275952,0.2858 -4.5139639,0.8929 -6.6993817,1.7903 2.1793729,4.282 5.8126087,7.5664 10.2050607,9.3491 z\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#831d00;fill-opacity:1;stroke:#000000;stroke-width:0.66112155px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\" />\n      <path\n         inkscape:connector-curvature=\"0\"\n         id=\"path4190-34-6-44\"\n         d=\"m 20.793331,1016.4693 c -10.8612917,1.4207 -18.5230737,11.3886 -17.1023276,22.2499 0.3015425,2.3052 1.0660799,4.4199 2.0636859,6.38 2.1854178,-0.8974 4.4234297,-1.5045 6.6993817,-1.7903 2.296293,-0.2884 4.646398,-0.2594 7.035534,0.057 2.389136,0.3161 4.817304,0.9193 7.297554,1.8188 -0.960828,1.3722 -1.947473,2.6126 -2.947835,3.7264 -1.000361,1.1137 -2.009999,2.0871 -3.053218,2.9206 -1.043219,0.8336 -2.108295,1.5255 -3.197696,2.0572 -0.530535,0.2589 -1.086585,0.3762 -1.62866,0.5597 3.07023,1.246 6.457067,1.8027 9.977126,1.3423 10.861291,-1.4208 18.496141,-11.3536 17.075395,-22.2149 -1.420746,-10.8613 -11.357649,-18.5272 -22.21894,-17.1064 z\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffff00;fill-opacity:1;stroke:#000000;stroke-width:0.66112155px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\" />\n      <circle\n         transform=\"matrix(0.26221497,-0.03429987,0.03429978,0.26221424,-144.51323,881.80748)\"\n         id=\"path4190-3-0-8-8\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.1677853,-0.02194768,0.02194762,0.16778494,-87.15565,935.68463)\"\n         id=\"path4190-3-3-7-8-3-5-7\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#000000;fill-opacity:1;stroke:none;stroke-width:6.00000668;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <path\n         sodipodi:nodetypes=\"cc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path9885-8-5\"\n         d=\"m 38.211328,1019.0754 c 7.804872,8.7132 10.010527,18.5417 3.927081,30.0216\"\n         style=\"fill:none;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path9885-6-7-0\"\n         d=\"m 42.544225,1022.13 c 5.807783,6.7105 7.475322,14.2562 3.013676,23.0388\"\n         style=\"fill:none;stroke:#000000;stroke-width:0.75341046px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path9885-6-7-1\"\n         d=\"m 46.253676,1024.0747 c 3.657066,5.7757 4.886768,12.1147 2.523034,19.288\"\n         style=\"fill:none;stroke:#000000;stroke-width:0.52885669px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path9885-6-7-1-7\"\n         d=\"m 48.967511,1025.7366 c 2.90507,4.5967 3.882913,9.6412 2.007722,15.3486\"\n         style=\"fill:none;stroke:#000000;stroke-width:0.42037135px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n    </g>','2016-01-25 20:32:45',NULL),(24,'paralyzed','    <g\n       transform=\"matrix(6,0,0,6,316.32598,-5606.7068)\"\n       id=\"paralyzed\">\n      <title\n         id=\"title4171\">paralyzed</title>\n      <path\n         sodipodi:nodetypes=\"czzcczzzcc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4534\"\n         d=\"m 22.161172,1025.0118 c 0,0 1.618302,1.4103 2.197802,2.1978 0.5795,0.7875 0.886544,1.5058 1.282052,2.442 0.395508,0.9362 1.037851,3.1746 1.037851,3.1746 L 28,1032.3622 c 0,0 -0.419222,-1.424 -0.588523,-2.2222 -0.169301,-0.7982 -0.419799,-1.6868 -0.411477,-2.5641 0.0083,-0.8773 0.366676,-1.9835 0.472527,-2.6252 0.105851,-0.6417 0.183151,-1.221 0.183151,-1.221 z\"\n         style=\"fill:url(#linearGradient4160);fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cczzcczzzcccccczzzzzzzzcccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4536\"\n         d=\"m 27.838828,1036.3622 1.831502,4.3394 c 0,0 -0.154473,0.6877 -1.159951,1.3431 -1.005478,0.6554 -3.803897,0.8751 -5.189256,1.5873 -1.385359,0.7122 -3.037874,1.6233 -3.113553,2.381 -0.07568,0.7577 -0.273384,0.4141 0.427351,0.4884 0.639685,-0.7804 1.215747,-1.1425 2.319902,-1.7118 1.104156,-0.5694 2.686068,-1.0027 3.601954,-1.3053 0.915886,-0.3026 1.736942,-0.3845 2.443223,-0.8291 0.706281,-0.4446 1,-1.293 1,-1.293 l 1.501832,4.7729 1.709401,4.884 1.526252,-0.6569 L 33,1045.7077 l -1.6337,-4.3455 c 0,0 0.743981,0.2008 1.478633,0.3162 0.734652,0.1154 1.628811,0.4626 2.564102,0.3663 0.935291,-0.096 2.286887,-0.349 3.052503,-0.7936 0.765616,-0.4446 1.631859,-1.2436 1.538462,-1.7094 -0.0934,-0.4658 -0.123322,-0.1795 -0.561661,-0.1795 -0.438339,0 -0.716973,0.7313 -1.159951,1 -0.442978,0.2687 -1.221001,0.4615 -1.465201,0.5836 -0.2442,0.1221 -1.813187,0.4164 -2.912088,0.1111 -1.098901,-0.3052 -2.460318,-0.2942 -2.460318,-0.2942 L 31,1040.5795 l -1.879121,-4.7619 z\"\n         style=\"fill:#ff37a2;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cczzzczccczc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4538\"\n         d=\"m 19.84127,1038.3622 -4.578755,2.3394 c 0,0 0.238646,1.2608 0.915751,1.6606 0.677105,0.3998 2.065814,0.3868 2.821734,0 0.75592,-0.3868 1.057631,-1.2312 1.32967,-1.8437 0.272039,-0.6125 0.366301,-1.7094 0.366301,-1.7094 0,0 0.748888,0.083 0.9768,-0.3053 0.227913,-0.3886 0.203936,-0.6887 0.183151,-1.1416 0.144078,-0.3236 3.540903,-5 3.540903,-5 -1.492144,1.4915 -2.765504,3.2102 -4.396825,4.5543 0,0 -0.737904,-0.094 -1,0.1832 -0.262096,0.2772 -0.15873,1.2625 -0.15873,1.2625 z\"\n         style=\"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.5;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cczzzczccczc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4538-1\"\n         d=\"m 19.75608,1038.0496 -5.106533,0.6009 c 0,0 -0.50257,-1.1806 -0.161973,-1.8894 0.340553,-0.7087 1.502108,-1.47 2.3455,-1.5687 0.843351,-0.099 1.563595,0.4354 2.13024,0.7933 0.566514,0.3581 1.254785,1.2173 1.254785,1.2173 0,0 0.576349,-0.4854 0.981642,-0.2893 0.406218,0.1948 0.552403,0.4591 0.786902,0.8471 0.299557,0.1891 5.722966,2.1877 5.722966,2.1877 -2.069465,-0.4103 -4.083415,-1.131 -6.18665,-1.3413 0,0 -0.561083,0.4883 -0.933075,0.4036 -0.371775,-0.085 -0.833804,-0.9612 -0.833804,-0.9612 z\"\n         style=\"fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.5;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cczzzzzzzzzzzczzzcc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4532\"\n         d=\"m 17,1023.8518 -3.263736,-0.8547 c 0,0 -1.985765,-1.895 -2.503053,-3.6349 -0.517288,-1.7399 -0.430063,-5.0749 0.18315,-6.4994 0.613213,-1.4245 1.65654,-2.8574 4.090355,-4.4017 2.433815,-1.5443 6.743132,-2.3693 10.01221,-2.0989 3.269078,0.2704 6.02835,0.8237 8.481074,2.2271 2.452724,1.4034 4.399642,3.4852 5.80464,5.7729 1.404998,2.2877 2.337351,5.5319 2.442002,7.536 0.104651,2.0041 -0.07168,2.9369 -0.854701,4.0293 -0.783025,1.0924 -2.197113,1.6754 -3.391941,2.0147 -1.194828,0.3393 -2.371416,0.5068 -3.506716,0.061 -1.1353,-0.4458 -1.854679,-1.9691 -2.747252,-2.641 -0.892573,-0.6719 -2.503053,-1.4493 -2.503053,-1.4493 0,0 -1.893516,0.8234 -2.991453,1.0378 -1.097937,0.2144 -2.475346,0.3731 -3.540903,0.1832 -1.065557,-0.1899 -2.169531,-0.7278 -2.710623,-1.16 -0.541092,-0.4322 -0.708181,-0.9768 -0.708181,-0.9768 -0.880392,0.087 -1.6234,0.6544 -2.291819,0.8547 z\"\n         style=\"fill:url(#radialGradient4152);fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n    </g>','2016-01-25 20:32:45',NULL),(25,'petrified','    <g\n       id=\"petrified\"\n       transform=\"translate(-300,-42)\">\n      <title\n         id=\"title5456\">petrified</title>\n      <path\n         inkscape:connector-curvature=\"0\"\n         id=\"path5099-2\"\n         d=\"m 727.47698,280.98474 c -1.25054,-1.05096 -2.29113,-2.42126 -3.75168,-3.15288 -0.3576,-0.17904 -0.49075,0.66965 -0.84849,0.8485 -0.67882,0.33936 -1.86677,-0.33936 -2.54559,0 -0.3576,0.17904 -0.49075,0.66965 -0.84854,0.84854 -0.25296,0.12624 -0.56568,0 -0.84855,0 -0.84849,0 -1.69704,0 -2.54558,0 -1.69704,0 -3.39408,0 -5.09117,0 -3.67694,0 -7.35389,0 -11.03083,0 -1.41422,0 -2.84266,-0.20016 -4.24267,0 -0.62607,0.0893 -1.09704,0.64853 -1.69704,0.84855 -0.26832,0.0893 -0.56568,0 -0.84855,0 -0.56568,0 -1.13136,0 -1.69704,0 -1.41422,0 -2.82844,0 -4.24262,0 -2.82845,0 -5.65685,0 -8.4853,0 -0.35712,0 -4.83873,-0.12624 -5.09116,0 -0.71554,0.3576 -0.98151,1.33929 -1.69704,1.69704 -0.50597,0.25296 -1.1604,-0.17904 -1.69709,0 -0.6,0.20016 -1.08346,0.69513 -1.69704,0.84854 -0.54879,0.13728 -1.13136,0 -1.69704,0 -1.97991,0 -3.95981,0 -5.93971,0 -0.56568,0 -1.14826,-0.13728 -1.69704,0 -0.61359,0.1536 -1.09709,0.64853 -1.69709,0.8485 -0.26832,0.0893 -0.59554,-0.12624 -0.8485,0 -0.3576,0.17904 -0.46032,0.75153 -0.84854,0.84854 -0.8232,0.20592 -1.69704,0 -2.54559,0 -0.56568,0 -1.13136,0 -1.69704,0 -0.56568,0 -1.1604,-0.17904 -1.69708,0 -0.75893,0.25296 -0.98151,1.3393 -1.69704,1.69704 -0.25296,0.12624 -0.56568,0 -0.84855,0 -0.84849,0 -1.69704,0 -2.54558,0 -1.69704,0 -3.39408,0 -5.09117,0 -0.56568,0 -1.14235,0.11088 -1.69704,0 -3.68726,-0.73742 -1.5708,-0.54168 -4.24262,-2.54558 -1.01194,-0.75893 -2.34168,-0.99538 -3.39413,-1.69704 -0.33264,-0.22176 -0.56568,-0.56568 -0.84855,-0.84855 -0.56568,-0.56568 -1.13136,-1.13136 -1.69704,-1.69704 -1.69704,-1.69704 -3.39412,-3.39413 -5.09116,-5.09117 -0.44688,-0.44688 -2.09242,-2.31897 -2.54559,-2.54558 -0.25296,-0.12624 -0.59553,0.12624 -0.84854,0 -0.16224,-0.0811 -3.31287,-3.2317 -3.39408,-3.39413 -0.12912,-0.25824 0,-2.16341 0,-2.54558 0,-2.26272 0,-4.52549 0,-6.78821 0,-1.9799 0,-3.95981 0,-5.93971 0,-0.55757 -0.15936,-2.06683 0,-2.54559 0.20016,-0.6 0.64853,-1.09704 0.84849,-1.69704 0.2664,-0.79939 -0.27504,-4.54104 0,-5.09116 0.17904,-0.3576 0.62664,-0.51572 0.84855,-0.84855 0.70166,-1.05245 1.04625,-2.30942 1.69704,-3.39408 0.52469,-0.87451 1.1724,-1.67112 1.69709,-2.54558 0.32544,-0.54235 0.49771,-1.17087 0.84849,-1.69709 1.83197,-2.7479 -0.1056,0.35328 1.69709,-0.8485 0.66562,-0.44352 1.13136,-1.1314 1.69704,-1.69708 1.21838,-1.21834 3.17678,-2.91034 4.24262,-4.24263 0.63711,-0.79632 1.08519,-1.72973 1.69709,-2.54558 0.71275,-0.95035 1.83279,-1.59523 2.54559,-2.54559 0.37968,-0.50596 0.49771,-1.17081 0.84849,-1.69704 0.44352,-0.66566 1.3393,-0.98155 1.69709,-1.69708 0.25296,-0.50597 -0.25296,-1.19108 0,-1.69704 0.3576,-0.71554 1.44408,-0.93812 1.69704,-1.69704 0.17904,-0.53669 0,-1.13141 0,-1.69709 0,-0.28272 -0.12624,-0.59554 0,-0.8485 0.3576,-0.71558 1.44408,-0.93811 1.69704,-1.69709 0.15216,-0.456 0,-2.67571 0,-3.39412 0,-3.39408 0,-6.78821 0,-10.18234 0,-1.01448 -0.1848,-4.53734 0,-5.09117 0.20016,-0.6 0.64853,-1.09704 0.84854,-1.69704 0.17904,-0.53664 -0.25296,-1.19107 0,-1.69704 0.3576,-0.71553 1.25328,-1.03142 1.69704,-1.69709 0.35088,-0.52622 0.49772,-1.17081 0.84855,-1.69704 0.22176,-0.33264 0.66965,-0.49075 0.84854,-0.84854 0.12624,-0.25296 -0.0893,-0.58018 0,-0.8485 0.20016,-0.6 0.64853,-1.09708 0.8485,-1.69708 0.0893,-0.26832 -0.12624,-0.59554 0,-0.8485 0.3576,-0.71554 1.33929,-0.9815 1.69709,-1.69709 0.12672,-0.25296 -0.12624,-0.59553 0,-0.84849 0.17904,-0.3576 0.56568,-0.56568 0.84849,-0.84855 0.28272,-0.28272 0.56573,-0.56568 0.84855,-0.84854 2.81424,-2.81419 -0.39984,0.80001 0.84854,-1.69704 0.3576,-0.71554 1.3393,-0.98151 1.69704,-1.69704 0.25296,-0.50597 -0.25296,-1.19112 0,-1.69709 0.17904,-0.3576 0.56568,-0.56568 0.84854,-0.8485 0.28272,-0.28272 0.56568,-1.1314 0.8485,-0.84854 0.28272,0.28272 -1.18133,1.0704 -0.8485,0.84854 1.17668,-0.78446 2.2898,-1.66214 3.39408,-2.54558 1.98884,-1.5911 -0.55305,-0.57202 3.39413,-2.54558 0.25296,-0.12624 0.59554,0.12624 0.84855,0 0.3576,-0.17904 0.46032,-0.75154 0.84849,-0.84855 0.8232,-0.20592 1.74063,0.26832 2.54559,0 0.96748,-0.32256 1.69708,-1.13136 2.54558,-1.69704 0.84854,-0.56568 1.67112,-1.1724 2.54558,-1.69709 1.08466,-0.65078 2.34168,-0.99537 3.39413,-1.69704 0.33264,-0.22176 0.49075,-0.66964 0.84855,-0.84854 0.50064,-0.25008 1.9619,0.1944 2.54558,0 1.2,-0.39984 2.16696,-1.39027 3.39408,-1.69704 1.09762,-0.27456 2.3208,0.3576 3.39413,0 0.37968,-0.12624 0.51571,-0.62664 0.84854,-0.84854 5.92253,-3.94834 -4.17177,3.76521 4.24263,-2.54559 0.32016,-0.24 0.56568,-0.56568 0.84854,-0.84849 0.8485,-0.84855 1.69704,-1.69709 2.54558,-2.54559 0.8485,-0.84854 1.54709,-1.87997 2.54559,-2.54558 0.2352,-0.15696 0.61315,0.15696 0.84849,0 0.66567,-0.44352 1.07237,-1.19731 1.69709,-1.69709 5.25898,-4.2072 0.27696,0.0979 4.24263,-2.54558 1.94169,-1.29447 -0.5306,-0.67167 2.54558,-1.69704 0.76368,-0.2544 1.7819,0.2544 2.54558,0 1.2,-0.39984 2.16696,-1.39028 3.39413,-1.69704 0.59448,-0.1488 4.78392,0 5.09117,0 3.11126,0 6.22253,0 9.33379,0 0.11088,0 6.50472,0.1416 6.78821,0 0.3576,-0.17904 0.4908,-0.66965 0.84854,-0.84855 0.67882,-0.33936 1.86677,0.33936 2.54559,0 0.71553,-0.3576 0.91262,-1.54017 1.69709,-1.69704 1.10937,-0.22176 2.30625,0.31104 3.39408,0 0.98059,-0.28032 1.63344,-1.24099 2.54558,-1.69709 0.50597,-0.25296 1.19112,0.25296 1.69704,0 0.3576,-0.17904 0.4908,-0.66964 0.84854,-0.84849 0.25296,-0.12624 0.84855,-0.28272 0.84855,0 0,0.28272 -1.13136,0 -0.84855,0 0.5052,0 4.77288,0.15936 5.09117,0 0.71554,-0.3576 1.03143,-1.25333 1.69709,-1.69709 0.2352,-0.15696 0.56568,0 0.8485,0 0.56568,0 1.13136,0 1.69708,0 1.69704,0 3.39408,0 5.09117,0 0.56568,0 1.13136,0 1.69704,0 0.56568,0 1.14826,0.13728 1.69704,0 0.61359,-0.1536 1.09709,-0.64853 1.69709,-0.8485 0.26832,-0.0893 0.8485,-0.28272 0.8485,0 0,0.28272 -1.13136,0 -0.8485,0 2.26272,0 4.52549,0 6.78821,0 0.47376,0 3.85421,-0.1296 4.24262,0 0.75898,0.25296 0.98155,1.33925 1.69709,1.69704 0.50597,0.25296 1.19107,-0.25296 1.69704,0 0.3576,0.17904 0.51571,0.62664 0.84854,0.84855 4.2866,2.85773 0.0192,0.005 2.54559,0.84849 3.07613,1.02538 0.60389,0.40272 2.54558,1.69709 0.52623,0.35088 1.17082,0.49767 1.69704,0.8485 0.66562,0.44352 1.13136,1.13136 1.69704,1.69709 0.84855,0.84849 1.69709,1.69704 2.54559,2.54558 0.44688,0.44688 2.31902,2.09237 2.54558,2.54558 0.25776,0.51524 -0.25776,4.57589 0,5.09117 0.3576,0.71554 1.25333,1.03138 1.69709,1.69704 0.70161,1.05245 0.99537,2.34163 1.69704,3.39413 0.22176,0.33264 0.56568,0.56568 0.84854,0.8485 0.28272,0.28272 0.49075,0.66964 0.8485,0.84854 0.25296,0.12624 0.59553,-0.12624 0.84854,0 0.3576,0.17904 0.51571,0.62664 0.84855,0.84854 0.52622,0.35088 1.17081,0.49772 1.69704,0.8485 0.33264,0.22176 0.49075,0.66965 0.84854,0.84854 0.25296,0.12624 0.59554,-0.12672 0.8485,0 0.71553,0.3576 1.03142,1.25328 1.69708,1.69704 6.15231,3.07618 -1.34164,-0.89443 2.54559,1.69709 0.52622,0.35088 1.19107,0.46896 1.69704,0.8485 0.63998,0.48 1.01107,1.28549 1.69704,1.69709 0.76699,0.46032 1.77864,0.38832 2.54558,0.84849 1.37199,0.8232 2.06285,2.50661 3.39413,3.39413 0.2352,0.15696 0.59554,-0.12624 0.84854,0 0.3576,0.17904 0.52853,0.60854 0.8485,0.84854 0.81586,0.61186 1.74926,1.05999 2.54558,1.69704 0.62472,0.49978 1.05706,1.21704 1.69709,1.69704 0.50597,0.37968 1.17082,0.49772 1.69704,0.84855 0.33264,0.22176 0.56568,0.56568 0.84855,0.84854 0.56568,0.56568 1.13136,1.13136 1.69704,1.69704 0.28272,0.28272 0.56568,0.56568 0.84854,0.84855 0.28272,0.28272 0.66965,0.49075 0.8485,0.84849 0.1536,0.30672 0,3.65247 0,4.24267 0,0.44352 0.11136,3.17098 0,3.39408 -0.17904,0.3576 -0.6696,0.4908 -0.8485,0.84855 -0.12912,0.25824 0,2.16345 0,2.54558 0,1.69704 0,3.39413 0,5.09117 0,1.9799 0,3.95981 0,5.93971 0,0.56568 0,1.13136 0,1.69704 0,0.28272 -0.12672,0.59554 0,0.84855 0.17904,0.3576 0.66965,0.49075 0.8485,0.84849 0.12672,0.25296 -0.12624,0.59559 0,0.84855 0.17904,0.3576 0.62668,0.51571 0.84854,0.84854 0.35088,0.52622 0.49771,1.17082 0.84854,1.69704 0.23952,0.35952 2.19452,2.37005 2.54559,2.54558 0.25296,0.12624 0.59553,-0.12624 0.84849,0 0.3576,0.17904 0.56573,0.56568 0.84855,0.84855 0.28272,0.28272 0.62664,0.51571 0.84854,0.84854 0.35088,0.52623 0.49771,1.17082 0.8485,1.69704 0.22176,0.33264 0.62669,0.51571 0.84854,0.84855 0.70167,1.05244 0.99543,2.34163 1.69704,3.39408 0.22176,0.33264 0.66965,0.49075 0.84855,0.84854 0.12672,0.25296 -0.12624,0.59554 0,0.84854 1.29384,2.58764 0.67267,-1.55193 1.69704,2.54559 0.27456,1.09757 -0.27456,2.29651 0,3.39408 0.1536,0.61358 0.64852,1.09709 0.84854,1.69709 0.2544,0.76363 -0.2544,1.7819 0,2.54558 2.04874,6.14621 -0.2448,-1.33781 1.69704,2.54558 0.12672,0.25296 0,0.56568 0,0.8485 0,0.56568 -0.13728,1.14826 0,1.69709 0.1536,0.61353 0.64853,1.09704 0.84854,1.69704 0.0893,0.26832 0,0.56568 0,0.84854 0.28272,0.8485 0.51634,1.71509 0.84855,2.54559 0.23472,0.58718 0.69513,1.08345 0.84849,1.69704 0.13728,0.54878 -0.13728,1.14825 0,1.69704 0.13776,0.55041 2.18511,4.55044 2.54559,5.09116 0.22176,0.33264 0.66965,0.49076 0.84854,0.84855 0.25296,0.50597 -0.25296,1.19107 0,1.69704 0.17904,0.3576 0.66965,0.49075 0.84855,0.84854 0.11136,0.2232 0,2.95042 0,3.39413 0,1.41418 0,2.8284 0,4.24262 0,0.28272 0.0893,0.58023 0,0.84855 -0.82071,2.46211 -0.53204,0.99221 -1.69709,2.54558 -1.65384,2.20512 -1.35792,2.6137 -3.39408,4.24263 -0.79632,0.63705 -1.74927,1.05998 -2.54559,1.69704 -0.21504,0.17232 -2.98099,3.18758 -3.39412,3.39412 -0.25296,0.12624 -0.56568,0 -0.84855,0 -0.56568,0.28272 -1.17081,0.49772 -1.69704,0.84855 -0.33264,0.22176 -0.56568,0.56568 -0.84854,0.84849 -1.02989,1.02994 -1.88002,2.16711 -3.39408,2.54559 -0.6012,0.15024 -3.92107,-0.21456 -4.24267,0 -0.66562,0.44352 -1.05706,1.21709 -1.69704,1.69709 0.16128,1.57502 -2.00895,0.58017 -2.54559,0.84849 -0.3576,0.17904 -0.49075,0.66965 -0.84854,0.84855 -0.54221,0.2712 -2.71114,-0.22752 -3.39408,0 -0.6,0.20016 -1.08351,0.69513 -1.69709,0.84854 -0.54878,0.13728 -1.17182,-0.21024 -1.69704,0 -0.94685,0.37872 -1.5781,1.37458 -2.54558,1.69704 -0.80496,0.26832 -1.71356,-0.16656 -2.54559,0 -0.62016,0.12384 -1.09704,0.64853 -1.69704,0.84854 -0.26832,0.0893 -0.59558,-0.12624 -0.84854,0 -0.3576,0.17904 -0.49075,0.66965 -0.84855,0.8485 -0.54369,0.27168 -4.56417,-0.26352 -5.09116,0 -0.3576,0.17904 -0.49076,0.66965 -0.8485,0.84854 -0.25296,0.12672 -0.56568,0 -0.84854,0 -1.41423,0 -2.82845,0 -4.24263,0 -0.71054,0 -3.59736,0.16128 -4.24267,0 -0.61354,-0.1536 -1.09704,-0.64852 -1.69704,-0.84854 -0.26832,-0.0893 -0.58018,0.0893 -0.84854,0 -0.6,-0.20016 -1.07688,-0.72446 -1.69704,-0.8485 -0.83204,-0.16656 -1.74063,0.26832 -2.54559,0 -0.96749,-0.32256 -1.67112,-1.1724 -2.54558,-1.69708 -0.54231,-0.32544 -1.17082,-0.49767 -1.69704,-0.8485 -0.33264,-0.22176 -0.49075,-0.66965 -0.84855,-0.84854 -0.30912,-0.15456 -3.39412,0.1488 -3.39412,0 0,-0.28272 1.13136,0 0.84854,0 -0.84854,0 -1.69704,0 -2.54558,0 -0.84855,0 -1.70861,-0.13968 -2.54559,0 -0.88224,0.14688 -1.66017,0.72206 -2.54558,0.84854 -1.11999,0.15984 -2.26272,0 -3.39413,0 -0.56568,0 -1.1604,-0.17904 -1.69704,0 -0.37968,0.12624 -0.46896,0.72202 -0.84854,0.8485 -0.53664,0.17904 -1.13136,0 -1.69704,0 -1.13136,0 -2.26277,0 -3.39413,0 -0.0509,0 -6.27413,-0.17136 -6.78821,0 -3.74558,1.24852 3.08285,0.84854 -2.54558,0.84854 -5.37404,0 -10.74802,0 -16.12205,0 -1.69704,0 -3.39413,0 -5.09117,0 -0.28272,0 -0.56568,0 -0.84854,0 -0.28272,0 -0.93759,0.26832 -0.8485,0 0.43824,-1.3211 1.36973,-2.42357 2.05459,-3.63533\"\n         style=\"display:inline;fill:#adadad;fill-opacity:1;stroke:none;stroke-width:1;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         inkscape:connector-curvature=\"0\"\n         id=\"path5099\"\n         d=\"m 727.47693,280.98467 c -1.25054,-1.05096 -2.29113,-2.42126 -3.75168,-3.15288 -0.3576,-0.17904 -0.49075,0.66965 -0.84849,0.8485 -0.67882,0.33936 -1.86677,-0.33936 -2.54559,0 -0.3576,0.17904 -0.49075,0.66964 -0.84854,0.84854 -0.25296,0.12624 -0.56568,0 -0.84854,0 -0.8485,0 -1.69704,0 -2.54559,0 -1.69704,0 -3.39408,0 -5.09117,0 -3.67694,0 -7.35388,0 -11.03083,0 -1.41422,0 -2.84265,-0.20016 -4.24267,0 -0.62606,0.0893 -1.09704,0.64853 -1.69704,0.84854 -0.26832,0.0893 -0.56568,0 -0.84854,0 -0.56568,0 -1.13136,0 -1.69704,0 -1.41423,0 -2.82845,0 -4.24263,0 -2.82845,0 -5.65685,0 -8.48529,0 -0.35712,0 -4.83874,-0.12624 -5.09117,0 -0.71554,0.3576 -0.98151,1.3393 -1.69704,1.69704 -0.50597,0.25296 -1.1604,-0.17904 -1.69709,0 -0.6,0.20016 -1.08346,0.69514 -1.69704,0.84855 -0.54878,0.13728 -1.13136,0 -1.69704,0 -1.9799,0 -3.95981,0 -5.93971,0 -0.56568,0 -1.14826,-0.13728 -1.69704,0 -0.61359,0.1536 -1.09709,0.64853 -1.69709,0.84849 -0.26832,0.0893 -0.59554,-0.12624 -0.8485,0 -0.3576,0.17904 -0.46032,0.75154 -0.84854,0.84855 -0.8232,0.20592 -1.69704,0 -2.54558,0 -0.56568,0 -1.13136,0 -1.69704,0 -0.56568,0 -1.1604,-0.17904 -1.69709,0 -0.75893,0.25296 -0.98151,1.33929 -1.69704,1.69704 -0.25296,0.12624 -0.56568,0 -0.84855,0 -0.84849,0 -1.69704,0 -2.54558,0 -1.69704,0 -3.39408,0 -5.09117,0 -0.56568,0 -1.14235,0.11088 -1.69704,0 -3.68726,-0.73743 -1.5708,-0.54168 -4.24262,-2.54559 -1.01194,-0.75892 -2.34168,-0.99537 -3.39413,-1.69704 -0.33264,-0.22176 -0.56568,-0.56568 -0.84854,-0.84854 -0.56568,-0.56568 -1.13136,-1.13136 -1.69704,-1.69704 -1.69704,-1.69704 -3.39413,-3.39413 -5.09117,-5.09117 -0.44688,-0.44688 -2.09242,-2.31897 -2.54559,-2.54558 -0.25296,-0.12624 -0.59553,0.12624 -0.84854,0 -0.16224,-0.0811 -3.31286,-3.2317 -3.39408,-3.39413 -0.12912,-0.25824 0,-2.16341 0,-2.54558 0,-2.26272 0,-4.52549 0,-6.78821 0,-1.97991 0,-3.95981 0,-5.93971 0,-0.55757 -0.15936,-2.06684 0,-2.54559 0.20016,-0.6 0.64853,-1.09704 0.8485,-1.69704 0.2664,-0.79939 -0.27504,-4.54104 0,-5.09117 0.17904,-0.3576 0.62664,-0.51571 0.84854,-0.84854 0.70166,-1.05245 1.04626,-2.30942 1.69704,-3.39408 0.52469,-0.87451 1.1724,-1.67112 1.69709,-2.54558 0.32544,-0.54236 0.49771,-1.17087 0.84849,-1.69709 1.83197,-2.74791 -0.1056,0.35328 1.69709,-0.8485 0.66562,-0.44352 1.13136,-1.13141 1.69704,-1.69709 1.21839,-1.21833 3.17679,-2.91033 4.24263,-4.24262 0.6371,-0.79632 1.08518,-1.72973 1.69708,-2.54558 0.71276,-0.95036 1.83279,-1.59524 2.54559,-2.54559 0.37968,-0.50597 0.49771,-1.17081 0.84849,-1.69704 0.44352,-0.66566 1.3393,-0.98155 1.69709,-1.69709 0.25296,-0.50596 -0.25296,-1.19107 0,-1.69704 0.3576,-0.71553 1.44408,-0.93811 1.69704,-1.69704 0.17904,-0.53668 0,-1.1314 0,-1.69708 0,-0.28272 -0.12624,-0.59554 0,-0.8485 0.3576,-0.71558 1.44408,-0.93811 1.69704,-1.69709 0.15216,-0.456 0,-2.67571 0,-3.39413 0,-3.39408 0,-6.7882 0,-10.18233 0,-1.01448 -0.1848,-4.53735 0,-5.09117 0.20016,-0.6 0.64853,-1.09704 0.84855,-1.69704 0.17904,-0.53664 -0.25296,-1.19107 0,-1.69704 0.3576,-0.71554 1.25328,-1.03142 1.69704,-1.69709 0.35088,-0.52622 0.49771,-1.17081 0.84854,-1.69704 0.22176,-0.33264 0.66965,-0.49075 0.84854,-0.84854 0.12624,-0.25296 -0.0893,-0.58018 0,-0.8485 0.20016,-0.6 0.64853,-1.09709 0.8485,-1.69709 0.0893,-0.26832 -0.12624,-0.59553 0,-0.84849 0.3576,-0.71554 1.3393,-0.98151 1.69709,-1.69709 0.12672,-0.25296 -0.12624,-0.59554 0,-0.8485 0.17904,-0.3576 0.56568,-0.56568 0.84849,-0.84854 0.28272,-0.28272 0.56573,-0.56568 0.84855,-0.84854 2.81424,-2.8142 -0.39984,0.80001 0.84854,-1.69704 0.3576,-0.71554 1.3393,-0.98151 1.69704,-1.69704 0.25296,-0.50597 -0.25296,-1.19112 0,-1.69709 0.17904,-0.3576 0.56568,-0.56568 0.84855,-0.8485 0.28272,-0.28272 0.56568,-1.13141 0.84849,-0.84854 0.28272,0.28272 -1.18133,1.0704 -0.84849,0.84854 1.17667,-0.78446 2.28979,-1.66214 3.39408,-2.54558 1.98883,-1.59111 -0.55306,-0.57202 3.39412,-2.54559 0.25296,-0.12624 0.59554,0.12624 0.84855,0 0.3576,-0.17904 0.46032,-0.75153 0.84849,-0.84854 0.8232,-0.20592 1.74063,0.26832 2.54559,0 0.96749,-0.32256 1.69709,-1.13136 2.54558,-1.69704 0.84855,-0.56568 1.67112,-1.1724 2.54559,-1.69709 1.08465,-0.65078 2.34168,-0.99537 3.39412,-1.69704 0.33264,-0.22176 0.49076,-0.66965 0.84855,-0.84854 0.50064,-0.25008 1.9619,0.1944 2.54558,0 1.2,-0.39984 2.16696,-1.39027 3.39408,-1.69704 1.09762,-0.27456 2.3208,0.3576 3.39413,0 0.37968,-0.12624 0.51571,-0.62664 0.84854,-0.84855 5.92253,-3.94833 -4.17177,3.76522 4.24263,-2.54558 0.32016,-0.24 0.56568,-0.56568 0.84854,-0.8485 0.8485,-0.84854 1.69704,-1.69708 2.54559,-2.54558 0.84849,-0.84854 1.54708,-1.87997 2.54558,-2.54558 0.2352,-0.15696 0.61315,0.15696 0.8485,0 0.66566,-0.44352 1.07236,-1.19732 1.69708,-1.69709 5.25898,-4.2072 0.27696,0.0979 4.24263,-2.54559 1.94169,-1.29446 -0.53059,-0.67166 2.54558,-1.69704 0.76368,-0.2544 1.78191,0.2544 2.54559,0 1.2,-0.39984 2.16696,-1.39027 3.39412,-1.69704 0.59448,-0.1488 4.78392,0 5.09117,0 3.11127,0 6.22253,0 9.33379,0 0.11088,0 6.50472,0.1416 6.78821,0 0.3576,-0.17904 0.4908,-0.66964 0.84855,-0.84854 0.67881,-0.33936 1.86676,0.33936 2.54558,0 0.71554,-0.3576 0.91262,-1.54018 1.69709,-1.69704 1.10937,-0.22176 2.30625,0.31104 3.39408,0 0.98059,-0.28032 1.63344,-1.24099 2.54558,-1.69709 0.50597,-0.25296 1.19112,0.25296 1.69704,0 0.3576,-0.17904 0.4908,-0.66965 0.84855,-0.84849 0.25296,-0.12624 0.84854,-0.28272 0.84854,0 0,0.28272 -1.13136,0 -0.84854,0 0.5052,0 4.77288,0.15936 5.09116,0 0.71554,-0.3576 1.03143,-1.25333 1.69709,-1.69709 0.2352,-0.15696 0.56568,0 0.8485,0 0.56568,0 1.13136,0 1.69709,0 1.69704,0 3.39408,0 5.09116,0 0.56568,0 1.13136,0 1.69704,0 0.56568,0 1.14826,0.13728 1.69704,0 0.61359,-0.1536 1.09709,-0.64853 1.69709,-0.8485 0.26832,-0.0893 0.8485,-0.28272 0.8485,0 0,0.28272 -1.13136,0 -0.8485,0 2.26272,0 4.52549,0 6.78821,0 0.47376,0 3.85421,-0.1296 4.24262,0 0.75898,0.25296 0.98156,1.33925 1.69709,1.69704 0.50597,0.25296 1.19107,-0.25296 1.69704,0 0.3576,0.17904 0.51571,0.62664 0.84855,0.84855 4.28659,2.85772 0.0192,0.005 2.54558,0.84849 3.07613,1.02538 0.60389,0.40272 2.54558,1.69709 0.52623,0.35088 1.17082,0.49766 1.69704,0.8485 0.66562,0.44352 1.13136,1.13136 1.69704,1.69708 0.84855,0.8485 1.69709,1.69704 2.54559,2.54559 0.44688,0.44688 2.31902,2.09237 2.54558,2.54558 0.25776,0.51523 -0.25776,4.57589 0,5.09117 0.3576,0.71554 1.25333,1.03138 1.69709,1.69704 0.70162,1.05245 0.99538,2.34163 1.69704,3.39413 0.22176,0.33264 0.56568,0.56568 0.84854,0.84849 0.28272,0.28272 0.49076,0.66965 0.8485,0.84855 0.25296,0.12624 0.59554,-0.12624 0.84854,0 0.3576,0.17904 0.51572,0.62664 0.84855,0.84854 0.52622,0.35088 1.17081,0.49771 1.69704,0.8485 0.33264,0.22176 0.49075,0.66965 0.84854,0.84854 0.25296,0.12624 0.59554,-0.12672 0.8485,0 0.71553,0.3576 1.03142,1.25328 1.69709,1.69704 6.1523,3.07618 -1.34165,-0.89443 2.54558,1.69709 0.52622,0.35088 1.19107,0.46896 1.69704,0.8485 0.63998,0.48 1.01107,1.28548 1.69704,1.69708 0.76699,0.46032 1.77864,0.38832 2.54558,0.8485 1.37199,0.8232 2.06285,2.50661 3.39413,3.39413 0.2352,0.15696 0.59554,-0.12624 0.84855,0 0.3576,0.17904 0.52852,0.60854 0.84849,0.84854 0.81586,0.61186 1.74927,1.05999 2.54559,1.69704 0.62472,0.49978 1.05705,1.21704 1.69708,1.69704 0.50597,0.37968 1.17082,0.49771 1.69704,0.84855 0.33264,0.22176 0.56568,0.56568 0.84855,0.84854 0.56568,0.56568 1.13136,1.13136 1.69704,1.69704 0.28272,0.28272 0.56568,0.56568 0.84854,0.84854 0.28272,0.28272 0.66965,0.49076 0.8485,0.8485 0.1536,0.30672 0,3.65246 0,4.24267 0,0.44352 0.11136,3.17098 0,3.39408 -0.17904,0.3576 -0.6696,0.4908 -0.8485,0.84855 -0.12912,0.25824 0,2.16345 0,2.54558 0,1.69704 0,3.39413 0,5.09117 0,1.9799 0,3.95981 0,5.93971 0,0.56568 0,1.13136 0,1.69704 0,0.28272 -0.12672,0.59554 0,0.84854 0.17904,0.3576 0.66965,0.49076 0.8485,0.8485 0.12672,0.25296 -0.12624,0.59558 0,0.84854 0.17904,0.3576 0.62669,0.51572 0.84854,0.84855 0.35088,0.52622 0.49771,1.17081 0.84855,1.69704 0.23952,0.35952 2.19451,2.37005 2.54558,2.54558 0.25296,0.12624 0.59554,-0.12624 0.8485,0 0.3576,0.17904 0.56572,0.56568 0.84854,0.84855 0.28272,0.28272 0.62664,0.51571 0.84854,0.84854 0.35088,0.52622 0.49772,1.17082 0.8485,1.69704 0.22176,0.33264 0.62669,0.51571 0.84854,0.84854 0.70167,1.05245 0.99543,2.34164 1.69704,3.39408 0.22176,0.33264 0.66965,0.49076 0.84855,0.84855 0.12672,0.25296 -0.12624,0.59553 0,0.84854 1.29384,2.58763 0.67267,-1.55193 1.69704,2.54559 0.27456,1.09756 -0.27456,2.29651 0,3.39408 0.1536,0.61358 0.64853,1.09708 0.84854,1.69708 0.2544,0.76364 -0.2544,1.78191 0,2.54559 2.04874,6.14621 -0.2448,-1.33781 1.69704,2.54558 0.12672,0.25296 0,0.56568 0,0.8485 0,0.56568 -0.13728,1.14825 0,1.69709 0.1536,0.61353 0.64853,1.09704 0.84855,1.69704 0.0893,0.26832 0,0.56568 0,0.84854 0.28272,0.8485 0.51633,1.71509 0.84854,2.54558 0.23472,0.58719 0.69514,1.08346 0.8485,1.69704 0.13728,0.54879 -0.13728,1.14826 0,1.69704 0.13776,0.55042 2.1851,4.55045 2.54558,5.09117 0.22176,0.33264 0.66965,0.49075 0.84854,0.84855 0.25296,0.50596 -0.25296,1.19107 0,1.69704 0.17904,0.3576 0.66965,0.49075 0.84855,0.84854 0.11136,0.2232 0,2.95042 0,3.39413 0,1.41417 0,2.8284 0,4.24262 0,0.28272 0.0893,0.58023 0,0.84855 -0.82071,2.46211 -0.53203,0.9922 -1.69709,2.54558 -1.65384,2.20512 -1.35792,2.6137 -3.39408,4.24262 -0.79632,0.63706 -1.74926,1.05999 -2.54558,1.69704 -0.21504,0.17232 -2.981,3.18759 -3.39413,3.39413 -0.25296,0.12624 -0.56568,0 -0.84855,0 -0.56568,0.28272 -1.17081,0.49771 -1.69704,0.84855 -0.33264,0.22176 -0.56568,0.56568 -0.84854,0.84849 -1.02989,1.02994 -1.88002,2.16711 -3.39408,2.54559 -0.6012,0.15024 -3.92107,-0.21456 -4.24267,0 -0.66562,0.44352 -1.05706,1.21708 -1.69704,1.69708 0.16128,1.57503 -2.00895,0.58018 -2.54559,0.8485 -0.3576,0.17904 -0.49075,0.66965 -0.84854,0.84854 -0.54221,0.2712 -2.71114,-0.22752 -3.39408,0 -0.6,0.20016 -1.0835,0.69514 -1.69709,0.84855 -0.54878,0.13728 -1.17182,-0.21024 -1.69704,0 -0.94685,0.37872 -1.57809,1.37457 -2.54558,1.69704 -0.80496,0.26832 -1.71355,-0.16656 -2.54559,0 -0.62016,0.12384 -1.09704,0.64853 -1.69704,0.84854 -0.26832,0.0893 -0.59558,-0.12624 -0.84854,0 -0.3576,0.17904 -0.49075,0.66965 -0.84854,0.8485 -0.5437,0.27168 -4.56418,-0.26352 -5.09117,0 -0.3576,0.17904 -0.49075,0.66965 -0.8485,0.84854 -0.25296,0.12672 -0.56568,0 -0.84854,0 -1.41423,0 -2.82845,0 -4.24263,0 -0.71054,0 -3.59736,0.16128 -4.24267,0 -0.61353,-0.1536 -1.09704,-0.64853 -1.69704,-0.84854 -0.26832,-0.0893 -0.58017,0.0893 -0.84854,0 -0.6,-0.20016 -1.07688,-0.72447 -1.69704,-0.8485 -0.83203,-0.16656 -1.74063,0.26832 -2.54559,0 -0.96748,-0.32256 -1.67112,-1.1724 -2.54558,-1.69709 -0.5423,-0.32544 -1.17082,-0.49766 -1.69704,-0.84849 -0.33264,-0.22176 -0.49075,-0.66965 -0.84854,-0.84855 -0.30912,-0.15456 -3.39413,0.1488 -3.39413,0 0,-0.28272 1.13136,0 0.84854,0 -0.84854,0 -1.69704,0 -2.54558,0 -0.84855,0 -1.70861,-0.13968 -2.54559,0 -0.88224,0.14688 -1.66017,0.72207 -2.54558,0.84855 -1.11998,0.15984 -2.26272,0 -3.39413,0 -0.56568,0 -1.1604,-0.17904 -1.69704,0 -0.37968,0.12624 -0.46896,0.72201 -0.84854,0.84849 -0.53664,0.17904 -1.13136,0 -1.69704,0 -1.13136,0 -2.26277,0 -3.39413,0 -0.0509,0 -6.27413,-0.17136 -6.78821,0 -3.74558,1.24853 3.08285,0.84855 -2.54558,0.84855 -5.37403,0 -10.74802,0 -16.12205,0 -1.69704,0 -3.39413,0 -5.09117,0 -0.28272,0 -0.56568,0 -0.84854,0 -0.28272,0 -0.93759,0.26832 -0.8485,0 0.43824,-1.32111 1.36973,-2.42357 2.05459,-3.63533\"\n         style=\"fill:url(#pattern8517);fill-opacity:1;stroke:#000000;stroke-width:2.4000001;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n    </g>','2016-01-25 21:25:46',NULL),(26,'pinned','    <g\n       id=\"pinned\"\n       transform=\"matrix(-4.8,0,0,4.8,590.75909,-4749.3009)\">\n      <title\n         id=\"title6772\">pinned</title>\n      <path\n         style=\"fill:url(#linearGradient8480);fill-opacity:1;stroke:none\"\n         d=\"M 5,45 15,30 20,35 5,45\"\n         id=\"path6675\"\n         inkscape:connector-curvature=\"0\"\n         transform=\"translate(0,1002.3622)\" />\n      <path\n         style=\"fill:url(#linearGradient8482);fill-opacity:1;stroke:none\"\n         d=\"M 5,20 30,45 35,40 30,30 40,20 45,25 45,15 35,5 25,5 30,10 20,20 10,15 Z\"\n         id=\"path6698\"\n         inkscape:connector-curvature=\"0\"\n         transform=\"translate(0,1002.3622)\"\n         sodipodi:nodetypes=\"ccccccccccccc\" />\n    </g>','2016-01-25 20:32:46',NULL),(27,'poisoned','    <g\n       transform=\"matrix(4,0,0,4,-13.533335,-3674.8538)\"\n       id=\"poisoned\">\n      <title\n         id=\"title4528\">poisoned</title>\n      <path\n         sodipodi:nodetypes=\"zzzzzzzzzzzzzzzzzzzzzzzzzzzz\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4479\"\n         d=\"m 19.71917,1009.1388 c -1.892917,0.5475 -3.318681,-0.4076 -5.71917,0.2234 -2.400489,0.631 -4.7775928,2.5582 -5.6971917,4.4774 -0.9195989,1.9192 0.7112497,3.6037 0.06105,5.5226 -0.6501997,1.9189 -3.6325385,3.4317 -4.0903541,5.2222 -0.4578156,1.7905 0.070882,3.3122 0.7264958,4.3956 0.6556135,1.0834 1.8832757,0.432 2.5091575,1.8926 0.6258818,1.4606 -0.9586303,4.5592 -0.7326007,6.3492 0.2260296,1.79 0.3471352,3.2378 1.5873016,4.1404 1.2401664,0.9026 3.7627816,-0.6129 4.7619046,0.2552 0.999123,0.8681 0.03565,2.1504 0.610501,3.1135 0.574847,0.9631 1.420423,1.7271 2.747252,2.2589 1.326829,0.5318 3.202797,0.7289 5.006105,0.3724 1.803308,-0.3565 3.590084,-2.7134 5.372406,-2.6923 1.782322,0.021 2.588832,1.7298 4.137973,2.1978 1.549141,0.468 3.44736,1.2073 5,0.4945 1.55264,-0.7128 2.525754,-2.8655 3,-4.2796 0.474246,-1.4141 -0.629876,-2.6557 0.133089,-3.7204 0.762965,-1.0647 2.648712,-0.5487 3.866911,-1.4689 1.218199,-0.9202 2.707321,-2.3792 3,-4.0293 0.292679,-1.6501 -0.505181,-3.3418 -1.433455,-4.8229 -0.928274,-1.4811 -3.280058,-1.7134 -4.029304,-3.6789 -0.749246,-1.9655 1.054757,-5.2463 0.7326,-7.127 -0.322157,-1.8807 -0.785213,-2.6534 -1.831502,-3.873 -1.046289,-1.2196 -2.94758,-1.867 -4.438339,-3 -1.490759,-1.133 -2.763117,-2.9145 -4.474969,-3.8107 -1.711852,-0.8962 -3.573012,-1.7253 -5.525031,-1.4652 -1.952019,0.2601 -3.387913,2.505 -5.28083,3.0525 z\"\n         style=\"fill:#00fe00;fill-opacity:0.59534882;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"czzzc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4461\"\n         d=\"m 25,1002.3622 c 0,0 -17.1672586,21.6606 -15,30 2.167259,8.3394 8.947509,10.232 15,10.232 6.052491,0 12.832741,-1.8926 15,-10.232 2.167259,-8.3394 -15,-30 -15,-30 z\"\n         style=\"fill:url(#radialGradient4477);fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cccccccccccczczczccccccccccccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4410\"\n         d=\"m 24.928654,1035.0972 0.02875,1.4466 -0.909577,-0.031 -0.05749,-1.363 -0.240906,0.031 0.08624,1.3009 -0.976846,-0.031 -0.0575,-1.2917 -0.229981,0 0.08164,1.3846 -0.800336,-0.062 -0.114991,-1.3847 c 0,0 -0.06466,-0.5094 -0.583577,-1.651 -0.518919,-1.1416 -1.799507,-1.0975 -2.296941,-1.967 -1.101136,-4.214 -1.67829,-10.9264 5.884651,-10.8602 7.562942,0.066 7.153288,7.1974 6.287119,10.8602 -1.136108,1.1229 -1.527652,0.767 -2.268192,1.8121 -0.740541,1.0452 -0.612325,1.8059 -0.612325,1.8059 l 0.05749,1.3227 -0.776187,0 -0.114991,-1.2917 -0.178811,0 0.11499,1.3536 -0.971096,10e-5 0.02875,-1.3537 -0.182836,-0.031 0,1.4156 -0.99582,0 -0.05749,-1.4156 z\"\n         style=\"fill:#ffffff;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.09775931;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"zzzzzzzzz\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4412\"\n         d=\"m 19.533289,1030.6274 c -0.460584,-0.5515 -0.248381,-2.1683 -0.12419,-2.3232 0.12419,-0.1549 0.588441,-0.7359 1.065964,-0.9912 0.477523,-0.2553 1.141202,-0.4152 1.751309,-0.4002 0.610107,0.015 1.551829,0.1056 1.811104,0.5073 0.259275,0.4018 -0.0012,1.0885 -0.143739,1.5036 -0.14258,0.4151 -0.450671,0.8178 -0.86243,1.27 -0.41176,0.4523 -0.950382,0.8654 -1.581122,1.026 -0.630741,0.1606 -1.456313,-0.041 -1.916896,-0.5923 z\"\n         style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"zzzzzzzzz\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4412-6\"\n         d=\"m 30.228096,1030.6404 c 0.460584,-0.5516 0.24838,-2.1683 0.12419,-2.3232 -0.12419,-0.1549 -0.588441,-0.736 -1.065964,-0.9912 -0.477523,-0.2553 -1.141202,-0.4152 -1.751309,-0.4003 -0.610107,0.015 -1.551829,0.1057 -1.811104,0.5074 -0.259275,0.4018 0.0012,1.0885 0.143739,1.5036 0.142581,0.4151 0.450671,0.8178 0.86243,1.27 0.41176,0.4523 0.950383,0.8654 1.581122,1.026 0.630741,0.1605 1.456313,-0.041 1.916896,-0.5923 z\"\n         style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"ccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4429-1\"\n         d=\"m 24.945573,1028.9753 c 0.606726,0.367 1.048636,2.4475 0.580608,2.567 -0.695024,-0.2861 -1.127844,-2.4577 -0.580608,-2.567 z\"\n         style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"ccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4429-1-2\"\n         d=\"m 24.962952,1028.9413 c -0.606725,0.3669 -1.048636,2.4475 -0.580608,2.5669 0.695025,-0.2861 1.127845,-2.4576 0.580608,-2.5669 z\"\n         style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n    </g>','2016-01-25 20:32:46',NULL),(28,'prone','    <g\n       transform=\"matrix(8,0,0,8,-22.600857,-7634.693)\"\n       id=\"prone\">\n      <title\n         id=\"title7104\">prone</title>\n      <path\n         style=\"fill:none;stroke:#000000;stroke-width:2;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 29.538231,1025.2666 -21.2132039,0\"\n         id=\"path6778-9\"\n         inkscape:connector-curvature=\"0\"\n         sodipodi:nodetypes=\"cc\" />\n      <path\n         style=\"fill:none;stroke:#000000;stroke-width:2;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 31.468447,1032.2217 -13.594451,-6.3396\"\n         id=\"path6784-6\"\n         inkscape:connector-curvature=\"0\" />\n      <path\n         style=\"fill:none;stroke:#000000;stroke-width:2;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 29.687261,1025.2711 18.793831,6.8403\"\n         id=\"path6805-8\"\n         inkscape:connector-curvature=\"0\" />\n      <path\n         style=\"fill:none;stroke:#000000;stroke-width:2;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 29.001565,1025.4833 18.793894,-6.8404\"\n         id=\"path6805-2-0\"\n         inkscape:connector-curvature=\"0\" />\n      <path\n         style=\"fill:none;stroke:#000000;stroke-width:2;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 28.635147,1013.7977 -10.606621,10.6067\"\n         id=\"path6784-4-1\"\n         inkscape:connector-curvature=\"0\" />\n      <circle\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.5;marker:none;enable-background:accumulate\"\n         id=\"path6780-4\"\n         transform=\"matrix(0.70710677,-0.70710679,0.70710679,0.70710677,-9.3526423,1028.8021)\"\n         cx=\"15\"\n         cy=\"10\"\n         r=\"5\" />\n    </g>','2016-01-25 20:32:46',NULL),(29,'shaken','    <g\n       transform=\"matrix(3.9662114,0.51881304,-0.51881304,3.9662114,662.50382,-3541.9331)\"\n       id=\"shaken\">\n      <title\n         id=\"title9947\">shaken</title>\n      <circle\n         transform=\"matrix(0.65553693,-0.08574961,0.08574961,0.65553693,-371.78428,661.10348)\"\n         id=\"path4190-34-6-6\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffff00;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.26221497,-0.03429987,0.03429978,0.26221424,-142.53012,881.54807)\"\n         id=\"path4190-3-0-8-7\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.26221497,-0.03429987,0.03429978,0.26221424,-123.32482,879.03585)\"\n         id=\"path4190-3-4-4-2-3\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.06115454,-0.00799951,0.00799949,0.06115441,-20.109968,996.24789)\"\n         id=\"path4190-3-3-7-8-3-5-1\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#000000;fill-opacity:1;stroke:none;stroke-width:6.00000668;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <path\n         sodipodi:nodetypes=\"cc\"\n         style=\"fill:none;stroke:#000000;stroke-width:0.79334623px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n         d=\"m 14.860784,1044.7331 c 8.99344,-2.6077 18.172269,-3.7982 27.532565,-3.6014\"\n         id=\"path4460-4\"\n         inkscape:connector-curvature=\"0\" />\n      <circle\n         transform=\"matrix(0.06115454,-0.00799952,0.0079995,0.06115441,-0.483312,993.68051)\"\n         id=\"path4190-3-3-7-8-3-5-2\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#000000;fill-opacity:1;stroke:none;stroke-width:6.00000668;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <path\n         sodipodi:nodetypes=\"cc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path9885\"\n         d=\"m 9.0988633,1022.8839 c -5.3011204,10.4275 -4.9045075,20.4927 3.9270627,30.0216\"\n         style=\"fill:none;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path9885-6\"\n         d=\"m 5.697437,1026.9502 c -3.8863502,7.9785 -3.5568965,15.6993 3.013653,23.0388\"\n         style=\"fill:none;stroke:#000000;stroke-width:0.75341046px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path9885-8\"\n         d=\"m 42.17754,1018.5566 c 7.804872,8.7132 10.010527,18.5417 3.927081,30.0216\"\n         style=\"fill:none;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"cc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path9885-6-7\"\n         d=\"m 46.510437,1021.6112 c 5.807783,6.7105 7.475322,14.2562 3.013676,23.0388\"\n         style=\"fill:none;stroke:#000000;stroke-width:0.75341046px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n    </g>','2016-01-25 21:30:17',NULL),(30,'sickened','    <g\n       transform=\"matrix(3.9662114,0.51881304,-0.51881304,3.9662114,757.75173,-3523.9373)\"\n       id=\"sickened\">\n      <title\n         id=\"title9358\">sickened</title>\n      <circle\n         transform=\"matrix(0.82629361,-0.10808599,0.10808599,0.82629361,-475.36444,563.59282)\"\n         id=\"path4190-34-8-7\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#65ab36;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.3305177,-0.04323443,0.04323431,0.33051677,-186.3933,841.45963)\"\n         id=\"path4190-3-0-9-6\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.11568127,-0.01513206,0.01513203,0.11568103,-55.340413,967.7553)\"\n         id=\"path4190-3-3-9-0-1\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:6.00000668;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.3305177,-0.04323443,0.04323431,0.33051677,-162.18534,838.29303)\"\n         id=\"path4190-3-4-4-7-6\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <circle\n         transform=\"matrix(0.11568127,-0.01513206,0.01513203,0.11568103,-30.562733,964.57534)\"\n         id=\"path4190-3-3-7-8-4-5\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:6.00000668;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         cx=\"525.10162\"\n         cy=\"639.99976\"\n         r=\"30\" />\n      <path\n         sodipodi:nodetypes=\"czc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path8605-7-3\"\n         d=\"m 13.07148,1053.5081 c 0,0 5.879897,-6.4407 16.0635,-7.9461 10.183603,-1.5055 17.257358,3.7848 17.039996,3.8221\"\n         style=\"fill:none;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         inkscape:connector-curvature=\"0\"\n         id=\"path4190-3-4-4-2-8-3\"\n         d=\"m 37.750693,1017.205 c -5.476197,0.7163 -9.334825,5.7363 -8.618496,11.2125 0.106838,0.8168 0.301379,1.5835 0.58692,2.3185 0.894435,-1.4948 4.678562,-3.0073 9.328609,-3.6155 4.650046,-0.6083 8.664897,-0.116 9.913713,1.0984 0.08689,-0.7837 0.108653,-1.5787 0.0018,-2.3955 -0.716329,-5.4761 -5.736364,-9.3348 -11.212561,-8.6184 z m -6.942214,15.5946 c 2.062273,2.9902 5.686996,4.7399 9.536279,4.2364 3.852896,-0.504 6.904283,-3.122 8.125756,-6.5467 -1.507912,1.2228 -4.75177,2.3549 -8.60809,2.8594 -3.842921,0.5027 -7.276908,0.2382 -9.053945,-0.5491 z\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#4a6f31;fill-opacity:1;stroke:#000000;stroke-width:0.33333296px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\" />\n      <path\n         id=\"path4190-3-4-4-2-4-4\"\n         d=\"m 13.539136,1020.3442 c -5.4762018,0.7163 -9.3348391,5.7363 -8.618501,11.2126 0.1068366,0.8167 0.3013791,1.5834 0.5869195,2.3184 0.8944251,-1.4948 4.6785625,-3.0072 9.3286135,-3.6155 4.650047,-0.6082 8.664887,-0.116 9.913714,1.0985 0.08689,-0.7837 0.108651,-1.5788 0.0018,-2.3955 -0.716338,-5.4763 -5.736365,-9.3348 -11.212561,-8.6185 z m -6.9422189,15.5947 c 2.0622677,2.9901 5.6869969,4.7399 9.5362839,4.2364 3.852896,-0.504 6.904284,-3.122 8.125756,-6.5468 -1.507914,1.2228 -4.751777,2.3549 -8.608097,2.8594 -3.842923,0.5026 -7.2769135,0.2382 -9.0539429,-0.549 z\"\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#4a7030;fill-opacity:1;stroke:#000000;stroke-width:0.33333296px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n         inkscape:connector-curvature=\"0\" />\n    </g>','2016-01-25 21:30:17',NULL),(31,'stable','    <g\n       id=\"stable\">\n      <title\n         id=\"title9515-2\">stable</title>\n      <path\n         style=\"fill:none;stroke:url(#linearGradient9818);stroke-width:50;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none;stroke-dashoffset:0\"\n         d=\"m 567.10163,347.99973 -559.999996,0\"\n         id=\"path3054-6-5-0\"\n         inkscape:connector-curvature=\"0\">\n      </path>\n    </g>\n ','2015-12-12 20:35:26',NULL),(32,'staggered','    <g\n       id=\"staggered\"\n       transform=\"matrix(8,0,0,8,-44.994646,-7685.6056)\">\n      <title\n         id=\"title7019\">staggered</title>\n      <path\n         style=\"fill:none;stroke:#000000;stroke-width:2;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 30,1027.3622 -15,-15\"\n         id=\"path6778\"\n         inkscape:connector-curvature=\"0\"\n         sodipodi:nodetypes=\"cc\" />\n      <path\n         style=\"fill:none;stroke:#000000;stroke-width:2;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 21.646446,1019.3622 -14.9999994,0\"\n         id=\"path6784\"\n         inkscape:connector-curvature=\"0\" />\n      <path\n         style=\"fill:none;stroke:#000000;stroke-width:2;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 30,1027.3622 0,20\"\n         id=\"path6805\"\n         inkscape:connector-curvature=\"0\" />\n      <path\n         style=\"fill:none;stroke:#000000;stroke-width:2;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 29.467241,1027.136 18.12618,8.4524\"\n         id=\"path6805-2\"\n         inkscape:connector-curvature=\"0\" />\n      <path\n         style=\"fill:none;stroke:#000000;stroke-width:2;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 32.598872,1009.4253 -11.490636,9.6418\"\n         id=\"path6784-4\"\n         inkscape:connector-curvature=\"0\" />\n      <path\n         style=\"fill:none;stroke:#afafaf;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 35,1012.3622 -10,5\"\n         id=\"path6784-4-6\"\n         inkscape:connector-curvature=\"0\" />\n      <path\n         style=\"fill:none;stroke:#afafaf;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 31.060662,1007.1854 -7.68679,8.1188\"\n         id=\"path6784-4-6-4\"\n         inkscape:connector-curvature=\"0\" />\n      <path\n         style=\"fill:none;stroke:#afafaf;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 18.553524,1020.7534 -11.1070476,1.2784\"\n         id=\"path6784-4-6-5\"\n         inkscape:connector-curvature=\"0\" />\n      <path\n         style=\"fill:none;stroke:#afafaf;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"M 18.553334,1018.6306 7.6788975,1016.033\"\n         id=\"path6784-4-6-5-5\"\n         inkscape:connector-curvature=\"0\" />\n      <circle\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.5;marker:none;enable-background:accumulate\"\n         id=\"path6780\"\n         transform=\"translate(0,1002.3622)\"\n         cx=\"15\"\n         cy=\"10\"\n         r=\"5\" />\n    </g>','2016-01-25 21:30:17',NULL),(33,'stunned','    <g\n       id=\"stunned\"\n       transform=\"matrix(4,0,0,4,1.524442,-3558.2291)\">\n      <title\n         id=\"title8430\">stunned</title>\n      <g\n         id=\"g4301-8\"\n         transform=\"matrix(-1,0,0,1,72.217935,-3.8435237)\">\n        <path\n           style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.41329667px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n           d=\"m 29.305075,1013.6856 5.278314,-3.515 0.586423,0.704 c -0.08557,1.0287 -0.28108,2.1135 -1.879051,2.5134 -1.609937,0.016 -3.985686,0.2976 -3.985686,0.2976 z\"\n           id=\"path4180-0-1\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"ccccc\" />\n        <ellipse\n           style=\"fill:#000000;fill-opacity:1;stroke:none\"\n           id=\"path4182-1-0\"\n           cx=\"-685.90057\"\n           cy=\"776.74701\"\n           rx=\"1.3245244\"\n           ry=\"1.2417101\"\n           transform=\"matrix(0.74442713,-0.66770372,0.70358831,0.71060783,0,0)\" />\n        <path\n           style=\"fill:#ffffff;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n           d=\"m 35.250768,1011.1482 -5.557895,-3.334 c 0,0 1.334147,2.9709 2.450674,3.5373 1.116449,0.5665 3.107221,-0.2033 3.107221,-0.2033 z\"\n           id=\"path4184-7-6-3\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"cczc\" />\n        <path\n           style=\"fill:#ffffff;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n           d=\"m 35.012344,1010.5151 -6.380862,-1.136 c 0,0 2.304756,2.301 3.549787,2.4326 1.244985,0.1317 2.831075,-1.2966 2.831075,-1.2966 z\"\n           id=\"path4184-7-4\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"cczc\" />\n        <path\n           style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.41329667px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n           d=\"m 30.642191,1012.7597 c -0.132583,-0.082 -1.892422,-0.2677 -1.892422,-0.2677 -0.754338,1.0783 -0.37945,1.7764 0.434822,2.3264 l 1.780292,-1.6732 z\"\n           id=\"path4203-5-1\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"ccccc\" />\n        <path\n           style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n           d=\"m 36.752137,1009.5661 1.404151,0.2442 -1.465201,0.3663 z\"\n           id=\"path4299-8\"\n           inkscape:connector-curvature=\"0\" />\n      </g>\n      <g\n         id=\"g4301-8-9\"\n         transform=\"matrix(-0.77000162,0.63804193,0.63804193,0.77000162,-605.56342,207.54484)\">\n        <path\n           style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.41329667px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n           d=\"m 29.305075,1013.6856 5.278314,-3.515 0.586423,0.704 c -0.08557,1.0287 -0.28108,2.1135 -1.879051,2.5134 -1.609937,0.016 -3.985686,0.2976 -3.985686,0.2976 z\"\n           id=\"path4180-0-1-5\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"ccccc\" />\n        <ellipse\n           style=\"fill:#000000;fill-opacity:1;stroke:none\"\n           id=\"path4182-1-0-6\"\n           cx=\"-685.90057\"\n           cy=\"776.74701\"\n           rx=\"1.3245244\"\n           ry=\"1.2417101\"\n           transform=\"matrix(0.74442713,-0.66770372,0.70358831,0.71060783,0,0)\" />\n        <path\n           style=\"fill:#ffffff;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n           d=\"m 35.250768,1011.1482 -5.557895,-3.334 c 0,0 1.334147,2.9709 2.450674,3.5373 1.116449,0.5665 3.107221,-0.2033 3.107221,-0.2033 z\"\n           id=\"path4184-7-6-3-2\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"cczc\" />\n        <path\n           style=\"fill:#ffffff;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n           d=\"m 35.012344,1010.5151 -6.380862,-1.136 c 0,0 2.304756,2.301 3.549787,2.4326 1.244985,0.1317 2.831075,-1.2966 2.831075,-1.2966 z\"\n           id=\"path4184-7-4-1\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"cczc\" />\n        <path\n           style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.41329667px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n           d=\"m 30.642191,1012.7597 c -0.132583,-0.082 -1.892422,-0.2677 -1.892422,-0.2677 -0.754338,1.0783 -0.37945,1.7764 0.434822,2.3264 l 1.780292,-1.6732 z\"\n           id=\"path4203-5-1-3\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"ccccc\" />\n        <path\n           style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n           d=\"m 36.752137,1009.5661 1.404151,0.2442 -1.465201,0.3663 z\"\n           id=\"path4299-8-1\"\n           inkscape:connector-curvature=\"0\" />\n      </g>\n      <g\n         transform=\"matrix(0.8,0,0,0.8,-390.72859,528.12211)\"\n         id=\"g4273-7\">\n        <circle\n           r=\"30\"\n           cy=\"639.99976\"\n           cx=\"525.10162\"\n           style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffff00;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n           id=\"path4190-1\"\n           transform=\"matrix(0.8333329,0,0,0.8333329,82.517151,91.66689)\" />\n        <circle\n           r=\"30\"\n           cy=\"639.99976\"\n           cx=\"525.10162\"\n           style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n           id=\"path4190-3-02\"\n           transform=\"matrix(0.33333342,0,0,0.33333248,333.00707,404.66702)\" />\n        <circle\n           r=\"30\"\n           cy=\"639.99976\"\n           cx=\"525.10162\"\n           style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:6.00000668;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n           id=\"path4190-3-3-8\"\n           transform=\"matrix(0.11666677,0,0,0.11666653,446.57198,542.89384)\" />\n        <circle\n           r=\"30\"\n           cy=\"639.99976\"\n           cx=\"525.10162\"\n           style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n           id=\"path4190-3-4-0\"\n           transform=\"matrix(0.33333342,0,0,0.33333248,357.42127,404.66702)\" />\n        <path\n           style=\"fill:none;stroke:#000000;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n           d=\"m 540.10163,629.99973 c 0,0 -2.64298,5 -5,5 -2.35702,0 -2.64298,-5 -5,-5 -2.35702,0 -2.64298,5 -5,5 -2.35702,0 -2.64298,-5 -5,-5 -2.35702,0 -2.64298,5 -5,5 -2.35702,0 -2.64298,-5 -5,-5 -2.35702,0 -2.64298,5 -5,5 -2.35702,0 -5,-5 -5,-5 l 0,0\"\n           id=\"path4253-3\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"czzzzzzzcc\" />\n        <circle\n           r=\"30\"\n           cy=\"639.99976\"\n           cx=\"525.10162\"\n           style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#ffffff;fill-opacity:1;stroke:#000000;stroke-width:6.00000668;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate\"\n           id=\"path4190-3-3-7-1\"\n           transform=\"matrix(0.11666677,0,0,0.11666653,471.55281,542.95449)\" />\n      </g>\n      <ellipse\n         ry=\"4.3150172\"\n         rx=\"24.316849\"\n         cy=\"1010.2401\"\n         cx=\"24.855312\"\n         id=\"path4212\"\n         style=\"fill:none;fill-opacity:1;stroke:#000000;stroke-width:1;stroke-linecap:round;stroke-miterlimit:4;stroke-dasharray:12, 12;stroke-dashoffset:0;stroke-opacity:1\" />\n      <g\n         transform=\"translate(0,2)\"\n         id=\"g4301\">\n        <path\n           style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.41329667px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n           d=\"m 29.305075,1013.6856 5.278314,-3.515 0.586423,0.704 c -0.08557,1.0287 -0.28108,2.1135 -1.879051,2.5134 -1.609937,0.016 -3.985686,0.2976 -3.985686,0.2976 z\"\n           id=\"path4180-0\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"ccccc\" />\n        <ellipse\n           style=\"fill:#000000;fill-opacity:1;stroke:none\"\n           id=\"path4182-1\"\n           cx=\"-685.90057\"\n           cy=\"776.74701\"\n           rx=\"1.3245244\"\n           ry=\"1.2417101\"\n           transform=\"matrix(0.74442713,-0.66770372,0.70358831,0.71060783,0,0)\" />\n        <path\n           style=\"fill:#ffffff;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n           d=\"m 35.250768,1011.1482 -5.557895,-3.334 c 0,0 1.334147,2.9709 2.450674,3.5373 1.116449,0.5665 3.107221,-0.2033 3.107221,-0.2033 z\"\n           id=\"path4184-7-6\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"cczc\" />\n        <path\n           style=\"fill:#ffffff;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n           d=\"m 35.012344,1010.5151 -6.380862,-1.136 c 0,0 2.304756,2.301 3.549787,2.4326 1.244985,0.1317 2.831075,-1.2966 2.831075,-1.2966 z\"\n           id=\"path4184-7\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"cczc\" />\n        <path\n           style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.41329667px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n           d=\"m 30.642191,1012.7597 c -0.132583,-0.082 -1.892422,-0.2677 -1.892422,-0.2677 -0.754338,1.0783 -0.37945,1.7764 0.434822,2.3264 l 1.780292,-1.6732 z\"\n           id=\"path4203-5\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"ccccc\" />\n        <path\n           style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n           d=\"m 36.752137,1009.5661 1.404151,0.2442 -1.465201,0.3663 z\"\n           id=\"path4299\"\n           inkscape:connector-curvature=\"0\" />\n      </g>\n      <g\n         id=\"g4301-7\"\n         transform=\"matrix(0.91648842,0.40006123,-0.40006123,0.91648842,382.49219,73.430472)\">\n        <path\n           style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.41329667px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n           d=\"m 29.305075,1013.6856 5.278314,-3.515 0.586423,0.704 c -0.08557,1.0287 -0.28108,2.1135 -1.879051,2.5134 -1.609937,0.016 -3.985686,0.2976 -3.985686,0.2976 z\"\n           id=\"path4180-0-7\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"ccccc\" />\n        <ellipse\n           style=\"fill:#000000;fill-opacity:1;stroke:none\"\n           id=\"path4182-1-9\"\n           cx=\"-685.90057\"\n           cy=\"776.74701\"\n           rx=\"1.3245244\"\n           ry=\"1.2417101\"\n           transform=\"matrix(0.74442713,-0.66770372,0.70358831,0.71060783,0,0)\" />\n        <path\n           style=\"fill:#ffffff;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n           d=\"m 35.250768,1011.1482 -5.557895,-3.334 c 0,0 1.334147,2.9709 2.450674,3.5373 1.116449,0.5665 3.107221,-0.2033 3.107221,-0.2033 z\"\n           id=\"path4184-7-6-5\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"cczc\" />\n        <path\n           style=\"fill:#ffffff;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.5;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n           d=\"m 35.012344,1010.5151 -6.380862,-1.136 c 0,0 2.304756,2.301 3.549787,2.4326 1.244985,0.1317 2.831075,-1.2966 2.831075,-1.2966 z\"\n           id=\"path4184-7-8\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"cczc\" />\n        <path\n           style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.41329667px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n           d=\"m 30.642191,1012.7597 c -0.132583,-0.082 -1.892422,-0.2677 -1.892422,-0.2677 -0.754338,1.0783 -0.37945,1.7764 0.434822,2.3264 l 1.780292,-1.6732 z\"\n           id=\"path4203-5-8\"\n           inkscape:connector-curvature=\"0\"\n           sodipodi:nodetypes=\"ccccc\" />\n        <path\n           style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n           d=\"m 36.752137,1009.5661 1.404151,0.2442 -1.465201,0.3663 z\"\n           id=\"path4299-1\"\n           inkscape:connector-curvature=\"0\" />\n      </g>\n    </g>','2016-01-25 21:33:01',NULL),(34,'unconscious','    <g\n       id=\"unconscious\"\n       transform=\"matrix(2.985984,0,0,2.985984,-1482.0488,-2519.4165)\">\n      <title\n         id=\"title8669\">unconscious</title>\n      <path\n         style=\"fill:none;stroke:#000000;stroke-width:4;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 550.70595,899.3837 -42.42641,0\"\n         id=\"path6778-9-4\"\n         inkscape:connector-curvature=\"0\"\n         sodipodi:nodetypes=\"cc\" />\n      <path\n         style=\"fill:none;stroke:#000000;stroke-width:4;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 554.56638,913.2939 -27.1889,-12.6792\"\n         id=\"path6784-6-7\"\n         inkscape:connector-curvature=\"0\" />\n      <path\n         style=\"fill:none;stroke:#000000;stroke-width:4;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 551.00401,899.3927 37.58766,13.6806\"\n         id=\"path6805-8-7\"\n         inkscape:connector-curvature=\"0\" />\n      <path\n         style=\"fill:none;stroke:#000000;stroke-width:4;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 549.63262,899.8171 37.58779,-13.6808\"\n         id=\"path6805-2-0-5\"\n         inkscape:connector-curvature=\"0\" />\n      <path\n         style=\"fill:none;stroke:#000000;stroke-width:4;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\"\n         d=\"m 548.89978,876.4459 -21.21324,21.2134\"\n         id=\"path6784-4-1-3\"\n         inkscape:connector-curvature=\"0\" />\n      <circle\n         style=\"color:#000000;display:inline;overflow:visible;visibility:visible;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.5;marker:none;enable-background:accumulate\"\n         id=\"path6780-4-4\"\n         transform=\"matrix(0.70710676,-0.70710681,0.70710681,0.70710676,0,0)\"\n         cx=\"-276.5524\"\n         cy=\"995.36816\"\n         r=\"10\" />\n      <text\n         transform=\"matrix(0.9741816,-0.22576583,0.22576583,0.9741816,0,0)\"\n         sodipodi:linespacing=\"125%\"\n         id=\"text8649\"\n         y=\"972.58392\"\n         x=\"296.36798\"\n         style=\"font-style:normal;font-weight:normal;font-size:40px;line-height:125%;font-family:sans-serif;letter-spacing:0px;word-spacing:0px;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\"\n         xml:space=\"preserve\"><tspan\n           y=\"972.58392\"\n           x=\"296.36798\"\n           id=\"tspan8651\"\n           sodipodi:role=\"line\">Zzz</tspan></text>\n    </g>','2016-01-25 21:30:17',NULL),(35,'destroyed','    <g\n       transform=\"translate(266.26274,-683.05427)\"\n       id=\"destroyed\">\n      <title\n         id=\"title8742\">destroyed</title>\n      <path\n         inkscape:connector-curvature=\"0\"\n         id=\"path3054-6-5-0-1-0-1\"\n         d=\"m -180.04118,836.72884 395.9798,395.97976\"\n         style=\"fill:none;stroke:url(#linearGradient9795);stroke-width:50;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1\">\n      </path>\n      <path\n         inkscape:connector-curvature=\"0\"\n         id=\"path3054-6-5-0-1-3\"\n         d=\"m 215.93862,836.72883 -395.9798,395.97977\"\n         style=\"fill:none;stroke:url(#linearGradient9797);stroke-width:50;stroke-linecap:round;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1\">\n      </path>\n      <path\n         sodipodi:nodetypes=\"cccccccccccczczczccccccccccccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4410-9\"\n         d=\"m 18.06201,1087.4272 0.274725,12.8299 -8.692308,-0.2745 -0.549454,-12.0879 -2.302196,0.2745 0.824175,11.538 -9.3351641,-0.2745 -0.54945,-11.4561 -2.1978,0 0.780219,12.2801 -7.6483529,-0.549 -1.098905,-12.2805 c 0,0 -0.617908,-4.518 -5.576917,-14.643 -4.959009,-10.1246 -17.196858,-9.7335 -21.95055,-17.4447 -10.522925,-37.3739 -16.038465,-96.90657 56.236261,-96.31887 72.274724,0.58815 68.359894,63.83287 60.082414,96.31887 -10.85714,9.9585 -14.5989,6.8022 -21.67582,16.0713 -7.076923,9.2695 -5.851645,16.0164 -5.851645,16.0164 l 0.54945,11.731 -7.41758,0 -1.0989,-11.4561 -1.708798,0 1.0989,12.0051 -9.280215,5e-4 0.274725,-12.0056 -1.747256,-0.2745 0,12.555 -9.516483,0 -0.54945,-12.555 z\"\n         style=\"fill:#ffffff;fill-opacity:1;fill-rule:evenodd;stroke:#000000;stroke-width:0.90000004;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"zzzzzzzzz\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4412-66\"\n         d=\"m -33.498432,1047.7844 c -4.401535,-4.8915 -2.373628,-19.2303 -1.186812,-20.6041 1.186817,-1.3739 5.623398,-6.5273 10.186812,-8.7912 4.563414,-2.264 10.905822,-3.6819 16.7362654,-3.5496 5.830443,0.1305 14.8299476,0.9369 17.3076926,4.5 2.477745,3.5631 -0.01125,9.6538 -1.373629,13.3353 -1.362564,3.681 -4.306806,7.2526 -8.2417592,11.2635 -3.9349529,4.0108 -9.0822644,7.6747 -15.1098888,9.099 -6.027624,1.4242 -13.917145,-0.36 -18.318681,-5.2529 z\"\n         style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"zzzzzzzzz\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4412-6-3\"\n         d=\"m 68.705757,1047.8996 c 4.401535,-4.8915 2.37363,-19.2303 1.18681,-20.6041 -1.186815,-1.3739 -5.623395,-6.5273 -10.18681,-8.7912 -4.563415,-2.264 -10.905822,-3.6819 -16.73626,-3.5496 -5.830443,0.1305 -14.829948,0.9369 -17.307693,4.5 -2.477745,3.5631 0.01125,9.6538 1.373629,13.3353 1.362564,3.681 4.306806,7.2526 8.241759,11.2635 3.934953,4.0108 9.082265,7.6747 15.109884,9.099 6.027626,1.4242 13.917146,-0.36 18.318681,-5.2529 z\"\n         style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"ccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4429-1-4\"\n         d=\"m 18.223691,1033.1324 c 5.798133,3.2544 10.021221,21.7067 5.54854,22.766 -6.64195,-2.5371 -10.778166,-21.7967 -5.54854,-22.766 z\"\n         style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n      <path\n         sodipodi:nodetypes=\"ccc\"\n         inkscape:connector-curvature=\"0\"\n         id=\"path4429-1-2-8\"\n         d=\"m 18.389777,1032.8305 c -5.798133,3.2544 -10.021221,21.7066 -5.548541,22.7659 6.641951,-2.5371 10.778166,-21.7966 5.548541,-22.7659 z\"\n         style=\"fill:#000000;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1\" />\n    </g>\n','2017-06-17 13:29:55',NULL);
/*!40000 ALTER TABLE `Modifier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `ModifierList`
--

DROP TABLE IF EXISTS `ModifierList`;
/*!50001 DROP VIEW IF EXISTS `ModifierList`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `ModifierList` (
  `idModifiers` tinyint NOT NULL,
  `updated` tinyint NOT NULL,
  `updatedBy` tinyint NOT NULL,
  `idPawn` tinyint NOT NULL,
  `idModifier` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `shapeSvg` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Modifiers`
--

DROP TABLE IF EXISTS `Modifiers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Modifiers` (
  `idModifiers` smallint(6) NOT NULL AUTO_INCREMENT,
  `idPawn` smallint(6) NOT NULL,
  `idModifier` smallint(6) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`idModifiers`),
  KEY `idPawn` (`idPawn`),
  KEY `idModifier` (`idModifier`),
  KEY `updated` (`updated`)
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Modifiers`
--

LOCK TABLES `Modifiers` WRITE;
/*!40000 ALTER TABLE `Modifiers` DISABLE KEYS */;
INSERT INTO `Modifiers` (`idModifiers`, `idPawn`, `idModifier`, `updated`, `updatedBy`) VALUES (21,5,8,'2017-06-17 13:30:30',NULL),(17,1,16,'2016-04-20 09:07:27',NULL);
/*!40000 ALTER TABLE `Modifiers` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dragon`@`localhost`*/ /*!50003 TRIGGER updatePawnInsertTrigger AFTER INSERT ON Modifiers
FOR EACH ROW UPDATE Pawn SET updated=NOW(), updatedBy='server' WHERE idPawn=NEW.idPawn */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dragon`@`localhost`*/ /*!50003 TRIGGER updatePawnUpdateTrigger AFTER UPDATE ON Modifiers
FOR EACH ROW UPDATE Pawn SET updated=NEW.updated, updatedBy='server' WHERE idPawn=NEW.idPawn AND NEW.updated>updated */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ALLOW_INVALID_DATES,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`dragon`@`localhost`*/ /*!50003 TRIGGER updatePawnDeleteTrigger AFTER DELETE ON Modifiers
FOR EACH ROW UPDATE Pawn SET updated=NOW(), updatedBy='server' WHERE idPawn=OLD.idPawn */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Pawn`
--

DROP TABLE IF EXISTS `Pawn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pawn` (
  `idPawn` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `selectKey` char(1) DEFAULT NULL,
  `rotate` double NOT NULL DEFAULT '0' COMMENT 'direction pawn is facing\n',
  `sizeFeet` double NOT NULL DEFAULT '5',
  `translateX` double NOT NULL DEFAULT '0' COMMENT 'X  location of pawn on map',
  `translateY` double NOT NULL DEFAULT '0' COMMENT 'Y location of pawn on map',
  `color` varchar(45) NOT NULL DEFAULT 'white',
  `height` double NOT NULL DEFAULT '0',
  `attackRange` double NOT NULL DEFAULT '0',
  `attackType` varchar(45) NOT NULL DEFAULT 'None',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `dmVisible` tinyint(1) NOT NULL DEFAULT '1',
  `depth` double NOT NULL DEFAULT '1',
  `backgroundColor` varchar(45) NOT NULL DEFAULT '#FFFFFF',
  `ruleLink` tinytext COMMENT 'URL associated to any rules for the pawn.\nThis will likely override the image URL if defined',
  `idImage` smallint(6) NOT NULL DEFAULT '1',
  `imageX` double NOT NULL DEFAULT '0' COMMENT 'X translation of image for pawn',
  `imageY` double NOT NULL DEFAULT '0' COMMENT 'Y translation of image for pawn',
  `imageScale` double NOT NULL DEFAULT '1',
  `idMap` smallint(6) DEFAULT NULL,
  `idRole` smallint(6) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`idPawn`),
  KEY `idMap` (`idMap`),
  KEY `updated` (`updated`),
  KEY `idImage` (`idImage`),
  KEY `idRole` (`idRole`),
  KEY `dmVisible` (`dmVisible`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='Pawn location on a Map.  Not \ngoing to impliment this right away, but for future reference.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pawn`
--

LOCK TABLES `Pawn` WRITE;
/*!40000 ALTER TABLE `Pawn` DISABLE KEYS */;
INSERT INTO `Pawn` (`idPawn`, `name`, `selectKey`, `rotate`, `sizeFeet`, `translateX`, `translateY`, `color`, `height`, `attackRange`, `attackType`, `visible`, `dmVisible`, `depth`, `backgroundColor`, `ruleLink`, `idImage`, `imageX`, `imageY`, `imageScale`, `idMap`, `idRole`, `updated`, `updatedBy`) VALUES (1,'Baldfist','1',-90,5,946.0234674329,340.44300766286,'#FF0101',0,-5,'Cone',1,1,1,'#FFAAAA',NULL,36,0,0,1,1,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(2,'Filerna','2',-90,5,996.0234674329,343.436302682,'#01FF01',0,0,'Line',1,1,1,'#AAFFAA',NULL,37,0,0,1,1,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(3,'Grub','3',-135,5,1046.0234674329,293.436302682,'#0101FF',0,0,'None',1,1,1,'#AAAAFF',NULL,38,0,0,1,1,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(4,'goblin 1','q',45,5,746.46312260536,391.97318007663,'#017050',0,15,'Cone',0,1,1,'#FFFFFF','http://paizo.com/pathfinderRPG/prd/bestiary/goblin.html#goblin',39,0,0,1,1,3,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(5,'goblin 2','w',0,5,1045.9865900383,191.49664750958,'#017050',0,0,'None',1,1,1,'#FFFFFF','http://paizo.com/pathfinderRPG/prd/bestiary/goblin.html#goblin',39,0,0,1,1,3,'2017-06-17 13:30:30','server'),(6,'goblin 3','e',45,5,845.51005747125,391.02011494253,'#017050',0,0,'None',0,1,1,'#FFFFFF','http://paizo.com/pathfinderRPG/prd/bestiary/goblin.html#goblin',39,0,0,1,1,3,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(7,'orc 1','r',90,5,398.02681992337,639.93295019158,'#015001',0,0,'None',0,1,1,'#FFFFFF','http://paizo.com/pathfinderRPG/prd/bestiary/orc.html#orc',33,-110,0,1.5,1,6,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(8,'orc 2','t',-90,5,697.55028735632,640.9530651341,'#015001',0,0,'Line',0,1,1,'#FFFFFF','http://paizo.com/pathfinderRPG/prd/bestiary/orc.html#orc',33,-110,0,1.5,1,6,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(9,'ogre','y',45,10,444.96647509579,980.61063218391,'#501010',0,0,'None',0,1,1,'#FFFFFF','http://paizo.com/pathfinderRPG/prd/bestiary/ogre.html#ogre',35,0,0,1,1,7,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36');
/*!40000 ALTER TABLE `Pawn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `PawnRoleImageSourceLocation`
--

DROP TABLE IF EXISTS `PawnRoleImageSourceLocation`;
/*!50001 DROP VIEW IF EXISTS `PawnRoleImageSourceLocation`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `PawnRoleImageSourceLocation` (
  `idPawn` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `selectKey` tinyint NOT NULL,
  `rotate` tinyint NOT NULL,
  `sizeFeet` tinyint NOT NULL,
  `translateX` tinyint NOT NULL,
  `translateY` tinyint NOT NULL,
  `height` tinyint NOT NULL,
  `attackRange` tinyint NOT NULL,
  `attackType` tinyint NOT NULL,
  `color` tinyint NOT NULL,
  `visible` tinyint NOT NULL,
  `dmVisible` tinyint NOT NULL,
  `depth` tinyint NOT NULL,
  `backgroundColor` tinyint NOT NULL,
  `imageX` tinyint NOT NULL,
  `imageY` tinyint NOT NULL,
  `imageScale` tinyint NOT NULL,
  `idMap` tinyint NOT NULL,
  `updated` tinyint NOT NULL,
  `updatedBy` tinyint NOT NULL,
  `idRole` tinyint NOT NULL,
  `roleName` tinyint NOT NULL,
  `idImage` tinyint NOT NULL,
  `filename` tinyint NOT NULL,
  `imageWidth` tinyint NOT NULL,
  `imageHeight` tinyint NOT NULL,
  `imageType` tinyint NOT NULL,
  `ruleLink` tinyint NOT NULL,
  `idSource` tinyint NOT NULL,
  `sourceName` tinyint NOT NULL,
  `sourceDescription` tinyint NOT NULL,
  `copyright` tinyint NOT NULL,
  `idLocation` tinyint NOT NULL,
  `directory` tinyint NOT NULL,
  `treeDepth` tinyint NOT NULL,
  `idParent` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Pointer`
--

DROP TABLE IF EXISTS `Pointer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pointer` (
  `idPointer` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `selectKey` char(1) DEFAULT NULL,
  `shapeSvg` blob NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`idPointer`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pointer`
--

LOCK TABLES `Pointer` WRITE;
/*!40000 ALTER TABLE `Pointer` DISABLE KEYS */;
INSERT INTO `Pointer` (`idPointer`, `name`, `selectKey`, `shapeSvg`, `updated`, `updatedBy`) VALUES (1,'target','b','     width=\"100%\" \n     height=\"100%\" \n     version=\"1.1\"\n     xmlns=\"http://www.w3.org/2000/svg\"\n     xmlns:xlink=\"http://www.w3.org/1999/xlink\">\n    <g\n       id=\"target\"\n       transform=\"translate(0,-1052.36216)\">\n       <animate id=\"fullFade\" begin=\"accessKey(b)\" dur=\"3.0s\" />\n       <g \n         id=\"outer-ring\">\n         <path\n            transform=\"translate(0,552.36216)\"\n            d=\"M 0,250 A 250,250 0 0 0 -250,500 250,250 0 0 0 0,750 250,250 0 0 0 250,500 250,250 0 0 0 0,250 Z m 0,50 A 200,200 0 0 1 200,500 200,200 0 0 1 0,700 200,200 0 0 1 -200,500 200,200 0 0 1 0,300 Z\"\n            style=\"opacity:1;fill:#ff41ff;fill-opacity:1;stroke:none;stroke-width:0.5;stroke-linecap:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"0\" to=\"0\" begin=\"fullFade.begin+0.0s\" dur=\"0.25s\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"0\" to=\"1\" begin=\"fullFade.begin+0.25s\" dur=\"0.25s\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"1\" to=\"1\" begin=\"fullFade.begin+0.5s\" dur=\"0.75s\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"1\" to=\"0\" begin=\"fullFade.begin+1.25s\" dur=\"0.25s\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"0\" to=\"0\" begin=\"fullFade.begin+1.5s\" dur=\"0.75s\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"0\" to=\"1\" begin=\"fullFade.begin+2.25s\" dur=\"0.25s\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"1\" to=\"1\" begin=\"fullFade.begin+2.5s\" dur=\"0.5s\" />\n       </g>\n       <g \n         id=\"middle-ring\">\n         <path\n            d=\"M 0,878.1236 A 174.23857,174.23857 0 0 0 -174.23857,1052.3622 174.23857,174.23857 0 0 0 0,1226.6008 174.23857,174.23857 0 0 0 174.23857,1052.3622 174.23857,174.23857 0 0 0 0,878.1236 Z m 0,34.84771 A 139.39085,139.39085 0 0 1 139.39085,1052.3622 139.39085,139.39085 0 0 1 0,1191.753 139.39085,139.39085 0 0 1 -139.39085,1052.3622 139.39085,139.39085 0 0 1 0,912.97131 Z\"\n            style=\"opacity:1;fill:#ff73ff;fill-opacity:1;stroke:none;stroke-width:0.5;stroke-linecap:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"0\" to=\"0\" begin=\"fullFade.begin+0.0s\" dur=\"0.5s\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"0\" to=\"1\" begin=\"fullFade.begin+0.5s\" dur=\"0.25s\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"1\" to=\"1\" begin=\"fullFade.begin+0.75s\" dur=\"0.75s\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"1\" to=\"0\" begin=\"fullFade.begin+1.5s\" dur=\"0.25s\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"0\" to=\"0\" begin=\"fullFade.begin+1.75s\" dur=\"0.75s\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"0\" to=\"1\" begin=\"fullFade.begin+2.5s\" dur=\"0.25s\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"1\" to=\"1\" begin=\"fullFade.begin+2.75s\" dur=\"0.25s\" />\n       </g>\n       <g \n         id=\"inner-ring\">\n         <path\n            d=\"M 0,937.7226 A 114.63958,114.63958 0 0 0 -114.63958,1052.3622 114.63958,114.63958 0 0 0 0,1167.0018 114.63958,114.63958 0 0 0 114.63958,1052.3622 114.63958,114.63958 0 0 0 0,937.7226 Z m 0,22.92791 A 91.71166,91.71166 0 0 1 91.71166,1052.3622 91.71166,91.71166 0 0 1 0,1144.0738 91.71166,91.71166 0 0 1 -91.71166,1052.3622 91.71166,91.71166 0 0 1 0,960.65051 Z\"\n            style=\"opacity:1;fill:#ffc3ff;fill-opacity:1;stroke:none;stroke-width:0.5;stroke-linecap:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"0\" to=\"0\" begin=\"fullFade.begin+0.0s\" dur=\"0.75s\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"0\" to=\"1\" begin=\"fullFade.begin+0.75s\" dur=\"0.25s\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"1\" to=\"1\" begin=\"fullFade.begin+1.0s\" dur=\"0.75s\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"1\" to=\"0\" begin=\"fullFade.begin+1.75s\" dur=\"0.25s\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"0\" to=\"0\" begin=\"fullFade.begin+2.0s\" dur=\"0.75s\" />\n         <animate attributeType=\"CSS\" attributeName=\"opacity\" from=\"0\" to=\"1\" begin=\"fullFade.begin+2.75s\" dur=\"0.25s\" />\n       </g>\n    </g>\n','2017-06-17 13:19:38',NULL);
/*!40000 ALTER TABLE `Pointer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pointers`
--

DROP TABLE IF EXISTS `Pointers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Pointers` (
  `idPointers` smallint(6) NOT NULL AUTO_INCREMENT,
  `idPointer` smallint(6) NOT NULL DEFAULT '1',
  `rotate` double NOT NULL DEFAULT '0',
  `scale` double NOT NULL DEFAULT '1',
  `translateX` double NOT NULL DEFAULT '0',
  `translateY` double NOT NULL DEFAULT '0',
  `visible` tinyint(1) DEFAULT '1',
  `idMap` smallint(6) DEFAULT '1',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`idPointers`),
  KEY `updated` (`updated`),
  KEY `idMap` (`idMap`),
  KEY `idPointer` (`idPointer`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Pointers are similar to pawns but are outside and on top of all the maps';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pointers`
--

LOCK TABLES `Pointers` WRITE;
/*!40000 ALTER TABLE `Pointers` DISABLE KEYS */;
INSERT INTO `Pointers` (`idPointers`, `idPointer`, `rotate`, `scale`, `translateX`, `translateY`, `visible`, `idMap`, `updated`, `updatedBy`) VALUES (1,1,0,0.05,0,0,0,1,'2017-06-17 13:20:20',NULL);
/*!40000 ALTER TABLE `Pointers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Role`
--

DROP TABLE IF EXISTS `Role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Role` (
  `idRole` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`idRole`),
  KEY `updated` (`updated`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='What role does this Pawn play: PC, PCLeader, NPC, NPCMonster, etc';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Role`
--

LOCK TABLES `Role` WRITE;
/*!40000 ALTER TABLE `Role` DISABLE KEYS */;
INSERT INTO `Role` (`idRole`, `name`, `updated`, `updatedBy`) VALUES (1,'pc','2016-01-31 15:44:55',NULL),(2,'npc','2016-01-31 15:44:55',NULL),(3,'monster','2016-01-31 15:44:55',NULL),(4,'label','2016-01-31 15:44:55',NULL),(5,'trap','2016-01-31 15:44:55',NULL),(6,'monster','2016-01-31 18:55:55',NULL),(7,'monster','2016-01-31 18:55:55',NULL);
/*!40000 ALTER TABLE `Role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Source`
--

DROP TABLE IF EXISTS `Source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Source` (
  `idSource` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` tinytext,
  `copyright` tinytext,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`idSource`),
  KEY `updated` (`updated`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Origin of Image';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Source`
--

LOCK TABLES `Source` WRITE;
/*!40000 ALTER TABLE `Source` DISABLE KEYS */;
INSERT INTO `Source` (`idSource`, `name`, `description`, `copyright`, `updated`, `updatedBy`) VALUES (1,'Unknown',NULL,NULL,'2016-01-31 15:44:55',NULL),(2,'http://donjon.bin.sh/fantasy/dungeon/','Random Dungeon Generator on donjon.bin.sh','code Copyright &copy; 2009-2016 drow','2016-02-02 00:39:30',NULL),(3,'http://donjon.bin.sh/world/','Fractal World Generator on donjon.bin.sh','code Copyright &copy; 2009-2016 drow','2016-02-02 00:39:30',NULL),(4,'puppeli @ Deviant Art','http://fav.me/dymmbc','https://creativecommons.org/licenses/by-sa/3.0/deed.en','2016-03-12 13:30:06',NULL),(5,'whitekidz @ Deviant Art','http://fav.me/d8ospmi','https://creativecommons.org/licenses/by-sa/3.0/deed.en','2016-03-12 13:31:21',NULL),(6,'xaarex @ Deviant Art','http://fav.me/d6ku8eo','https://creativecommons.org/licenses/by-sa/3.0/deed.en','2016-03-12 13:32:58',NULL);
/*!40000 ALTER TABLE `Source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Tile`
--

DROP TABLE IF EXISTS `Tile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Tile` (
  `idTile` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL COMMENT 'tile name',
  `rotate` double NOT NULL DEFAULT '0' COMMENT 'rotate',
  `scale` double NOT NULL COMMENT 'scale',
  `translateX` double NOT NULL DEFAULT '0' COMMENT 'translate x',
  `translateY` double NOT NULL DEFAULT '0' COMMENT 'translate y',
  `visible` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'visibile',
  `dmVisible` tinyint(1) NOT NULL DEFAULT '1',
  `depth` double NOT NULL DEFAULT '1' COMMENT 'layer depth',
  `backgroundColor` varchar(45) DEFAULT NULL COMMENT 'background color or transparent if NULL',
  `ruleLink` tinytext COMMENT 'URL for any rules associated with the tile\nThis may override the image ruleLink',
  `idImage` smallint(6) NOT NULL COMMENT 'foreign key to Image table',
  `idMap` smallint(6) DEFAULT NULL COMMENT 'foreign key to Map table',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updatedBy` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`idTile`),
  KEY `idImage` (`idImage`),
  KEY `idMap` (`idMap`),
  KEY `updated` (`updated`),
  KEY `dmVisible` (`dmVisible`)
) ENGINE=MyISAM AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 COMMENT='specify geometric location and the visibility of Tile elements which are part of a Map.  \nA Tile refrences only one Image, but can be in many Maps.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Tile`
--

LOCK TABLES `Tile` WRITE;
/*!40000 ALTER TABLE `Tile` DISABLE KEYS */;
INSERT INTO `Tile` (`idTile`, `name`, `rotate`, `scale`, `translateX`, `translateY`, `visible`, `dmVisible`, `depth`, `backgroundColor`, `ruleLink`, `idImage`, `idMap`, `updated`, `updatedBy`) VALUES (31,'Corridor 1',0,1,927,120,1,1,38,NULL,NULL,3,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(32,'Corridor 2a',0,1,0,215,0,1,36,NULL,NULL,4,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(33,'Corridor 2b',0,1,0,324,0,1,35,NULL,NULL,5,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(34,'Corridor 2c',0,1,127,324,0,1,34,NULL,NULL,6,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(35,'Corridor 2d',0,1,127,521,0,1,33,NULL,NULL,7,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(36,'Corridor 2e',0,1,520,429,0,1,32,NULL,NULL,8,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(37,'Corridor 3a',0,1,818,627,0,1,28,NULL,NULL,9,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(38,'Corridor 3b',0,1,922,601,0,1,25,NULL,NULL,10,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(39,'Corridor 4',0,1,1017,424,0,1,24,NULL,NULL,11,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(40,'Corridor 5a',0,1,1017,715,0,1,22,NULL,NULL,12,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(41,'Corridor 5b',0,1,629,1119,0,1,21,NULL,NULL,13,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(42,'Corridor 5c',0,1,621,920,0,1,20,NULL,NULL,14,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(43,'Corridor 5d',0,1,721,919,0,1,19,NULL,NULL,15,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(44,'Corridor 6a',0,1,26,1318,0,1,15,NULL,NULL,16,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(45,'Corridor 6b',0,1,27,1019,0,1,14,NULL,NULL,17,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(46,'Entry',0,1,525,0,1,1,39,NULL,NULL,19,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(47,'Locked Door 1',0,1,776,825,0,1,26,NULL,NULL,20,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(48,'Room 1',0,1,0,0,0,1,37,NULL,NULL,21,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(49,'Room 2',0,1,622,325,0,1,30,NULL,NULL,22,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(50,'Room 3',0,1,230,625,0,1,29,NULL,NULL,23,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(51,'Room 4',0,1,819,920,0,1,18,NULL,NULL,24,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(52,'Room 5',0,1,221,926,0,1,17,NULL,NULL,25,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(53,'Room 6',0,1,17,624,0,1,13,NULL,NULL,26,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(54,'Secret Door 1',0,1,520,571,0,1,27,NULL,NULL,27,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(55,'Stair Down',0,1,121,420,0,1,31,NULL,NULL,28,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(56,'Stair Up',0,1,923,419,0,1,23,NULL,NULL,29,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(57,'Trapped Door 1',0,1,575,923,0,1,16,NULL,NULL,30,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(58,'Trapped Door 2',0,1,28,976,0,1,12,NULL,NULL,31,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(59,'Deadly Dungeon',0,1,0,0,0,0,10,NULL,NULL,18,1,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(60,'overview',0,1,-417.95977011494,0.000000000000025592654732181,1,1,5,NULL,NULL,2,2,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(61,'orc_warrior_by_puppeli',0,0.5,-202.44300766284,1.0502873563218,1,1,4,NULL,NULL,34,5,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36'),(62,'bullrog_ogre_street_mage_by_xaarex',0,0.5,-410.47318007663,1.2801724137931,1,1,4,NULL,NULL,32,4,'2017-06-17 13:20:48','10.10.12.29_dm_Mozilla%2F5.0%20%28Windows%20NT%2010.0%3B%20Win64%3B%20x64%29%20AppleWebKit%2F537.36%20%28KHTML%2C%20like%20Gecko%29%20Chrome%2F58.0.3029.110%20Safari%2F537.36');
/*!40000 ALTER TABLE `Tile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `TileDmVisibleOnDisplay`
--

DROP TABLE IF EXISTS `TileDmVisibleOnDisplay`;
/*!50001 DROP VIEW IF EXISTS `TileDmVisibleOnDisplay`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `TileDmVisibleOnDisplay` (
  `idDisplay` tinyint NOT NULL,
  `dName` tinyint NOT NULL,
  `dPos` tinyint NOT NULL,
  `dWidth` tinyint NOT NULL,
  `dHeight` tinyint NOT NULL,
  `dTop` tinyint NOT NULL,
  `dBot` tinyint NOT NULL,
  `dLeft` tinyint NOT NULL,
  `dRight` tinyint NOT NULL,
  `dBackC` tinyint NOT NULL,
  `dDepth` tinyint NOT NULL,
  `idAdventure` tinyint NOT NULL,
  `adventureName` tinyint NOT NULL,
  `idMap` tinyint NOT NULL,
  `mName` tinyint NOT NULL,
  `mPPF` tinyint NOT NULL,
  `mFPI` tinyint NOT NULL,
  `mWidth` tinyint NOT NULL,
  `mHeight` tinyint NOT NULL,
  `mRot` tinyint NOT NULL,
  `mScale` tinyint NOT NULL,
  `mScaleY` tinyint NOT NULL,
  `mX` tinyint NOT NULL,
  `mY` tinyint NOT NULL,
  `mVis` tinyint NOT NULL,
  `mDmVis` tinyint NOT NULL,
  `mSName` tinyint NOT NULL,
  `mDmSName` tinyint NOT NULL,
  `mDepth` tinyint NOT NULL,
  `mBackC` tinyint NOT NULL,
  `idMapType` tinyint NOT NULL,
  `mtName` tinyint NOT NULL,
  `idTile` tinyint NOT NULL,
  `tName` tinyint NOT NULL,
  `tScale` tinyint NOT NULL,
  `tRot` tinyint NOT NULL,
  `tX` tinyint NOT NULL,
  `tY` tinyint NOT NULL,
  `tVis` tinyint NOT NULL,
  `tDmVis` tinyint NOT NULL,
  `tDepth` tinyint NOT NULL,
  `tBackC` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `TileImageSourceLocation`
--

DROP TABLE IF EXISTS `TileImageSourceLocation`;
/*!50001 DROP VIEW IF EXISTS `TileImageSourceLocation`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `TileImageSourceLocation` (
  `idTile` tinyint NOT NULL,
  `name` tinyint NOT NULL,
  `rotate` tinyint NOT NULL,
  `scale` tinyint NOT NULL,
  `translateX` tinyint NOT NULL,
  `translateY` tinyint NOT NULL,
  `visible` tinyint NOT NULL,
  `dmVisible` tinyint NOT NULL,
  `depth` tinyint NOT NULL,
  `idMap` tinyint NOT NULL,
  `updated` tinyint NOT NULL,
  `updatedBy` tinyint NOT NULL,
  `idImage` tinyint NOT NULL,
  `filename` tinyint NOT NULL,
  `imageWidth` tinyint NOT NULL,
  `imageHeight` tinyint NOT NULL,
  `imageType` tinyint NOT NULL,
  `ruleLink` tinyint NOT NULL,
  `idSource` tinyint NOT NULL,
  `sourceName` tinyint NOT NULL,
  `sourceDescription` tinyint NOT NULL,
  `copyright` tinyint NOT NULL,
  `idLocation` tinyint NOT NULL,
  `directory` tinyint NOT NULL,
  `treeDepth` tinyint NOT NULL,
  `idParent` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `TileVisibleOnDisplay`
--

DROP TABLE IF EXISTS `TileVisibleOnDisplay`;
/*!50001 DROP VIEW IF EXISTS `TileVisibleOnDisplay`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `TileVisibleOnDisplay` (
  `idDisplay` tinyint NOT NULL,
  `dName` tinyint NOT NULL,
  `dPos` tinyint NOT NULL,
  `dWidth` tinyint NOT NULL,
  `dHeight` tinyint NOT NULL,
  `dTop` tinyint NOT NULL,
  `dBot` tinyint NOT NULL,
  `dLeft` tinyint NOT NULL,
  `dRight` tinyint NOT NULL,
  `dBackC` tinyint NOT NULL,
  `dDepth` tinyint NOT NULL,
  `idAdventure` tinyint NOT NULL,
  `adventureName` tinyint NOT NULL,
  `idMap` tinyint NOT NULL,
  `mName` tinyint NOT NULL,
  `mPPF` tinyint NOT NULL,
  `mFPI` tinyint NOT NULL,
  `mWidth` tinyint NOT NULL,
  `mHeight` tinyint NOT NULL,
  `mRot` tinyint NOT NULL,
  `mScale` tinyint NOT NULL,
  `mScaleY` tinyint NOT NULL,
  `mX` tinyint NOT NULL,
  `mY` tinyint NOT NULL,
  `mVis` tinyint NOT NULL,
  `mDmVis` tinyint NOT NULL,
  `mSName` tinyint NOT NULL,
  `mDmSName` tinyint NOT NULL,
  `mDepth` tinyint NOT NULL,
  `mBackC` tinyint NOT NULL,
  `idMapType` tinyint NOT NULL,
  `mtName` tinyint NOT NULL,
  `idTile` tinyint NOT NULL,
  `tName` tinyint NOT NULL,
  `tScale` tinyint NOT NULL,
  `tRot` tinyint NOT NULL,
  `tX` tinyint NOT NULL,
  `tY` tinyint NOT NULL,
  `tVis` tinyint NOT NULL,
  `tDmVis` tinyint NOT NULL,
  `tDepth` tinyint NOT NULL,
  `tBackC` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `AdventureIllustration`
--

/*!50001 DROP TABLE IF EXISTS `AdventureIllustration`*/;
/*!50001 DROP VIEW IF EXISTS `AdventureIllustration`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dragon`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `AdventureIllustration` AS select `A`.`idAdventure` AS `idAdventure`,`A`.`name` AS `name`,`A`.`description` AS `description`,`M`.`idMap` AS `idMap`,`M`.`name` AS `mapName`,`M`.`pixelsPerFoot` AS `pixelsPerFoot`,`M`.`feetPerInch` AS `feetPerInch`,`M`.`widthInches` AS `widthInches`,`M`.`heightInches` AS `heightInches`,`M`.`rotate` AS `rotate`,`M`.`scale` AS `scale`,`M`.`scaleY` AS `scaleY`,`M`.`translateX` AS `translateX`,`M`.`translateY` AS `translateY`,`M`.`visible` AS `visible`,`M`.`dmVisible` AS `dmVisible`,`M`.`showName` AS `showName`,`M`.`dmShowName` AS `dmShowName`,`M`.`depth` AS `depth`,`M`.`backgroundColor` AS `backgroundColor` from (((`Adventure` `A` join `AdventureMap` `AM` on((`A`.`idAdventure` = `AM`.`idAdventure`))) join `Map` `M` on((`AM`.`idMap` = `M`.`idMap`))) join `MapType` `MT` on((`M`.`idMapType` = `MT`.`idMapType`))) where (`MT`.`name` = 'illustration') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `AdventureOverviewMap`
--

/*!50001 DROP TABLE IF EXISTS `AdventureOverviewMap`*/;
/*!50001 DROP VIEW IF EXISTS `AdventureOverviewMap`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dragon`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `AdventureOverviewMap` AS select `A`.`idAdventure` AS `idAdventure`,`A`.`name` AS `name`,`A`.`description` AS `description`,`M`.`idMap` AS `idMap`,`M`.`name` AS `mapName`,`M`.`pixelsPerFoot` AS `pixelsPerFoot`,`M`.`feetPerInch` AS `feetPerInch`,`M`.`widthInches` AS `widthInches`,`M`.`heightInches` AS `heightInches`,`M`.`rotate` AS `rotate`,`M`.`scale` AS `scale`,`M`.`scaleY` AS `scaleY`,`M`.`translateX` AS `translateX`,`M`.`translateY` AS `translateY`,`M`.`visible` AS `visible`,`M`.`dmVisible` AS `dmVisible`,`M`.`showName` AS `showName`,`M`.`dmShowName` AS `dmShowName`,`M`.`depth` AS `depth`,`M`.`backgroundColor` AS `backgroundColor` from (((`Adventure` `A` join `AdventureMap` `AM` on((`A`.`idAdventure` = `AM`.`idAdventure`))) join `Map` `M` on((`AM`.`idMap` = `M`.`idMap`))) join `MapType` `MT` on((`M`.`idMapType` = `MT`.`idMapType`))) where (`MT`.`name` = 'overviewMap') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `AdventurePawnGrid`
--

/*!50001 DROP TABLE IF EXISTS `AdventurePawnGrid`*/;
/*!50001 DROP VIEW IF EXISTS `AdventurePawnGrid`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dragon`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `AdventurePawnGrid` AS select `A`.`idAdventure` AS `idAdventure`,`A`.`name` AS `name`,`A`.`description` AS `description`,`M`.`idMap` AS `idMap`,`M`.`name` AS `mapName`,`M`.`pixelsPerFoot` AS `pixelsPerFoot`,`M`.`feetPerInch` AS `feetPerInch`,`M`.`widthInches` AS `widthInches`,`M`.`heightInches` AS `heightInches`,`M`.`rotate` AS `rotate`,`M`.`scale` AS `scale`,`M`.`scaleY` AS `scaleY`,`M`.`translateX` AS `translateX`,`M`.`translateY` AS `translateY`,`M`.`visible` AS `visible`,`M`.`dmVisible` AS `dmVisible`,`M`.`showName` AS `showName`,`M`.`dmShowName` AS `dmShowName`,`M`.`depth` AS `depth`,`M`.`backgroundColor` AS `backgroundColor` from (((`Adventure` `A` join `AdventureMap` `AM` on((`A`.`idAdventure` = `AM`.`idAdventure`))) join `Map` `M` on((`AM`.`idMap` = `M`.`idMap`))) join `MapType` `MT` on((`M`.`idMapType` = `MT`.`idMapType`))) where (`MT`.`name` = 'pawnGrid') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `AllAdventureMap`
--

/*!50001 DROP TABLE IF EXISTS `AllAdventureMap`*/;
/*!50001 DROP VIEW IF EXISTS `AllAdventureMap`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dragon`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `AllAdventureMap` AS select `A`.`idAdventure` AS `idAdventure`,`A`.`name` AS `adventureName`,`A`.`description` AS `adventureDescription`,`M`.`idMap` AS `idMap`,`M`.`name` AS `name`,`M`.`pixelsPerFoot` AS `pixelsPerFoot`,`M`.`feetPerInch` AS `feetPerInch`,`M`.`widthInches` AS `widthInches`,`M`.`heightInches` AS `heightInches`,`M`.`rotate` AS `rotate`,`M`.`scale` AS `scale`,`M`.`scaleY` AS `scaleY`,`M`.`translateX` AS `translateX`,`M`.`translateY` AS `translateY`,`M`.`visible` AS `visible`,`M`.`dmVisible` AS `dmVisible`,`M`.`showName` AS `showName`,`M`.`dmShowName` AS `dmShowName`,`M`.`depth` AS `depth`,`M`.`backgroundColor` AS `backgroundColor`,`M`.`idDisplay` AS `idDisplay`,`M`.`idMapType` AS `idMapType`,`M`.`updated` AS `updated`,`M`.`updatedBy` AS `updatedBy` from ((`Adventure` `A` join `AdventureMap` `AM` on((`A`.`idAdventure` = `AM`.`idAdventure`))) join `Map` `M` on((`AM`.`idMap` = `M`.`idMap`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `MapDmVisibleOnDisplay`
--

/*!50001 DROP TABLE IF EXISTS `MapDmVisibleOnDisplay`*/;
/*!50001 DROP VIEW IF EXISTS `MapDmVisibleOnDisplay`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dragon`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `MapDmVisibleOnDisplay` AS select `D`.`idDisplay` AS `idDisplay`,`D`.`name` AS `dName`,`D`.`position` AS `dPos`,`D`.`width` AS `dWidth`,`D`.`height` AS `dHeight`,`D`.`top` AS `dTop`,`D`.`bottom` AS `dBot`,`D`.`left` AS `dLeft`,`D`.`right` AS `dRight`,`D`.`backgroundColor` AS `dBackC`,`D`.`depth` AS `dDepth`,`M`.`idAdventure` AS `idAdventure`,`M`.`adventureName` AS `adventureName`,`M`.`idMap` AS `idMap`,`M`.`name` AS `mName`,`M`.`pixelsPerFoot` AS `mPPF`,`M`.`feetPerInch` AS `mFPI`,`M`.`widthInches` AS `mWidth`,`M`.`heightInches` AS `mHeight`,`M`.`rotate` AS `mRot`,`M`.`scale` AS `mScale`,`M`.`scaleY` AS `mScaleY`,`M`.`translateX` AS `mX`,`M`.`translateY` AS `mY`,`M`.`visible` AS `mVis`,`M`.`dmVisible` AS `mDmVis`,`M`.`showName` AS `mSName`,`M`.`dmShowName` AS `mDmSName`,`M`.`depth` AS `mDepth`,`M`.`backgroundColor` AS `mBackC`,`MT`.`idMapType` AS `idMapType`,`MT`.`name` AS `mtName` from ((`Display` `D` join `AllAdventureMap` `M` on((`D`.`idDisplay` = `M`.`idDisplay`))) join `MapType` `MT` on((`M`.`idMapType` = `MT`.`idMapType`))) where (`M`.`dmVisible` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `MapMapType`
--

/*!50001 DROP TABLE IF EXISTS `MapMapType`*/;
/*!50001 DROP VIEW IF EXISTS `MapMapType`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dragon`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `MapMapType` AS select `M`.`idAdventure` AS `idAdventure`,`M`.`adventureName` AS `adventureName`,`M`.`idMap` AS `idMap`,`M`.`name` AS `mapName`,`M`.`pixelsPerFoot` AS `pixelsPerFoot`,`M`.`feetPerInch` AS `feetPerInch`,`M`.`widthInches` AS `widthInches`,`M`.`heightInches` AS `heightInches`,`M`.`rotate` AS `rotate`,`M`.`scale` AS `scale`,`M`.`scaleY` AS `scaleY`,`M`.`translateX` AS `translateX`,`M`.`translateY` AS `translateY`,`M`.`visible` AS `visible`,`M`.`dmVisible` AS `dmVisible`,`M`.`showName` AS `showName`,`M`.`dmShowName` AS `dmShowName`,`M`.`depth` AS `depth`,`M`.`backgroundColor` AS `backgroundColor`,`M`.`idDisplay` AS `idDisplay`,`M`.`updated` AS `updated`,`M`.`updatedBy` AS `updatedBy`,`MT`.`name` AS `mapType` from (`AllAdventureMap` `M` join `MapType` `MT` on((`M`.`idMapType` = `MT`.`idMapType`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `MapPointer`
--

/*!50001 DROP TABLE IF EXISTS `MapPointer`*/;
/*!50001 DROP VIEW IF EXISTS `MapPointer`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dragon`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `MapPointer` AS select `PS`.`idPointers` AS `idPointers`,`PS`.`rotate` AS `rotate`,`PS`.`scale` AS `scale`,`PS`.`translateX` AS `translateX`,`PS`.`translateY` AS `translateY`,`PS`.`visible` AS `visible`,`PS`.`idMap` AS `idMap`,`PS`.`updated` AS `updated`,`PS`.`updatedBy` AS `updatedBy`,`P`.`idPointer` AS `idPointer`,`P`.`name` AS `name`,`P`.`selectKey` AS `selectKey`,`P`.`shapeSvg` AS `shapeSvg` from (`Pointers` `PS` join `Pointer` `P` on((`PS`.`idPointer` = `P`.`idPointer`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `ModifierList`
--

/*!50001 DROP TABLE IF EXISTS `ModifierList`*/;
/*!50001 DROP VIEW IF EXISTS `ModifierList`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dragon`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `ModifierList` AS select `MS`.`idModifiers` AS `idModifiers`,`MS`.`updated` AS `updated`,`MS`.`updatedBy` AS `updatedBy`,`MS`.`idPawn` AS `idPawn`,`M`.`idModifier` AS `idModifier`,`M`.`name` AS `name`,`M`.`shapeSvg` AS `shapeSvg` from (`Modifiers` `MS` join `Modifier` `M` on((`MS`.`idModifier` = `M`.`idModifier`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PawnRoleImageSourceLocation`
--

/*!50001 DROP TABLE IF EXISTS `PawnRoleImageSourceLocation`*/;
/*!50001 DROP VIEW IF EXISTS `PawnRoleImageSourceLocation`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dragon`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `PawnRoleImageSourceLocation` AS select `P`.`idPawn` AS `idPawn`,`P`.`name` AS `name`,`P`.`selectKey` AS `selectKey`,`P`.`rotate` AS `rotate`,`P`.`sizeFeet` AS `sizeFeet`,`P`.`translateX` AS `translateX`,`P`.`translateY` AS `translateY`,`P`.`height` AS `height`,`P`.`attackRange` AS `attackRange`,`P`.`attackType` AS `attackType`,`P`.`color` AS `color`,`P`.`visible` AS `visible`,`P`.`dmVisible` AS `dmVisible`,`P`.`depth` AS `depth`,`P`.`backgroundColor` AS `backgroundColor`,`P`.`imageX` AS `imageX`,`P`.`imageY` AS `imageY`,`P`.`imageScale` AS `imageScale`,`P`.`idMap` AS `idMap`,`P`.`updated` AS `updated`,`P`.`updatedBy` AS `updatedBy`,`R`.`idRole` AS `idRole`,`R`.`name` AS `roleName`,`I`.`idImage` AS `idImage`,`I`.`filename` AS `filename`,`I`.`width` AS `imageWidth`,`I`.`height` AS `imageHeight`,`I`.`type` AS `imageType`,if((`P`.`ruleLink` is not null),`P`.`ruleLink`,`I`.`ruleLink`) AS `ruleLink`,`S`.`idSource` AS `idSource`,`S`.`name` AS `sourceName`,`S`.`description` AS `sourceDescription`,`S`.`copyright` AS `copyright`,`L`.`idLocation` AS `idLocation`,`L`.`name` AS `directory`,`L`.`depth` AS `treeDepth`,`L`.`idParent` AS `idParent` from ((((`Pawn` `P` join `Role` `R` on((`P`.`idRole` = `R`.`idRole`))) join `Image` `I` on((`P`.`idImage` = `I`.`idImage`))) join `Source` `S` on((`I`.`idSource` = `S`.`idSource`))) join `Location` `L` on((`I`.`idLocation` = `L`.`idLocation`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `TileDmVisibleOnDisplay`
--

/*!50001 DROP TABLE IF EXISTS `TileDmVisibleOnDisplay`*/;
/*!50001 DROP VIEW IF EXISTS `TileDmVisibleOnDisplay`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dragon`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `TileDmVisibleOnDisplay` AS select `D`.`idDisplay` AS `idDisplay`,`D`.`name` AS `dName`,`D`.`position` AS `dPos`,`D`.`width` AS `dWidth`,`D`.`height` AS `dHeight`,`D`.`top` AS `dTop`,`D`.`bottom` AS `dBot`,`D`.`left` AS `dLeft`,`D`.`right` AS `dRight`,`D`.`backgroundColor` AS `dBackC`,`D`.`depth` AS `dDepth`,`M`.`idAdventure` AS `idAdventure`,`M`.`adventureName` AS `adventureName`,`M`.`idMap` AS `idMap`,`M`.`name` AS `mName`,`M`.`pixelsPerFoot` AS `mPPF`,`M`.`feetPerInch` AS `mFPI`,`M`.`widthInches` AS `mWidth`,`M`.`heightInches` AS `mHeight`,`M`.`rotate` AS `mRot`,`M`.`scale` AS `mScale`,`M`.`scaleY` AS `mScaleY`,`M`.`translateX` AS `mX`,`M`.`translateY` AS `mY`,`M`.`visible` AS `mVis`,`M`.`dmVisible` AS `mDmVis`,`M`.`showName` AS `mSName`,`M`.`dmShowName` AS `mDmSName`,`M`.`depth` AS `mDepth`,`M`.`backgroundColor` AS `mBackC`,`MT`.`idMapType` AS `idMapType`,`MT`.`name` AS `mtName`,`T`.`idTile` AS `idTile`,`T`.`name` AS `tName`,`T`.`scale` AS `tScale`,`T`.`rotate` AS `tRot`,`T`.`translateX` AS `tX`,`T`.`translateY` AS `tY`,`T`.`visible` AS `tVis`,`T`.`dmVisible` AS `tDmVis`,`T`.`depth` AS `tDepth`,`T`.`backgroundColor` AS `tBackC` from (((`Display` `D` join `AllAdventureMap` `M` on((`D`.`idDisplay` = `M`.`idDisplay`))) join `Tile` `T` on((`M`.`idMap` = `T`.`idMap`))) join `MapType` `MT` on((`M`.`idMapType` = `MT`.`idMapType`))) where ((`M`.`dmVisible` = 1) and (`T`.`dmVisible` = 1)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `TileImageSourceLocation`
--

/*!50001 DROP TABLE IF EXISTS `TileImageSourceLocation`*/;
/*!50001 DROP VIEW IF EXISTS `TileImageSourceLocation`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dragon`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `TileImageSourceLocation` AS select `T`.`idTile` AS `idTile`,`T`.`name` AS `name`,`T`.`rotate` AS `rotate`,`T`.`scale` AS `scale`,`T`.`translateX` AS `translateX`,`T`.`translateY` AS `translateY`,`T`.`visible` AS `visible`,`T`.`dmVisible` AS `dmVisible`,`T`.`depth` AS `depth`,`T`.`idMap` AS `idMap`,`T`.`updated` AS `updated`,`T`.`updatedBy` AS `updatedBy`,`I`.`idImage` AS `idImage`,`I`.`filename` AS `filename`,`I`.`width` AS `imageWidth`,`I`.`height` AS `imageHeight`,`I`.`type` AS `imageType`,if((`T`.`ruleLink` is not null),`T`.`ruleLink`,`I`.`ruleLink`) AS `ruleLink`,`S`.`idSource` AS `idSource`,`S`.`name` AS `sourceName`,`S`.`description` AS `sourceDescription`,`S`.`copyright` AS `copyright`,`L`.`idLocation` AS `idLocation`,`L`.`name` AS `directory`,`L`.`depth` AS `treeDepth`,`L`.`idParent` AS `idParent` from (((`Tile` `T` join `Image` `I` on((`T`.`idImage` = `I`.`idImage`))) join `Source` `S` on((`I`.`idSource` = `S`.`idSource`))) join `Location` `L` on((`I`.`idLocation` = `L`.`idLocation`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `TileVisibleOnDisplay`
--

/*!50001 DROP TABLE IF EXISTS `TileVisibleOnDisplay`*/;
/*!50001 DROP VIEW IF EXISTS `TileVisibleOnDisplay`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`dragon`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `TileVisibleOnDisplay` AS select `D`.`idDisplay` AS `idDisplay`,`D`.`name` AS `dName`,`D`.`position` AS `dPos`,`D`.`width` AS `dWidth`,`D`.`height` AS `dHeight`,`D`.`top` AS `dTop`,`D`.`bottom` AS `dBot`,`D`.`left` AS `dLeft`,`D`.`right` AS `dRight`,`D`.`backgroundColor` AS `dBackC`,`D`.`depth` AS `dDepth`,`M`.`idAdventure` AS `idAdventure`,`M`.`adventureName` AS `adventureName`,`M`.`idMap` AS `idMap`,`M`.`name` AS `mName`,`M`.`pixelsPerFoot` AS `mPPF`,`M`.`feetPerInch` AS `mFPI`,`M`.`widthInches` AS `mWidth`,`M`.`heightInches` AS `mHeight`,`M`.`rotate` AS `mRot`,`M`.`scale` AS `mScale`,`M`.`scaleY` AS `mScaleY`,`M`.`translateX` AS `mX`,`M`.`translateY` AS `mY`,`M`.`visible` AS `mVis`,`M`.`dmVisible` AS `mDmVis`,`M`.`showName` AS `mSName`,`M`.`dmShowName` AS `mDmSName`,`M`.`depth` AS `mDepth`,`M`.`backgroundColor` AS `mBackC`,`MT`.`idMapType` AS `idMapType`,`MT`.`name` AS `mtName`,`T`.`idTile` AS `idTile`,`T`.`name` AS `tName`,`T`.`scale` AS `tScale`,`T`.`rotate` AS `tRot`,`T`.`translateX` AS `tX`,`T`.`translateY` AS `tY`,`T`.`visible` AS `tVis`,`T`.`dmVisible` AS `tDmVis`,`T`.`depth` AS `tDepth`,`T`.`backgroundColor` AS `tBackC` from (((`Display` `D` join `AllAdventureMap` `M` on((`D`.`idDisplay` = `M`.`idDisplay`))) join `Tile` `T` on((`M`.`idMap` = `T`.`idMap`))) join `MapType` `MT` on((`M`.`idMapType` = `MT`.`idMapType`))) where ((`M`.`visible` = 1) and (`T`.`visible` = 1)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-17  8:30:46
