-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema DragonberryPi
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `DragonberryPi` ;

-- -----------------------------------------------------
-- Schema DragonberryPi
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DragonberryPi` DEFAULT CHARACTER SET utf8 ;
USE `DragonberryPi` ;

-- -----------------------------------------------------
-- Table `DragonberryPi`.`Adventure`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`Adventure` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`Adventure` (
  `idAdventure` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(320) NULL,
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  PRIMARY KEY (`idAdventure`),
  INDEX `updated` (`updated` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DragonberryPi`.`MapType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`MapType` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`MapType` (
  `idMapType` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` CHAR(16) NOT NULL,
  `description` TEXT NULL,
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  PRIMARY KEY (`idMapType`),
  INDEX `mapTypeName` (`name` ASC),
  INDEX `updated` (`updated` ASC))
ENGINE = InnoDB
COMMENT = 'Type of \"Map\", is it a PawnGrid, an OverviewMap, or a Headshot';


-- -----------------------------------------------------
-- Table `DragonberryPi`.`Display`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`Display` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`Display` (
  `idDisplay` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `position` VARCHAR(45) NULL DEFAULT 'fixed',
  `width` VARCHAR(45) NULL DEFAULT '100%',
  `height` VARCHAR(45) NULL DEFAULT '100%',
  `top` VARCHAR(45) NULL DEFAULT NULL,
  `bottom` VARCHAR(45) NULL DEFAULT NULL,
  `left` VARCHAR(45) NULL DEFAULT NULL,
  `right` VARCHAR(45) NULL DEFAULT NULL,
  `transform` VARCHAR(45) NULL,
  `backgroundColor` VARCHAR(45) NULL DEFAULT 'white',
  `depth` DOUBLE NOT NULL DEFAULT 1,
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  PRIMARY KEY (`idDisplay`),
  INDEX `updated` (`updated` ASC))
ENGINE = InnoDB
COMMENT = 'The Display will be a portion of the browser as a <DIV> element.\nThe properties will be defined as part of a CSS style sheet.';


