/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP DATABASE IF EXISTS `inventory`;
CREATE DATABASE IF NOT EXISTS `inventory` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `inventory`;

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `excerpt` varchar(45) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `description` varchar(45) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `concract` varchar(255) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  `comment` varchar(255) CHARACTER SET utf32 COLLATE utf32_unicode_ci DEFAULT NULL,
  `sap_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`article_id`),
  KEY `fk_article_category_id` (`category_id`),
  CONSTRAINT `fk_article_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `article`;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` (`article_id`, `name`, `excerpt`, `description`, `concract`, `category_id`, `comment`, `sap_number`) VALUES
	(83, 'ACME SSD HD11 1TB', 'Kratki opis 1', 'Detaljan opis', 'EPU-25154/2022', 8, '', '1300-200200'),
	(84, 'ACME SSD HD11 1024GB', 'Kratki opis', 'Detaljan opis', 'EPU-25154/2022', 8, 'Komentar 1024GB', '1300-200201'),
	(85, 'ACME SSD HD11 1024MB', 'Kratki opis', 'Detaljan opis', 'EPU-25154/2022', 8, 'Komentar 1024MB serverski', '1300-200202'),
	(90, 'ThinkCentre 720S', 'Računar 720S', 'Detaljan opis računara', 'EPU-25158/2022', 9, '', '1300-100200');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;

DROP TABLE IF EXISTS `article_feature`;
CREATE TABLE IF NOT EXISTS `article_feature` (
  `article_feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `feature_id` int unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`article_feature_id`),
  UNIQUE KEY `uq_article_feature_article_id_feature_id` (`article_id`,`feature_id`) USING BTREE,
  KEY `fk_article_feature_feature_id` (`feature_id`) USING BTREE,
  CONSTRAINT `fk_article_feature_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_article_feature_feature_id` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`feature_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `article_feature`;
/*!40000 ALTER TABLE `article_feature` DISABLE KEYS */;
INSERT INTO `article_feature` (`article_feature_id`, `article_id`, `feature_id`, `value`) VALUES
	(54, 83, 8, '1TB'),
	(55, 83, 9, 'HDD'),
	(64, 84, 8, '1024GB'),
	(65, 84, 9, 'SSD'),
	(68, 85, 8, '1024MB'),
	(69, 85, 9, 'SSD Server'),
	(75, 90, 10, 'SFF radna stanica');
/*!40000 ALTER TABLE `article_feature` ENABLE KEYS */;

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `image_path` varchar(128) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '',
  `parent__category_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uq_category_name` (`name`),
  UNIQUE KEY `uq_category_image_path` (`image_path`),
  KEY `fk_category_parent__category_id` (`parent__category_id`) USING BTREE,
  CONSTRAINT `FK_category_category` FOREIGN KEY (`parent__category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `category`;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`category_id`, `name`, `image_path`, `parent__category_id`) VALUES
	(7, 'Računarska oprema', '/slika.png', NULL),
	(8, 'Memorija pohrane', '/memorija.png', 7),
	(9, 'Radne stanice', '', NULL);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

DROP TABLE IF EXISTS `debt_items`;
CREATE TABLE IF NOT EXISTS `debt_items` (
  `debt_items_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int NOT NULL,
  `user_id` int unsigned NOT NULL,
  `value` int NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serial_number` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`debt_items_id`),
  UNIQUE KEY `article_id_user_id_timestamp_serial_number` (`article_id`,`user_id`,`timestamp`,`serial_number`),
  KEY `fk_debt_items_user_id` (`user_id`),
  CONSTRAINT `fk_debt_items_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `debt_items`;
/*!40000 ALTER TABLE `debt_items` DISABLE KEYS */;
INSERT INTO `debt_items` (`debt_items_id`, `article_id`, `user_id`, `value`, `comment`, `timestamp`, `serial_number`) VALUES
	(2, 90, 1, 1, 'Zamjenjen računar zbog potrebe rada', '2022-03-01 22:30:55', '2'),
	(3, 90, 1, 1, 'Zamjenjen računar zbog potrebe rada 2', '2022-03-01 22:32:03', '87'),
	(4, 85, 2, 1, 'HDD CRKAO', '2022-03-02 23:26:44', 'JHSKDS8890'),
	(5, 85, 1, 1, 'Crkao', '2022-03-02 23:52:25', '525D6F82F');
/*!40000 ALTER TABLE `debt_items` ENABLE KEYS */;

DROP TABLE IF EXISTS `destroyed`;
CREATE TABLE IF NOT EXISTS `destroyed` (
  `destroyed_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `value` int NOT NULL DEFAULT '0',
  `comment` varchar(255) CHARACTER SET utf32 COLLATE utf32_unicode_ci DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `serial_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`destroyed_id`),
  UNIQUE KEY `article_id_user_id_serial_number` (`article_id`,`user_id`,`serial_number`),
  KEY `fk_destroyed_user_id` (`user_id`),
  CONSTRAINT `fk_destroyed_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_destroyed_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `destroyed`;
