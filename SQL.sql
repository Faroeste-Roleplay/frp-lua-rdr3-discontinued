-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.11-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Copiando estrutura do banco de dados para redm
CREATE DATABASE IF NOT EXISTS `redm` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `redm`;

-- Copiando estrutura para tabela redm.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `charid` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `characterName` varchar(50) NOT NULL,
  `level` int(11) DEFAULT 1,
  `xp` int(11) DEFAULT 0,
  `groups` text NOT NULL DEFAULT '{}',
  `charTable` text NOT NULL DEFAULT '{}',
  `clothes` text DEFAULT '{}',
  `weapons` text NOT NULL DEFAULT '{}',
  `is_dead` int(11) DEFAULT 0,
  PRIMARY KEY (`charid`),
  KEY `FK_characters_users` (`user_id`),
  CONSTRAINT `FK_characters_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.characters: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
INSERT INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `xp`, `groups`, `charTable`, `clothes`, `weapons`, `is_dead`) VALUES
	(28, 3, 'Nome Teste', 1, 0, '{"user":true,"admin":true}', '{"hunger": "50", "thirst": "50", "model": "mp_male", "head": "517496604", "age": "18", "hair": "332193580", "teeth": "101272007", "mustache": "298392309", "position": "{\\"z\\":65.46,\\"x\\":1008.53,\\"y\\":-985.56}", "posse": "56"}', '{"gloves": "0x10BD09BD", "hat": "0x10106532", "vests": "0x1077DF15", "boots": "0x11044269", "pants": "0x1A0CD667", "shirts": "0x10A9CF9B", "gunbelts": "0x3DF1A52", "coats": "0x105F0147", "legs": "0x8AD16414"}', '{"weapon_bow":40,"weapon_repeater_carbine":135,"weapon_melee_hatchet":1,"weapon_pistol_volcanic":49,"weapon_fishingrod":0,"weapon_thrown_throwing_knives":1,"weapon_lasso":1,"weapon_melee_torch":0}', 0),
	(30, 3, 'Testante Haah', 1, 0, '{"user":true,"admin":true,"vip":true}', '{"hunger": "0", "thirst": "0", "legs": "453543685", "age": "19", "torso": "453543685", "model": "mp_female", "head": "301009282", "position": "{\\"x\\":1343.94,\\"z\\":49.66,\\"y\\":-1904.61}"}', '{"gunbelts": "0x4D2686CA", "neckwear": "0x122A8031", "pants": "0x114B1F63", "boots": "0x12CB6473", "shirts": "0x1178F4F4", "hat": "0x1746D236"}', '{}', 0);
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;

-- Copiando estrutura para tabela redm.chests
CREATE TABLE IF NOT EXISTS `chests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charid` int(11) DEFAULT NULL,
  `position` text NOT NULL DEFAULT '{}[]',
  `type` int(11) NOT NULL,
  `capacity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_chests_characters` (`charid`),
  CONSTRAINT `FK_chests_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.chests: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `chests` DISABLE KEYS */;
INSERT INTO `chests` (`id`, `charid`, `position`, `type`, `capacity`) VALUES
	(45, NULL, '[100.1,200.2,300.2,180.0]', 0, 20);
/*!40000 ALTER TABLE `chests` ENABLE KEYS */;

-- Copiando estrutura para procedure redm.getData
DELIMITER //
CREATE PROCEDURE `getData`(
	IN `typeData` VARCHAR(10),
	IN `id` INT(8)
,
	IN `keyValue` VARCHAR(50)

)
BEGIN
	IF (keyValue = 'all' && typeData = 'clothes') THEN
		SELECT clothes as Value FROM characters WHERE charid = id;
	ELSEIF (keyValue = 'all' && typeData = 'groups') THEN
		SELECT groups as Value FROM characters WHERE charid = id;
	ELSEIF (keyValue = 'all' && typeData = 'charTable') THEN
		SELECT charTable as Value FROM characters WHERE charid = id;
	END IF;
	
	IF (typeData = 'groups') THEN
		SELECT json_extract(groups, CONCAT("$.", keyValue)) as Value FROM characters WHERE charid = id;
	ELSEIF (typeData = 'clothes') THEN
		SELECT json_extract(clothes, CONCAT("$.", keyValue)) as Value FROM characters WHERE charid = id;
	ELSEIF (typeData = 'charTable') THEN
		SELECT json_extract(charTable, CONCAT("$.", keyValue)) as Value FROM characters WHERE charid = id;
	END IF;