-- -----------------------------------------------------
-- Table `DragonberryPi`.`Map`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`Map` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`Map` (
  `idMap` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `pixelsPerFoot` DOUBLE NULL DEFAULT 10 COMMENT 'pixels per map square before scaling\n',
  `feetPerInch` DOUBLE NULL DEFAULT 5,
  `widthInches` DOUBLE NULL DEFAULT 10,
  `heightInches` DOUBLE NULL DEFAULT 10,
  `rotate` DOUBLE NOT NULL DEFAULT 0,
  `scale` DOUBLE NOT NULL DEFAULT 1,
  `scaleY` DOUBLE NULL,
  `translateX` DOUBLE NOT NULL DEFAULT 0,
  `translateY` DOUBLE NOT NULL DEFAULT 0,
  `visible` TINYINT(1) NOT NULL DEFAULT TRUE,
  `dmVisible` TINYINT(1) NOT NULL DEFAULT TRUE,
  `showName` TINYINT(1) NOT NULL DEFAULT 0,
  `dmShowName` TINYINT(1) NOT NULL DEFAULT 1,
  `depth` DOUBLE NOT NULL DEFAULT 1,
  `backgroundColor` VARCHAR(45) NULL DEFAULT NULL,
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  `idAdventure` SMALLINT UNSIGNED NOT NULL,
  `idMapType` SMALLINT UNSIGNED NOT NULL,
  `idDisplay` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`idMap`),
  INDEX `updated` (`updated` ASC),
  INDEX `dmVisible` (`dmVisible` ASC),
  INDEX `fk_idAdventure2_idx` (`idAdventure` ASC),
  INDEX `fk_idMapType1_idx` (`idMapType` ASC),
  INDEX `fk_idDisplay1_idx` (`idDisplay` ASC),
  CONSTRAINT `fk_idAdventure2`
    FOREIGN KEY (`idAdventure`)
    REFERENCES `DragonberryPi`.`Adventure` (`idAdventure`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idMapType1`
    FOREIGN KEY (`idMapType`)
    REFERENCES `DragonberryPi`.`MapType` (`idMapType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idDisplay1`
    FOREIGN KEY (`idDisplay`)
    REFERENCES `DragonberryPi`.`Display` (`idDisplay`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'define a map made up of tiles.  Every Map will be layed out in squares index by letter and number where A,0 is the upper left (before rotation).';


-- -----------------------------------------------------
-- Table `DragonberryPi`.`Source`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`Source` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`Source` (
  `idSource` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `url` TINYTEXT NULL,
  `description` TINYTEXT NULL,
  `copyright` TINYTEXT NULL,
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  PRIMARY KEY (`idSource`),
  INDEX `updated` (`updated` ASC))
ENGINE = InnoDB
COMMENT = 'Origin of Image';


-- -----------------------------------------------------
-- Table `DragonberryPi`.`Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`Location` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`Location` (
  `idLocation` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` TINYBLOB NOT NULL,
  `depth` TINYINT NOT NULL DEFAULT 0,
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  `idParent` SMALLINT UNSIGNED NULL,
  PRIMARY KEY (`idLocation`),
  INDEX `updated` (`updated` ASC),
  INDEX `fk_idParent_idx` (`idParent` ASC),
  CONSTRAINT `fk_idParent`
    FOREIGN KEY (`idParent`)
    REFERENCES `DragonberryPi`.`Location` (`idLocation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Directory Location';


-- -----------------------------------------------------
-- Table `DragonberryPi`.`Image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`Image` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`Image` (
  `idImage` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `filename` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL DEFAULT 'PNG',
  `width` SMALLINT NOT NULL DEFAULT 0,
  `height` SMALLINT NOT NULL DEFAULT 0,
  `ruleLink` TINYTEXT NULL DEFAULT NULL COMMENT 'URL to any rules information related to the image',
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  `idSource` SMALLINT UNSIGNED NOT NULL,
  `idLocation` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`idImage`),
  INDEX `updated` (`updated` ASC),
  INDEX `fk_idSource1_idx` (`idSource` ASC),
  INDEX `fk_idLocation1_idx` (`idLocation` ASC),
  CONSTRAINT `fk_idSource1`
    FOREIGN KEY (`idSource`)
    REFERENCES `DragonberryPi`.`Source` (`idSource`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idLocation1`
    FOREIGN KEY (`idLocation`)
    REFERENCES `DragonberryPi`.`Location` (`idLocation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Location of image files on disk.';


-- -----------------------------------------------------
-- Table `DragonberryPi`.`Tile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`Tile` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`Tile` (
  `idTile` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL COMMENT 'tile name',
  `rotate` DOUBLE NOT NULL DEFAULT 0 COMMENT 'rotate',
  `scale` DOUBLE NOT NULL DEFAULT 1 COMMENT 'scale',
  `translateX` DOUBLE NOT NULL DEFAULT 0 COMMENT 'translate x',
  `translateY` DOUBLE NOT NULL DEFAULT 0 COMMENT 'translate y',
  `visible` TINYINT(1) NOT NULL DEFAULT TRUE COMMENT 'visibile',
  `dmVisible` TINYINT(1) NOT NULL DEFAULT TRUE,
  `depth` DOUBLE NOT NULL DEFAULT 1 COMMENT 'layer depth',
  `backgroundColor` VARCHAR(45) NULL DEFAULT NULL COMMENT 'background color or transparent if NULL',
  `ruleLink` TINYTEXT NULL DEFAULT NULL COMMENT 'URL for any rules associated with the tile\nThis may override the image ruleLink',
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  `idMap` SMALLINT UNSIGNED NOT NULL,
  `idImage` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`idTile`),
  INDEX `updated` (`updated` ASC),
  INDEX `dmVisible` (`dmVisible` ASC),
  INDEX `fk_idMap2_idx` (`idMap` ASC),
  INDEX `fk_idImage2_idx` (`idImage` ASC),
  CONSTRAINT `fk_idMap2`
    FOREIGN KEY (`idMap`)
    REFERENCES `DragonberryPi`.`Map` (`idMap`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idImage2`
    FOREIGN KEY (`idImage`)
    REFERENCES `DragonberryPi`.`Image` (`idImage`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'specify geometric location and the visibility of Tile elements which are part of a Map.  \nA Tile refrences only one Image, but can be in many Maps.';


-- -----------------------------------------------------
-- Table `DragonberryPi`.`Role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`Role` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`Role` (
  `idRole` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  PRIMARY KEY (`idRole`),
  INDEX `updated` (`updated` ASC))
ENGINE = InnoDB
COMMENT = 'What role does this Pawn play: PC, PCLeader, NPC, NPCMonster, etc';


-- -----------------------------------------------------
-- Table `DragonberryPi`.`PawnMask`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`PawnMask` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`PawnMask` (
  `idPawnMask` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT NULL,
  `maskSvg` BLOB NOT NULL,
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  PRIMARY KEY (`idPawnMask`))
ENGINE = InnoDB
COMMENT = 'This is the SVG file used to mask the pawn image into the actual Pawn with the shape and colors we want';


-- -----------------------------------------------------
-- Table `DragonberryPi`.`Pawn`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`Pawn` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`Pawn` (
  `idPawn` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `rotate` DOUBLE NOT NULL DEFAULT 0 COMMENT 'direction pawn is facing\n',
  `sizeFeet` DOUBLE NOT NULL DEFAULT 5,
  `translateX` DOUBLE NOT NULL DEFAULT 0 COMMENT 'X  location of pawn on map',
  `translateY` DOUBLE NOT NULL DEFAULT 0 COMMENT 'Y location of pawn on map',
  `color` VARCHAR(45) NOT NULL DEFAULT 'white',
  `height` DOUBLE NOT NULL DEFAULT 0,
  `visionRange` DOUBLE NULL,
  `attackSource` TINYINT NOT NULL DEFAULT 1,
  `attackRange` DOUBLE NOT NULL DEFAULT 0,
  `attackType` VARCHAR(45) NOT NULL DEFAULT 'None',
  `visible` TINYINT(1) NOT NULL DEFAULT TRUE,
  `dmVisible` TINYINT(1) NOT NULL DEFAULT TRUE,
  `depth` DOUBLE NOT NULL DEFAULT 1,
  `backgroundColor` VARCHAR(45) NOT NULL DEFAULT '#FFFFFF',
  `ruleLink` TINYTEXT NULL DEFAULT NULL COMMENT 'URL associated to any rules for the pawn.\nThis will likely override the image URL if defined',
  `imageX` DOUBLE NOT NULL DEFAULT 0 COMMENT 'X translation of image for pawn',
  `imageY` DOUBLE NOT NULL DEFAULT 0 COMMENT 'Y translation of image for pawn',
  `imageScale` DOUBLE NOT NULL DEFAULT 1.0,
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  `idMap` SMALLINT UNSIGNED NOT NULL,
  `idRole` SMALLINT UNSIGNED NOT NULL,
  `idMaster` SMALLINT UNSIGNED NULL DEFAULT NULL,
  `idPawnMask` SMALLINT UNSIGNED NOT NULL,
  `idImage` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`idPawn`),
  INDEX `updated` (`updated` ASC),
  INDEX `dmVisible` (`dmVisible` ASC),
  INDEX `fk_idMap3_idx` (`idMap` ASC),
  INDEX `fk_idRole2_idx` (`idRole` ASC),
  INDEX `fk_idMaster_idx` (`idMaster` ASC),
  INDEX `fk_idPawnMask1_idx` (`idPawnMask` ASC),
  INDEX `fk_idImage1_idx` (`idImage` ASC),
  CONSTRAINT `fk_idMap3`
    FOREIGN KEY (`idMap`)
    REFERENCES `DragonberryPi`.`Map` (`idMap`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idRole2`
    FOREIGN KEY (`idRole`)
    REFERENCES `DragonberryPi`.`Role` (`idRole`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idMaster`
    FOREIGN KEY (`idMaster`)
    REFERENCES `DragonberryPi`.`Pawn` (`idPawn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idPawnMask1`
    FOREIGN KEY (`idPawnMask`)
    REFERENCES `DragonberryPi`.`PawnMask` (`idPawnMask`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idImage1`
    FOREIGN KEY (`idImage`)
    REFERENCES `DragonberryPi`.`Image` (`idImage`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Pawn location on a Map.  Not \ngoing to impliment this right away, but for future reference.';


-- -----------------------------------------------------
-- Table `DragonberryPi`.`Modifier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`Modifier` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`Modifier` (
  `idModifier` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `shapeSvg` BLOB NOT NULL,
  `shapePlacement` ENUM('center', 'clock') NOT NULL DEFAULT 'clock',
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  PRIMARY KEY (`idModifier`),
  INDEX `updated` (`updated` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DragonberryPi`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`User` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`User` (
  `idUser` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `hash` VARCHAR(255) NOT NULL,
  `created` DATETIME NOT NULL DEFAULT NOW(),
  `type` ENUM('standard', 'administrator') NULL DEFAULT 'standard',
  `login` TINYINT(1) NOT NULL DEFAULT 0,
  `locked` TINYINT(1) NOT NULL DEFAULT 0,
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  PRIMARY KEY (`idUser`),
  INDEX `updated` (`updated` ASC),
  UNIQUE INDEX `user` (`user` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DragonberryPi`.`AdventureAuthority`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`AdventureAuthority` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`AdventureAuthority` (
  `idUser` SMALLINT UNSIGNED NOT NULL,
  `idAdventure` SMALLINT UNSIGNED NOT NULL,
  `canView` TINYINT(1) NOT NULL DEFAULT 1,
  `canControl` TINYINT(1) NOT NULL DEFAULT 0,
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  PRIMARY KEY (`idUser`, `idAdventure`),
  INDEX `fk_idAdventure1_idx` (`idAdventure` ASC),
  INDEX `fk_idUser1_idx` (`idUser` ASC),
  INDEX `updated` (`updated` ASC),
  CONSTRAINT `fk_idUser1`
    FOREIGN KEY (`idUser`)
    REFERENCES `DragonberryPi`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idAdventure1`
    FOREIGN KEY (`idAdventure`)
    REFERENCES `DragonberryPi`.`Adventure` (`idAdventure`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'grants authority to view and/or control all maps, pawns, and tiles belonging to the Adventure';


-- -----------------------------------------------------
-- Table `DragonberryPi`.`UserPreferences`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`UserPreferences` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`UserPreferences` (
  `idUser` SMALLINT UNSIGNED NOT NULL,
  `userName` VARCHAR(45) NULL,
  `selectColor` VARCHAR(45) NOT NULL DEFAULT '#ff9900',
  `mapScale` DOUBLE NOT NULL DEFAULT 1.0,
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  PRIMARY KEY (`idUser`),
  INDEX `updated` (`updated` ASC),
  CONSTRAINT `fk_idUser2`
    FOREIGN KEY (`idUser`)
    REFERENCES `DragonberryPi`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DragonberryPi`.`MapAuthority`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`MapAuthority` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`MapAuthority` (
  `idUser` SMALLINT UNSIGNED NOT NULL,
  `idMap` SMALLINT UNSIGNED NOT NULL,
  `canView` TINYINT(1) NOT NULL DEFAULT 0,
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  PRIMARY KEY (`idUser`, `idMap`),
  INDEX `fk_idMap1_idx` (`idMap` ASC),
  INDEX `fk_idUser3_idx` (`idUser` ASC),
  INDEX `updated` (`updated` ASC),
  CONSTRAINT `fk_idUser3`
    FOREIGN KEY (`idUser`)
    REFERENCES `DragonberryPi`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idMap1`
    FOREIGN KEY (`idMap`)
    REFERENCES `DragonberryPi`.`Map` (`idMap`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'modifies view access authority granted by AdventureAuthority, tyipically to hide a map from players while working on it.';


-- -----------------------------------------------------
-- Table `DragonberryPi`.`RoleAuthority`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`RoleAuthority` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`RoleAuthority` (
  `idUser` SMALLINT UNSIGNED NOT NULL,
  `idRole` SMALLINT UNSIGNED NOT NULL,
  `canControl` TINYINT(1) NOT NULL DEFAULT 1,
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  PRIMARY KEY (`idUser`, `idRole`),
  INDEX `fk_idRole1_idx` (`idRole` ASC),
  INDEX `fk_idUser4_idx` (`idUser` ASC),
  INDEX `updated` (`updated` ASC),
  CONSTRAINT `fk_idUser4`
    FOREIGN KEY (`idUser`)
    REFERENCES `DragonberryPi`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idRole1`
    FOREIGN KEY (`idRole`)
    REFERENCES `DragonberryPi`.`Role` (`idRole`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'modifies control access granted by AdventureAuthority to allow control of Pawns which a particular Role';


-- -----------------------------------------------------
-- Table `DragonberryPi`.`PawnSelect`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`PawnSelect` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`PawnSelect` (
  `idUser` SMALLINT UNSIGNED NOT NULL,
  `idPawn` SMALLINT UNSIGNED NOT NULL,
  `isSelected` TINYINT(1) NOT NULL DEFAULT 0,
  `showSelect` TINYINT(1) NOT NULL DEFAULT 1,
  `selectKey` CHAR NULL DEFAULT NULL,
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  PRIMARY KEY (`idUser`, `idPawn`),
  INDEX `fk_idPawn1_idx` (`idPawn` ASC),
  INDEX `fk_idUser5_idx` (`idUser` ASC),
  INDEX `updated` (`updated` ASC),
  CONSTRAINT `fk_idUser5`
    FOREIGN KEY (`idUser`)
    REFERENCES `DragonberryPi`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idPawn1`
    FOREIGN KEY (`idPawn`)
    REFERENCES `DragonberryPi`.`Pawn` (`idPawn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DragonberryPi`.`PawnModifier`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `DragonberryPi`.`PawnModifier` ;

CREATE TABLE IF NOT EXISTS `DragonberryPi`.`PawnModifier` (
  `idPawn` SMALLINT UNSIGNED NOT NULL,
  `idModifier` SMALLINT UNSIGNED NOT NULL,
  `updated` TIMESTAMP(3) NOT NULL DEFAULT NOW() ON UPDATE NOW(),
  `updatedBy` VARCHAR(240) NULL,
  PRIMARY KEY (`idPawn`, `idModifier`),
  INDEX `fk_idModifier1_idx` (`idModifier` ASC),
  INDEX `fk_idPawn2_idx` (`idPawn` ASC),
  INDEX `updated` (`updated` ASC),
  CONSTRAINT `fk_idPawn2`
    FOREIGN KEY (`idPawn`)
    REFERENCES `DragonberryPi`.`Pawn` (`idPawn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_idModifier1`
    FOREIGN KEY (`idModifier`)
    REFERENCES `DragonberryPi`.`Modifier` (`idModifier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `DragonberryPi` ;

-- -----------------------------------------------------
-- Placeholder table for view `DragonberryPi`.`ValidUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DragonberryPi`.`ValidUser` (`idUser` INT, `user` INT, `email` INT, `hash` INT, `created` INT, `type` INT, `login` INT, `locked` INT, `updated` INT, `updatedBy` INT, `userName` INT, `selectColor` INT, `mapScale` INT);

-- -----------------------------------------------------
-- View `DragonberryPi`.`ValidUser`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `DragonberryPi`.`ValidUser` ;
DROP TABLE IF EXISTS `DragonberryPi`.`ValidUser`;
USE `DragonberryPi`;
CREATE  OR REPLACE VIEW `ValidUser` AS SELECT User.*,userName,selectColor,mapScale FROM User LEFT JOIN UserPreferences USING (idUser) WHERE User.locked = False;
USE `DragonberryPi`;

DELIMITER $$

USE `DragonberryPi`$$
DROP TRIGGER IF EXISTS `DragonberryPi`.`PawnModifier_AFTER_INSERT` $$
USE `DragonberryPi`$$
CREATE DEFINER = CURRENT_USER TRIGGER `DragonberryPi`.`PawnModifier_AFTER_INSERT` AFTER INSERT ON `PawnModifier` FOR EACH ROW
UPDATE `Pawn` SET updated=NOW(), updatedBy='server' WHERE idPawn=NEW.idPawn$$


USE `DragonberryPi`$$
DROP TRIGGER IF EXISTS `DragonberryPi`.`PawnModifier_AFTER_UPDATE` $$
USE `DragonberryPi`$$
CREATE DEFINER = CURRENT_USER TRIGGER `DragonberryPi`.`PawnModifier_AFTER_UPDATE` AFTER UPDATE ON `PawnModifier` FOR EACH ROW
UPDATE `Pawn` SET updated=NEW.updated, updatedBy='server' WHERE idPawn=NEW.idPawn AND NEW.updated>updated$$


USE `DragonberryPi`$$
DROP TRIGGER IF EXISTS `DragonberryPi`.`PawnModifier_AFTER_DELETE` $$
USE `DragonberryPi`$$
CREATE DEFINER = CURRENT_USER TRIGGER `DragonberryPi`.`PawnModifier_AFTER_DELETE` AFTER DELETE ON `PawnModifier` FOR EACH ROW
UPDATE `Pawn` SET updated=NOW(), updatedBy='server' WHERE idPawn=OLD.idPawn$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
