-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.5.9-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para faroeste
CREATE DATABASE IF NOT EXISTS `faroeste` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `faroeste`;

-- Copiando estrutura para tabela faroeste.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `charid` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `characterName` varchar(50) NOT NULL,
  `level` int(11) DEFAULT 1,
  `age` int(11) DEFAULT 1,
  `xp` int(11) DEFAULT 0,
  `wanted` text NOT NULL DEFAULT '{}',
  `groups` bigint(20) NOT NULL DEFAULT 0,
  `metaData` text NOT NULL DEFAULT '{}',
  `is_dead` int(11) DEFAULT 0,
  PRIMARY KEY (`charid`),
  KEY `FK_characters_users` (`user_id`),
  CONSTRAINT `FK_character_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela faroeste.characters: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `metaData`, `is_dead`) VALUES
	(1, 1, 'Jorge Madeira', 1, 33, 62, '{}', 1, '{"hunger": "38.24", "thirst": "39.34", "banco": "0", "position": "[2497.895,-832.18,42.297]", "stats": "[250,33.6,100,100]"}', 0);
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;

-- Copiando estrutura para tabela faroeste.characters_appearence
CREATE TABLE IF NOT EXISTS `characters_appearence` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charid` int(11) DEFAULT NULL,
  `isMale` tinyint(1) DEFAULT 1,
  `model` mediumtext DEFAULT NULL,
  `enabledComponents` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`enabledComponents`)),
  `faceFeatures` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`faceFeatures`)),
  `overlays` longtext DEFAULT NULL,
  `clothes` longtext DEFAULT NULL,
  `pedHeight` text DEFAULT NULL,
  `pedWeight` int(11) DEFAULT 70,
  PRIMARY KEY (`id`),
  KEY `charID` (`charid`) USING BTREE,
  CONSTRAINT `characters_appearence_ibfk_1` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela faroeste.characters_appearence: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `characters_appearence` DISABLE KEYS */;
INSERT IGNORE INTO `characters_appearence` (`id`, `charid`, `isMale`, `model`, `enabledComponents`, `faceFeatures`, `overlays`, `clothes`, `pedHeight`, `pedWeight`) VALUES
	(1, 1, 1, 'mp_male', '{"heads":1931485756,"BODIES_UPPER":3212342147,"BODIES_LOWER":202858862,"skin_tone":0,"porte":0,"hair":1286449448,"mustache":0,"eyes":46507404,"teeth":0}', '[{"hash":34006,"index":"0.1"}]', '{}', '{"coats": "0", "coats2": "0", "hat": "0x137A8AA5", "vests": "0", "shirts": "0x12801254", "cloaks": "0", "boots": "0x11044269", "masks": "0", "pants": "0x1395EFA0"}', '0.9573360085487366', 70);
/*!40000 ALTER TABLE `characters_appearence` ENABLE KEYS */;