END//
DELIMITER ;

-- Copiando estrutura para tabela redm.horses
CREATE TABLE IF NOT EXISTS `horses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charid` int(11) NOT NULL,
  `model` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `clothes` text DEFAULT '{}',
  PRIMARY KEY (`id`),
  KEY `FK_horses_characters` (`charid`),
  CONSTRAINT `FK_horses_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.horses: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `horses` DISABLE KEYS */;
INSERT INTO `horses` (`id`, `charid`, `model`, `name`, `clothes`) VALUES
	(3, 28, 'A_C_Donkey_01', 'Burrinho', ''),
	(4, 28, 'A_C_HORSE_TURKOMAN_GOLD', 'Cavalo1', '{}'),
	(6, 30, 'A_C_Donkey_01', 'Burrinho', ''),
	(7, 30, 'A_C_HORSE_ARABIAN_ROSEGREYBAY', 'Cavalokkk', '');
/*!40000 ALTER TABLE `horses` ENABLE KEYS */;

-- Copiando estrutura para procedure redm.inventories
DELIMITER //
CREATE PROCEDURE `inventories`(
	IN `iid` VARCHAR(20),
	IN `charid` INT(8),
	IN `itemName` VARCHAR(100),
	IN `itemCount` INT(8),
	IN `typeInv` VARCHAR(8)



)
BEGIN
    IF (typeInv = "update") THEN
        UPDATE inventories SET items = JSON_SET(items, CONCAT("$.", itemName), itemCount) WHERE id = iid;
    ELSEIF (typeInv = "remove") THEN
        UPDATE inventories SET items = JSON_REMOVE(items, CONCAT("$.", itemName)) WHERE id = iid;
    ELSEIF (typeInv = "select") THEN
        SELECT * from inventories WHERE id = iid;
    ELSEIF (typeInv = "insert") THEN
        INSERT INTO inventories(id, charid, capacity, items) VALUES (iid, charid, 20, "{}");
    ELSEIF (typeInv = "deadPlayer") THEN
        UPDATE inventories SET items = '{}' WHERE id = iid and charid = charid;
    END IF;
END//
DELIMITER ;

-- Copiando estrutura para tabela redm.inventories
CREATE TABLE IF NOT EXISTS `inventories` (
  `id` varchar(100) NOT NULL,
  `charid` int(11) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `items` text NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_inventoriers_characters` (`charid`),
  CONSTRAINT `FK_inventories_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.inventories: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `inventories` DISABLE KEYS */;
INSERT INTO `inventories` (`id`, `charid`, `capacity`, `items`) VALUES
	('char:28', 28, 20, '{"generic_money": 290605, "generic_gold": 97, "consumable_apple": 18, "kit_camp_simple": 2, "generic_picareta": 1, "generic_provision_disco_ammolite": 3, "generic_ourobruto": 21, "generic_pedralavada": 12, "weapon_bow": 9, "weapon_thrown_dynamite": 1, "weapon_melee_lantern_electric": 5}'),
	('char:30', 30, 20, '{"generic_money": 489590, "weapon_revolver_cattleman": 1}'),
	('horse:3', 28, 20, '{}'),
	('horse:4', 28, 20, '{}'),
	('horse:6', 30, 20, '{}'),
	('horse:7', 30, 20, '{}');
/*!40000 ALTER TABLE `inventories` ENABLE KEYS */;

-- Copiando estrutura para tabela redm.jail
CREATE TABLE IF NOT EXISTS `jail` (
  `id` int(11) NOT NULL DEFAULT 0,
  `charid` int(11) DEFAULT NULL,
  `jail_time` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_jail_characters` (`charid`),
  CONSTRAINT `FK_jail_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.jail: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `jail` DISABLE KEYS */;
/*!40000 ALTER TABLE `jail` ENABLE KEYS */;

-- Copiando estrutura para tabela redm.posses
CREATE TABLE IF NOT EXISTS `posses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charid` int(11) NOT NULL,
  `members` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `charid` (`charid`),
  CONSTRAINT `FK_posses_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.posses: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `posses` DISABLE KEYS */;
