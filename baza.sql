-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               8.0.28 - MySQL Community Server - GPL
-- Server OS:                    Linux
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for inventory
DROP DATABASE IF EXISTS `inventory`;
CREATE DATABASE IF NOT EXISTS `inventory` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `inventory`;

-- Dumping structure for table inventory.administrator
DROP TABLE IF EXISTS `administrator`;
CREATE TABLE IF NOT EXISTS `administrator` (
  `administrator_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password_hash` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`administrator_id`),
  UNIQUE KEY `administrator_username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table inventory.administrator: ~0 rows (approximately)
DELETE FROM `administrator`;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` (`administrator_id`, `username`, `password_hash`) VALUES
	(1, 'admin', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE');
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;

-- Dumping structure for table inventory.administrator_token
DROP TABLE IF EXISTS `administrator_token`;
CREATE TABLE IF NOT EXISTS `administrator_token` (
  `administrator_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `administrator_id` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` varchar(2550) NOT NULL,
  `expire_at` datetime NOT NULL,
  `is_valid` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`administrator_token_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table inventory.administrator_token: ~8 rows (approximately)
DELETE FROM `administrator_token`;
/*!40000 ALTER TABLE `administrator_token` DISABLE KEYS */;
INSERT INTO `administrator_token` (`administrator_token_id`, `administrator_id`, `created_at`, `token`, `expire_at`, `is_valid`) VALUES
	(2, 1, '2022-03-18 15:07:16', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUwMjkwODM2LjA5OCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85OC4wLjQ3NTguMTA5IFNhZmFyaS81MzcuMzYgT1BSLzg0LjAuNDMxNi4zNiIsImlhdCI6MTY0NzYxMjQzNn0.wVS1NEISf6X2n2HZqgmwu095Kupd6hsrximwyrGEV4o', '2022-04-18 14:07:16', 1),
	(3, 1, '2022-03-18 15:09:09', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NjI2OTYuMDExLCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy4yOC40IiwiaWF0IjoxNjQ3MTg0Mjk2fQ.kV9bMPwIvKgxQ2Mv4Pc0ezsyVkcJtptUjH2WsklpxSg', '2022-04-18 14:09:09', 1),
	(4, 1, '2022-03-18 15:33:08', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUwMjkyMzg4LjE4OSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85OC4wLjQ3NTguMTA5IFNhZmFyaS81MzcuMzYgT1BSLzg0LjAuNDMxNi4zNiIsImlhdCI6MTY0NzYxMzk4OH0.dxbmG36FD0jfkzcKQNYZLewOu9x-cxoqIxujt4_M6Ys', '2022-04-18 14:33:08', 1),
	(5, 1, '2022-03-18 15:34:02', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUwMjkyNDQyLjQsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTguMC40NzU4LjEwOSBTYWZhcmkvNTM3LjM2IE9QUi84NC4wLjQzMTYuMzYiLCJpYXQiOjE2NDc2MTQwNDJ9.86Y40MuFsJKVPKb6JefkVjsMhM3PEdwUZsBSdElf4qY', '2022-04-18 14:34:02', 1),
	(6, 1, '2022-03-22 09:53:32', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUwNjE3NjEyLjYyOCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85OC4wLjQ3NTguMTA5IFNhZmFyaS81MzcuMzYgT1BSLzg0LjAuNDMxNi4zNiIsImlhdCI6MTY0NzkzOTIxMn0.HhC0HkA7nVerWiWChuUQ3sGuUFvtEo4ovPZB1Lxy9tY', '2022-04-22 08:53:32', 1),
	(7, 1, '2022-03-22 19:17:47', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUwNjUxNDY3Ljg0LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC44MiBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3OTczMDY3fQ.UI1tYcRqmjddUIpIvcEFBqLQoQK1Ov92miooH1Z1EZE', '2022-04-22 18:17:47', 1),
	(8, 1, '2022-03-24 20:11:21', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUwODI3NDgxLjUxNSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC44MiBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ4MTQ5MDgxfQ.nqsA-y1NooBnc_-MNdoXjcbeCBwk8HGbujU_mQDbcf8', '2022-04-24 19:11:21', 1),
	(9, 1, '2022-03-26 03:19:13', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUwOTM5NTUzLjQ0NiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC44NCBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ4MjYxMTUzfQ.hkoZArJG8tBwkWs4KojQ_ZOtf69p2Cm3EgOkjN0YbxU', '2022-04-26 02:19:13', 1),
	(10, 1, '2022-03-26 16:45:13', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUwOTg3OTEzLjEwNSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC44NCBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ4MzA5NTEzfQ.aOGvJYyCNCQeWDAnN2Qj5NC2qnIWKmScRhEFTLMPTPw', '2022-04-26 15:45:13', 1);
/*!40000 ALTER TABLE `administrator_token` ENABLE KEYS */;

-- Dumping structure for table inventory.article
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
) ENGINE=InnoDB AUTO_INCREMENT=94 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table inventory.article: ~7 rows (approximately)
DELETE FROM `article`;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` (`article_id`, `name`, `excerpt`, `description`, `concract`, `category_id`, `comment`, `sap_number`) VALUES
	(83, 'ACME SSD HD11 1TB', 'Kratki opis 1', 'Detaljan opis', 'EPU-25154/2022', 8, '', '1300-200200'),
	(84, 'ACME SSD HD11 1024GB', 'Kratki opis', 'Detaljan opis', 'EPU-25154/2022', 8, 'Komentar 1024GB', '1300-200201'),
	(85, 'ACME SSD HD11 1024MB', 'Kratki opis', 'Detaljan opis', 'EPU-25154/2022', 8, 'Komentar 1024MB serverski', '1300-200202'),
	(90, 'ThinkCentre 720S', 'Računar 720S', 'Detaljan opis računara', 'EPU-25158/2022', 9, '', '1300-100200'),
	(91, 'HP ProDesk 600 G6', 'Small Form Factor PC', 'Opis računara', 'EPU-232158/2022', 9, '', '1300-1005254'),
	(92, 'ThinkCentre M93', 'Small Form Factor PC', 'Opis računara', 'EPU-233248/2022', 9, '', '1300-1325254'),
	(93, 'HP E24 G4 FHD Monitor', 'HP E24 G4 FHD Monitor', 'Opis monitor', 'EPU-232558/2022', 10, '', 'ZE0687922');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;

-- Dumping structure for table inventory.article_feature
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
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table inventory.article_feature: ~24 rows (approximately)
DELETE FROM `article_feature`;
/*!40000 ALTER TABLE `article_feature` DISABLE KEYS */;
INSERT INTO `article_feature` (`article_feature_id`, `article_id`, `feature_id`, `value`) VALUES
	(54, 83, 8, '1TB'),
	(55, 83, 9, 'HDD'),
	(64, 84, 8, '1024GB'),
	(65, 84, 9, 'SSD'),
	(68, 85, 8, '1024MB'),
	(69, 85, 9, 'SSD Server'),
	(75, 90, 10, 'SFF radna stanica'),
	(76, 91, 10, 'Small Form Factor PC'),
	(77, 91, 11, 'Intel Core i5-10500 @ 3,1GHz'),
	(78, 91, 13, '8 GB'),
	(79, 91, 14, 'SSD-256GB'),
	(81, 91, 16, 'E8:D8:D1:CD:13:10'),
	(82, 92, 10, 'Small Form Factor PC'),
	(83, 92, 11, 'Intel Core i3-4130 CPU @ 3.40GHz'),
	(84, 92, 13, '8 GB'),
	(85, 92, 14, 'HDD-500GB'),
	(87, 92, 16, '44:39:C4:8E:9B:CD'),
	(88, 93, 17, 'IPS'),
	(89, 93, 19, '24 inch'),
	(90, 93, 20, '1000:1'),
	(91, 93, 21, '250 niti'),
	(92, 93, 22, '0.274 mm'),
	(93, 93, 23, '1xVGA, 4xUSB, 1xDP, 1xHDMI'),
	(95, 93, 24, 'FHD (1920 x 1080)'),
	(96, 93, 25, 'ZG0685264'),
	(97, 91, 26, 'ZE0689895'),
	(98, 90, 26, 'ZE0681263'),
	(99, 92, 26, 'ZG0687563');
/*!40000 ALTER TABLE `article_feature` ENABLE KEYS */;

-- Dumping structure for table inventory.category
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table inventory.category: ~4 rows (approximately)
DELETE FROM `category`;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`category_id`, `name`, `image_path`, `parent__category_id`) VALUES
	(7, 'Računarska oprema', 'bi bi-pc-display', NULL),
	(8, 'Memorija pohrane', 'bi bi-hdd', 9),
	(9, 'Radne stanice', 'bi bi-pc-display-horizontal', NULL),
	(10, 'Monitor', 'bi bi-display', 7);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- Dumping structure for table inventory.debt_items
DROP TABLE IF EXISTS `debt_items`;
CREATE TABLE IF NOT EXISTS `debt_items` (
  `debt_items_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_article_id` int unsigned NOT NULL,
  `article_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `value` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serial_number` varchar(255) DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'razduženo',
  `comment` varchar(255) DEFAULT NULL,
  `inv_broj` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`debt_items_id`),
  UNIQUE KEY `article_id_user_id_timestamp_serial_number` (`article_id`,`user_id`,`timestamp`,`serial_number`),
  KEY `FK_debt_items_user_article` (`user_id`),
  KEY `fk_debt_items_user_article_id` (`user_article_id`),
  CONSTRAINT `fk_debt_items_article_di` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_debt_items_user_article_id` FOREIGN KEY (`user_article_id`) REFERENCES `user_article` (`user_article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_debt_items_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table inventory.debt_items: ~0 rows (approximately)
DELETE FROM `debt_items`;
/*!40000 ALTER TABLE `debt_items` DISABLE KEYS */;
INSERT INTO `debt_items` (`debt_items_id`, `user_article_id`, `article_id`, `user_id`, `value`, `timestamp`, `serial_number`, `status`, `comment`, `inv_broj`) VALUES
	(33, 100, 92, 6, 1, '2022-03-22 13:34:47', '975975098', 'razduženo', '', NULL);
/*!40000 ALTER TABLE `debt_items` ENABLE KEYS */;

-- Dumping structure for table inventory.destroyed
DROP TABLE IF EXISTS `destroyed`;
CREATE TABLE IF NOT EXISTS `destroyed` (
  `destroyed_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_article_id` int unsigned NOT NULL,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `value` int NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serial_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'otpisano',
  `comment` varchar(255) DEFAULT NULL,
  `inv_broj` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`destroyed_id`),
  UNIQUE KEY `article_id_user_id_serial_number` (`article_id`,`user_id`,`serial_number`),
  KEY `fk_destroyed_user_id` (`user_id`),
  KEY `fk_destroyed_user_article_id` (`user_article_id`),
  CONSTRAINT `fk_destroyed_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_destroyed_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_destroyed_user_article_id` FOREIGN KEY (`user_article_id`) REFERENCES `user_article` (`user_article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table inventory.destroyed: ~0 rows (approximately)
DELETE FROM `destroyed`;
/*!40000 ALTER TABLE `destroyed` DISABLE KEYS */;
/*!40000 ALTER TABLE `destroyed` ENABLE KEYS */;

-- Dumping structure for table inventory.documents
DROP TABLE IF EXISTS `documents`;
CREATE TABLE IF NOT EXISTS `documents` (
  `documents_id` int unsigned NOT NULL AUTO_INCREMENT,
  `path` varchar(255) NOT NULL,
  `document_number` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`documents_id`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table inventory.documents: ~45 rows (approximately)
DELETE FROM `documents`;
/*!40000 ALTER TABLE `documents` DISABLE KEYS */;
INSERT INTO `documents` (`documents_id`, `path`, `document_number`) VALUES
	(6, '/prenosnica.docx', 1),
	(7, '/prenosnica.docx', 2),
	(22, '/prenosnica.docx', 22),
	(81, '/prenosnica.docx', 3),
	(82, '/prenosnica.docx', 4),
	(83, '/prenosnica.docx', 5),
	(84, '/prenosnica.docx', 6),
	(85, '/prenosnica.docx', 7),
	(86, '/prenosnica.docx', 8),
	(87, '/prenosnica.docx', 9),
	(89, '/prenosnica.docx', 10),
	(90, '/prenosnica.docx', 11),
	(91, '/prenosnica.docx', 12),
	(92, '/prenosnica.docx', 13),
	(93, '/prenosnica.docx', 14),
	(94, '/prenosnica.docx', 15),
	(95, '/prenosnica.docx', 16),
	(96, '/prenosnica.docx', 17),
	(97, '/prenosnica.docx', 18),
	(98, '/prenosnica.docx', 19),
	(99, '/prenosnica.docx', 20),
	(100, '/prenosnica.docx', 21),
	(101, '/prenosnica.docx', 23),
	(102, '[object Object]/prenosnica231.docx', 24),
	(103, '/prenosnica241.docx', 25),
	(104, '/prenosnica26.docx', 26),
	(105, '/prenosnica27.docx', 27),
	(106, '/prenosnica28.docx', 28),
	(107, '/prenosnica29.docx', 29),
	(108, '/prenosnica30.docx', 30),
	(109, '/prenosnica31.docx', 31),
	(110, '/prenosnica32.docx', 32),
	(111, '/prenosnica33.docx', 33),
	(112, '/prenosnica34.docx', 34),
	(113, '/prenosnica35.docx', 35),
	(114, '/prenosnica36.docx', 36),
	(115, '/prenosnica37.docx', 37),
	(116, '/prenosnica38.docx', 38),
	(117, '/prenosnica39.docx', 39),
	(118, '/prenosnica40.docx', 40),
	(119, '/prenosnica41.docx', 41),
	(120, '/prenosnica42.docx', 42),
	(121, '/prenosnica43.docx', 43),
	(122, '/prenosnica44.docx', 44),
	(123, '/prenosnica45.docx', 45),
	(124, '/prenosnica46.docx', 46),
	(125, '/prenosnica47.docx', 47),
	(126, '/prenosnica48.docx', 48),
	(127, '/prenosnica49.docx', 49),
	(128, '/prenosnica50.docx', 50),
	(129, '/prenosnica51.docx', 51),
	(130, '/prenosnica52.docx', 52),
	(131, '/prenosnica53.docx', 53);
/*!40000 ALTER TABLE `documents` ENABLE KEYS */;

-- Dumping structure for table inventory.feature
DROP TABLE IF EXISTS `feature`;
CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `uq_feature_category_id_name` (`category_id`,`name`),
  KEY `fk_feature_category_id` (`category_id`) USING BTREE,
  CONSTRAINT `fk_feature_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table inventory.feature: ~14 rows (approximately)
DELETE FROM `feature`;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` (`feature_id`, `name`, `category_id`) VALUES
	(8, 'Kapacitet', 8),
	(9, 'Tip', 8),
	(11, 'CPU', 9),
	(26, 'Inventurni broj', 9),
	(16, 'MAC', 9),
	(14, 'Memorija', 9),
	(13, 'RAM', 9),
	(10, 'Tip', 9),
	(25, 'Inventurni broj', 10),
	(23, 'Konektori', 10),
	(20, 'Omjer kontrasta', 10),
	(19, 'Rezolucija', 10),
	(24, 'Rezolucija slike', 10),
	(21, 'Svjetlina', 10),
	(22, 'Visina piksela', 10),
	(17, 'Vrsta prikaza', 10);
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;

-- Dumping structure for table inventory.responsibility
DROP TABLE IF EXISTS `responsibility`;
CREATE TABLE IF NOT EXISTS `responsibility` (
  `responsibility_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_article_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `value` int NOT NULL DEFAULT '0',
  `status` enum('zaduženo','razduženo','otpisano') NOT NULL DEFAULT 'zaduženo',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serial_number` varchar(255) NOT NULL,
  `inv_broj` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`responsibility_id`) USING BTREE,
  UNIQUE KEY `user_id_article_id_serial_number` (`user_id`,`article_id`,`serial_number`),
  KEY `FK_104` (`article_id`),
  KEY `FK_92` (`user_id`),
  KEY `fk_responsibility_user_article_id` (`user_article_id`),
  CONSTRAINT `fk_responsibility_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_responsibility_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_responsibility_user_article_id` FOREIGN KEY (`user_article_id`) REFERENCES `user_article` (`user_article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table inventory.responsibility: ~2 rows (approximately)
DELETE FROM `responsibility`;
/*!40000 ALTER TABLE `responsibility` DISABLE KEYS */;
INSERT INTO `responsibility` (`responsibility_id`, `user_article_id`, `user_id`, `article_id`, `value`, `status`, `timestamp`, `serial_number`, `inv_broj`) VALUES
	(68, 200, 6, 92, 1, 'zaduženo', '2022-03-23 23:36:16', 'AEZAKMI', NULL),
	(80, 213, 1, 83, 1, 'zaduženo', '2022-03-26 16:45:39', 'KJKSZPJJJ', NULL),
	(81, 214, 2, 83, 1, 'zaduženo', '2022-03-26 16:47:26', 'AEZAKMIC', NULL),
	(82, 215, 6, 83, 1, 'zaduženo', '2022-03-26 16:48:36', 'OHDUDE', NULL),
	(87, 220, 1, 93, 1, 'zaduženo', '2022-03-26 19:40:05', 'FSSAR5AS3', 'ZE0689878');
/*!40000 ALTER TABLE `responsibility` ENABLE KEYS */;

-- Dumping structure for table inventory.stock
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
) ENGINE=InnoDB AUTO_INCREMENT=346 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table inventory.stock: ~7 rows (approximately)
DELETE FROM `stock`;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` (`stock_id`, `article_id`, `value_on_concract`, `value_available`, `timestamp`, `sap_number`) VALUES
	(192, 91, 1, 0, '2022-03-14 23:45:34', '1300-1005255'),
	(208, 90, 50, 33, '2022-03-16 00:19:53', '1300-100200'),
	(214, 85, 15, 18, '2022-03-17 13:21:02', '1300-200202'),
	(217, 84, 50, 38, '2022-03-18 15:42:55', '1300-200201'),
	(325, 92, 5, 0, '2022-03-23 23:36:16', '1300-1325254'),
	(340, 83, 50, 32, '2022-03-26 16:48:36', '1300-200205'),
	(345, 93, 1, 4, '2022-03-26 19:40:05', 'ZE0687922');
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;

-- Dumping structure for table inventory.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `surname` varchar(64) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `forname` varchar(64) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `job_title` varchar(64) CHARACTER SET utf32 COLLATE utf32_unicode_ci DEFAULT NULL,
  `department` varchar(64) CHARACTER SET utf32 COLLATE utf32_unicode_ci DEFAULT NULL,
  `location` varchar(64) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table inventory.user: ~3 rows (approximately)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`user_id`, `surname`, `forname`, `job_title`, `department`, `location`, `email`, `password_hash`) VALUES
	(1, 'Mudžahid', 'Cerić', 'Tehničar za IKT', 'Služba za IKT', 'Direkcija Zenica', 'm.ceric@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE'),
	(2, 'Goran ', 'Karović', 'Stručni saradnik', 'Sektor za IKT', 'Direkcija', 'g.karovic@epbih.ba', 'AD27CCAFBB4429CEE9F60CEAA26F213E27037107434AC50F70314AC83D1D7CCBC73966453BE06B01ECEC83B0915C27DD2A8901A292B2D55C1D6E53B779471ADC'),
	(6, 'Emir', 'Hedzic', 'Stručni saradnik za IKT', 'Sektor za IKT', 'Direkcija Zenica', '', '3');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- Dumping structure for table inventory.user_article
DROP TABLE IF EXISTS `user_article`;
CREATE TABLE IF NOT EXISTS `user_article` (
  `user_article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL,
  `document_id` int unsigned NOT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `serial_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` enum('zaduženo','razduženo','otpisano') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'zaduženo',
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` varchar(255) DEFAULT NULL,
  `inv_broj` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_article_id`) USING BTREE,
  UNIQUE KEY `serial_number_status_timestamp` (`serial_number`,`status`,`timestamp`),
  KEY `fk_user_article_user_id` (`user_id`),
  KEY `fk_user_article_article_id` (`article_id`),
  KEY `fk_user_article_document_id` (`document_id`),
  CONSTRAINT `fk_user_article_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_user_article_document_id` FOREIGN KEY (`document_id`) REFERENCES `documents` (`documents_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_user_article_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table inventory.user_article: ~40 rows (approximately)
DELETE FROM `user_article`;
/*!40000 ALTER TABLE `user_article` DISABLE KEYS */;
INSERT INTO `user_article` (`user_article_id`, `article_id`, `document_id`, `user_id`, `serial_number`, `status`, `timestamp`, `comment`, `inv_broj`) VALUES
	(100, 92, 6, 6, '975975098', 'razduženo', '2022-03-22 13:34:47', '', NULL),
	(101, 93, 7, 1, 'FSSAR5AS3', 'razduženo', '2022-03-22 20:12:44', 'Novo zaduženje', NULL),
	(173, 92, 81, 1, 'AEZAKMI', 'razduženo', '2022-03-23 21:19:04', 'Test', NULL),
	(174, 92, 82, 1, 'AEZAKMI', 'zaduženo', '2022-03-23 21:21:02', 'Test', NULL),
	(175, 92, 83, 6, 'AEZAKMI', 'zaduženo', '2022-03-23 21:21:45', 'Test', NULL),
	(176, 92, 84, 1, 'AEZAKMI', 'razduženo', '2022-03-23 21:22:30', 'Test', NULL),
	(177, 92, 85, 6, 'AEZAKMI', 'razduženo', '2022-03-23 21:32:01', 'Test', NULL),
	(178, 92, 86, 2, 'AEZAKMI', 'razduženo', '2022-03-23 21:33:35', 'Test', NULL),
	(179, 92, 87, 6, 'AEZAKMI', 'razduženo', '2022-03-23 21:33:59', 'Test', NULL),
	(180, 92, 89, 2, 'AEZAKMI', 'razduženo', '2022-03-23 22:04:04', 'Test', NULL),
	(181, 92, 92, 2, 'AEZAKMI', 'zaduženo', '2022-03-23 22:24:02', 'Test', NULL),
	(182, 92, 93, 6, 'AEZAKMI', 'razduženo', '2022-03-23 22:26:19', 'Test', NULL),
	(184, 92, 95, 1, 'AEZAKMI', 'razduženo', '2022-03-23 22:28:29', 'Test', NULL),
	(186, 92, 97, 2, 'AEZAKMI', 'zaduženo', '2022-03-23 22:31:55', 'Test', NULL),
	(187, 92, 99, 1, 'AEZAKMI', 'razduženo', '2022-03-23 22:35:35', 'Test', NULL),
	(188, 92, 100, 6, 'AEZAKMI', 'zaduženo', '2022-03-23 22:36:08', 'Test', NULL),
	(189, 92, 22, 2, 'AEZAKMI', 'razduženo', '2022-03-23 23:09:41', 'Test', NULL),
	(190, 92, 101, 6, 'AEZAKMI', 'razduženo', '2022-03-23 23:12:22', 'Test', NULL),
	(191, 92, 102, 2, 'AEZAKMI', 'razduženo', '2022-03-23 23:15:09', 'Test', NULL),
	(192, 92, 103, 1, 'AEZAKMI', 'razduženo', '2022-03-23 23:17:03', 'Test', NULL),
	(193, 92, 104, 6, 'AEZAKMI', 'razduženo', '2022-03-23 23:17:51', 'Test', NULL),
	(194, 92, 105, 1, 'AEZAKMI', 'razduženo', '2022-03-23 23:19:09', 'Test', NULL),
	(195, 92, 106, 2, 'AEZAKMI', 'razduženo', '2022-03-23 23:20:04', 'Test', NULL),
	(196, 92, 107, 6, 'AEZAKMI', 'razduženo', '2022-03-23 23:30:59', 'Test', NULL),
	(197, 92, 108, 2, 'AEZAKMI', 'razduženo', '2022-03-23 23:31:50', 'Test', NULL),
	(198, 92, 109, 6, 'AEZAKMI', 'razduženo', '2022-03-23 23:34:51', 'Test', NULL),
	(199, 92, 110, 1, 'AEZAKMI', 'razduženo', '2022-03-23 23:34:56', 'Test', NULL),
	(200, 92, 111, 6, 'AEZAKMI', 'zaduženo', '2022-03-23 23:36:16', 'Test', NULL),
	(201, 93, 112, 2, 'FSSAR5AS3', 'razduženo', '2022-03-24 20:48:57', 'Komentar zaduženja', NULL),
	(202, 93, 113, 6, 'FSSAR5AS3', 'razduženo', '2022-03-24 21:51:47', 'Komentar razduženja', NULL),
	(203, 93, 114, 2, 'FSSAR5AS3', 'razduženo', '2022-03-24 21:54:08', 'Komentar razduženja sa Emira', NULL),
	(204, 93, 115, 6, 'FSSAR5AS3', 'razduženo', '2022-03-24 21:54:29', 'Komentar razduženja opreme sa Emira i zaduženje na Mudžahida', NULL),
	(205, 93, 116, 1, 'FSSAR5AS3', 'razduženo', '2022-03-24 21:56:39', 'Komentar razduženja sa Mudžahida na Gorana ', NULL),
	(206, 93, 117, 2, 'FSSAR5AS3', 'zaduženo', '2022-03-24 21:59:56', 'Zaduženje nove opreme', NULL),
	(207, 93, 118, 2, 'FSSAR5AS3', 'razduženo', '2022-03-24 22:18:32', 'Razduženje', NULL),
	(208, 93, 119, 1, 'FSSAR5AS3', 'razduženo', '2022-03-24 22:18:57', 'sssss', NULL),
	(209, 93, 120, 2, 'FSSAR5AS3', 'razduženo', '2022-03-24 22:23:16', 'Hoću Hedžića zadužiti', NULL),
	(210, 93, 121, 6, 'FSSAR5AS3', 'razduženo', '2022-03-24 22:28:02', 'Vraćam na Gorana sa Emira', NULL),
	(211, 93, 122, 2, 'FSSAR5AS3', 'razduženo', '2022-03-24 22:28:54', 'Sa Emira na Mudžahida', NULL),
	(212, 93, 123, 1, 'FSSAR5AS3', 'razduženo', '2022-03-24 22:30:17', 'Zaduženje na gorana', NULL),
	(213, 83, 124, 1, 'KJKSZPJJJ', 'zaduženo', '2022-03-26 16:45:39', 'Zaduženje nove opreme', NULL),
	(214, 83, 125, 2, 'AEZAKMIC', 'zaduženo', '2022-03-26 16:47:26', 'Zaduženje nove opreme', NULL),
	(215, 83, 126, 6, 'OHDUDE', 'zaduženo', '2022-03-26 16:48:36', 'Zaduženje nove opreme', NULL),
	(216, 93, 127, 2, 'FSSAR5AS3', 'razduženo', '2022-03-26 18:00:09', 'Komentar novog sistema', 'ZE0689878'),
	(217, 93, 128, 6, 'FSSAR5AS3', 'razduženo', '2022-03-26 19:09:46', 'Komentar', 'ZE0689878'),
	(218, 93, 129, 1, 'FSSAR5AS3', 'razduženo', '2022-03-26 19:36:48', 'xx', 'ZE0689878'),
	(219, 93, 130, 6, 'FSSAR5AS3', 'razduženo', '2022-03-26 19:39:34', 'zaduženo', 'ZE0689878'),
	(220, 93, 131, 1, 'FSSAR5AS3', 'zaduženo', '2022-03-26 19:40:05', 'Zaduženje nove opreme', 'ZE0689878');
/*!40000 ALTER TABLE `user_article` ENABLE KEYS */;

-- Dumping structure for table inventory.user_token
DROP TABLE IF EXISTS `user_token`;
CREATE TABLE IF NOT EXISTS `user_token` (
  `user_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` varchar(2550) NOT NULL,
  `expire_at` datetime NOT NULL,
  `is_valid` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_token_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table inventory.user_token: ~41 rows (approximately)
DELETE FROM `user_token`;
/*!40000 ALTER TABLE `user_token` DISABLE KEYS */;
INSERT INTO `user_token` (`user_token_id`, `user_id`, `created_at`, `token`, `expire_at`, `is_valid`) VALUES
	(4, 1, '2022-03-13 00:44:18', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4MDcwNTguNjU2LCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy4yOC40IiwiaWF0IjoxNjQ3MTI4NjU4fQ.xunJeYa9nsAj7pDRMYKTSb28CdCxDxeO7F9SYu34yZk', '2022-04-12 23:44:18', 1),
	(5, 1, '2022-03-13 00:44:25', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4MDcwNjUuODUzLCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy4yOC40IiwiaWF0IjoxNjQ3MTI4NjY1fQ.3QFienwuIkBTzWAtYwK6GQw7wiXSKfdMYBmSk-pGHXg', '2022-04-12 23:44:25', 1),
	(6, 1, '2022-03-13 01:03:08', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4MDgxODguOTI3LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC41MSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MTI5Nzg4fQ.8HXyIqvNmT3ntccVzg3tJQKgMSdE0WGNLacFLWtEk0o', '2022-04-13 00:03:08', 1),
	(7, 1, '2022-03-13 01:07:35', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4MDg0NTUuNDA4LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC41MSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MTMwMDU1fQ.6BJ1ZnM_s-selm25njKi5u3LiIjwSEIATG05KdgP7Ro', '2022-04-13 00:07:35', 1),
	(8, 1, '2022-03-13 01:13:23', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4MDg4MDMuNTU1LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMjkiLCJ1YSI6Ik1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDEwXzE1XzYpIEFwcGxlV2ViS2l0LzYwNS4xLjE1IChLSFRNTCwgbGlrZSBHZWNrbykgVmVyc2lvbi8xNS40IFNhZmFyaS82MDUuMS4xNSIsImlhdCI6MTY0NzEzMDQwM30.DCyBg0xlLl7wNPR08d6uC9hXZuCcQoUKFpiw_Itvnuc', '2022-04-13 00:13:23', 1),
	(9, 1, '2022-03-13 13:07:59', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTE2NzkuOTY4LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMjgiLCJ1YSI6Ik1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDEwXzE1XzYpIEFwcGxlV2ViS2l0LzYwNS4xLjE1IChLSFRNTCwgbGlrZSBHZWNrbykgVmVyc2lvbi8xNS40IFNhZmFyaS82MDUuMS4xNSIsImlhdCI6MTY0NzE3MzI3OX0.oFzJQRHyc9HhBcSaeQEmegfu5PQR8f6qEEVxViRJe3I', '2022-04-13 12:07:59', 1),
	(10, 1, '2022-03-13 13:11:22', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTE4ODIuODI0LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMjkiLCJ1YSI6Ik1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDEwXzE1XzYpIEFwcGxlV2ViS2l0LzYwNS4xLjE1IChLSFRNTCwgbGlrZSBHZWNrbykgVmVyc2lvbi8xNS40IFNhZmFyaS82MDUuMS4xNSIsImlhdCI6MTY0NzE3MzQ4Mn0.gcfTC9vk3GPG-5g4Ul9KatWV6DqiTxPggXEsnQzFW9w', '2022-04-13 12:11:22', 1),
	(11, 1, '2022-03-13 13:35:22', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTMzMjIuNjU2LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC41MSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MTc0OTIyfQ.HBzaxlppBp2aplzDP8mV7HBbzPTVEqQthzuGrgy0oLY', '2022-04-13 12:35:22', 1),
	(12, 1, '2022-03-13 13:35:54', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTMzNTQuOTQ2LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC41MSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MTc0OTU0fQ.OPBCdKMAjJOthtADM0qD57Y_qXMgJAfh_8ZhKKVTEkU', '2022-04-13 12:35:54', 1),
	(13, 1, '2022-03-13 13:36:56', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTM0MTYuODYyLCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC41MSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MTc1MDE2fQ.YMY1KQoP446C9dWnZ3-ILvR-cJgVnupM_uGehPMXTXM', '2022-04-13 12:36:56', 1),
	(14, 1, '2022-03-13 13:37:22', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTM0NDIuNjA5LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCA2LjA7IE5leHVzIDUgQnVpbGQvTVJBNThOKSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTkuMC40ODQ0LjUxIE1vYmlsZSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MTc1MDQyfQ.GUNJxBBksM-7dPXKM2P6VIimx43zv3rKCW4WZPzW7BI', '2022-04-13 12:37:22', 1),
	(15, 1, '2022-03-13 13:37:29', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTM0NDkuNjcsImlwIjoiOjpmZmZmOjE5Mi4xNjguMC4xMyIsInVhIjoiTW96aWxsYS81LjAgKExpbnV4OyBBbmRyb2lkIDYuMDsgTmV4dXMgNSBCdWlsZC9NUkE1OE4pIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85OS4wLjQ4NDQuNTEgTW9iaWxlIFNhZmFyaS81MzcuMzYiLCJpYXQiOjE2NDcxNzUwNDl9.ZG4RkpEYfWvRZDi9R5uaPZbhiea9BfL7uIfuHA-591Q', '2022-04-13 12:37:29', 1),
	(16, 1, '2022-03-13 13:40:05', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTM2MDUuNTE5LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCA2LjA7IE5leHVzIDUgQnVpbGQvTVJBNThOKSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTkuMC40ODQ0LjUxIE1vYmlsZSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MTc1MjA1fQ.Fbt7-9nPHbFoTVY3pLaHPz3xWQ4fdvDkKV2eIXw-ax4', '2022-04-13 12:40:05', 1),
	(17, 1, '2022-03-13 13:41:12', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTM2NzIuMTY3LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCA2LjA7IE5leHVzIDUgQnVpbGQvTVJBNThOKSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTkuMC40ODQ0LjUxIE1vYmlsZSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MTc1MjcyfQ.9-UI4mABWAzeqvEkwnSk_cozazmmpa4dlQlDs8XawaM', '2022-04-13 12:41:12', 1),
	(18, 1, '2022-03-13 13:50:25', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTQyMjUuNTMzLCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC41MSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MTc1ODI1fQ.IxF3WnYKunLjJbSnZcFpbGui4pIHR6zjmOo501xs1Yg', '2022-04-13 12:50:25', 1),
	(19, 1, '2022-03-13 16:07:49', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NjI0NjkuNzE0LCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy4yOC40IiwiaWF0IjoxNjQ3MTg0MDY5fQ.ARCXOm4fXBNpZMUpmBKRnFaz0WM0mHwyalOMqztS9xg', '2022-04-13 15:07:49', 1),
	(20, 1, '2022-03-13 16:09:55', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NjI1OTUuMzksImlwIjoiOjoxIiwidWEiOiJQb3N0bWFuUnVudGltZS83LjI4LjQiLCJpYXQiOjE2NDcxODQxOTV9.Sm_c3fXizvq08mXE6wKwUyOpTPeTFqw4jfpm2gtFZRo', '2022-04-13 15:09:55', 1),
	(21, 1, '2022-03-13 16:11:36', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NjI2OTYuMDExLCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy4yOC40IiwiaWF0IjoxNjQ3MTg0Mjk2fQ.kV9bMPwIvKgxQ2Mv4Pc0ezsyVkcJtptUjH2WsklpxSg', '2022-04-13 15:11:36', 1),
	(22, 1, '2022-03-13 16:28:37', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NjM3MTcuNzcsImlwIjoiOjoxIiwidWEiOiJQb3N0bWFuUnVudGltZS83LjI4LjQiLCJpYXQiOjE2NDcxODUzMTd9.eOX9m8SeeM2AGD1QfnulcqTVnNQ4qO9UMtUmYiucmG4', '2022-04-13 15:28:37', 1),
	(23, 1, '2022-03-13 23:09:07', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4ODc3NDcuNzgyLCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCA2LjA7IE5leHVzIDUgQnVpbGQvTVJBNThOKSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTkuMC40ODQ0LjUxIE1vYmlsZSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MjA5MzQ3fQ.yvvrsJqGvwsUZBGLnQQi6mDSGfAovi5SoPn2jOac1qY', '2022-04-13 22:09:07', 1),
	(24, 1, '2022-03-13 23:12:59', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4ODc5NzkuNzE1LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC41MSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MjA5NTc5fQ.X0tfHLl3neE8hIb6g9kw9vXbeUiBeAu24jT2o9LB0Uc', '2022-04-13 22:12:59', 1),
	(25, 1, '2022-03-13 23:15:20', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4ODgxMjAuODUsImlwIjoiOjpmZmZmOjE5Mi4xNjguMC4xMyIsInVhIjoiTW96aWxsYS81LjAgKExpbnV4OyBBbmRyb2lkIDYuMDsgTmV4dXMgNSBCdWlsZC9NUkE1OE4pIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85OS4wLjQ4NDQuNTEgTW9iaWxlIFNhZmFyaS81MzcuMzYiLCJpYXQiOjE2NDcyMDk3MjB9.FvV40jlOXjmj-xeBZbXQRvtn3q8PAN1URYFk3Vu9Vig', '2022-04-13 22:15:20', 1),
	(26, 1, '2022-03-14 00:01:30', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4OTA4OTAuMDc0LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC41MSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MjEyNDkwfQ.e1gkGWlw6HbtXt67CgWyb2v9EWz_FYW9RkrAucBdHSo', '2022-04-13 23:01:30', 1),
	(27, 1, '2022-03-14 00:01:58', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4OTA5MTguNDY0LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMjkiLCJ1YSI6Ik1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDEwXzE1XzYpIEFwcGxlV2ViS2l0LzYwNS4xLjE1IChLSFRNTCwgbGlrZSBHZWNrbykgVmVyc2lvbi8xNS40IFNhZmFyaS82MDUuMS4xNSIsImlhdCI6MTY0NzIxMjUxOH0.SaUMV8BI6gT8y05u-tDBgYwxzBu-f4Z-vzveeSktSJc', '2022-04-13 23:01:58', 1),
	(28, 1, '2022-03-17 13:14:59', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAxOTc2OTkuODQzLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NTE5Mjk5fQ.qnrAM7irlHulC3iXcxMTTq5vQdR-iGUDzt4GCi71wQc', '2022-04-17 12:14:59', 1),
	(29, 1, '2022-03-18 12:49:02', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyODI1NDEuOTk3LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjA0MTQxfQ.bjC6_u0t0i7L972HSpCoSTXfZr_Foqec7dmWCNYlBz0', '2022-04-18 11:49:01', 1),
	(30, 1, '2022-03-18 12:50:53', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyODI2NTMuODc0LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjA0MjUzfQ.uyeb85e7tHPZX2q7yocq5qwj7wTDUswaQYWV2yMA7go', '2022-04-18 11:50:53', 1),
	(31, 1, '2022-03-18 12:55:16', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyODI5MTYuNTY5LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjA0NTE2fQ.nkQ3JsDHz3wkidFQibTBryJd0Z6i4OMuDZ9DsypVOYI', '2022-04-18 11:55:16', 1),
	(32, 1, '2022-03-18 12:59:22', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyODMxNjIuMDQyLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjA0NzYyfQ.FZ_SkKZQtfBBw9T6IbGISufHMsevPLhSKyan-dx516w', '2022-04-18 11:59:22', 1),
	(33, 1, '2022-03-18 13:00:17', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyODMyMTcuMjAxLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjA0ODE3fQ.niTimi_rAsK6cI_-ewqv9YFme40cG6rdZV909BBfFS8', '2022-04-18 12:00:17', 1),
	(34, 1, '2022-03-18 13:01:27', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyODMyODcuMTg5LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjA0ODg3fQ.7aGV_h-aNBXCumTSSg2vhzZj7H-anoxj13MaYoFhnCw', '2022-04-18 12:01:27', 1),
	(35, 1, '2022-03-18 13:05:16', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyODM1MTYuMjcyLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjA1MTE2fQ.qjmprCO0ZoVXL9UWekpahVhAGKe1wUsgiuAPjD73wQ8', '2022-04-18 12:05:16', 1),
	(36, 1, '2022-03-18 13:10:24', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyODM4MjQuNDE2LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjA1NDI0fQ.WjkmRP5LY0RUrI8OiciPkOyg9SdU9vmTVloxpuDJ5VE', '2022-04-18 12:10:24', 1),
	(37, 1, '2022-03-18 13:12:11', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyODM5MzEuMTQ1LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjA1NTMxfQ.eQQxKsLyR91WfdFc9moR22QB9u2HPPXJdLdJT2Kr15M', '2022-04-18 12:12:11', 1),
	(38, 2, '2022-03-18 13:15:18', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoyLCJpZGVudGl0eSI6Imcua2Fyb3ZpY0BlcGJpaC5iYSIsImV4cCI6MTY1MDI4NDExOC42NDcsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTguMC40NzU4LjEwOSBTYWZhcmkvNTM3LjM2IE9QUi84NC4wLjQzMTYuMzYiLCJpYXQiOjE2NDc2MDU3MTh9.6A63PSOpPFnlPvzr3wVekAUua-VzdJWPE9KOPpLFPds', '2022-04-18 12:15:18', 1),
	(39, 2, '2022-03-18 13:16:35', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoyLCJpZGVudGl0eSI6Imcua2Fyb3ZpY0BlcGJpaC5iYSIsImV4cCI6MTY1MDI4NDE5NS4yMTEsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTguMC40NzU4LjEwOSBTYWZhcmkvNTM3LjM2IE9QUi84NC4wLjQzMTYuMzYiLCJpYXQiOjE2NDc2MDU3OTV9.Z7RKnhT1_kxdqCRtG7dt_NErPl0lGUWowyZxpddzpEE', '2022-04-18 12:16:35', 1),
	(40, 2, '2022-03-18 13:35:29', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoyLCJpZGVudGl0eSI6Imcua2Fyb3ZpY0BlcGJpaC5iYSIsImV4cCI6MTY1MDI4NTMyOS44ODMsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTguMC40NzU4LjEwOSBTYWZhcmkvNTM3LjM2IE9QUi84NC4wLjQzMTYuMzYiLCJpYXQiOjE2NDc2MDY5Mjl9.YhdzXR1OenxqMWUQW9-0vpJbtZMCgT_9rRcVB2WHiWU', '2022-04-18 12:35:29', 1),
	(41, 2, '2022-03-18 14:54:03', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoyLCJpZGVudGl0eSI6Imcua2Fyb3ZpY0BlcGJpaC5iYSIsImV4cCI6MTY1MDI5MDA0My4zNDksImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTguMC40NzU4LjEwOSBTYWZhcmkvNTM3LjM2IE9QUi84NC4wLjQzMTYuMzYiLCJpYXQiOjE2NDc2MTE2NDN9.f3KIkjIsMm3bMs9WN9uPVfomSwjAa7JN_kQd6CmtqNw', '2022-04-18 13:54:03', 1),
	(42, 1, '2022-03-18 15:43:37', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyOTMwMTcuMzc1LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjE0NjE3fQ.7QdTrWyyPm5yHUtG-DJiJsojLwtAKLvt5QLLXySoy4E', '2022-04-18 14:43:37', 1),
	(43, 1, '2022-03-18 15:43:52', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyOTMwMzIuNzQ0LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjE0NjMyfQ.cxiFXvqF6ccpQhUPxKyz7QYQ5TFpyco--JYzxw8qzeg', '2022-04-18 14:43:52', 1),
	(44, 1, '2022-03-18 15:48:24', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyOTMzMDQuNDQ3LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjE0OTA0fQ.7SqhUh5G8Zqv54lA2eP1C970eis6YuqWR2QQaICB4oI', '2022-04-18 14:48:24', 1);
/*!40000 ALTER TABLE `user_token` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