-- Copiando estrutura para tabela faroeste.characters_group
CREATE TABLE IF NOT EXISTS `characters_group` (
  `charid` int(11) NOT NULL,
  `groupID` int(11) NOT NULL,
  `rank` int(11) DEFAULT NULL,
  PRIMARY KEY (`charid`,`groupID`),
  UNIQUE KEY `profile_group_groupID_profileID_unique` (`charid`,`groupID`),
  KEY `groupID` (`groupID`),
  CONSTRAINT `profile_group_ibfk_1` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `profile_group_ibfk_2` FOREIGN KEY (`groupID`) REFERENCES `group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela faroeste.characters_group: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `characters_group` DISABLE KEYS */;
INSERT IGNORE INTO `characters_group` (`charid`, `groupID`, `rank`) VALUES
	(1, 1, 1);
/*!40000 ALTER TABLE `characters_group` ENABLE KEYS */;

-- Copiando estrutura para tabela faroeste.chests
CREATE TABLE IF NOT EXISTS `chests` (
  `id` tinytext NOT NULL DEFAULT 'AUTO_INCREMENT',
  `charid` int(11) DEFAULT NULL,
  `position` text NOT NULL DEFAULT '{}[]',
  `type` int(11) NOT NULL,
  `capacity` int(11) NOT NULL,
  KEY `FK_chests_characters` (`charid`),
  CONSTRAINT `FK_chests_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela faroeste.chests: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `chests` DISABLE KEYS */;
INSERT IGNORE INTO `chests` (`id`, `charid`, `position`, `type`, `capacity`) VALUES
	('1', NULL, '[-63.092,331.621,110.446,180.0]', 0, 20);
/*!40000 ALTER TABLE `chests` ENABLE KEYS */;

-- Copiando estrutura para tabela faroeste.fort
CREATE TABLE IF NOT EXISTS `fort` (
  `id` int(11) NOT NULL DEFAULT 0,
  `nome` text NOT NULL DEFAULT '0',
  `bando` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela faroeste.fort: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `fort` DISABLE KEYS */;
INSERT IGNORE INTO `fort` (`id`, `nome`, `bando`) VALUES
	(1, 'Mercer', 0),
	(2, 'Wallace', 0);
/*!40000 ALTER TABLE `fort` ENABLE KEYS */;

-- Copiando estrutura para procedure faroeste.getData
DELIMITER //
CREATE PROCEDURE `getData`(
	IN `typeData` VARCHAR(10),
	IN `id` INT(8),
	IN `keyValue` VARCHAR(50)
)
BEGIN
	IF (keyValue = 'all' && typeData = 'clothes') THEN
		SELECT clothes as Value FROM characters_appearence WHERE charid = id;
	ELSEIF (keyValue = 'all' && typeData = 'enabledComponents') THEN
		SELECT enabledComponents as Value FROM characters_appearence WHERE charid = id;
	ELSEIF (keyValue = 'all' && typeData = 'faceFeatures') THEN
		SELECT faceFeatures as Value FROM characters_appearence WHERE charid = id;
	ELSEIF (keyValue = 'all' && typeData = 'overlay') THEN
		SELECT overlay as Value FROM characters_appearence WHERE charid = id;	
	ELSEIF (keyValue = 'all' && typeData = 'wanted') THEN
		SELECT wanted as Value FROM characters WHERE charid = id;	
	ELSEIF (keyValue = 'all' && typeData = 'groups') THEN
		SELECT groups as Value FROM characters WHERE charid = id;
	ELSEIF (keyValue = 'all' && typeData = 'metaData') THEN
		SELECT metaData as Value FROM characters WHERE charid = id;		
	ELSEIF (keyValue = 'all' && typeData = 'modificacao') THEN
		SELECT modificacao as Value FROM horses WHERE id = id;
	END IF;
	
	IF (typeData = 'clothes') THEN
		SELECT json_extract(clothes, CONCAT("$.", keyValue)) as Value FROM characters_appearence WHERE charid = id;
    ELSEIF (typeData = 'enabledComponents') THEN
		SELECT json_extract(enabledComponents, CONCAT("$.", keyValue)) as Value FROM characters_appearence WHERE charid = id;
    ELSEIF (typeData = 'faceFeatures') THEN
		SELECT json_extract(faceFeatures, CONCAT("$.", keyValue)) as Value FROM characters_appearence WHERE charid = id;
    ELSEIF (typeData = 'overlay') THEN
		SELECT json_extract(overlay, CONCAT("$.", keyValue)) as Value FROM characters_appearence WHERE charid = id;
	ELSEIF (typeData = 'wanted') THEN
		SELECT json_extract(wanted, CONCAT("$.", keyValue)) as Value FROM characters WHERE charid = id;
	ELSEIF (typeData = 'groups') THEN
		SELECT json_extract(groups, CONCAT("$.", keyValue)) as Value FROM characters WHERE charid = id;
	ELSEIF (typeData = 'metaData') THEN
		SELECT json_extract(metaData, CONCAT("$.", keyValue)) as Value FROM characters WHERE charid = id;
	ELSEIF (typeData = 'modificacao') THEN
		SELECT json_extract(modificacao, CONCAT("$.", keyValue)) as Value FROM horses WHERE id = id;
	END IF;
END//
DELIMITER ;

-- Copiando estrutura para tabela faroeste.group
CREATE TABLE IF NOT EXISTS `group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela faroeste.group: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
INSERT IGNORE INTO `group` (`id`, `name`) VALUES
	(1, 'Staff'),
	(2, 'Police');
/*!40000 ALTER TABLE `group` ENABLE KEYS */;

-- Copiando estrutura para tabela faroeste.horses
CREATE TABLE IF NOT EXISTS `horses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charid` int(11) NOT NULL,
  `model` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `components` text NOT NULL DEFAULT '{}',
  `metaData` text NOT NULL DEFAULT '{}',
  `isDead` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_horses_characters` (`charid`),
  CONSTRAINT `FK_horses_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela faroeste.horses: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `horses` DISABLE KEYS */;
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`, `metaData`, `isDead`) VALUES
	(29, 1, 'A_C_Horse_AmericanStandardbred_Buckskin', 'Macho', '["0x106961A8","0x127E0412","0x3B3AB08","0x1D4EDB88","0x130E341A","0x12DBBBAF","0x107D9598","0x12F0DF9F"]', '{}', 0);
/*!40000 ALTER TABLE `horses` ENABLE KEYS */;

-- Copiando estrutura para tabela faroeste.inventories
CREATE TABLE IF NOT EXISTS `inventories` (
  `id` varchar(100) NOT NULL,
  `charid` int(11) DEFAULT NULL,
  `inv_capacity` tinyint(4) DEFAULT 20,
  `inv_slots` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`inv_slots`)),
  KEY `FK_inventories_characters` (`charid`),
  CONSTRAINT `FK_inventories_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela faroeste.inventories: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `inventories` DISABLE KEYS */;
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:2', 1, 40, '{"129": "{\\"info\\":\\"[]\\",\\"amount\\":[1,9,12],\\"name\\":\\"pistol_mauser\\"}", "113": "{\\"name\\":\\"id_card\\",\\"info\\":{\\"lastname\\":\\"Pintado\\",\\"firstname\\":\\"João\\",\\"birthdate\\":\\"1996-05-10\\",\\"nationality\\":\\"BR\\",\\"gender\\":\\"man\\",\\"citizenid\\":\\"RMN42922\\"},\\"amount\\":[1]}", "102": "{\\"info\\":\\"[]\\",\\"amount\\":[2000],\\"name\\":\\"money\\"}"}'),
	('static:public:2:2', 1, 100, '{}'),
	('static:public:2:2', 1, 100, '{}'),
	('static:public:1:2', 1, 100, '{}'),
	('static:public:1:2', 1, 100, '{}'),
	('static:public:2:1', 1, 100, '{}'),
	('horse:29', 1, 40, '{}');
/*!40000 ALTER TABLE `inventories` ENABLE KEYS */;

-- Copiando estrutura para procedure faroeste.inv_remove_slot
DELIMITER //
CREATE PROCEDURE `inv_remove_slot`(
IN `inv_id` VARCHAR(100), IN `slot_id` INT
)
BEGIN
    UPDATE inventories SET inv_slots = JSON_REMOVE(inv_slots, CONCAT("$.", slot_id)) WHERE id = inv_id;
END//
DELIMITER ;

-- Copiando estrutura para procedure faroeste.inv_update_slot
DELIMITER //
CREATE PROCEDURE `inv_update_slot`(
IN `inv_id` VARCHAR(100), IN `slot_id` INT(8), IN `slot_value` VARCHAR(255)
)
BEGIN
    UPDATE inventories SET inv_slots = JSON_SET(inv_slots, CONCAT("$.", slot_id), slot_value) WHERE id = inv_id;
END//
DELIMITER ;

-- Copiando estrutura para tabela faroeste.jail
CREATE TABLE IF NOT EXISTS `jail` (
  `id` int(11) NOT NULL DEFAULT 0,
  `charid` int(11) DEFAULT NULL,
  `jail_time` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_jail_characters` (`charid`),
  CONSTRAINT `FK_jail_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela faroeste.jail: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `jail` DISABLE KEYS */;
/*!40000 ALTER TABLE `jail` ENABLE KEYS */;

-- Copiando estrutura para tabela faroeste.posses
CREATE TABLE IF NOT EXISTS `posses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charid` int(11) NOT NULL,
  `members` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `charid` (`charid`),
  CONSTRAINT `FK_posses_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela faroeste.posses: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `posses` DISABLE KEYS */;