INSERT INTO `posses` (`id`, `charid`, `members`, `name`) VALUES
	(56, 28, '{"28":1}', 'BICHO');
/*!40000 ALTER TABLE `posses` ENABLE KEYS */;

-- Copiando estrutura para tabela redm.quests
CREATE TABLE IF NOT EXISTS `quests` (
  `questId` varchar(50) NOT NULL DEFAULT '0',
  `charid` int(11) NOT NULL AUTO_INCREMENT,
  `questSteps` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`questId`),
  KEY `charid` (`charid`),
  CONSTRAINT `FK_quests_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.quests: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `quests` DISABLE KEYS */;
/*!40000 ALTER TABLE `quests` ENABLE KEYS */;

-- Copiando estrutura para procedure redm.remData
DELIMITER //
CREATE PROCEDURE `remData`(
	IN `typeData` VARCHAR(20),
	IN `keyValue` VARCHAR(50),
	IN `id` INT(8)
)
BEGIN
	IF (typeData = 'groups') THEN
		UPDATE characters SET groups = JSON_REMOVE(groups, CONCAT("$.", keyValue)) WHERE charid = id;
	ELSEIF (typeData = 'clothes') THEN
		UPDATE characters SET clothes = JSON_REMOVE(clothes, CONCAT("$.", keyValue)) WHERE charid = id;
	ELSEIF (typeData = 'charTable') THEN
		UPDATE characters SET charTable = JSON_REMOVE(charTable, CONCAT("$.", keyValue)) WHERE charid = id;
	END IF;
END//
DELIMITER ;

-- Copiando estrutura para procedure redm.setData
DELIMITER //
CREATE PROCEDURE `setData`(
	IN `typeData` VARCHAR(20),
	IN `keyValue` VARCHAR(50),
	IN `valueKey` VARCHAR(50),
	IN `id` INT(8)


)
BEGIN
	IF (typeData = 'groups') THEN
		UPDATE characters SET groups = JSON_SET(groups, CONCAT("$.", keyValue), valueKey) WHERE charid = id;
	ELSEIF (typeData = 'clothes') THEN
		UPDATE characters SET clothes = JSON_SET(clothes, CONCAT("$.", keyValue), valueKey) WHERE charid = id;
	ELSEIF (typeData = 'charTable') THEN
		UPDATE characters SET charTable = JSON_SET(charTable, CONCAT("$.", keyValue), valueKey) WHERE charid = id;
	END IF;
END//
DELIMITER ;

-- Copiando estrutura para tabela redm.users
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(21) NOT NULL,
  `name` varchar(50) NOT NULL,
  `banned` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`),
  KEY `identifier` (`identifier`),
  CONSTRAINT `FK_users_whitelist` FOREIGN KEY (`identifier`) REFERENCES `whitelist` (`identifier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.users: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(3, 'steam:11000010596ee06', 'KlandesTino', 0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Copiando estrutura para tabela redm.whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `id` int(11) NOT NULL,
  `identifier` varchar(21) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.whitelist: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `whitelist` DISABLE KEYS */;
INSERT INTO `whitelist` (`id`, `identifier`) VALUES
	(1, 'steam:11000010596ee06');
/*!40000 ALTER TABLE `whitelist` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