/*!40000 ALTER TABLE `destroyed` DISABLE KEYS */;
INSERT INTO `destroyed` (`destroyed_id`, `article_id`, `value`, `comment`, `timestamp`, `user_id`, `serial_number`) VALUES
	(7, 83, 1, 'Nije upotrebljivo više', '2022-03-03 00:03:01', 1, '584SD5SD5');
/*!40000 ALTER TABLE `destroyed` ENABLE KEYS */;

DROP TABLE IF EXISTS `feature`;
CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `uq_feature_category_id_name` (`category_id`,`name`),
  KEY `fk_feature_category_id` (`category_id`) USING BTREE,
  CONSTRAINT `fk_feature_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `feature`;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` (`feature_id`, `name`, `category_id`) VALUES
	(8, 'Kapacitet', 8),
	(9, 'Tip', 8),
	(10, 'Tip', 9);
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;

DROP TABLE IF EXISTS `stock`;
CREATE TABLE IF NOT EXISTS `stock` (
  `stock_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `value_on_concract` int NOT NULL DEFAULT '0',
  `value_available` int NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sap_number` varchar(50) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`stock_id`),
  KEY `fk_stock_article_id` (`article_id`),
  CONSTRAINT `fk_stock_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `stock`;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` (`stock_id`, `article_id`, `value_on_concract`, `value_available`, `timestamp`, `sap_number`) VALUES
	(87, 84, 50, 0, '2022-02-14 20:34:26', '1300-200201'),
	(144, 83, 50, 37, '2022-03-01 00:23:30', '1300-200200'),
	(156, 90, 50, 38, '2022-03-01 23:14:18', '1300-100200'),
	(158, 85, 15, 20, '2022-03-02 23:26:44', '1300-200202');
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `surname` varchar(45) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `forname` varchar(45) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `job_title` varchar(45) CHARACTER SET utf32 COLLATE utf32_unicode_ci DEFAULT NULL,
  `department` varchar(45) CHARACTER SET utf32 COLLATE utf32_unicode_ci DEFAULT NULL,
  `location` varchar(45) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `surname`, `forname`, `job_title`, `department`, `location`, `email`) VALUES
	(1, 'Mudžahid', 'Cerić', 'Tehničar za IKT', 'Služba za IKT', 'Direkcija Zenica', ''),
	(2, 'Goran ', 'Karović', 'Stručni saradnik', 'Sektor za IKT', 'Direkcija', ''),
	(6, 'Emir', 'Hedzic', 'neradnik', 'Sektor za IKT', 'PJD Žepče', '');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

DROP TABLE IF EXISTS `user_article`;
CREATE TABLE IF NOT EXISTS `user_article` (
  `user_article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `value` int NOT NULL DEFAULT '0',
  `status` enum('zaduženo','razduženo','otpisano') NOT NULL DEFAULT 'zaduženo',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serial_number` varchar(255) NOT NULL,
  PRIMARY KEY (`user_article_id`),
  UNIQUE KEY `user_id_article_id_serial_number` (`user_id`,`article_id`,`serial_number`),
  KEY `FK_104` (`article_id`),
  KEY `FK_92` (`user_id`),
  CONSTRAINT `fk_user_article_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_user_article_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `user_article`;
/*!40000 ALTER TABLE `user_article` DISABLE KEYS */;
INSERT INTO `user_article` (`user_article_id`, `user_id`, `article_id`, `value`, `status`, `timestamp`, `serial_number`) VALUES
	(70, 1, 90, 1, 'zaduženo', '2022-02-28 20:16:07', '12'),
	(73, 1, 83, 1, 'zaduženo', '2022-03-01 00:23:30', '33'),
	(83, 1, 90, 1, 'zaduženo', '2022-03-01 23:06:05', '13'),
	(84, 2, 90, 1, 'zaduženo', '2022-03-01 23:14:18', 'SN25482D95');
/*!40000 ALTER TABLE `user_article` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