/*!40000 ALTER TABLE `posses` ENABLE KEYS */;

-- Copiando estrutura para procedure faroeste.procInventory
DELIMITER //
CREATE PROCEDURE `procInventory`(
	IN `iid` VARCHAR(20),
	IN `charid` INT(8),
	IN `capacity` INT(8),
	IN `slot` INT(8),
	IN `itemId` VARCHAR(100),
	IN `itemAmount` INT(8),
	IN `procType` VARCHAR(8)
)
BEGIN
    IF (procType = "update") THEN
		UPDATE inventories SET inv_slots = JSON_SET(inv_slots, CONCAT("$.", slot), "{}") WHERE id = iid;
        UPDATE inventories SET inv_slots = JSON_SET(inv_slots, CONCAT(CONCAT("$.", slot), "[0]"), itemId, CONCAT(CONCAT("$.", slot), "[1]"), itemAmount) WHERE id = iid;
    ELSEIF (procType = "updateAmmoOnly") THEN
        UPDATE inventories SET inv_slots = JSON_SET(inv_slots, CONCAT(CONCAT("$.", slot), "[3]"), itemAmmoInClip, CONCAT(CONCAT("$.", slot), "[4]"), itemAmmoInWeapon) WHERE id = iid;
    ELSEIF (procType = "remove") THEN
        UPDATE inventories SET inv_slots = JSON_REMOVE(inv_slots, CONCAT("$.", slot)) WHERE id = iid;
    ELSEIF (procType = "select") THEN
        SELECT * from inventories WHERE id = iid;
    ELSEIF (procType = "insert") THEN
        INSERT INTO inventories(id, charid, inv_capacity, inv_slots) VALUES (iid, charid, capacity, "{}");
    ELSEIF (procType = "clear") THEN
        UPDATE inventories SET inv_slots = "{}" WHERE id = iid and charid = charid;
    END IF;
