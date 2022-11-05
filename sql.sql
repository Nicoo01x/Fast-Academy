-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.24-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Volcando estructura para tabla es_extended.datastore
CREATE TABLE IF NOT EXISTS `datastore` (
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla es_extended.datastore: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `datastore` DISABLE KEYS */;
INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES
	('society_ambulance', 'Ambulance', 1),
	('society_police', 'Police', 1);
/*!40000 ALTER TABLE `datastore` ENABLE KEYS */;

-- Volcando estructura para tabla es_extended.datastore_data
CREATE TABLE IF NOT EXISTS `datastore_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_datastore_owner_name` (`owner`,`name`),
  KEY `index_datastore_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla es_extended.datastore_data: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `datastore_data` DISABLE KEYS */;
INSERT INTO `datastore_data` (`id`, `name`, `owner`, `data`) VALUES
	(1, 'society_ambulance', NULL, '{}'),
	(2, 'society_police', NULL, '{"weapons":[{"count":0,"name":"WEAPON_PISTOL_MK2"}]}');
/*!40000 ALTER TABLE `datastore_data` ENABLE KEYS */;

-- Volcando estructura para tabla es_extended.guille_gangsv2
CREATE TABLE IF NOT EXISTS `guille_gangsv2` (
  `gang` varchar(50) DEFAULT NULL,
  `maxmembers` int(11) DEFAULT NULL,
  `ranks` longtext DEFAULT NULL,
  `gangStyle` int(11) DEFAULT NULL,
  `colors` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `vehicles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `points` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `members` mediumtext DEFAULT NULL,
  `shop` longtext DEFAULT NULL,
  `inventory` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Volcando datos para la tabla es_extended.guille_gangsv2: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `guille_gangsv2` DISABLE KEYS */;
INSERT INTO `guille_gangsv2` (`gang`, `maxmembers`, `ranks`, `gangStyle`, `colors`, `vehicles`, `points`, `members`, `shop`, `inventory`) VALUES
	('saf', 12, '[{"num":1,"label":1}]', 1, '{"g":1,"b":1,"r":1}', '[{"vehicle":"sultan2"}]', '[{"heading":0.0,"coords":{"x":141.0107421875,"y":-1061.87158203125,"z":28.19236183166504},"type":"Save Vehicles"},{"heading":0.0,"coords":{"x":138.7856903076172,"y":-1064.38134765625,"z":28.19236183166504},"type":"Get Vehicles"},{"heading":0.0,"coords":{"x":136.23617553710938,"y":-1065.9337158203126,"z":28.19236183166504},"type":"Armory"},{"heading":0.0,"coords":{"x":133.85760498046876,"y":-1063.941162109375,"z":28.19236183166504},"type":"Boss"},{"heading":0.0,"coords":{"x":132.94210815429688,"y":-1061.07275390625,"z":28.19236183166504},"type":"Shop"},{"heading":0.0,"coords":{"x":131.75624084472657,"y":-1061.7545166015626,"z":28.19236183166504},"type":"Save Vehicles"}]', '[{"member":{"steam":"steam:110000153dd8568","rank":"1","name":"academyzon"}}]', '[]', '[]');
/*!40000 ALTER TABLE `guille_gangsv2` ENABLE KEYS */;

-- Volcando estructura para tabla es_extended.items
CREATE TABLE IF NOT EXISTS `items` (
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 1,
  `rare` tinyint(4) NOT NULL DEFAULT 0,
  `can_remove` tinyint(4) NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla es_extended.items: ~13 rows (aproximadamente)
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
	('ak', 'Ak-47', 0, 0, 1),
	('carabina', 'Carabina', 0, 0, 1),
	('carabinamk2', 'Carabina Mk2', 0, 0, 1),
	('cecAmmo', 'Municion Francotirador [36]', 0, 0, 1),
	('mun_fucili', 'Municion Fusil [60]', 0, 0, 1),
	('mun_pistola', 'Municion Pistola [36]', 0, 0, 1),
	('mun_pompa', 'Municion Escopeta [36]', 0, 0, 1),
	('mun_smg', 'Municion smg [36]', 0, 0, 1),
	('pistola', 'Pistola 9mm', 0, 0, 1),
	('pistoladacombattimento', 'Pistola de Combate ', 0, 0, 1),
	('pistolamk2', 'FN Five Seven', 0, 0, 1),
	('pistolavintage', 'Pistola Vintage ', 0, 0, 1),
	('specialcarbine', 'Carabina Special', 0, 0, 1);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

-- Volcando estructura para tabla es_extended.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla es_extended.jobs: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` (`name`, `label`) VALUES
	('ambulance', 'Ambulance'),
	('police', 'PFA'),
	('unemployed', 'Unemployed');
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Volcando estructura para tabla es_extended.job_grades
CREATE TABLE IF NOT EXISTS `job_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `skin_female` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla es_extended.job_grades: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `job_grades` DISABLE KEYS */;
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(1, 'unemployed', 0, 'unemployed', 'Unemployed', 200, '{}', '{}'),
	(31, 'police', 0, 'Cadete', 'Cadete', 0, '{}', '{}'),
	(32, 'police', 1, 'Cabo', 'Cabo', 0, '{}', '{}'),
	(33, 'police', 2, 'Cabo1', 'Cabo1', 0, '{}', '{}'),
	(34, 'police', 3, 'Cabo11', 'Cabo11', 0, '{}', '{}'),
	(35, 'police', 4, 'Sargentol', 'Sargentol', 0, '{}', '{}'),
	(36, 'police', 5, 'Sargentoll', 'Sargentoll', 0, '{}', '{}'),
	(41, 'police', 6, 'Instructor', 'Instructor', 0, '{}', '{}'),
	(42, 'police', 7, 'Director', 'Chief', 0, '{}', '{}');
/*!40000 ALTER TABLE `job_grades` ENABLE KEYS */;

-- Volcando estructura para tabla es_extended.okokbanking_societies
CREATE TABLE IF NOT EXISTS `okokbanking_societies` (
  `society` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `society_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` int(50) DEFAULT NULL,
  `iban` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_withdrawing` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla es_extended.okokbanking_societies: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `okokbanking_societies` DISABLE KEYS */;
/*!40000 ALTER TABLE `okokbanking_societies` ENABLE KEYS */;

-- Volcando estructura para tabla es_extended.okokbanking_transactions
CREATE TABLE IF NOT EXISTS `okokbanking_transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receiver_identifier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receiver_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender_identifier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sender_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` int(50) NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla es_extended.okokbanking_transactions: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `okokbanking_transactions` DISABLE KEYS */;
INSERT INTO `okokbanking_transactions` (`id`, `receiver_identifier`, `receiver_name`, `sender_identifier`, `sender_name`, `date`, `value`, `type`) VALUES
	(1, 'Banco', 'Bank (PIN)', '4aa64c2b330e58a116af4ea7b734d62180be61f6', 'academyzon', '2022-09-08 19:23:47', 1000, 'transfer');
/*!40000 ALTER TABLE `okokbanking_transactions` ENABLE KEYS */;

-- Volcando estructura para tabla es_extended.trunk_inventory
CREATE TABLE IF NOT EXISTS `trunk_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `owned` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla es_extended.trunk_inventory: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `trunk_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `trunk_inventory` ENABLE KEYS */;

-- Volcando estructura para tabla es_extended.users
CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `accounts` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `group` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'user',
  `inventory` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `job` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `loadout` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '{"x":-269.4,"y":-955.3,"z":31.2,"heading":205.8}',
  `skin` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `iban` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pincode` int(50) DEFAULT NULL,
  `is_dead` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Volcando datos para la tabla es_extended.users: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
es_extendedjobsguille_gangsv2guille_gangsv2