END//
DELIMITER ;

-- Copiando estrutura para tabela faroeste.quests
CREATE TABLE IF NOT EXISTS `quests` (
  `questId` varchar(50) NOT NULL DEFAULT '0',
  `charid` int(11) NOT NULL AUTO_INCREMENT,
  `questSteps` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`questId`),
  KEY `charid` (`charid`),
  CONSTRAINT `FK_quests_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela faroeste.quests: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `quests` DISABLE KEYS */;
/*!40000 ALTER TABLE `quests` ENABLE KEYS */;

-- Copiando estrutura para procedure faroeste.remData
DELIMITER //
CREATE PROCEDURE `remData`(
	IN `typeData` VARCHAR(20),
	IN `keyValue` VARCHAR(50),
	IN `id` INT(8)
)
BEGIN
	IF (typeData = 'clothes') THEN
		UPDATE characters_appearence SET clothes = JSON_REMOVE(clothes, CONCAT("$.", keyValue)) WHERE charid = id;
  ELSEIF (typeData = 'enabledComponents') THEN
		UPDATE characters_appearence SET enabledComponents = JSON_REMOVE(enabledComponents, CONCAT("$.", keyValue)) WHERE charid = id;		
  ELSEIF (typeData = 'faceFeatures') THEN
		UPDATE characters_appearence SET faceFeatures = JSON_REMOVE(faceFeatures, CONCAT("$.", keyValue)) WHERE charid = id;	
  ELSEIF (typeData = 'overlay') THEN
		UPDATE characters_appearence SET overlay = JSON_REMOVE(overlay, CONCAT("$.", keyValue)) WHERE charid = id;		
  ELSEIF (typeData = 'groups') THEN
		UPDATE characters SET groups = JSON_REMOVE(groups, CONCAT("$.", keyValue)) WHERE charid = id;		
	ELSEIF (typeData = 'wanted') THEN
		UPDATE characters SET wanted = JSON_REMOVE(wanted, CONCAT("$.", keyValue)) WHERE charid = id;
	ELSEIF (typeData = 'metaData') THEN
		UPDATE characters SET metaData = JSON_REMOVE(metaData, CONCAT("$.", keyValue)) WHERE charid = id;
	ELSEIF (typeData = 'modificacao') THEN
		UPDATE horses SET modificacao = JSON_REMOVE(modificacao, CONCAT("$.", keyValue)) WHERE charid = id;
	END IF;
END//
DELIMITER ;

-- Copiando estrutura para procedure faroeste.setData
DELIMITER //
CREATE PROCEDURE `setData`(
	IN `typeData` VARCHAR(20),
	IN `keyValue` VARCHAR(50),
	IN `valueKey` VARCHAR(50),
	IN `id` INT(8)
)
BEGIN
	IF (typeData = 'clothes') THEN
		UPDATE characters_appearence SET clothes = JSON_SET(clothes, CONCAT("$.", keyValue), valueKey) WHERE charid = id;
	ELSEIF (typeData = 'enabledComponents') THEN
		UPDATE characters_appearence SET enabledComponents = JSON_SET(enabledComponents, CONCAT("$.", keyValue), valueKey) WHERE charid = id;
	ELSEIF (typeData = 'faceFeatures') THEN
		UPDATE characters_appearence SET faceFeatures = JSON_SET(faceFeatures, CONCAT("$.", keyValue), valueKey) WHERE charid = id;
	ELSEIF (typeData = 'overlay') THEN
		UPDATE characters_appearence SET overlay = JSON_SET(overlay, CONCAT("$.", keyValue), valueKey) WHERE charid = id;
	ELSEIF (typeData = 'groups') THEN
		UPDATE characters SET groups = JSON_SET(groups, CONCAT("$.", keyValue), valueKey) WHERE charid = id;		
	ELSEIF (typeData = 'wanted') THEN
		UPDATE characters SET wanted = JSON_SET(wanted, CONCAT("$.", keyValue), valueKey) WHERE charid = id;			
	ELSEIF (typeData = 'metaData') THEN
		UPDATE characters SET metaData = JSON_SET(metaData, CONCAT("$.", keyValue), valueKey) WHERE charid = id;		
	ELSEIF (typeData = 'modificacao') THEN
		UPDATE horses SET modificacao = JSON_SET(modif, CONCAT("$.", keyValue), valueKey) WHERE id = id;
	END IF;
END//
DELIMITER ;

-- Copiando estrutura para tabela faroeste.stables
CREATE TABLE IF NOT EXISTS `stables` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT 'Estábulo',
  `ownerId` int(11) NOT NULL DEFAULT 0,
  `placeId` text NOT NULL DEFAULT '0',
  `members` varchar(50) NOT NULL DEFAULT '0',
  `horses` longtext DEFAULT '{}',
  `itens` longtext NOT NULL DEFAULT '{}',
  `money` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ownerId` (`ownerId`),
  CONSTRAINT `ownerid_key` FOREIGN KEY (`ownerId`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela faroeste.stables: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `stables` DISABLE KEYS */;
INSERT IGNORE INTO `stables` (`id`, `name`, `ownerId`, `placeId`, `members`, `horses`, `itens`, `money`) VALUES
	(1, 'Estábulo', 1, 'valentine_01', '0', '{"A_C_Horse_KentuckySaddle_Grey": [2, 2200], "A_C_Horse_Nokota_ReverseDappleRoan": [1, 34520], "A_C_Horse_Morgan_Palomino": [3, 55440]}', '{}', 0);
/*!40000 ALTER TABLE `stables` ENABLE KEYS */;

-- Copiando estrutura para tabela faroeste.tents
CREATE TABLE IF NOT EXISTS `tents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charid` int(11) NOT NULL,
  `model` bigint(20) NOT NULL,
  `position` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela faroeste.tents: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `tents` DISABLE KEYS */;
/*!40000 ALTER TABLE `tents` ENABLE KEYS */;

-- Copiando estrutura para tabela faroeste.users
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(21) NOT NULL,
  `name` varchar(50) NOT NULL,
  `banned` tinyint(1) unsigned zerofill NOT NULL DEFAULT 0,
  `reason` varchar(50) NOT NULL DEFAULT 'não definido',
  `whitelist` tinyint(1) unsigned zerofill NOT NULL DEFAULT 0,
  `createdAt` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela faroeste.users: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`, `reason`, `whitelist`, `createdAt`) VALUES
	(1, 'steam:11000010596ee06', 'KlandesTino', 0, 'não definido', 1, 'Tue Dec 29 13:27:42 2020');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
