-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for inventory_v2
CREATE DATABASE IF NOT EXISTS `inventory_v2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `inventory_v2`;

-- Dumping structure for table inventory_v2.administrator
CREATE TABLE IF NOT EXISTS `administrator` (
  `administrator_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`administrator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.administrator: ~0 rows (approximately)
INSERT INTO `administrator` (`administrator_id`, `username`, `password_hash`) VALUES
	(1, 'admin', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE');

-- Dumping structure for table inventory_v2.administrator_token
CREATE TABLE IF NOT EXISTS `administrator_token` (
  `administrator_token_id` int NOT NULL AUTO_INCREMENT,
  `administrator_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `token` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expire_at` timestamp NULL DEFAULT NULL,
  `is_valid` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`administrator_token_id`),
  KEY `administrator_id` (`administrator_id`),
  CONSTRAINT `administrator_token_ibfk_1` FOREIGN KEY (`administrator_id`) REFERENCES `administrator` (`administrator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.administrator_token: ~5 rows (approximately)
INSERT INTO `administrator_token` (`administrator_token_id`, `administrator_id`, `created_at`, `token`, `expire_at`, `is_valid`) VALUES
	(1, 1, '2023-10-23 15:45:05', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk3ODE3MDk0LjI1LCJpcCI6Ijo6ZmZmZjoxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMTYuMC4wLjAgU2FmYXJpLzUzNy4zNiBPUFIvMTAyLjAuMC4wIiwiaWF0IjoxNjk3ODE2Nzk0fQ.eo_dswpWSSfpJRtDwMQBkV1aOz2ZkQUo6SRfgEPs9v8', '2023-10-23 15:45:01', 1),
	(2, 1, '2023-10-23 15:58:28', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNzAwNzU1MTA4LjQzOCwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjkuMiIsImlhdCI6MTY5ODA3NjcwOH0.JVttUD9sWrGeBklLbjiMMXHYyjDnzBkzjJSEx8Rb9-U', '2023-11-23 14:58:28', NULL),
	(3, 1, '2023-10-25 15:21:30', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNzAwOTI1NjkwLjA4LCJpcCI6Ijo6ZmZmZjoxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMTYuMC4wLjAgU2FmYXJpLzUzNy4zNiBPUFIvMTAyLjAuMC4wIiwiaWF0IjoxNjk4MjQ3MjkwfQ.lJjOB55aIFnNmTCzgNIsJwItCnBXDLygNLVlNukEcls', '2023-11-25 14:21:30', NULL),
	(4, 1, '2023-10-25 21:30:38', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNzAwOTQ3ODM4LjQ1NCwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjI4IiwidWEiOiJNb3ppbGxhLzUuMCAoTGludXg7IFU7IEFuZHJvaWQgMTM7IGVuLXVzOyBYaWFvbWkgMTFUIEJ1aWxkL1RQMUEuMjIwNjI0LjAxNCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgVmVyc2lvbi80LjAgQ2hyb21lLzEwMC4wLjQ4OTYuMTI3IE1vYmlsZSBTYWZhcmkvNTM3LjM2IFhpYW9NaS9NaXVpQnJvd3Nlci8xMy4yNS4yLjItZ24iLCJpYXQiOjE2OTgyNjk0Mzh9.1P2zScfO7dFepBVcyMbLk5S2UD5efLXg_cJdAMV6lME', '2023-11-25 20:30:38', NULL),
	(5, 1, '2023-10-25 21:36:14', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNzAwOTQ4MTc0LjkxMSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTE2LjAuMC4wIFNhZmFyaS81MzcuMzYgT1BSLzEwMi4wLjAuMCIsImlhdCI6MTY5ODI2OTc3NH0.0-lGyzkOSgqnFcMWEyqvWWk5vtkmDw_Stj1fuSU95_A', '2023-11-25 20:36:14', NULL);

-- Dumping structure for table inventory_v2.article
CREATE TABLE IF NOT EXISTS `article` (
  `article_id` int NOT NULL AUTO_INCREMENT,
  `serial_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `inv_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `user_id` int DEFAULT NULL,
  `document_id` int DEFAULT NULL,
  `status` enum('zaduženo','razduženo','otpisano') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `stock_id` int NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `category_id` int DEFAULT NULL,
  PRIMARY KEY (`article_id`),
  KEY `user_id` (`user_id`),
  KEY `fk_article_stock` (`stock_id`),
  KEY `article_ibfk_3` (`category_id`),
  CONSTRAINT `article_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `article_ibfk_2` FOREIGN KEY (`stock_id`) REFERENCES `stock` (`stock_id`),
  CONSTRAINT `article_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.article: ~2 rows (approximately)
INSERT INTO `article` (`article_id`, `serial_number`, `inv_number`, `user_id`, `document_id`, `status`, `timestamp`, `stock_id`, `comment`, `category_id`) VALUES
	(3, 'S4PT4033', 'ZE06878665', 1, 1, 'zaduženo', '2023-10-25 22:03:32', 1, 'Zaduženje sa skladišta', 2),
	(4, 'CN41060Z0V', 'ZE0687920', 3, 2, 'zaduženo', '2023-10-25 22:03:37', 2, 'Komentar', 3);

-- Dumping structure for table inventory_v2.article_feature
CREATE TABLE IF NOT EXISTS `article_feature` (
  `article_feature_id` int NOT NULL AUTO_INCREMENT,
  `article_id` int NOT NULL DEFAULT '0',
  `feature_id` int NOT NULL DEFAULT '0',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`article_feature_id`),
  UNIQUE KEY `uq_article_feature_article_id_feature_id` (`article_id`,`feature_id`) USING BTREE,
  KEY `fk_article_feature_feature_id` (`feature_id`) USING BTREE,
  CONSTRAINT `fk_article_feature_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_article_feature_feature_id` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`feature_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.article_feature: ~10 rows (approximately)
INSERT INTO `article_feature` (`article_feature_id`, `article_id`, `feature_id`, `value`) VALUES
	(1, 3, 1, 'Intel i5'),
	(2, 3, 2, '8 GB'),
	(3, 3, 3, '1 TB'),
	(4, 4, 4, '1xVGA, 4xUSB, 1xDP, 1xHDMI'),
	(5, 4, 5, '250 niti'),
	(6, 4, 6, '0.274 mm'),
	(7, 4, 7, 'FHD (1920 x 1080)'),
	(8, 4, 8, '24 inch'),
	(9, 4, 9, 'IPS'),
	(10, 4, 10, '1000:1');

-- Dumping structure for table inventory_v2.article_timeline
CREATE TABLE IF NOT EXISTS `article_timeline` (
  `article_timeline_id` int NOT NULL AUTO_INCREMENT,
  `article_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  `document_id` int DEFAULT NULL,
  `serial_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` enum('zaduženo','razduženo','otpisano') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `inv_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`article_timeline_id`),
  KEY `article_id` (`article_id`),
  KEY `user_id` (`user_id`),
  KEY `document_id` (`document_id`),
  CONSTRAINT `article_timeline_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`),
  CONSTRAINT `article_timeline_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `article_timeline_ibfk_3` FOREIGN KEY (`document_id`) REFERENCES `documents` (`documents_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.article_timeline: ~2 rows (approximately)
INSERT INTO `article_timeline` (`article_timeline_id`, `article_id`, `user_id`, `document_id`, `serial_number`, `status`, `timestamp`, `inv_number`, `comment`) VALUES
	(1, 3, 1, NULL, 'S4PT4033', 'zaduženo', '2023-10-24 17:56:03', 'ZE06878665', 'Artikal dodan'),
	(2, 4, 3, NULL, 'CN41060Z0V', 'zaduženo', '2023-10-25 15:37:13', 'ZE0687920', 'Artikal dodan');

-- Dumping structure for table inventory_v2.category
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `image_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `parent_category_id` int DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  KEY `parent_category_id` (`parent_category_id`),
  CONSTRAINT `category_ibfk_1` FOREIGN KEY (`parent_category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.category: ~3 rows (approximately)
INSERT INTO `category` (`category_id`, `name`, `image_path`, `parent_category_id`) VALUES
	(1, 'Računarska oprema', 'bi bi-pc-display', NULL),
	(2, 'Radna stanica', 'bi bi-pc-display-horizontal', 1),
	(3, 'Monitori', 'bi bi-display', 1);

-- Dumping structure for table inventory_v2.department
CREATE TABLE IF NOT EXISTS `department` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `departmend_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `parent_department_id` int DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  KEY `parent_department_id` (`parent_department_id`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`parent_department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.department: ~1 rows (approximately)
INSERT INTO `department` (`department_id`, `title`, `description`, `departmend_code`, `parent_department_id`) VALUES
	(1, 'Sektor za IKT', NULL, '0306', NULL);

-- Dumping structure for table inventory_v2.department_job
CREATE TABLE IF NOT EXISTS `department_job` (
  `department_job_id` int NOT NULL AUTO_INCREMENT,
  `department_id` int NOT NULL,
  `job_id` int NOT NULL,
  `location_id` int NOT NULL,
  PRIMARY KEY (`department_job_id`),
  KEY `department_id` (`department_id`),
  KEY `job_id` (`job_id`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `department_job_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`),
  CONSTRAINT `department_job_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `job` (`job_id`),
  CONSTRAINT `department_job_ibfk_3` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table inventory_v2.department_job: ~1 rows (approximately)
INSERT INTO `department_job` (`department_job_id`, `department_id`, `job_id`, `location_id`) VALUES
	(1, 1, 1, 1),
	(2, 1, 2, 1);

-- Dumping structure for table inventory_v2.documents
CREATE TABLE IF NOT EXISTS `documents` (
  `documents_id` int NOT NULL AUTO_INCREMENT,
  `article_id` int NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `document_number` int NOT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`documents_id`),
  KEY `article_id` (`article_id`),
  CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.documents: ~2 rows (approximately)
INSERT INTO `documents` (`documents_id`, `article_id`, `path`, `document_number`, `created_date`) VALUES
	(1, 3, 'prenosnica1.docx', 1, '2023-10-24 17:56:03'),
	(2, 4, 'prenosnica2.docx', 2, '2023-10-25 15:37:13');

-- Dumping structure for table inventory_v2.feature
CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`feature_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `feature_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.feature: ~10 rows (approximately)
INSERT INTO `feature` (`feature_id`, `name`, `category_id`) VALUES
	(1, 'CPU', 2),
	(2, 'RAM', 2),
	(3, 'Memorija pohrane', 2),
	(4, 'Konektori', 3),
	(5, 'Svjetlina', 3),
	(6, 'Visina piksela', 3),
	(7, 'Rezolucija slike', 3),
	(8, 'Rezolucija', 3),
	(9, 'Vrsta prikaza', 3),
	(10, 'Omjer kontrasta', 3);

-- Dumping structure for table inventory_v2.job
CREATE TABLE IF NOT EXISTS `job` (
  `job_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `job_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.job: ~2 rows (approximately)
INSERT INTO `job` (`job_id`, `title`, `description`, `job_code`) VALUES
	(1, 'Tehničar za IKT', NULL, '0306-01'),
	(2, 'Stručni saradnik za održavanje IKT servis i infrastrukture', NULL, '0306-02');

-- Dumping structure for table inventory_v2.location
CREATE TABLE IF NOT EXISTS `location` (
  `location_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `parent_location_id` int DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE KEY `code` (`code`),
  KEY `parent_location_id` (`parent_location_id`),
  CONSTRAINT `location_ibfk_1` FOREIGN KEY (`parent_location_id`) REFERENCES `location` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.location: ~0 rows (approximately)
INSERT INTO `location` (`location_id`, `name`, `code`, `parent_location_id`) VALUES
	(1, 'ED Zenica - Direkcija', '03', NULL);

-- Dumping structure for table inventory_v2.stock
CREATE TABLE IF NOT EXISTS `stock` (
  `stock_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `excerpt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `contract` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `category_id` int NOT NULL,
  `sap_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `value_on_contract` int NOT NULL DEFAULT (0),
  `value_available` int NOT NULL DEFAULT (0),
  `timestamp` timestamp NOT NULL DEFAULT (now()),
  PRIMARY KEY (`stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.stock: ~2 rows (approximately)
INSERT INTO `stock` (`stock_id`, `name`, `excerpt`, `description`, `contract`, `category_id`, `sap_number`, `value_on_contract`, `value_available`, `timestamp`) VALUES
	(1, 'ThinkCentre 720S', 'Kratko opis', 'Duži opis', 'EDB-254/2023', 2, '1300-200200', 6, 5, '2023-10-23 16:08:35'),
	(2, 'HP E24 G4 FHD Monitor', 'Kratko opis', 'Duži opis', 'EDB-255/2023', 3, '1300-200300', 13, 11, '2023-10-23 16:11:03');

-- Dumping structure for table inventory_v2.upgrade_feature
CREATE TABLE IF NOT EXISTS `upgrade_feature` (
  `upgrade_feature_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `value` decimal(10,2) NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `serial_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `article_id` int NOT NULL,
  PRIMARY KEY (`upgrade_feature_id`),
  KEY `article_id` (`article_id`),
  CONSTRAINT `upgrade_feature_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.upgrade_feature: ~0 rows (approximately)

-- Dumping structure for table inventory_v2.user
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `surname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `forname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `fullname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `local_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `telephone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `job_id` int NOT NULL,
  `department_id` int NOT NULL,
  `location_id` int NOT NULL,
  `registration_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login_date` timestamp NULL DEFAULT NULL,
  `status` enum('aktivan','neaktivan') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'neaktivan',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `local_number` (`local_number`),
  KEY `job_id` (`job_id`),
  KEY `department_id` (`department_id`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `job` (`job_id`),
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`),
  CONSTRAINT `user_ibfk_3` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.user: ~3 rows (approximately)
INSERT INTO `user` (`user_id`, `surname`, `forname`, `fullname`, `local_number`, `telephone`, `email`, `password_hash`, `job_id`, `department_id`, `location_id`, `registration_date`, `last_login_date`, `status`) VALUES
	(1, 'Mudžahid', 'Cerić', 'Cerić Mudžahid', '1617', '032/449-617', 'm.ceric@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 1, 1, 1, '2023-10-23 15:57:45', NULL, 'neaktivan'),
	(2, 'Goran', 'Karović', 'Karović Goran', '1652', '032/449-652', 'g.karovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 2, 1, 1, '2023-10-25 15:28:48', NULL, 'neaktivan'),
	(3, 'Emir', 'Hedžić', 'Hedžić Emir', '1654', '032/449-654', 'e.hedzic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 2, 1, 1, '2023-10-25 15:30:37', NULL, 'neaktivan');

-- Dumping structure for table inventory_v2.user_token
CREATE TABLE IF NOT EXISTS `user_token` (
  `user_token_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expire_at` timestamp NULL DEFAULT NULL,
  `is_valid` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user_token_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_token_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.user_token: ~0 rows (approximately)

-- Dumping structure for trigger inventory_v2.article_status_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `article_status_trigger` AFTER INSERT ON `article` FOR EACH ROW BEGIN
    INSERT INTO article_timeline (article_id, user_id, document_id, serial_number, status, inv_number, timestamp, comment)
    VALUES (NEW.article_id, NEW.user_id, NEW.document_id, NEW.serial_number, NEW.status, NEW.inv_number, NOW(), 'Artikal dodan');

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger inventory_v2.article_update_status_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `article_update_status_trigger` AFTER UPDATE ON `article` FOR EACH ROW BEGIN
    IF OLD.status != NEW.status THEN
        INSERT INTO article_timeline (article_id, user_id, document_id, serial_number, status, inv_number, timestamp, comment)
        VALUES (NEW.article_id, NEW.user_id, NEW.document_id, NEW.serial_number, NEW.status, NEW.inv_number, NOW(), 'Status promijenjen');
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger inventory_v2.article_update_timestamp
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `article_update_timestamp` BEFORE UPDATE ON `article` FOR EACH ROW BEGIN
    SET NEW.timestamp = NOW();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger inventory_v2.before_user_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `before_user_insert` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
    SET NEW.fullname = CONCAT(NEW.forname, ' ', NEW.surname);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger inventory_v2.update_last_login
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `update_last_login` BEFORE UPDATE ON `user` FOR EACH ROW BEGIN
    -- Pronađi najnoviji unos u user_token za ovog korisnika
    SELECT MAX(created_at) INTO @last_login_date
    FROM user_token
    WHERE user_id = NEW.user_id;

    -- Ako je pronađen unos, postavi last_login_date na taj datum i vrijeme
    IF @last_login_date IS NOT NULL THEN
        SET NEW.last_login_date = @last_login_date;
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger inventory_v2.user_audit_trigger
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `user_audit_trigger` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
    -- Postavi trenutni datum i vrijeme prilikom umetanja novog reda
    SET NEW.registration_date = NOW();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for inventory
CREATE DATABASE IF NOT EXISTS `inventory` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `inventory`;

-- Dumping structure for table inventory.administrator
CREATE TABLE IF NOT EXISTS `administrator` (
  `administrator_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `password_hash` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`administrator_id`),
  UNIQUE KEY `administrator_username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.administrator: ~0 rows (approximately)
INSERT INTO `administrator` (`administrator_id`, `username`, `password_hash`) VALUES
	(1, 'admin', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE');

-- Dumping structure for table inventory.administrator_token
CREATE TABLE IF NOT EXISTS `administrator_token` (
  `administrator_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `administrator_id` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expire_at` datetime NOT NULL,
  `is_valid` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`administrator_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.administrator_token: ~136 rows (approximately)
INSERT INTO `administrator_token` (`administrator_token_id`, `administrator_id`, `created_at`, `token`, `expire_at`, `is_valid`) VALUES
	(2, 1, '2022-03-18 14:07:16', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUwMjkwODM2LjA5OCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85OC4wLjQ3NTguMTA5IFNhZmFyaS81MzcuMzYgT1BSLzg0LjAuNDMxNi4zNiIsImlhdCI6MTY0NzYxMjQzNn0.wVS1NEISf6X2n2HZqgmwu095Kupd6hsrximwyrGEV4o', '2022-04-18 14:07:16', 1),
	(3, 1, '2022-03-18 14:09:09', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NjI2OTYuMDExLCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy4yOC40IiwiaWF0IjoxNjQ3MTg0Mjk2fQ.kV9bMPwIvKgxQ2Mv4Pc0ezsyVkcJtptUjH2WsklpxSg', '2022-04-18 14:09:09', 1),
	(4, 1, '2022-03-18 14:33:08', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUwMjkyMzg4LjE4OSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85OC4wLjQ3NTguMTA5IFNhZmFyaS81MzcuMzYgT1BSLzg0LjAuNDMxNi4zNiIsImlhdCI6MTY0NzYxMzk4OH0.dxbmG36FD0jfkzcKQNYZLewOu9x-cxoqIxujt4_M6Ys', '2022-04-18 14:33:08', 1),
	(5, 1, '2022-03-18 14:34:02', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUwMjkyNDQyLjQsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTguMC40NzU4LjEwOSBTYWZhcmkvNTM3LjM2IE9QUi84NC4wLjQzMTYuMzYiLCJpYXQiOjE2NDc2MTQwNDJ9.86Y40MuFsJKVPKb6JefkVjsMhM3PEdwUZsBSdElf4qY', '2022-04-18 14:34:02', 1),
	(6, 1, '2022-03-22 08:53:32', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUwNjE3NjEyLjYyOCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85OC4wLjQ3NTguMTA5IFNhZmFyaS81MzcuMzYgT1BSLzg0LjAuNDMxNi4zNiIsImlhdCI6MTY0NzkzOTIxMn0.HhC0HkA7nVerWiWChuUQ3sGuUFvtEo4ovPZB1Lxy9tY', '2022-04-22 08:53:32', 1),
	(7, 1, '2022-03-22 18:17:47', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUwNjUxNDY3Ljg0LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC44MiBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3OTczMDY3fQ.UI1tYcRqmjddUIpIvcEFBqLQoQK1Ov92miooH1Z1EZE', '2022-04-22 18:17:47', 1),
	(8, 1, '2022-03-24 19:11:21', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUwODI3NDgxLjUxNSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC44MiBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ4MTQ5MDgxfQ.nqsA-y1NooBnc_-MNdoXjcbeCBwk8HGbujU_mQDbcf8', '2022-04-24 19:11:21', 1),
	(9, 1, '2022-03-26 02:19:13', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUwOTM5NTUzLjQ0NiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC44NCBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ4MjYxMTUzfQ.hkoZArJG8tBwkWs4KojQ_ZOtf69p2Cm3EgOkjN0YbxU', '2022-04-26 02:19:13', 1),
	(10, 1, '2022-03-26 15:45:13', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUwOTg3OTEzLjEwNSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC44NCBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ4MzA5NTEzfQ.aOGvJYyCNCQeWDAnN2Qj5NC2qnIWKmScRhEFTLMPTPw', '2022-04-26 15:45:13', 1),
	(11, 1, '2022-03-29 15:20:37', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUxMjQ1NjM3LjYzNSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoWDExOyBMaW51eCB4ODZfNjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85OS4wLjQ4NDQuODQgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTY0ODU2NzIzN30.arrzVgDIR3ddAzeiUVa1HDJaOFzrQS8u1ZNNNL3HSNI', '2022-04-29 15:20:37', 1),
	(12, 1, '2022-03-29 16:51:16', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUxMjUxMDc2LjMxMSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjI5IiwidWEiOiJNb3ppbGxhLzUuMCAoTWFjaW50b3NoOyBJbnRlbCBNYWMgT1MgWCAxMF8xNV82KSBBcHBsZVdlYktpdC82MDUuMS4xNSAoS0hUTUwsIGxpa2UgR2Vja28pIFZlcnNpb24vMTUuNCBTYWZhcmkvNjA1LjEuMTUiLCJpYXQiOjE2NDg1NzI2NzZ9.gbtzIgMQfDBY1BdE0KR7PO58IkaEul-yiRSnrrFAeMQ', '2022-04-29 16:51:16', 1),
	(13, 1, '2022-03-29 20:14:33', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUxMjYzMjczLjA1MywiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjI2IiwidWEiOiJNb3ppbGxhLzUuMCAoTWFjaW50b3NoOyBJbnRlbCBNYWMgT1MgWCAxMF8xNV82KSBBcHBsZVdlYktpdC82MDUuMS4xNSAoS0hUTUwsIGxpa2UgR2Vja28pIFZlcnNpb24vMTUuNCBTYWZhcmkvNjA1LjEuMTUiLCJpYXQiOjE2NDg1ODQ4NzN9.man9d5Xc6G35QKDngo8_0GF_mnv4yGE-lsiG7DTA2oI', '2022-04-29 20:14:33', 1),
	(14, 1, '2022-03-30 19:15:45', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUxMzQ2MTQ1Ljg0NywiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC44NCBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ4NjY3NzQ1fQ.0V2Q8zvyvbKZP_vbR0bie2-pX4vrZdnDVO7YZhBI_hk', '2022-04-30 19:15:45', 1),
	(15, 1, '2022-03-31 08:35:29', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUxMzk0MTI5LjkzNCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwMC4wLjQ4OTYuNjAgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTY0ODcxNTcyOX0.Jht2zPgB6tVvMwqH5GtRAAccH79sODJNZpcZv9Lk70w', '2022-05-01 08:35:29', 1),
	(16, 1, '2022-03-31 13:44:54', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUxNDEyNjk0LjIwOCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCA2LjA7IE5leHVzIDUgQnVpbGQvTVJBNThOKSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTAwLjAuNDg5Ni42MCBNb2JpbGUgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTY0ODczNDI5NH0.hJiA_8FKVkLtAsx5i5O4uYBb9jKIaMbFcMzyNqN3VNc', '2022-05-01 13:44:54', 1),
	(17, 1, '2022-03-31 15:35:09', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUxNDE5MzA5LjY0NywiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwMC4wLjQ4OTYuNjAgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTY0ODc0MDkwOX0.ePx5U1hDWhmJZnj8VH5krPt_Wi4OQlfsyclpFKRsOEw', '2022-05-01 15:35:09', 1),
	(18, 1, '2022-03-31 16:20:15', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUxNDIyMDE1LjQ2OSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjI3IiwidWEiOiJNb3ppbGxhLzUuMCAoTWFjaW50b3NoOyBJbnRlbCBNYWMgT1MgWCAxMF8xNV82KSBBcHBsZVdlYktpdC82MDUuMS4xNSAoS0hUTUwsIGxpa2UgR2Vja28pIFZlcnNpb24vMTUuNCBTYWZhcmkvNjA1LjEuMTUiLCJpYXQiOjE2NDg3NDM2MTV9.tQFBfhupBhPr0KMHCid8L8ppkoa9km4du0k0Ck6yAck', '2022-05-01 16:20:15', 1),
	(19, 1, '2022-03-31 17:07:29', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUxNDI0ODQ5Ljk1MywiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoWDExOyBMaW51eCB4ODZfNjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDAuMC40ODk2LjYwIFNhZmFyaS81MzcuMzYiLCJpYXQiOjE2NDg3NDY0NDl9.02aBI7TaEqXnIT8zLHCfqxBCtHqGBSCuQmw0tAOEFzw', '2022-05-01 17:07:29', 1),
	(20, 1, '2022-04-02 16:17:10', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUxNTk0NjMwLjE5MSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjI5IiwidWEiOiJNb3ppbGxhLzUuMCAoTWFjaW50b3NoOyBJbnRlbCBNYWMgT1MgWCAxMF8xNV82KSBBcHBsZVdlYktpdC82MDUuMS4xNSAoS0hUTUwsIGxpa2UgR2Vja28pIFZlcnNpb24vMTUuNCBTYWZhcmkvNjA1LjEuMTUiLCJpYXQiOjE2NDg5MTYyMzB9.CHRgntmMwgmpKO6_0Y2bCwTQk-acfgK4VR2Hh0BSTSk', '2022-05-03 16:17:10', 1),
	(21, 1, '2022-04-02 16:18:42', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUxNTk0NzIyLjc4LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwMC4wLjQ4OTYuNjAgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTY0ODkxNjMyMn0.Zd4aTD-QJS48X2h5FOtkrhhanufUFrtC1-xd8hgtB0k', '2022-05-03 16:18:42', 1),
	(22, 1, '2022-04-06 17:08:57', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUxOTQzMzM3Ljg2NiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwMC4wLjQ4OTYuNjAgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTY0OTI2NDkzN30.6mVENiapwQXs7LeNKufgXvHHmLF8oQyiFFge922RxLk', '2022-05-07 17:08:57', 1),
	(23, 1, '2022-04-10 12:05:20', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUyMjcwNzIwLjk2OSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoWDExOyBMaW51eCB4ODZfNjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDAuMC40ODk2Ljc1IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE2NDk1OTIzMjB9.ouPpAiiDbGIkQUftCsayVaVYJHyrixq4pR8lTqgnpqs', '2022-05-11 12:05:20', 1),
	(24, 1, '2022-04-10 12:54:09', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUyMjczNjQ5LjIwMywiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoWDExOyBMaW51eCB4ODZfNjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDAuMC40ODk2Ljc1IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE2NDk1OTUyNDl9.8b7z3uAQ2i-1zz7KesVM1wRN8aoRdy29QHwHvVshAwM', '2022-05-11 12:54:09', 1),
	(25, 1, '2022-04-17 02:16:27', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUyODQwMTg3LjQ2LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMjciLCJ1YSI6Ik1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDEwXzE1XzYpIEFwcGxlV2ViS2l0LzYwNS4xLjE1IChLSFRNTCwgbGlrZSBHZWNrbykgVmVyc2lvbi8xNS41IFNhZmFyaS82MDUuMS4xNSIsImlhdCI6MTY1MDE2MTc4N30.GjiulYo33QmiOyB7nXG47d3XzY7L2r4aWfOcj3UN9kw', '2022-05-18 02:16:27', 1),
	(26, 1, '2022-04-17 16:07:14', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUyODkwMDM0LjAzNSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoWDExOyBMaW51eCB4ODZfNjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDAuMC40ODk2LjEyNyBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjUwMjExNjM0fQ.uAKvtEY84VpaO0W5zDBnQP6H4mt5G5J9GuVAJsmQuuc', '2022-05-18 16:07:14', 1),
	(27, 1, '2022-04-29 17:34:38', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUzOTMyMDc4LjQ1MywiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjkuMCIsImlhdCI6MTY1MTI1MzY3OH0.XjFq_PbI0aWCQhgXjm6ZbH8aQd6xILTP_P1ubJImHFg', '2022-05-30 17:34:38', 1),
	(28, 1, '2022-04-30 03:06:41', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjUzOTY2NDAxLjg5MSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjI3IiwidWEiOiJNb3ppbGxhLzUuMCAoTWFjaW50b3NoOyBJbnRlbCBNYWMgT1MgWCAxMF8xNV82KSBBcHBsZVdlYktpdC82MDUuMS4xNSAoS0hUTUwsIGxpa2UgR2Vja28pIFZlcnNpb24vMTUuNSBTYWZhcmkvNjA1LjEuMTUiLCJpYXQiOjE2NTEyODgwMDF9._847LuxxFi2O2Jv-n0RXBah4KvyVCGrV3Be_iLGRdu0', '2022-05-31 03:06:41', 1),
	(29, 1, '2022-07-12 20:49:50', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjYwMzM3MzkwLjQ4OCwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoWDExOyBMaW51eCB4ODZfNjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDMuMC41MDYwLjExNCBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjU3NjU4OTkwfQ.joJq0mKplckCEZUnx05WgybV5RqWnYUPP-EOp9-4W1I', '2022-08-12 20:49:50', 1),
	(30, 1, '2022-07-14 10:00:12', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjYwNDcxMjEyLjEsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTAzLjAuNTA2MC4xMTQgU2FmYXJpLzUzNy4zNiBFZGcvMTAzLjAuMTI2NC40OSIsImlhdCI6MTY1Nzc5MjgxMn0.dCVSc0b90F1FuEjlWcY11T2aeGxVF03QnWnL9mSCdKM', '2022-08-14 10:00:12', 1),
	(31, 1, '2022-10-20 12:32:30', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjY4OTQ3NTUwLjMxMiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDYuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA2LjAuMTM3MC40NyIsImlhdCI6MTY2NjI2OTE1MH0.Pi-RudNDKicI66M8kjTN7YQ-bFVb_P5VScxDqVCF6co', '2022-11-20 12:32:30', 1),
	(36, 1, '2022-10-21 18:01:27', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjY5MDUzNjg3Ljc2NSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA2LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNi4wLjEzNzAuNDciLCJpYXQiOjE2NjYzNzUyODd9.ZMUIDmXUt-bZ8IzalqjnIzIdD7RDzc25UsrgenQvsnw', '2022-11-21 18:01:27', 1),
	(37, 1, '2022-10-21 18:02:08', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjY5MDUzNzI4LjMxNCwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjMwIiwidWEiOiJNb3ppbGxhLzUuMCAoTGludXg7IEFuZHJvaWQgMTI7IDIxMDgxMTExUkcgQnVpbGQvU1AxQS4yMTA4MTIuMDE2KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA2LjAuNTI0OS4xMjYgTW9iaWxlIFNhZmFyaS81MzcuMzYgT1BYLzEuNiIsImlhdCI6MTY2NjM3NTMyOH0.q7lU6-Hs07PaLIbVGfFO_gqNRi2Lhqcd5pisxQNhY7s', '2022-11-21 18:02:08', 1),
	(38, 1, '2022-10-22 17:26:10', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjY5MTM3OTcwLjk3NCwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoTGludXg7IEFuZHJvaWQgNi4wOyBOZXh1cyA1IEJ1aWxkL01SQTU4TikgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwNi4wLjAuMCBNb2JpbGUgU2FmYXJpLzUzNy4zNiBFZGcvMTA2LjAuMTM3MC40NyIsImlhdCI6MTY2NjQ1OTU3MH0.b5NeKGbPFDMR-N4ffa94noRCrgGmTg1w5PVKsJOiAIM', '2022-11-22 17:26:10', 1),
	(39, 1, '2022-10-22 17:29:36', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjY5MTM4MTc2LjkwMSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA2LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNi4wLjEzNzAuNDciLCJpYXQiOjE2NjY0NTk3NzZ9.aBQOAcLwAKSJ-zyomkY5Etxk1UXj-4EDeR6hdc8aAuI', '2022-11-22 17:29:36', 1),
	(40, 1, '2022-10-24 22:07:01', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjY5MzI3NjIxLjgxNSwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjkuMiIsImlhdCI6MTY2NjY0OTIyMX0.DwFgdd9x6WMd1zZ0UboZIK6wTxNp-MgXC0uUmvaLZzg', '2022-11-24 22:07:01', 1),
	(41, 1, '2022-10-24 22:12:36', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjY5MzI3OTU2LjkxOSwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjkuMiIsImlhdCI6MTY2NjY0OTU1Nn0.kPtydxDAGnHO2dDybfLk08Y0DhhT1hUa674lO8LIilw', '2022-11-24 22:12:36', 1),
	(42, 1, '2022-11-03 16:46:28', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcwMTcyMzg4LjcxMywiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDYuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA2LjAuMTM3MC40NyIsImlhdCI6MTY2NzQ5Mzk4OH0.E6tpivlJkK4RSwOG68VWduppBMNmVru_CoTpgEn992g', '2022-12-04 16:46:28', 1),
	(43, 1, '2022-11-03 22:39:52', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcwMTkzNTkyLjM2NSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjI3IiwidWEiOiJNb3ppbGxhLzUuMCAoTGludXg7IEFuZHJvaWQgMTI7IDIxMDgxMTExUkcgQnVpbGQvU1AxQS4yMTA4MTIuMDE2KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA2LjAuNTI0OS4xMjYgTW9iaWxlIFNhZmFyaS81MzcuMzYgT1BYLzEuNyIsImlhdCI6MTY2NzUxNTE5Mn0.Ia22Zh_nE5N4BJnYna-kQLd8-mIr87T1Lg51ZRL-lZQ', '2022-12-04 22:39:52', 1),
	(44, 1, '2022-11-03 22:40:57', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcwMTkzNjU3LjA1NCwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA2LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNi4wLjEzNzAuNDciLCJpYXQiOjE2Njc1MTUyNTd9.Wa_4Iu2a6JJNr0eNawV8-o1cX6I8LhReN7udZz3LpKE', '2022-12-04 22:40:57', 1),
	(45, 1, '2022-11-04 22:52:19', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcwMjgwNzM5LjkyOSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA2LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNi4wLjEzNzAuNDciLCJpYXQiOjE2Njc2MDIzMzl9.DR3ck923cOGNcdv0v0ZCDi9pTJ8--jhb02bA6MATmo0', '2022-12-05 22:52:19', 1),
	(46, 1, '2022-11-04 22:53:12', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcwMjgwNzkyLjMzNywiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA2LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNi4wLjEzNzAuNDciLCJpYXQiOjE2Njc2MDIzOTJ9.VjosbKN72iIaqOL9-dX9SiSmKw7bzezDul7-JmsH6TY', '2022-12-05 22:53:12', 1),
	(47, 1, '2022-11-04 22:55:10', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcwMjgwOTEwLjgxOSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA2LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNi4wLjEzNzAuNDciLCJpYXQiOjE2Njc2MDI1MTB9.Z5K3PaF2b4a_FUov3gcCrXXPpA-N-qFGvpkr60hOrV4', '2022-12-05 22:55:10', 1),
	(48, 1, '2022-11-04 23:14:32', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcwMjgyMDcyLjIwMywiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA2LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNi4wLjEzNzAuNDciLCJpYXQiOjE2Njc2MDM2NzJ9.mc5V5iBN1jHtMXHWc4lFT53SXOut-lTihyeO9cbZ17w', '2022-12-05 23:14:32', 1),
	(49, 1, '2022-11-04 23:19:48', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcwMjgyMzg4LjU4MiwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA2LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNi4wLjEzNzAuNDciLCJpYXQiOjE2Njc2MDM5ODh9.e43zoWqWHIEtEGCIGHv3k6hra8gkSmO69MF_zAjas6A', '2022-12-05 23:19:48', 1),
	(50, 1, '2022-11-06 23:50:48', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcwNDU3MDQ4LjY4NywiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjI3IiwidWEiOiJNb3ppbGxhLzUuMCAoTGludXg7IEFuZHJvaWQgMTI7IDIxMDgxMTExUkcgQnVpbGQvU1AxQS4yMTA4MTIuMDE2KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuNTMwNC45MSBNb2JpbGUgU2FmYXJpLzUzNy4zNiBPUFgvMS43IiwiaWF0IjoxNjY3Nzc4NjQ4fQ.FNmVpEgWx55RYa340xuF0Qj-zvz8wT-OgfpUuKI7SCI', '2022-12-07 23:50:48', 1),
	(51, 1, '2022-11-11 22:55:53', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcwODg1NzUzLjUzNywiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNy4wLjE0MTguMzUiLCJpYXQiOjE2NjgyMDczNTN9.1c6oQLuOptJMK1Dm15Re1csEdnLF3Fuo6YCSh_Lm0e0', '2022-12-12 22:55:53', 1),
	(52, 1, '2022-11-12 02:20:10', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcwODk4MDEwLjc3OSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjI5IiwidWEiOiJNb3ppbGxhLzUuMCAoTGludXg7IEFuZHJvaWQgMTI7IDIxMDgxMTExUkcgQnVpbGQvU1AxQS4yMTA4MTIuMDE2KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuNTMwNC45MSBNb2JpbGUgU2FmYXJpLzUzNy4zNiBPUFgvMS43IiwiaWF0IjoxNjY4MjE5NjEwfQ.e1BG2399OJLqBHuuG7zM4YLPLvQgrEK9FhYz6kBRpWU', '2022-12-13 02:20:10', 1),
	(53, 1, '2022-11-12 17:23:33', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcwOTUyMjEzLjQ5NCwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNy4wLjE0MTguMzUiLCJpYXQiOjE2NjgyNzM4MTN9.1r_3I7T_UvcXBrvPxU-Zg1HiTqqRkzoRWnYrWj75FF4', '2022-12-13 17:23:33', 1),
	(54, 1, '2022-11-13 17:39:39', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxMDM5NTc5LjkwMywiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjI5IiwidWEiOiJNb3ppbGxhLzUuMCAoTGludXg7IEFuZHJvaWQgMTI7IDIxMDgxMTExUkcpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgTW9iaWxlIFNhZmFyaS81MzcuMzYiLCJpYXQiOjE2NjgzNjExNzl9.nRKl-Jpe25kn99YiyCWdVxouPna6IFBhmM9x4lIzNr0', '2022-12-14 17:39:39', 1),
	(55, 1, '2022-11-13 17:40:11', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxMDM5NjExLjAwMSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNy4wLjE0MTguNDIiLCJpYXQiOjE2NjgzNjEyMTF9.D9qC-S12ZabZcppYiNOd68Ss38StxGFpZ4ZEVRTHBAQ', '2022-12-14 17:40:11', 1),
	(56, 1, '2022-11-15 23:09:35', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxMjMyMTc1Ljk4NiwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNy4wLjE0MTguNDIiLCJpYXQiOjE2Njg1NTM3NzV9.MAPHJNd8yGIGgdzBpCQ8T7J228fncoAiIoJam2wD-U8', '2022-12-16 23:09:35', 1),
	(57, 1, '2022-11-20 22:04:13', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjU5OTQ1LjM5MSwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjkuMiIsImlhdCI6MTY2ODk4MTU0NX0.fUXu8wWg5GhAfNwSkiy3WncAjclQNJZPkM3bg2o072A', '2022-12-21 21:59:05', 1),
	(58, 1, '2022-11-20 22:04:22', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjU5OTU1Ljk2MiwiaXAiOiI6OmZmZmY6MTAuMS4xLjk1IiwidWEiOiJQb3N0bWFuUnVudGltZS83LjI5LjIiLCJpYXQiOjE2Njg5ODE1NTV9.cShNYLle2t6tzepBwWE6L2B0r1Ypvr9LiIbrdfJEESA', '2022-12-21 21:59:15', 1),
	(59, 1, '2022-11-20 22:05:30', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjYwMDI0LjE5MSwiaXAiOiI6OmZmZmY6MTAuMS4xNC40NiIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwNy4wLjAuMCBTYWZhcmkvNTM3LjM2IEVkZy8xMDcuMC4xNDE4LjQyIiwiaWF0IjoxNjY4OTgxNjI0fQ.X6qXUFrbK9elD8gXF-g_ajr8gC2-Nb9k0KuiNteEefs', '2022-12-21 22:00:24', 1),
	(60, 1, '2022-11-20 22:07:30', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjYwMTQ0LjAzNywiaXAiOiI6OmZmZmY6MTAuMS44NS4yMzciLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjkuMiIsImlhdCI6MTY2ODk4MTc0NH0.hMkW2ibGNEPOE06XaeVIcym5GuX6NstJhs4E7S80EiU', '2022-12-21 22:02:24', 1),
	(61, 1, '2022-11-20 22:09:09', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjYwMjQyLjkyOSwiaXAiOiI6OmZmZmY6MTAuMS42MC4zMCIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwNy4wLjAuMCBTYWZhcmkvNTM3LjM2IEVkZy8xMDcuMC4xNDE4LjQyIiwiaWF0IjoxNjY4OTgxODQyfQ.5lHLlWU2QEAQm6D4x-scFziLIUfbHM_nihW8eVJFRu0', '2022-12-21 22:04:02', 1),
	(62, 1, '2022-11-20 22:10:51', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjYwMzQ0LjkyMSwiaXAiOiI6OmZmZmY6MTAuMS41LjYiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC40MiIsImlhdCI6MTY2ODk4MTk0NH0.r8Vvw4ZueVjhTrfvUVOM5pg_18FZNIzVKxV-hLCv6Kw', '2022-12-21 22:05:44', 1),
	(63, 1, '2022-11-20 22:13:49', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjYwNTIyLjQ2OSwiaXAiOiI6OmZmZmY6MTAuMS42MC42NSIsInVhIjoiTW96aWxsYS81LjAgKExpbnV4OyBBbmRyb2lkIDEyOyAyMTA4MTExMVJHIEJ1aWxkL1NQMUEuMjEwODEyLjAxNikgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwNy4wLjUzMDQuMTA1IE1vYmlsZSBTYWZhcmkvNTM3LjM2IE9QWC8xLjciLCJpYXQiOjE2Njg5ODIxMjJ9.0HG46oZ29chseb1JYH7_8UXbZum2DQzIwNcmuz_gRyw', '2022-12-21 22:08:42', 1),
	(64, 1, '2022-11-20 22:15:49', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjYwNjQyLjkwNCwiaXAiOiI6OmZmZmY6MTAuMS4zLjI0NSIsInVhIjoiTW96aWxsYS81LjAgKExpbnV4OyBBbmRyb2lkIDEyOyAyMTA4MTExMVJHIEJ1aWxkL1NQMUEuMjEwODEyLjAxNikgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwNy4wLjUzMDQuMTA1IE1vYmlsZSBTYWZhcmkvNTM3LjM2IE9QWC8xLjciLCJpYXQiOjE2Njg5ODIyNDJ9.YmAwviqLOsqQmbTb-HBPkc-KHLevwo4jL05RxMOyHKc', '2022-12-21 22:10:42', 1),
	(65, 1, '2022-11-20 22:21:47', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjYxMDAxLjIwOSwiaXAiOiI6OmZmZmY6MTAuMS4xMy4xNDEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC40MiIsImlhdCI6MTY2ODk4MjYwMX0.q1oRfR9EOaLm8E9Zlz67QFSX_lsX8dbieWN478Izm-U', '2022-12-21 22:16:41', 1),
	(66, 1, '2022-11-20 22:32:29', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjYxNjQyLjg3OSwiaXAiOiI6OmZmZmY6MTAuMS44NS4yMzciLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC40MiIsImlhdCI6MTY2ODk4MzI0Mn0.f9xLZ4LtSiZeWqpiz_MXIuZelDdeWrXiqbf18DPziHM', '2022-12-21 22:27:22', 1),
	(67, 1, '2022-11-20 22:33:38', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjYxNzExLjgzNiwiaXAiOiI6OmZmZmY6MTAuMS44NS4yMzciLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC40MiIsImlhdCI6MTY2ODk4MzMxMX0.XyXdZxMXlXEyI1bqruXMBpcHjTLe972LmyQzaZTDsDo', '2022-12-21 22:28:31', 1),
	(68, 1, '2022-11-20 22:34:49', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjYxNzgzLjM3MSwiaXAiOiI6OmZmZmY6MTAuMS4zMS4xNjIiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC40MiIsImlhdCI6MTY2ODk4MzM4M30.KYqrQs-qbjDQOOUOri6MrFTE1Nn0rAehVmrjGqhqlsc', '2022-12-21 22:29:43', 1),
	(69, 1, '2022-11-20 22:36:33', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjYxODg3LjIwNywiaXAiOiI6OmZmZmY6MTAuMS44OC4yNTUiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC40MiIsImlhdCI6MTY2ODk4MzQ4N30.5Xdz1WtYFH6RnhQcC371XXtXG0pS5FKju-pL781G8fY', '2022-12-21 22:31:27', 1),
	(70, 1, '2022-11-20 22:46:42', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjYyNDk2LjA1LCJpcCI6Ijo6ZmZmZjoxMC4xLjE2LjEyMSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy4yOS4yIiwiaWF0IjoxNjY4OTg0MDk2fQ.ALMw8_lQTKg7kgBGMC_vHQGRihdm-UxX_emEAnVfgaA', '2022-12-21 22:41:36', 1),
	(71, 1, '2022-11-20 22:48:35', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjYyNjA4LjYwNiwiaXAiOiI6OmZmZmY6MTAuMS45NC4xMDAiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC40MiIsImlhdCI6MTY2ODk4NDIwOH0.NZP7B9nB3o0gntHzU9-hdSscmhjM4-20hmGwulpxVpE', '2022-12-21 22:43:28', 1),
	(72, 1, '2022-11-20 22:51:06', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjYyNzYwLjE1MywiaXAiOiI6OmZmZmY6MTAuMS42Mi4yNCIsInVhIjoiTW96aWxsYS81LjAgKExpbnV4OyBBbmRyb2lkIDEyOyAyMTA4MTExMVJHIEJ1aWxkL1NQMUEuMjEwODEyLjAxNikgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwNy4wLjUzMDQuMTA1IE1vYmlsZSBTYWZhcmkvNTM3LjM2IE9QWC8xLjciLCJpYXQiOjE2Njg5ODQzNjB9.0roP2tqPACS7d00h5Dnedmc8_Dja0_E69WbUrn8mEDo', '2022-12-21 22:46:00', 1),
	(73, 1, '2022-11-20 23:27:14', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjY0OTI3LjYyOCwiaXAiOiI6OmZmZmY6MTAuMS4yMi4xODYiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC40MiIsImlhdCI6MTY2ODk4NjUyN30.M1aqKx1YdUkkE1SdKkn7COY78Rd-EMrFTEw1YbcgQ80', '2022-12-21 23:22:07', 1),
	(74, 1, '2022-11-20 23:33:09', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjY1MjgxLjc0NCwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNy4wLjE0MTguNDIiLCJpYXQiOjE2Njg5ODY4ODF9.ECQ8xJU4XpNt5Cjo4-MqKy5zJ_g9qxlf7NWqBDxrm5M', '2022-12-21 23:28:01', 1),
	(75, 1, '2022-11-20 23:43:25', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjY1ODk4LjczNCwiaXAiOiI6OmZmZmY6MTAuMS40OC4xMjIiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCAxMjsgMjEwODExMTFSRyBCdWlsZC9TUDFBLjIxMDgxMi4wMTYpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC41MzA0LjEwNSBNb2JpbGUgU2FmYXJpLzUzNy4zNiBPUFgvMS43IiwiaWF0IjoxNjY4OTg3NDk4fQ.NWmoNiG6YRL-pykLHfgz2rpmEB7gE2noBEDcAhydBzc', '2022-12-21 23:38:18', 1),
	(76, 1, '2022-11-20 23:45:11', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNjY2MDA0LjczOCwiaXAiOiI6OmZmZmY6MTAuMS4xOS41MSIsInVhIjoiTW96aWxsYS81LjAgKExpbnV4OyBBbmRyb2lkIDEyOyAyMTA4MTExMVJHKSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuMC4wIE1vYmlsZSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjY4OTg3NjA0fQ.0ZPsr7rTxLimJdfX_tcGXXnadqv2jTQytJtzuJsrpjI', '2022-12-21 23:40:04', 1),
	(77, 1, '2022-11-21 17:01:40', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNzI4MTkzLjU3MSwiaXAiOiI6OmZmZmY6MTAuMS40OC4xMjIiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCAxMjsgMjEwODExMTFSRyBCdWlsZC9TUDFBLjIxMDgxMi4wMTYpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC41MzA0LjEwNSBNb2JpbGUgU2FmYXJpLzUzNy4zNiBPUFgvMS43IiwiaWF0IjoxNjY5MDQ5NzkzfQ.-X47fVeSq6p7luKmWSU9Y4EcoUO-K8z-JXZ7OTPCtxw', '2022-12-22 16:56:33', 1),
	(78, 1, '2022-11-21 17:14:34', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNzI4OTY4LjIxMSwiaXAiOiI6OmZmZmY6MTAuMS40OC4xMjIiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCAxMjsgMjEwODExMTFSRyBCdWlsZC9TUDFBLjIxMDgxMi4wMTYpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC41MzA0LjEwNSBNb2JpbGUgU2FmYXJpLzUzNy4zNiBPUFgvMS43IiwiaWF0IjoxNjY5MDUwNTY4fQ.-epFb1IViqiuCl-lGsiHB7dWeHMsB6IIZ-EUhYmMa0U', '2022-12-22 17:09:28', 1),
	(79, 1, '2022-11-21 19:28:28', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNzM3MDAyLjQ5MiwiaXAiOiI6OmZmZmY6MTAuMS4zNS4xOTciLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC40MiIsImlhdCI6MTY2OTA1ODYwMn0.PypzUl0W7lRU6I9_h4DXscnwlZHsUufklFwu0RtWR0g', '2022-12-22 19:23:22', 1),
	(80, 1, '2022-11-21 19:31:48', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNzM3MjAxLjgwMywiaXAiOiI6OmZmZmY6MTAuMS40NS4xOCIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwNy4wLjAuMCBTYWZhcmkvNTM3LjM2IEVkZy8xMDcuMC4xNDE4LjQyIiwiaWF0IjoxNjY5MDU4ODAxfQ.hWAetEr0bOPMLdgRDVm2mzGCr2wyXDI4tTQQOKEJgJE', '2022-12-22 19:26:41', 1),
	(81, 1, '2022-11-21 19:34:16', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNzM3MzQ5LjU5MSwiaXAiOiI6OmZmZmY6MTAuMS4zOC4xODQiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC40MiIsImlhdCI6MTY2OTA1ODk0OX0.EiQAEzAruoI_WejrpzB5wAtcFXDHebks9tPbwTPxrIY', '2022-12-22 19:29:09', 1),
	(82, 1, '2022-11-21 21:07:31', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxNzQyOTQ1LjEwMSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNy4wLjE0MTguNDIiLCJpYXQiOjE2NjkwNjQ1NDV9.QkN0t9rUMRjkiM5r9CUdbSB8jTjwKTOs9dkdhx5uui8', '2022-12-22 21:02:25', 1),
	(83, 1, '2022-11-22 22:12:03', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxODMzMjE2LjUxMSwiaXAiOiI6OmZmZmY6MTAuMS44Ny4xMjIiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjkuMiIsImlhdCI6MTY2OTE1NDgxNn0.kEyEd6h2cstfxY7x_hyh39hOAV7GYIzae1FAKUVJioQ', '2022-12-23 22:06:56', 1),
	(84, 1, '2022-11-22 22:16:28', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxODMzNDgxLjQyMywiaXAiOiI6OmZmZmY6MTAuMTAuMTAuNyIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwNy4wLjAuMCBTYWZhcmkvNTM3LjM2IEVkZy8xMDcuMC4xNDE4LjUyIiwiaWF0IjoxNjY5MTU1MDgxfQ.PGqVhZO4SJ_TWijGVuyA7Gr4Az7Z5NoxhAKz7VdEkIU', '2022-12-23 22:11:21', 1),
	(85, 1, '2022-11-22 22:16:47', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxODMzNTAwLjg5NiwiaXAiOiI6OmZmZmY6MTAuMTAuMTAuMTQiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCAxMjsgMjEwODExMTFSRyBCdWlsZC9TUDFBLjIxMDgxMi4wMTYpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC41MzA0LjEwNSBNb2JpbGUgU2FmYXJpLzUzNy4zNiBPUFgvMS43IiwiaWF0IjoxNjY5MTU1MTAwfQ.g2yZzLu-ZcoCUZ90dm9e5EBRDg1oyi7pQsqpnR7G-3E', '2022-12-23 22:11:40', 1),
	(86, 1, '2022-11-22 22:42:06', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxODM1MDE5Ljk0MiwiaXAiOiIxMjcuMC4wLjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjkuMiIsImlhdCI6MTY2OTE1NjYxOX0.ElNia1coJ93NtEsj_0mM3lR_jN7CZGLdcwBVNL_486Q', '2022-12-23 22:36:59', 1),
	(87, 1, '2022-11-22 22:50:22', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxODM1NTE1LjYzNywiaXAiOiIxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCAxMjsgMjEwODExMTFSRyBCdWlsZC9TUDFBLjIxMDgxMi4wMTYpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC41MzA0LjEwNSBNb2JpbGUgU2FmYXJpLzUzNy4zNiBPUFgvMS43IiwiaWF0IjoxNjY5MTU3MTE1fQ.6--4-I_KXwXp-8WUum9WHwBEeM4xn33rYg7Pn5vHDpE', '2022-12-23 22:45:15', 1),
	(88, 1, '2022-11-23 06:54:09', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxODY0NTQyLjk0NywiaXAiOiIxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC40MiIsImlhdCI6MTY2OTE4NjE0Mn0.ZrkYdurfeaLgYVkWaHZG6emgSRhcxlPEVaHhZ4d3k9w', '2022-12-24 06:49:02', 1),
	(89, 1, '2022-11-23 19:45:52', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxOTEwODQ1LjY5NywiaXAiOiIxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCAxMjsgMjEwODExMTFSRyBCdWlsZC9TUDFBLjIxMDgxMi4wMTYpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC41MzA0LjEwNSBNb2JpbGUgU2FmYXJpLzUzNy4zNiBPUFgvMS43IiwiaWF0IjoxNjY5MjMyNDQ1fQ.TMusnUetPM-ts8Rh8OrZIZf6U2NoZCIclnUaedZHr1A', '2022-12-24 19:40:45', 1),
	(90, 1, '2022-11-23 21:21:25', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxOTE2NTc4LjczLCJpcCI6IjEyNy4wLjAuMSIsInVhIjoiTW96aWxsYS81LjAgKExpbnV4OyBVOyBBbmRyb2lkIDEyOyBoci1ocjsgWGlhb21pIDEyIEJ1aWxkL1NLUTEuMjExMDA2LjAwMSkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgVmVyc2lvbi80LjAgQ2hyb21lLzEwMC4wLjQ4OTYuMTI3IE1vYmlsZSBTYWZhcmkvNTM3LjM2IFhpYW9NaS9NaXVpQnJvd3Nlci8xMy42LjAuMy1nbiIsImlhdCI6MTY2OTIzODE3OH0.4fJE3GMGIIufs5MVJNvowsUHPl6Jzu-5hcRl3ZgKpr4', '2022-12-24 21:16:18', 1),
	(91, 1, '2022-11-25 15:53:54', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyMDcwMDM0LjExNSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNy4wLjE0MTguNTIiLCJpYXQiOjE2NjkzOTE2MzR9.Otaf8eRzyH4gW5xy8P6H-9wJb9G6lhg-l5c-mYsXhGk', '2022-12-26 15:53:54', 1),
	(92, 1, '2022-11-25 19:03:15', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyMDgxMzk1LjIyNywiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNy4wLjE0MTguNTIiLCJpYXQiOjE2Njk0MDI5OTV9.3pod31RkPRUmLi8DqJJfLn9BVaGKp-bMBPR_k_dt3cQ', '2022-12-26 19:03:15', 1),
	(93, 1, '2022-11-25 20:02:49', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyMDg0OTY5LjY4NCwiaXAiOiIxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCAxMjsgMjEwODExMTFSRyBCdWlsZC9TUDFBLjIxMDgxMi4wMTYpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC41MzA0LjEwNSBNb2JpbGUgU2FmYXJpLzUzNy4zNiBPUFgvMS43IiwiaWF0IjoxNjY5NDA2NTY5fQ.qr8E_GFVKMNRujWM8NXLcT7Qu6g4ERTMBjOSHLwsFhY', '2022-12-26 20:02:49', 1),
	(94, 1, '2022-11-25 20:12:05', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyMDg1NTI1LjI4LCJpcCI6IjEyNy4wLjAuMSIsInVhIjoiTW96aWxsYS81LjAgKExpbnV4OyBBbmRyb2lkIDEyOyAyMTA4MTExMVJHKSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuMC4wIE1vYmlsZSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjY5NDA3MTI1fQ.l6PStNzUdwh0SPTjcI6lmx0JP-APjkUlfSA9SgAH2uo', '2022-12-26 20:12:05', 1),
	(95, 1, '2022-11-25 23:17:41', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyMDk2NjYwLjkzNywiaXAiOiIxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC41MiIsImlhdCI6MTY2OTQxODI2MH0.9WJLsWMORn-pHRSFDXg0e3tT1321Pyhyiw8P1Gmr0Wc', '2022-12-26 23:17:40', 1),
	(96, 1, '2022-11-25 23:19:39', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyMDk2Nzc5Ljc0LCJpcCI6IjEyNy4wLjAuMSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwNy4wLjAuMCBTYWZhcmkvNTM3LjM2IEVkZy8xMDcuMC4xNDE4LjUyIiwiaWF0IjoxNjY5NDE4Mzc5fQ.tnVpJKGBHwrjG1QlqFLu393VKTz23o1ut-v6UBlA1tc', '2022-12-26 23:19:39', 1),
	(97, 1, '2022-11-26 09:15:12', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyMTMyNTEyLjAwNCwiaXAiOiIxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCAxMjsgMjEwODExMTFSRyBCdWlsZC9TUDFBLjIxMDgxMi4wMTYpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC41MzA0LjE0MSBNb2JpbGUgU2FmYXJpLzUzNy4zNiBPUFgvMS43IiwiaWF0IjoxNjY5NDU0MTEyfQ.3aiKUy2E6mmI_koQ_nLusy-kw2bkbgVkllp3fJJtY50', '2022-12-27 09:15:12', 1),
	(98, 1, '2022-11-26 15:19:25', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyMTU0MzY1Ljg1NiwiaXAiOiIxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC41MiIsImlhdCI6MTY2OTQ3NTk2NX0.giec6x0BuU7rSw0u7w0fjBKmGP8qMMbkg4AgLZ6_vdY', '2022-12-27 15:19:25', 1),
	(99, 1, '2022-11-26 15:37:37', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyMTU1NDU3LjA3OSwiaXAiOiIxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC41MiIsImlhdCI6MTY2OTQ3NzA1N30.VI_rmYO4fJiDGZXQnIzHkAzgrsBKqgN_4z0nkxpFYPs', '2022-12-27 15:37:37', 1),
	(100, 1, '2022-11-29 07:26:33', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyMzg1MTkzLjgzMywiaXAiOiIxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC41NiIsImlhdCI6MTY2OTcwNjc5M30.JH0BOYCpLM0-93ixSiGMLbO2VWR4bdGUzRyaC-X3WaE', '2022-12-30 07:26:33', 1),
	(101, 1, '2022-11-29 07:26:34', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyMzg1MTk0LjEzLCJpcCI6IjEyNy4wLjAuMSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwNy4wLjAuMCBTYWZhcmkvNTM3LjM2IEVkZy8xMDcuMC4xNDE4LjU2IiwiaWF0IjoxNjY5NzA2Nzk0fQ.nHdRoMU6_nXNTvJluXmA2rXAtXOAJFc_R7CQinKxy5A', '2022-12-30 07:26:34', 1),
	(102, 1, '2022-11-29 16:15:39', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyNDE2OTM2LjEzMSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNy4wLjE0MTguNTIiLCJpYXQiOjE2Njk3Mzg1MzZ9.wkudmIvS0DF-RZX_D7xUgq7ITK3FwOHRSOZy9XOq_7Y', '2022-12-30 16:15:36', 1),
	(103, 1, '2022-11-29 16:37:55', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyNDE4MjcyLjE1MSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNy4wLjE0MTguNTIiLCJpYXQiOjE2Njk3Mzk4NzJ9.0UY6w1Mk97NS_qqZQHAwN5erApE_66TT4Oxc8_XNy9o', '2022-12-30 16:37:52', 1),
	(104, 1, '2022-11-30 06:50:51', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyNDY5NDUxLjIwOSwiaXAiOiIxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC41NiIsImlhdCI6MTY2OTc5MTA1MX0.M_lZE-3hBVB7Pkb8S9Ne7qpzJb5bPX7k1MuYhed9X_w', '2022-12-31 06:50:51', 1),
	(105, 1, '2022-12-01 08:46:04', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyNTYyNzY0LjIxLCJpcCI6IjEyNy4wLjAuMSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwNy4wLjAuMCBTYWZhcmkvNTM3LjM2IEVkZy8xMDcuMC4xNDE4LjYyIiwiaWF0IjoxNjY5ODg0MzY0fQ.maoWYmVYsyMMkJY5sS8RJ0Zflm9USDejgNonmIvZdCQ', '2023-01-01 08:46:04', 1),
	(106, 1, '2022-12-01 08:54:53', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyNTYzMjkzLjQzMywiaXAiOiIxMjcuMC4wLjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjkuMiIsImlhdCI6MTY2OTg4NDg5M30.UFqslrWzsW3dD_0n7Tpfdqd03CkRT26ZFPKaqik0GDc', '2023-01-01 08:54:53', 1),
	(107, 1, '2022-12-01 09:31:43', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyNTY1NTAzLjcwOCwiaXAiOiIxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC42MiIsImlhdCI6MTY2OTg4NzEwM30.eRWhprKiF5YINuz8vQbWKuqMlD6AwGjrmthUHOS_0CQ', '2023-01-01 09:31:43', 1),
	(108, 1, '2022-12-01 10:00:55', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyNTY3MjU1LjA0OSwiaXAiOiIxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC42MiIsImlhdCI6MTY2OTg4ODg1NX0.uCjR15m-DZYtI-p_A9OJWjbEs9FQ5zhSlNzHEft7FIE', '2023-01-01 10:00:55', 1),
	(109, 1, '2022-12-01 13:56:34', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcyNTgxMzk0LjMzNCwiaXAiOiIxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC42MiIsImlhdCI6MTY2OTkwMjk5NH0.aXYGj3gpMK5sjgJZFr4b3WBJidzqQiEfw-J27i_CVus', '2023-01-01 13:56:34', 1),
	(110, 1, '2023-09-07 11:56:43', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk2NzY2MjAzLjUyNiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMTUuMC4wLjAgU2FmYXJpLzUzNy4zNiBPUFIvMTAxLjAuMC4wIiwiaWF0IjoxNjk0MDg3ODAzfQ.m1SuW1-39tzcLcHlqUofHNdaNnVLKCRIMJx3471rHVQ', '2023-10-08 11:56:43', 1),
	(111, 1, '2023-09-14 13:20:26', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk3Mzc2MDI2LjAwOCwiaXAiOiI6OmZmZmY6MTkyLjE2OC4xMi41MiIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzExNS4wLjAuMCBTYWZhcmkvNTM3LjM2IE9QUi8xMDEuMC4wLjAiLCJpYXQiOjE2OTQ2OTc2MjZ9.CbQ1aXy0IFg2Usje4SsxMG4YzEMcfFGGbYO8rtoGJaA', '2023-10-15 13:20:26', 1),
	(112, 1, '2023-09-15 13:07:24', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk3NDYxNjQ0Ljc4OSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4xMi41MiIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzExNS4wLjAuMCBTYWZhcmkvNTM3LjM2IE9QUi8xMDEuMC4wLjAiLCJpYXQiOjE2OTQ3ODMyNDR9.g6tc5lktaokDGyAjpzqeiGItg3ajx1gu4Af3adGu6H4', '2023-10-16 13:07:24', 1),
	(113, 1, '2023-09-19 13:07:15', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk3ODA3MjM1LjkxNCwiaXAiOiI6OmZmZmY6MTkyLjE2OC4xMi41MiIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzExNS4wLjAuMCBTYWZhcmkvNTM3LjM2IE9QUi8xMDEuMC4wLjAiLCJpYXQiOjE2OTUxMjg4MzV9.TUXXCscDWjqHgSKvar-cNgk8lRtl7GsoVxNziTfg-yY', '2023-10-20 13:07:15', 1),
	(114, 1, '2023-09-19 13:40:53', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk3ODA5MjUzLjU5MiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMTUuMC4wLjAgU2FmYXJpLzUzNy4zNiBPUFIvMTAxLjAuMC4wIiwiaWF0IjoxNjk1MTMwODUzfQ.-D7Bp7nKbyQGQeabJMNaWQxJaEAltr_0s1i-wfFrhNg', '2023-10-20 13:40:53', 1),
	(115, 1, '2023-09-20 05:48:07', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk3ODY3Mjg3LjEwMiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMTUuMC4wLjAgU2FmYXJpLzUzNy4zNiBPUFIvMTAxLjAuMC4wIiwiaWF0IjoxNjk1MTg4ODg3fQ.DqXUmMuhdrnPVAe1lxYtZcJz8xCPWMoAV_ChtcMsyzE', '2023-10-21 05:48:07', 1),
	(116, 1, '2023-09-20 06:13:20', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk3ODY4ODAwLjc4OCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMTUuMC4wLjAgU2FmYXJpLzUzNy4zNiBPUFIvMTAxLjAuMC4wIiwiaWF0IjoxNjk1MTkwNDAwfQ.A_1SvZ__O7WW8W7jcaFamefKSGU_ZGECyXIqSvKWGUg', '2023-10-21 06:13:20', 1),
	(117, 1, '2023-09-20 07:36:18', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk3ODczNzc4LjM5OCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMTUuMC4wLjAgU2FmYXJpLzUzNy4zNiBPUFIvMTAxLjAuMC4wIiwiaWF0IjoxNjk1MTk1Mzc4fQ.z2LinBQktQaK02IHtg7vcp8o8kqwJSOloNN3LrsSgUo', '2023-10-21 07:36:18', 1),
	(118, 1, '2023-09-21 08:37:59', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk3OTYzODc5LjM1NywiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMzMuMCIsImlhdCI6MTY5NTI4NTQ3OX0.nCVRJm88aFWwaOdlk7dMaKDAAe-NIIdQJspfXia3MlI', '2023-10-22 08:37:59', 1),
	(119, 1, '2023-09-21 10:22:41', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk3OTcwMTYxLjkyNiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMTUuMC4wLjAgU2FmYXJpLzUzNy4zNiBPUFIvMTAxLjAuMC4wIiwiaWF0IjoxNjk1MjkxNzYxfQ.GZGDb5O3i_mRgVQXPmU4hMZcZPZQ2z05kMRwAdk_WBs', '2023-10-22 10:22:41', 1),
	(120, 1, '2023-09-21 10:32:38', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk3OTcwNzU4LjcwMiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMTUuMC4wLjAgU2FmYXJpLzUzNy4zNiBPUFIvMTAxLjAuMC4wIiwiaWF0IjoxNjk1MjkyMzU4fQ.QT5TU44W0BdMolRtgwrUBq36vhzcBldRfUkvbyaGXNU', '2023-10-22 10:32:38', 1),
	(121, 1, '2023-09-28 13:57:15', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk4NTg3ODM1LjM2MywiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMTYuMC4wLjAgU2FmYXJpLzUzNy4zNiBPUFIvMTAyLjAuMC4wIiwiaWF0IjoxNjk1OTA5NDM1fQ.4cBuHA05w6GC1TIIEHJDj1unnuU0ZyeJPZZu12Srsuw', '2023-10-29 13:57:15', 1),
	(122, 1, '2023-10-06 13:41:39', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk5Mjc4MDk5LjU4MSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMTYuMC4wLjAgU2FmYXJpLzUzNy4zNiBPUFIvMTAyLjAuMC4wIiwiaWF0IjoxNjk2NTk5Njk5fQ.rLmvwTx5CCOr34xEVvttQHd6t_g8NhMkgju3v31CBtQ', '2023-10-06 13:41:59', 1),
	(123, 1, '2023-10-06 13:45:45', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk5Mjc4MzQ1LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzExNi4wLjAuMCBTYWZhcmkvNTM3LjM2IE9QUi8xMDIuMC4wLjAiLCJpYXQiOjE2OTY1OTk5NDV9.8xk03x6SimGUGIw-Pwz0AEI1QfeM3mmlUfnlMch82KE', '2023-11-06 13:45:45', 1),
	(124, 1, '2023-10-10 12:51:44', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk5NjIwNzA0LjAzNiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMTYuMC4wLjAgU2FmYXJpLzUzNy4zNiBPUFIvMTAyLjAuMC4wIiwiaWF0IjoxNjk2OTQyMzA0fQ.bxdqYQCLvpO_GP0--UPhU3Gag62f9WMaW3EdbbsFyjo', '2023-11-10 12:51:44', 1),
	(125, 1, '2023-10-10 13:10:19', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk5NjIxODE5LjkyOCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMTYuMC4wLjAgU2FmYXJpLzUzNy4zNiBPUFIvMTAyLjAuMC4wIiwiaWF0IjoxNjk2OTQzNDE5fQ.FmOp-9j0iZxQec0fqpsqMrZiYtxd2ASbZmNjIJBFlW0', '2023-11-10 13:10:19', 1),
	(126, 1, '2023-10-10 13:13:22', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk5NjIyMDAyLjI5NiwiaXAiOiI6OmZmZmY6MTkyLjE2OC4xMi41MiIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzExNi4wLjAuMCBTYWZhcmkvNTM3LjM2IE9QUi8xMDIuMC4wLjAiLCJpYXQiOjE2OTY5NDM2MDJ9.FKKtfZ2_4rpjn-pogNa9g5y0BLx1OSUt4HYIzI4Ek2w', '2023-11-10 13:13:22', 1),
	(127, 1, '2023-10-10 13:20:28', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk5NjIyNDI4LjYzNSwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTE2LjAuMC4wIFNhZmFyaS81MzcuMzYgT1BSLzEwMi4wLjAuMCIsImlhdCI6MTY5Njk0NDAyOH0.iSwGPUjZ_r4T8bGK7ihFJhSc5pLCUQQiRgbrDWzRWHU', '2023-11-10 13:20:28', 1),
	(128, 1, '2023-10-11 06:10:00', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk5NjgzMDAwLjE4MSwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMzMuMCIsImlhdCI6MTY5NzAwNDYwMH0.yNtYtUEeJqpzgRgiOzrit8xULylPszuV5DOtT507eOU', '2023-11-11 06:10:00', 1),
	(129, 1, '2023-10-11 07:55:45', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk5Njg5MzQ1LjU4OCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMTYuMC4wLjAgU2FmYXJpLzUzNy4zNiBPUFIvMTAyLjAuMC4wIiwiaWF0IjoxNjk3MDEwOTQ1fQ.nLcpegtQ2_rtaArNOQv_XNZyhefeWAVEj9zW6W4AvqM', '2023-11-11 07:55:45', 1),
	(130, 1, '2023-10-10 12:07:58', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk5NjE4MDc4LjA3LCJpcCI6Ijo6ZmZmZjoxMjcuMC4wLjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMzMuMCIsImlhdCI6MTY5NjkzOTY3OH0.e-IGHRVPewXPfVmrjOlbuDMu49llwLOh2KOG_LjEzq4', '2023-11-10 12:07:58', 1),
	(131, 1, '2023-10-10 21:51:02', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk5NjUzMDYyLjQ5MywiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoWDExOyBVYnVudHU7IExpbnV4IHg4Nl82NDsgcnY6MTA5LjApIEdlY2tvLzIwMTAwMTAxIEZpcmVmb3gvMTE4LjAiLCJpYXQiOjE2OTY5NzQ2NjJ9.xSHMEPDAYbWt4yG7lORqjhIqNiP_Gl4t2vRGpEVbPI4', '2023-11-10 21:51:02', 1),
	(132, 1, '2023-10-10 21:59:53', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk5NjUzNTkzLjU2OCwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoWDExOyBVYnVudHU7IExpbnV4IHg4Nl82NDsgcnY6MTA5LjApIEdlY2tvLzIwMTAwMTAxIEZpcmVmb3gvMTE4LjAiLCJpYXQiOjE2OTY5NzUxOTN9.AaYoYuZZ1mvZ-csd2BpvAwwXiaNVMRbPS0oaGyg5-1U', '2023-11-10 21:59:53', 1),
	(133, 1, '2023-10-10 22:03:13', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk5NjUzNzkzLjQ2NCwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJQb3N0bWFuUnVudGltZS83LjMzLjAiLCJpYXQiOjE2OTY5NzUzOTN9.sW2PC3fFmlyp7p-u4Srzb1Rd7kdYRLeIcxyV_9vFc0o', '2023-11-10 22:03:13', 1),
	(134, 1, '2023-10-10 22:41:53', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk5NjU2MTEzLjg2NSwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJQb3N0bWFuUnVudGltZS83LjMzLjAiLCJpYXQiOjE2OTY5Nzc3MTN9.AISQa7PARzA9Pwducu1nok3o6hQhmRvv8-IFtTgaTsk', '2023-11-10 22:41:53', 1),
	(135, 1, '2023-10-10 22:43:57', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk5NjU2MjM3Ljk4MiwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoWDExOyBVYnVudHU7IExpbnV4IHg4Nl82NDsgcnY6MTA5LjApIEdlY2tvLzIwMTAwMTAxIEZpcmVmb3gvMTE4LjAiLCJpYXQiOjE2OTY5Nzc4Mzd9.303dB71dEf72LiHIXm3CYmbZGpppcvsGB3CleO9xkew', '2023-11-10 22:43:57', 1),
	(136, 1, '2023-10-10 22:48:59', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk5NjU2NTM5LjAxNywiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoTGludXg7IEFuZHJvaWQgMTM7IDIxMDgxMTExUkcgQnVpbGQvVFAxQS4yMjA2MjQuMDE0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTE3LjAuMC4wIE1vYmlsZSBTYWZhcmkvNTM3LjM2IE9QWC8yLjEiLCJpYXQiOjE2OTY5NzgxMzl9.3DL55sNHK6IMU7T_ZfH0iRD-KLYGcPZ6iFDfS78azA4', '2023-11-10 22:48:59', 1),
	(137, 1, '2023-10-11 16:01:06', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk5NzE4NDY2LjY1OCwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoTGludXg7IEFuZHJvaWQgMTM7IDIxMDgxMTExUkcgQnVpbGQvVFAxQS4yMjA2MjQuMDE0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTE3LjAuMC4wIE1vYmlsZSBTYWZhcmkvNTM3LjM2IE9QWC8yLjEiLCJpYXQiOjE2OTcwNDAwNjZ9.JqmFT3h8kQHiynBxBqMFLeXSpke70lGizQb8kTnP10g', '2023-11-11 16:01:06', 1),
	(138, 1, '2023-10-13 00:42:08', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk5ODM2MTI4Ljg0MywiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoWDExOyBVYnVudHU7IExpbnV4IHg4Nl82NDsgcnY6MTA5LjApIEdlY2tvLzIwMTAwMTAxIEZpcmVmb3gvMTE4LjAiLCJpYXQiOjE2OTcxNTc3Mjh9.u9GKSjAo5j5FQf_0O4w4hUCGPP4l4qA8ad3a-RS4qd4', '2023-11-13 00:42:08', 1),
	(139, 1, '2023-10-13 23:27:39', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk5OTE4MDU5LjI0NCwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTE2LjAuMC4wIFNhZmFyaS81MzcuMzYgT1BSLzEwMi4wLjAuMCIsImlhdCI6MTY5NzIzOTY1OX0.5l6DGZeTvlP0_SQVAxhWuvDQmDqB_QPjIppAgRm0fIM', '2023-11-13 23:27:39', 1),
	(140, 1, '2023-10-20 16:20:52', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNzAwNDk3MjUyLjU1OCwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjkuMiIsImlhdCI6MTY5NzgxODg1Mn0.xhBeFxZadcoiFv6YFJNqFNSzdiY5JNSkJToR4ZxYwH0', '2023-11-20 16:20:52', 1),
	(141, 1, '2023-10-20 16:34:05', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNzAwNDk4MDQ1Ljk1MiwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTE2LjAuMC4wIFNhZmFyaS81MzcuMzYgT1BSLzEwMi4wLjAuMCIsImlhdCI6MTY5NzgxOTY0NX0.rin9YZ3lTp-eNJ5thDprZbJMdG0hgmDXOT3Ve0ndRis', '2023-11-20 16:34:05', 1);

-- Dumping structure for table inventory.article
CREATE TABLE IF NOT EXISTS `article` (
  `article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `excerpt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `description` varchar(450) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `concract` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `sap_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`article_id`),
  KEY `fk_article_category_id` (`category_id`),
  CONSTRAINT `fk_article_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.article: ~17 rows (approximately)
INSERT INTO `article` (`article_id`, `name`, `excerpt`, `description`, `concract`, `category_id`, `comment`, `sap_number`) VALUES
	(83, 'ACME SSD HD11 1TB', 'Kratki opis 1', 'Detaljan opis', 'EPU-25154/2022', 8, '', '1300-200200'),
	(84, 'ACME SSD HD11 1024GB', 'Kratki opis', 'Detaljan opis', 'EPU-25154/2022', 8, 'Komentar 1024GB', '1300-200201'),
	(85, 'ACME SSD HD11 1024MB', 'Kratki opis', 'Detaljan opis', 'EPU-25154/2022', 8, 'Komentar 1024MB serverski', '1300-200202'),
	(90, 'ThinkCentre 720S', 'Računar 720S', 'Detaljan opis računara', 'EPU-25158/2022', 9, 'Komentarcicc', '1300-100200'),
	(91, 'HP ProDesk 600 G6', 'Small Form Factor PC', 'Opis računara', 'EPU-232158/2022', 9, '', '1300-1005254'),
	(92, 'ThinkCentre M93', 'Small Form Factor PC', 'Opis računara', 'EPU-233248/2022', 9, '', '1300-1325254'),
	(93, 'HP E24 G4 FHD Monitor', 'HP E24 G4 FHD Monitor', 'Opis monitor', 'EPU-232558/2022', 10, '', 'ZE0687922'),
	(95, 'HP Compaq dc7900 Small Form Factor', 'HP Compaq dc7900 poslovno računalo', 'Energetski učinkovite tehnologije, vodeća rješenja za upravljanje na daljinu i tri fleksibilna faktora oblika dizajnirana da odgovaraju vašim specifičnim poslovnim potrebama -- HP Compaq dc7900 PC stabilna je platforma koja smanjuje troškove posjedovanja.', '0', 9, NULL, '0'),
	(96, 'ThinkCentre M83 SFF Pro Desktop', 'The new small form factor (SFF) pro design features the compactness of the SFF with the expansion ability of a tower. The SFF desktops weigh in at 16.5 lbs / 7.8 kg and support both horizontal and vertical orientations.', 'The new small form factor (SFF) pro design features the compactness of the SFF with the expansion ability of a tower. The SFF desktops weigh in at 16.5 lbs / 7.8 kg and support both horizontal and vertical orientations.', 'EZE-254584/2022', 9, 'Komentare će trebati ukinuti', '1300-005254'),
	(97, 'ThinkCentre M92/M92p Tiny, Small, Tower', 'This Tiny desktop packs a powerful enterprise performance and Intel Pro manageability into an ultra-compact form factor thats energy-efficient and easy to manage.', 'This Tiny desktop packs a powerful enterprise performance and Intel Pro manageability into an ultra-compact form factor thats energy-efficient and easy to manage.', 'EZE-58479/2022', 9, 'Komentare brišemo', '1300-005248'),
	(98, 'ASUS VW199T-P 19"', '19 inča monitor', '19 inča monitor kocka', 'ABA-162819-272/2022', 10, 'Komentare brisemo', '1300-183994'),
	(103, 'Računar Dell OptiPlex 3090 SFF', '', '', '639294 ne znam', 9, NULL, ''),
	(104, 'Philips 170S', 'Monitor Philips', 'Monitor Philips', 'Ugovor 1', 10, NULL, '1300-100000'),
	(105, 'Philips S Line 20', 'Monitor Philips S Line 20"', 'Monitor Philips S Line 20"', 'Ugovor Monitor', 10, NULL, '1300-100001'),
	(106, 'HP Compaq 8200 Elite Small Form Factor PC', 'HP Compaq 8200 Elite Small Form Factor PC je stariji model računara koji je prvobitno pušten u prodaju oko 2011. godine. ', 'HP Compaq 8200 Elite Small Form Factor PC', 'Ugovor računar', 9, NULL, '1300-100002'),
	(107, 'Dell 21,5"', 'Dell 21,5"', 'Dell 21,5"', 'Ugovor Monitori', 10, NULL, '1300-100003'),
	(108, 'HP Compaq L1506', 'Monitor HP Compaq L1506 je stariji model monitora koji je pušten u prodaju oko 2006. godine.', 'Monitor HP Compaq L1506 je osnovni model koji je pružao standardne performanse za osnovne računarske zadatke. Nema naprednih karakteristika ili tehnologija koje biste očekivali na modernijim monitorima.', 'Ugovor monitori', 10, NULL, '1300-100004');

-- Dumping structure for table inventory.article_feature
CREATE TABLE IF NOT EXISTS `article_feature` (
  `article_feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `feature_id` int unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`article_feature_id`),
  UNIQUE KEY `uq_article_feature_article_id_feature_id` (`article_id`,`feature_id`) USING BTREE,
  KEY `fk_article_feature_feature_id` (`feature_id`) USING BTREE,
  CONSTRAINT `fk_article_feature_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_article_feature_feature_id` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`feature_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.article_feature: ~70 rows (approximately)
INSERT INTO `article_feature` (`article_feature_id`, `article_id`, `feature_id`, `value`) VALUES
	(54, 83, 8, '1TB'),
	(55, 83, 9, 'HDD'),
	(64, 84, 8, '1024GB'),
	(65, 84, 9, 'SSD'),
	(68, 85, 8, '1024MB'),
	(69, 85, 9, 'SSD Server'),
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
	(105, 95, 11, 'Intel Core 2 Duo E7200 processor 2.53 GHz, 3 MB L2 cache, 1066 MHz FSB'),
	(107, 95, 14, '256GB'),
	(108, 95, 13, '4GB'),
	(109, 95, 10, 'SFF'),
	(110, 96, 11, 'Intel Core i7-4770'),
	(112, 96, 14, '500GB'),
	(113, 96, 13, '8GB'),
	(114, 96, 10, 'SFF'),
	(355, 102, 23, 'VGA/HDMI/DVI/DP'),
	(356, 102, 20, '1:10000'),
	(357, 102, 19, '24"'),
	(358, 102, 24, '1920:1080'),
	(359, 102, 21, 'nesto'),
	(360, 102, 17, 'FULL HD'),
	(374, 98, 23, 'VGA/DVI x2'),
	(375, 98, 20, '1000000:1'),
	(376, 98, 19, '19"'),
	(377, 98, 24, '1440x900'),
	(383, 97, 11, 'Intel Core i7-3770'),
	(384, 97, 14, '500GB'),
	(385, 97, 13, '4GB'),
	(386, 97, 10, 'SFF'),
	(401, 90, 11, 'Intel I7 7000'),
	(402, 90, 14, '1TB HDD'),
	(403, 90, 13, '16GB'),
	(404, 90, 10, 'SFF radna stanica'),
	(405, 103, 11, 'I5 10500'),
	(406, 103, 14, '256GB SSD'),
	(407, 103, 13, '8GB'),
	(408, 103, 10, 'SFF'),
	(409, 104, 23, 'VGA'),
	(410, 104, 19, '1280*1024'),
	(411, 105, 23, 'VGA'),
	(412, 105, 19, '1280*1024'),
	(413, 105, 22, '20'),
	(414, 106, 11, ' Intel Core i3'),
	(415, 106, 14, '500'),
	(416, 106, 13, '8'),
	(417, 106, 10, 'SFF'),
	(418, 107, 23, 'VGA/HDMI'),
	(419, 107, 19, '1920*1080'),
	(420, 107, 22, '21,5'),
	(421, 108, 23, 'VGA'),
	(422, 108, 20, '400:1'),
	(423, 108, 19, '1024*768'),
	(424, 108, 21, '250 nits'),
	(425, 108, 22, '');

-- Dumping structure for table inventory.article_timeline
CREATE TABLE IF NOT EXISTS `article_timeline` (
  `article_timeline_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `document_id` int unsigned NOT NULL,
  `serial_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` enum('zaduženo','razduženo','otpisano') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'zaduženo',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `inv_broj` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `comment` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`article_timeline_id`),
  UNIQUE KEY `serial_number_status_timestamp` (`serial_number`,`status`,`timestamp`),
  KEY `fk_article_timeline_article` (`article_id`),
  KEY `fk_article_timeline_user` (`user_id`),
  KEY `fk_article_timeline_documents` (`document_id`),
  CONSTRAINT `fk_article_timeline_article` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_article_timeline_documents` FOREIGN KEY (`document_id`) REFERENCES `documents` (`documents_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_article_timeline_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.article_timeline: ~27 rows (approximately)
INSERT INTO `article_timeline` (`article_timeline_id`, `article_id`, `user_id`, `document_id`, `serial_number`, `status`, `timestamp`, `inv_broj`, `comment`) VALUES
	(163, 90, 148, 293, 'S4PT4033', 'zaduženo', '2023-09-25 11:34:42', 'ZE06878665', 'Komentrar'),
	(171, 90, 157, 301, 'S4PT4035', 'zaduženo', '2023-09-26 06:54:04', 'ZE06878661', ''),
	(172, 90, 150, 302, 'S4PT4047', 'zaduženo', '2023-09-26 06:54:41', 'ZE06878666', ''),
	(177, 90, 152, 307, 'S4PT4038', 'zaduženo', '2023-09-28 06:22:07', 'ZE06878662', ''),
	(178, 90, 200, 308, 'S4PT4040', 'zaduženo', '2023-09-28 07:59:58', 'ZE06878664', ''),
	(179, 90, 201, 309, 'S4PT4044', 'zaduženo', '2023-09-28 08:00:43', 'ZE06878663', ''),
	(180, 91, 207, 310, 'CZC1118K7Z', 'zaduženo', '2023-09-28 11:38:42', 'ZG0687167', ''),
	(181, 91, 151, 311, 'CZC1118K6N', 'zaduženo', '2023-09-28 11:39:45', 'ZG0687152', ''),
	(182, 91, 151, 312, 'CZC1118K6N', 'razduženo', '2023-09-28 11:40:36', 'ZG0687152', 'Greška prilikom prvog zaduženje. U startu je ovaj računar bio zadužen na Rašidu Hajdić.'),
	(183, 91, 208, 312, 'CZC1118K6N', 'zaduženo', '2023-09-28 11:40:36', 'ZG0687152', 'Greška prilikom prvog zaduženje. U startu je ovaj računar bio zadužen na Rašidu Hajdić.'),
	(184, 91, 210, 313, 'CZC1118K7L', 'zaduženo', '2023-09-28 12:05:37', 'ZE0687908', ''),
	(185, 91, 209, 314, 'CZC1118K77', 'zaduženo', '2023-09-28 12:05:57', 'ZE0687907', ''),
	(186, 91, 211, 315, 'CZC1118K8N', 'zaduženo', '2023-09-28 12:15:01', 'ZG0687151', ''),
	(187, 93, 209, 316, 'CN41060Z0V', 'zaduženo', '2023-09-28 12:16:34', 'ZE0687920', ''),
	(188, 92, 149, 317, 'S4S54781', 'zaduženo', '2023-09-28 12:19:59', 'ZE0687457', ''),
	(190, 92, 174, 319, 'S4G27223', 'zaduženo', '2023-09-28 12:21:12', 'ZE0687314', ''),
	(191, 92, 175, 320, 'S4G27129', 'zaduženo', '2023-09-28 12:21:36', 'ZE0687342', ''),
	(192, 92, 181, 321, 'S4G27201', 'zaduženo', '2023-09-28 12:22:09', 'ZE0687343', ''),
	(194, 92, 177, 323, 'S4S54522', 'zaduženo', '2023-09-28 12:26:54', 'ZE0687453', ''),
	(195, 92, 186, 324, 'S4S54794', 'zaduženo', '2023-09-28 12:27:55', 'ZG0686649', ''),
	(196, 92, 179, 325, 'S4S54204', 'zaduženo', '2023-09-28 12:28:27', 'ZE0687500', ''),
	(197, 92, 188, 326, 'S4S54766', 'zaduženo', '2023-09-28 12:32:25', 'ZE0687451', ''),
	(198, 92, 173, 327, 'S4S59266', 'zaduženo', '2023-09-28 12:32:53', 'ZE0687443', ''),
	(199, 92, 169, 328, 'S4G27138', 'zaduženo', '2023-09-28 12:33:28', 'ZE0687317', ''),
	(200, 92, 151, 329, 'S4S59287', 'zaduženo', '2023-09-28 12:34:09', 'ZG0686647', ''),
	(201, 92, 212, 330, 'S4S54800', 'zaduženo', '2023-09-28 12:39:01', 'ZG0686648', ''),
	(202, 92, 213, 331, 'S4S41757', 'zaduženo', '2023-09-28 12:39:21', 'ZE0687444', '');

-- Dumping structure for table inventory.category
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `image_path` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `parent__category_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uq_category_name` (`name`),
  UNIQUE KEY `uq_category_image_path` (`image_path`),
  KEY `fk_category_parent__category_id` (`parent__category_id`) USING BTREE,
  CONSTRAINT `FK_category_category` FOREIGN KEY (`parent__category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.category: ~8 rows (approximately)
INSERT INTO `category` (`category_id`, `name`, `image_path`, `parent__category_id`) VALUES
	(7, 'Rač. oprema', 'bi bi-pc-display', NULL),
	(8, 'Memorija pohrane', 'bi bi-hdd', 9),
	(9, 'Radne stanice', 'bi bi-pc-display-horizontal', 7),
	(10, 'Monitor', 'bi bi-display', 7),
	(11, 'Telefoni', 'bi bi-telephone-fill', NULL),
	(12, 'Bežični telefon', 'bi bi-phone-fill', 11),
	(18, 'Žični telefon', 'bi bi-phone', 11),
	(20, 'Miš', 'bi bi-mouse2-fill', 7);

-- Dumping structure for table inventory.debt_items
CREATE TABLE IF NOT EXISTS `debt_items` (
  `debt_items_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_article_id` int unsigned NOT NULL,
  `article_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `document_id` int unsigned NOT NULL,
  `value` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serial_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'razduženo',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `inv_broj` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`debt_items_id`),
  UNIQUE KEY `article_id_user_id_timestamp_serial_number` (`article_id`,`user_id`,`timestamp`,`serial_number`) USING BTREE,
  KEY `fk_debt_items_document_id` (`document_id`),
  KEY `FK_debt_items_user_article` (`user_id`) USING BTREE,
  KEY `fk_debt_items_user_article_id` (`user_article_id`) USING BTREE,
  CONSTRAINT `fk_debt_items_article_di` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_debt_items_document_id` FOREIGN KEY (`document_id`) REFERENCES `documents` (`documents_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_debt_items_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_debt_items_user_article_id` FOREIGN KEY (`user_article_id`) REFERENCES `user_article` (`user_article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.debt_items: ~0 rows (approximately)

-- Dumping structure for table inventory.department
CREATE TABLE IF NOT EXISTS `department` (
  `department_id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'undefined',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `departmend_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'undefined',
  `parent_department_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`department_id`) USING BTREE,
  KEY `FK_department_department` (`parent_department_id`),
  CONSTRAINT `FK_department_department` FOREIGN KEY (`parent_department_id`) REFERENCES `department` (`department_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.department: ~50 rows (approximately)
INSERT INTO `department` (`department_id`, `title`, `description`, `departmend_code`, `parent_department_id`) VALUES
	(2, 'Sektor za IKT', 'Sektor za informacione i komunikacione tehnologije IKT', '1010206', NULL),
	(3, 'Služba za IKT Zenica', 'Sektor za informacione i komunikacione tehnologije IKT Zenica', '101020601', 2),
	(5, 'Sektor za investicije', 'Sektor za investicije', '1030802', NULL),
	(6, 'Služba za pripremu investicija', 'Služba za pripremu investicija', '103080201', 5),
	(7, 'Služba za realizaciju investicija', 'Služba za realizaciju investicija', '103080202', 5),
	(8, 'Služba za imovinsko-pravne odnose', 'Služba za imovinsko-pravne odnose', '103080203', 5),
	(9, 'Odjeljenje za nova prava', 'Odjeljenje za nova prava', '10308020301', 8),
	(10, 'Odjeljenje za postojeću imovinu', 'Odjeljenje za postojeću imovinu', '10308020302', 8),
	(11, 'Sektor za pristup mreži i upravljanje', 'Sektor za pristup mreži i upravljanje', '1030803', NULL),
	(12, 'Služba za pristup mreži', 'Služba za pristup mreži', '103080301', 11),
	(13, 'Služba za upravljanje i operativne analize', '', '103080302', 11),
	(14, 'Odjeljenje za dispečiranje', '', '10308030201', 13),
	(15, 'Odjeljenje za zaštitu i kvalitet električne energije', '', '10308030202', 13),
	(19, 'Ured Direktora', '', '1030801', NULL),
	(20, 'Služba za internu kontrole', '', '103080101', 19),
	(21, 'Služba za odnose s javnošću i informisanje kupaca', '', '103080102', 19),
	(22, 'Sektor obračunskih mjerenja i očitanja', '', '1030805', NULL),
	(23, 'Sektor za ekonomske poslove', '', '1030807', NULL),
	(24, 'Služba za finansije i računovodstvo', '', '103080701', 23),
	(25, 'Služba za komercijalne poslove', '', '103080702', 23),
	(26, 'Sektor za pravne, kadrovske i opće poslove', '', '1030808', NULL),
	(27, 'Služba za pravne i kadrovske poslove', '', '103080801', 26),
	(28, 'Služba za opće poslove', '', '103080802', 26),
	(29, 'Područje snabdjevanja', '', '1040206', NULL),
	(30, 'Služba za obračun', '', '104020601', 29),
	(31, 'Služba za naplatu i utuženja', '', '104020602', 29),
	(32, 'Služba za analitičke evidencije', '', '104020603', 29),
	(33, 'Sektor za tržišno snabdijevanje', '', '10401', NULL),
	(34, 'Služba za sigurnost i zaštitu', 'Služba za sigurnost i zaštitu', '103080103', 19),
	(35, 'Sektor za održavanje mreža i postrojenja', '', '1030804', NULL),
	(36, 'Služba za održavanje mreža i postrojenja', 'Služba za održavanje mreža i postrojenja', '103080401', 35),
	(37, 'Služba za transport', 'Služba za transport', '103080402', 35),
	(38, 'Poslovna jedinica Zenica', 'Poslovna jedinica Zenica', '1030806', NULL),
	(39, 'Poslovna jedinica Doboj Jug', '', '103080611', NULL),
	(40, 'Služba za planiranje, analizu i izvještavanje', '', '', 19),
	(41, 'Odjeljenje za prikupljanje i obradu mjernih podataka', 'Odjeljenje za prikupljanje i obradu mjernih podataka', '103080501', 22),
	(42, 'Odjeljenje za planiranje i održavanje mjernih mjesta ', 'Odjeljenje za planiranje i održavanje mjernih mjesta ', '103080502', 22),
	(43, 'Odjeljenje za pristup mreži', 'Odjeljenje za pristup mreži', '10308060101', 38),
	(44, 'Odjeljenje za upravljanje i održavanje mreža i postrojenja', 'Odjeljenje za upravljanje i održavanje mreža i postrojenja', '10308060102', 38),
	(45, 'Odjeljenje obračunskih mjerenja i očitanja', 'Odjeljenje obračunskih mjerenja i očitanja', '10308060103', 38),
	(46, 'Poslovna jedinica Kakanj', 'Poslovna jedinica Kakanj', '', NULL),
	(47, 'Poslovna jedinica Maglaj', 'Poslovna jedinica Maglaj', '', NULL),
	(48, 'Poslovna jedinica Olovo', 'Poslovna jedinica Olovo', '', NULL),
	(49, 'Poslovna jedinica Tešanj', 'Poslovna jedinica Tešanj', '', NULL),
	(50, 'Poslovna jedinica Vareš', 'Poslovna jedinica Vareš', '', NULL),
	(51, 'Poslovna jedinica Visoko', 'Poslovna jedinica Visoko', '', NULL),
	(52, 'Poslovna jedinica Zavidovići', 'Poslovna jedinica Zavidovići', '', NULL),
	(53, 'Poslovna jedinica Žepče', 'Poslovna jedinica Žepče', '', NULL),
	(54, 'Poslovna jedinica Breza', 'Poslovna jedinica Breza', '', NULL),
	(57, 'Odjeljenje obračuna i naplate električne energije (KA)', '', '', 46);

-- Dumping structure for table inventory.department_job
CREATE TABLE IF NOT EXISTS `department_job` (
  `department_job_id` int unsigned NOT NULL AUTO_INCREMENT,
  `department_id` int unsigned NOT NULL DEFAULT '0',
  `job_id` int unsigned NOT NULL DEFAULT '0',
  `location_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`department_job_id`),
  KEY `department_job_department_id` (`department_id`),
  KEY `department_job_job_id` (`job_id`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `department_job_department_id` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `department_job_job_id` FOREIGN KEY (`job_id`) REFERENCES `job` (`job_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_department_job_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.department_job: ~96 rows (approximately)
INSERT INTO `department_job` (`department_job_id`, `department_id`, `job_id`, `location_id`) VALUES
	(2, 3, 2, 2),
	(13, 5, 7, 2),
	(14, 5, 6, 2),
	(15, 5, 8, 2),
	(16, 2, 9, 2),
	(17, 11, 8, 2),
	(18, 22, 8, 3),
	(19, 23, 8, 2),
	(20, 24, 9, 2),
	(21, 25, 9, 2),
	(22, 6, 9, 2),
	(23, 26, 8, 2),
	(24, 27, 9, 2),
	(27, 28, 9, 2),
	(29, 31, 9, 2),
	(30, 30, 9, 2),
	(31, 29, 8, 2),
	(32, 6, 10, 2),
	(33, 6, 11, 2),
	(34, 19, 12, 2),
	(36, 19, 13, 2),
	(38, 19, 14, 2),
	(40, 19, 15, 2),
	(42, 20, 9, 2),
	(44, 20, 16, 2),
	(46, 20, 16, 2),
	(48, 21, 9, 2),
	(54, 21, 17, 2),
	(55, 34, 18, 2),
	(57, 34, 19, 2),
	(59, 34, 20, 2),
	(61, 6, 9, 2),
	(62, 6, 21, 2),
	(64, 6, 10, 2),
	(65, 6, 11, 2),
	(66, 7, 9, 2),
	(67, 7, 22, 2),
	(68, 7, 23, 2),
	(69, 7, 24, 2),
	(70, 7, 25, 2),
	(71, 7, 26, 2),
	(72, 7, 27, 2),
	(73, 8, 9, 2),
	(74, 9, 28, 2),
	(75, 9, 29, 2),
	(76, 10, 30, 2),
	(77, 7, 9, 2),
	(78, 7, 22, 2),
	(79, 7, 23, 2),
	(80, 7, 24, 2),
	(81, 7, 25, 2),
	(82, 7, 26, 2),
	(83, 7, 27, 2),
	(84, 8, 9, 2),
	(85, 9, 28, 2),
	(86, 9, 29, 2),
	(87, 12, 9, 2),
	(88, 12, 9, 2),
	(90, 12, 32, 2),
	(91, 12, 31, 2),
	(93, 13, 9, 2),
	(101, 13, 33, 2),
	(102, 13, 34, 2),
	(103, 15, 36, 2),
	(104, 15, 37, 2),
	(107, 15, 35, 2),
	(109, 15, 38, 2),
	(110, 35, 8, 2),
	(111, 36, 9, 2),
	(112, 25, 39, 2),
	(113, 25, 40, 2),
	(114, 25, 41, 2),
	(115, 25, 42, 2),
	(116, 25, 43, 2),
	(117, 3, 44, 2),
	(118, 38, 45, 3),
	(119, 39, 45, 38),
	(122, 31, 47, 2),
	(123, 24, 48, 2),
	(124, 44, 52, 36),
	(125, 45, 51, 36),
	(126, 44, 51, 36),
	(127, 54, 45, 36),
	(128, 45, 50, 36),
	(129, 44, 50, 36),
	(130, 32, 49, 36),
	(131, 57, 97, 39),
	(132, 44, 51, 39),
	(133, 32, 56, 39),
	(134, 46, 55, 39),
	(135, 31, 54, 39),
	(136, 41, 53, 39),
	(137, 44, 65, 39),
	(138, 46, 45, 39),
	(139, 32, 57, 39),
	(140, 43, 58, 39);

-- Dumping structure for table inventory.destroyed
CREATE TABLE IF NOT EXISTS `destroyed` (
  `destroyed_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_article_id` int unsigned NOT NULL,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `document_id` int unsigned NOT NULL,
  `value` int NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serial_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'otpisano',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `inv_broj` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`destroyed_id`),
  UNIQUE KEY `article_id_user_id_serial_number` (`article_id`,`user_id`,`serial_number`) USING BTREE,
  KEY `fk_destroyed_document_id` (`document_id`),
  KEY `fk_destroyed_user_id` (`user_id`) USING BTREE,
  KEY `fk_destroyed_user_article_id` (`user_article_id`) USING BTREE,
  CONSTRAINT `fk_destroyed_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_destroyed_document_id` FOREIGN KEY (`document_id`) REFERENCES `documents` (`documents_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_destroyed_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_destroyed_user_article_id` FOREIGN KEY (`user_article_id`) REFERENCES `user_article` (`user_article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.destroyed: ~0 rows (approximately)

-- Dumping structure for table inventory.documents
CREATE TABLE IF NOT EXISTS `documents` (
  `documents_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `document_number` int NOT NULL DEFAULT '0',
  `created_date` datetime NOT NULL DEFAULT (now()),
  PRIMARY KEY (`documents_id`),
  KEY `fk_documents_article_id` (`article_id`),
  CONSTRAINT `fk_documents_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.documents: ~28 rows (approximately)
INSERT INTO `documents` (`documents_id`, `article_id`, `path`, `document_number`, `created_date`) VALUES
	(293, 90, 'prenosnica1.docx', 1, '2023-09-25 13:34:42'),
	(301, 90, 'prenosnica2.docx', 2, '2023-09-26 08:54:04'),
	(302, 90, 'prenosnica3.docx', 3, '2023-09-26 08:54:41'),
	(307, 90, 'prenosnica4.docx', 4, '2023-09-28 08:22:07'),
	(308, 90, 'prenosnica5.docx', 5, '2023-09-28 09:59:58'),
	(309, 90, 'prenosnica6.docx', 6, '2023-09-28 10:00:43'),
	(310, 91, 'prenosnica7.docx', 7, '2023-09-28 13:38:42'),
	(311, 91, 'prenosnica8.docx', 8, '2023-09-28 13:39:45'),
	(312, 91, 'prenosnica9.docx', 9, '2023-09-28 13:40:36'),
	(313, 91, 'prenosnica10.docx', 10, '2023-09-28 14:05:37'),
	(314, 91, 'prenosnica11.docx', 11, '2023-09-28 14:05:57'),
	(315, 91, 'prenosnica12.docx', 12, '2023-09-28 14:15:01'),
	(316, 93, 'prenosnica13.docx', 13, '2023-09-28 14:16:34'),
	(317, 92, 'prenosnica14.docx', 14, '2023-09-28 14:19:59'),
	(319, 92, 'prenosnica16.docx', 16, '2023-09-28 14:21:12'),
	(320, 92, 'prenosnica17.docx', 17, '2023-09-28 14:21:36'),
	(321, 92, 'prenosnica18.docx', 18, '2023-09-28 14:22:09'),
	(323, 92, 'prenosnica19.docx', 19, '2023-09-28 14:26:54'),
	(324, 92, 'prenosnica20.docx', 20, '2023-09-28 14:27:55'),
	(325, 92, 'prenosnica21.docx', 21, '2023-09-28 14:28:27'),
	(326, 92, 'prenosnica22.docx', 22, '2023-09-28 14:32:25'),
	(327, 92, 'prenosnica23.docx', 23, '2023-09-28 14:32:53'),
	(328, 92, 'prenosnica24.docx', 24, '2023-09-28 14:33:28'),
	(329, 92, 'prenosnica25.docx', 25, '2023-09-28 14:34:09'),
	(330, 92, 'prenosnica26.docx', 26, '2023-09-28 14:39:01'),
	(331, 92, 'prenosnica27.docx', 27, '2023-09-28 14:39:21'),
	(332, 92, 'prenosnica28.docx', 28, '2023-09-28 15:02:32'),
	(334, 92, 'prenosnica29.docx', 29, '2023-09-28 15:02:56');

-- Dumping structure for table inventory.feature
CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `uq_feature_category_id_name` (`category_id`,`name`),
  KEY `fk_feature_category_id` (`category_id`) USING BTREE,
  CONSTRAINT `fk_feature_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.feature: ~19 rows (approximately)
INSERT INTO `feature` (`feature_id`, `name`, `category_id`) VALUES
	(8, 'Kapacitet', 8),
	(9, 'Tip', 8),
	(11, 'CPU', 9),
	(51, 'IP Adresa', 9),
	(16, 'MAC', 9),
	(14, 'Memorija', 9),
	(13, 'RAM', 9),
	(10, 'Tip', 9),
	(23, 'Konektori', 10),
	(20, 'Omjer kontrasta', 10),
	(19, 'Rezolucija', 10),
	(24, 'Rezolucija slike', 10),
	(21, 'Svjetlina', 10),
	(22, 'Visina piksela', 10),
	(17, 'Vrsta prikaza', 10),
	(48, 'Proizvo?a?', 12),
	(47, 'Tip', 18),
	(49, 'DPI', 20),
	(50, 'Tip', 20);

-- Dumping structure for table inventory.job
CREATE TABLE IF NOT EXISTS `job` (
  `job_id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'undefined',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `job_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'undefined',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.job: ~91 rows (approximately)
INSERT INTO `job` (`job_id`, `title`, `description`, `job_code`) VALUES
	(2, 'Tehničar za IKT **', 'Tehničar za IKT ** Zenica', '936545'),
	(6, 'Koordinator za GIS', 'Koordinator za GIS', 'undefined'),
	(7, 'Projekt menadžer', 'Projekt menadžer', 'undefined'),
	(8, 'Rukovodilac sektora', 'Rukovodilac sektora', 'undefined'),
	(9, 'Rukovodilac službe', 'Rukovodilac službe', 'undefined'),
	(10, 'Referent za pripremu investicija', '', ''),
	(11, 'Stručni saradnik za pripremu investicija', '', ''),
	(12, 'Direktor', 'Direktor podružnice ED Zenica', ''),
	(13, 'Tehnički direktor', 'Tehnički direktor podružnice ED Zenica', ''),
	(14, 'Tehnički sekretar', 'Tehnički sekretar Ureda Direktora', ''),
	(15, 'Pomoćnik direktora', 'Pomoćnik direktora ED Zenica', ''),
	(16, 'Samostalni referent za kontrolu**', '', ''),
	(17, 'Referent za odnose sa javnošću i informisanje kupaca', '', ''),
	(18, 'Stručni saradnik za zaštitu zdravlja i sigurnost na radu', 'Stručni saradnik za zaštitu zdravlja i sigurnost na radu', ''),
	(19, 'Stručni saradnik za okolinsko upravljanje', 'Stručni saradnik za okolinsko upravljanje', ''),
	(20, 'Stručni saradnik za sigurnost, protivpožarnu zaštitu i spašavanje', 'Stručni saradnik za sigurnost, protivpožarnu zaštitu i spašavanje', ''),
	(21, 'Projektant', '', ''),
	(22, 'Inženjer za građevinski nadzor', 'Inženjer za građevinski nadzor', ''),
	(23, 'Stručni saradnik za priključenja', 'Stručni saradnik za priključenja', ''),
	(24, 'Stručni saradnik za priključenja - rang 1', 'Stručni saradnik za priključenja - rang 1', ''),
	(25, 'Stručni saradnik za realizaciju investicija', 'Stručni saradnik za realizaciju investicija', ''),
	(26, 'Referent za investicije', 'Referent za investicije', ''),
	(27, 'Referent za priključenja', 'Referent za priključenja', ''),
	(28, 'Stručni saradnik za rješavanje imovinsko-pravnih odnosa u procesu realizacije investicija,rang 3', 'Stručni saradnik za rješavanje imovinsko-pravnih odnosa u procesu realizacije investicija,rang 3', ''),
	(29, 'Stručni sradanik za rješavanje imovinsko pravnih odnosa u procesu realizacije investicija', 'Stručni sradanik za rješavanje imovinsko pravnih odnosa u procesu realizacije investicija', ''),
	(30, 'Stručni saradnik za stvarna prava na postojećoj imovini, Rang 1', 'Stručni saradnik za stvarna  prava na postojećoj imovini, Rang 1', ''),
	(31, 'Inženjer za pristup mreži, rang 2', 'Inženjer za pristup mreži, rang 2', ''),
	(32, 'Inženjer za pristup mreži', 'Inženjer za pristup mreži', ''),
	(33, 'Dispečer za srednji i niski napon', 'Dispečer za srednji i niski napon', ''),
	(34, 'Glavni dispečer', 'Glavni dispečer', ''),
	(35, 'Inženjer za zaštitu i kvalitet električne energije', 'Inženjer za zaštitu i kvalitet električne energije', ''),
	(36, 'Vodeći elektromehaničar *', 'Vodeći elektromehaničar *', ''),
	(37, 'Tehničar za ispitivanja **', 'Tehničar za ispitivanja **', ''),
	(38, 'Tehničar za pripremu', 'Tehničar za pripremu', ''),
	(39, 'Samostalni referent nabavke*', 'Samostalni referent nabavke*', ''),
	(40, 'Stručni saradnik za nabavku i ugovaranje', 'Stručni saradnik za nabavku i ugovaranje', ''),
	(41, 'Vodeći skladištar**', 'Vodeći skladištar**', ''),
	(42, 'Vodeći skladištar', 'Vodeći skladištar', ''),
	(43, 'Referent za računovodstvo**', 'Referent za računovodstvo**', ''),
	(44, 'Stručni saradnik za održavanje IKT servis i infrastrukture', 'Stručni saradnik za održavanje IKT servis i infrastrukture', ''),
	(45, 'Rukovodilac Poslovne Jedinice', '', ''),
	(46, 'Stručni saradnik za planiranje i izvještavanje', '', ''),
	(47, 'Vodeći referent za naplatu i utuženja*', '', ''),
	(48, 'Stručni suradnik za finansijske i računovodstvene poslove', 'Stručni suradnik za finansijske i računovodstvene poslove', 'undefined'),
	(49, 'Vodeći referent za analitičke evidencije', 'Vodeći referent za analitičke evidencije', ''),
	(50, 'Vodeći elektromonter', 'Vodeći elektromonter\n', ''),
	(51, 'Elektromonter**', 'Elektromonter**', ''),
	(52, 'Elektromonter', 'Elektromonter', ''),
	(53, 'Referent za prikupljanje i obradu mjerni', 'Referent za prikupljanje i obradu mjerni', ''),
	(54, 'Referent za naplatu i utuženja*', 'Referent za naplatu i utuženja*', ''),
	(55, 'Referent za ekonomske i opće poslove', 'Referent za ekonomske i opće poslove', ''),
	(56, 'Referent za analitičke evidencije**', 'Referent za analitičke evidencije**', ''),
	(57, 'Samostalni referent za analitičke evid*', 'Samostalni referent za analitičke evidencije *', ''),
	(58, 'Samostalni tehničar za pristup mreži *', 'Samostalni tehničar za pristup mreži *', ''),
	(59, 'Inženjer za priključenja*', 'Inženjer za priključenja*', ''),
	(60, 'Referent za obračun*', 'Referent za obračun*', ''),
	(61, 'Tehničar za pristup mreži', 'Tehničar za pristup mreži', ''),
	(62, 'Samostalni referent za obračun*', 'Samostalni referent za obračun*', ''),
	(63, 'Stručni saradnik za planiranje i održavanje', 'Stručni saradnik za planiranje i održavanje', ''),
	(64, 'Referent za pripremu**', 'Referent za pripremu**', ''),
	(65, 'Referent za pripremu', 'Referent za pripremu', ''),
	(66, 'Vodeći referent za obračun*', 'Vodeći referent za obračun*', ''),
	(67, 'Samostalni referent za naplatu i utuženja*', 'Samostalni referent za naplatu i utuženja*', ''),
	(68, 'Vodeći elektromonter**', 'Vodeći elektromonter**', ''),
	(69, 'Dispečer za srednji i niski napon*', 'Dispečer za srednji i niski napon*', ''),
	(71, 'Inženjer za mreže i postrojenja', 'Inženjer za mreže i postrojenja', ''),
	(72, 'Mašinista hidromehaničke opreme', 'Mašinista hidromehaničke opreme', ''),
	(73, 'Referent za odnose sa javnošću i komunikacije', 'Referent za odnose sa javnošću i komunikacije', ''),
	(74, 'Stručni saradnik za  prikupljanje i obradu MM', 'Stručni saradnik za  prikupljanje i obradu mjernih mjesta', ''),
	(75, 'Tehničar za ispitivanja **', 'Tehničar za ispitivanja **', ''),
	(76, 'Tehničar za pripremu', 'Tehničar za pripremu', ''),
	(77, 'Vodeći automehaničar-kontrolor *', 'Vodeći automehaničar-kontrolor *', ''),
	(79, 'Inženjer za nadzor i investicije', 'Inženjer za nadzor i investicije', ''),
	(80, 'Referent općih poslova **', 'Referent općih poslova **', ''),
	(81, 'Referent za finansije', 'Referent za finansije', ''),
	(82, 'Referent za kadrovske poslove', 'Referent za kadrovske poslove', ''),
	(83, 'Referent za upravno-administrativne poslove', 'Referent za upravno-administrativne poslove', ''),
	(84, 'Rukovodilac područja', 'Rukovodilac područja', ''),
	(85, 'Voditelj protokola', 'Voditelj protokola', ''),
	(86, 'Vodeći referent za računovodstvo *', 'Vodeći referent za računovodstvo *', ''),
	(87, 'Vodeći referent općih poslova*', 'Vodeći referent općih poslova*', ''),
	(88, 'Vođa smjene', 'Vođa smjene', ''),
	(89, 'Stručni saradnik za priključenja **', 'Stručni saradnik za priključenja **', ''),
	(90, 'Stručni saradnik za analitičke evidencije', 'Stručni saradnik za analitičke evidencije', ''),
	(91, 'Stručni saradnik za naplatu i utuženja', 'Stručni saradnik za naplatu i utuženja', ''),
	(92, 'Stručni saradnik za obračun i realizaciju', 'Stručni saradnik za obračun i realizaciju', ''),
	(93, 'Stručni saradnik za planiranje analizu', 'Stručni saradnik za planiranje analizu', ''),
	(94, 'Stručni saradnik za podršku i održavanje', 'Stručni saradnik za podršku i održavanje', ''),
	(95, 'Stručni saradnik za pravne i kadrovske poslove', 'Stručni saradnik za pravne i kadrovske poslove', ''),
	(96, 'Stručni saradnik za tržišne operacije', 'Stručni saradnik za tržišne operacije', ''),
	(97, 'Referent za obračun i naplatu', '', '');

-- Dumping structure for table inventory.location
CREATE TABLE IF NOT EXISTS `location` (
  `location_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `parent_location_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  KEY `FK_location_location` (`parent_location_id`),
  CONSTRAINT `FK_location_location` FOREIGN KEY (`parent_location_id`) REFERENCES `location` (`location_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.location: ~14 rows (approximately)
INSERT INTO `location` (`location_id`, `name`, `code`, `parent_location_id`) VALUES
	(1, 'ED Zenica', '101', NULL),
	(2, 'Direkcija Zenica', '103', 1),
	(3, 'PJD Zenica', '10303', 1),
	(34, 'PJD Visoko', '105', 1),
	(35, 'PJD Maglaj', '103080607', 1),
	(36, 'PJD Breza', '103080604', 1),
	(37, 'PJD Zenica', '', 1),
	(38, 'PJD Doboj Jug', '', 1),
	(39, 'PJD Kakanj', '', 1),
	(40, 'PJD Vareš', '', 1),
	(41, 'PJD Olovo', '', 1),
	(42, 'PJD Begov Han', '', 1),
	(43, 'PJD Zavidovići', '', 1),
	(45, 'PJD Tešanj', '', 1);

-- Dumping structure for table inventory.responsibility
CREATE TABLE IF NOT EXISTS `responsibility` (
  `responsibility_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_article_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `document_id` int unsigned NOT NULL,
  `value` int NOT NULL DEFAULT '0',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'zaduženo',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serial_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `inv_broj` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`responsibility_id`) USING BTREE,
  UNIQUE KEY `user_id_article_id_serial_number` (`user_id`,`article_id`,`serial_number`) USING BTREE,
  KEY `FK_104` (`article_id`),
  KEY `fk_responsibility_document_id` (`document_id`),
  KEY `FK_92` (`user_id`) USING BTREE,
  KEY `fk_responsibility_user_article_id` (`user_article_id`) USING BTREE,
  CONSTRAINT `fk_responsibility_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_responsibility_document_id` FOREIGN KEY (`document_id`) REFERENCES `documents` (`documents_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_responsibility_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_responsibility_user_article_id` FOREIGN KEY (`user_article_id`) REFERENCES `user_article` (`user_article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.responsibility: ~25 rows (approximately)
INSERT INTO `responsibility` (`responsibility_id`, `user_article_id`, `user_id`, `article_id`, `document_id`, `value`, `status`, `timestamp`, `serial_number`, `inv_broj`) VALUES
	(151, 290, 148, 90, 293, 1, 'zaduženo', '2023-09-25 11:34:42', 'S4PT4033', 'ZE06878665'),
	(159, 298, 157, 90, 301, 1, 'zaduženo', '2023-09-26 06:54:04', 'S4PT4035', 'ZE06878661'),
	(160, 299, 150, 90, 302, 1, 'zaduženo', '2023-09-26 06:54:41', 'S4PT4047', 'ZE06878666'),
	(165, 304, 152, 90, 307, 1, 'zaduženo', '2023-09-28 06:22:07', 'S4PT4038', 'ZE06878662'),
	(166, 305, 200, 90, 308, 1, 'zaduženo', '2023-09-28 07:59:58', 'S4PT4040', 'ZE06878664'),
	(167, 306, 201, 90, 309, 1, 'zaduženo', '2023-09-28 08:00:43', 'S4PT4044', 'ZE06878663'),
	(168, 307, 207, 91, 310, 1, 'zaduženo', '2023-09-28 11:38:42', 'CZC1118K7Z', 'ZG0687167'),
	(169, 308, 208, 91, 312, 1, 'zaduženo', '2023-09-28 11:39:45', 'CZC1118K6N', 'ZG0687152'),
	(170, 309, 210, 91, 313, 1, 'zaduženo', '2023-09-28 12:05:37', 'CZC1118K7L', 'ZE0687908'),
	(171, 310, 209, 91, 314, 1, 'zaduženo', '2023-09-28 12:05:57', 'CZC1118K77', 'ZE0687907'),
	(172, 311, 211, 91, 315, 1, 'zaduženo', '2023-09-28 12:15:01', 'CZC1118K8N', 'ZG0687151'),
	(173, 312, 209, 93, 316, 1, 'zaduženo', '2023-09-28 12:16:34', 'CN41060Z0V', 'ZE0687920'),
	(174, 313, 149, 92, 317, 1, 'zaduženo', '2023-09-28 12:19:59', 'S4S54781', 'ZE0687457'),
	(176, 315, 174, 92, 319, 1, 'zaduženo', '2023-09-28 12:21:12', 'S4G27223', 'ZE0687314'),
	(177, 316, 175, 92, 320, 1, 'zaduženo', '2023-09-28 12:21:36', 'S4G27129', 'ZE0687342'),
	(178, 317, 181, 92, 321, 1, 'zaduženo', '2023-09-28 12:22:09', 'S4G27201', 'ZE0687343'),
	(180, 319, 177, 92, 323, 1, 'zaduženo', '2023-09-28 12:26:54', 'S4S54522', 'ZE0687453'),
	(181, 320, 186, 92, 324, 1, 'zaduženo', '2023-09-28 12:27:55', 'S4S54794', 'ZG0686649'),
	(182, 321, 179, 92, 325, 1, 'zaduženo', '2023-09-28 12:28:27', 'S4S54204', 'ZE0687500'),
	(183, 322, 188, 92, 326, 1, 'zaduženo', '2023-09-28 12:32:25', 'S4S54766', 'ZE0687451'),
	(184, 323, 173, 92, 327, 1, 'zaduženo', '2023-09-28 12:32:53', 'S4S59266', 'ZE0687443'),
	(185, 324, 169, 92, 328, 1, 'zaduženo', '2023-09-28 12:33:28', 'S4G27138', 'ZE0687317'),
	(186, 325, 151, 92, 329, 1, 'zaduženo', '2023-09-28 12:34:09', 'S4S59287', 'ZG0686647'),
	(187, 326, 212, 92, 330, 1, 'zaduženo', '2023-09-28 12:39:01', 'S4S54800', 'ZG0686648'),
	(188, 327, 213, 92, 331, 1, 'zaduženo', '2023-09-28 12:39:21', 'S4S41757', 'ZE0687444');

-- Dumping structure for table inventory.stock
CREATE TABLE IF NOT EXISTS `stock` (
  `stock_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `value_on_concract` int NOT NULL DEFAULT '0',
  `value_available` int NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sap_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`stock_id`),
  KEY `fk_stock_article_id` (`article_id`),
  CONSTRAINT `fk_stock_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.stock: ~18 rows (approximately)
INSERT INTO `stock` (`stock_id`, `article_id`, `value_on_concract`, `value_available`, `timestamp`, `sap_number`) VALUES
	(217, 84, 50, 38, '2022-03-18 14:42:55', '1300-200201'),
	(360, 97, 32, 32, '2022-03-31 16:05:38', '1300-005248'),
	(367, 85, 15, 14, '2022-03-31 17:58:45', '1300-200202'),
	(434, 102, 131, 2, '2022-10-22 17:26:31', 'ZE06879222'),
	(437, 83, 50, 29, '2022-10-22 17:41:16', '1300-200205'),
	(442, 95, 91, 91, '2022-11-13 18:32:47', '1300-551455'),
	(445, 96, 33, 33, '2022-11-13 23:36:20', '1300-005254'),
	(449, 103, 23, 23, '2022-11-26 09:09:37', ''),
	(454, 98, 24, 24, '2023-09-15 13:38:15', '1300-183994'),
	(460, 104, 37, 37, '2023-09-22 13:32:37', '1300-100000'),
	(461, 105, 27, 27, '2023-09-22 13:34:43', '1300-100001'),
	(462, 106, 18, 18, '2023-09-22 13:38:31', '1300-100002'),
	(463, 107, 31, 31, '2023-09-22 13:49:58', '1300-100003'),
	(464, 108, 3, 3, '2023-09-22 13:52:59', '1300-100004'),
	(481, 90, 6, 0, '2023-09-28 08:00:43', '1300-100200'),
	(486, 91, 10, 5, '2023-09-28 12:15:01', '1300-100525'),
	(487, 93, 13, 12, '2023-09-28 12:16:34', 'ZE0687922'),
	(504, 92, 31, 18, '2023-09-28 13:02:58', '1300-132525');

-- Dumping structure for table inventory.upgrade_feature
CREATE TABLE IF NOT EXISTS `upgrade_feature` (
  `upgrade_feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `value` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `serial_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `article_id` int unsigned NOT NULL,
  PRIMARY KEY (`upgrade_feature_id`),
  KEY `fk_upgrade_feature_serial_number_user_article_serial_number` (`serial_number`),
  KEY `upgrade_feature_article_id_article_article_id` (`article_id`),
  CONSTRAINT `upgrade_feature_article_id_article_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.upgrade_feature: ~6 rows (approximately)
INSERT INTO `upgrade_feature` (`upgrade_feature_id`, `name`, `value`, `timestamp`, `comment`, `serial_number`, `article_id`) VALUES
	(3, 'SSD', '256GB', '2022-07-14 10:08:32', 'Ugrađen SSD 256GB, ostavljen HDD 500GB zbog podataka. Urađeno detaljno čišćenje radne stanice.', 'KJKSZPJJJ', 92),
	(4, 'HDD', '500GB', '2022-10-21 18:05:27', 'Ugrađen HDD iz starog računara zbog podataka.', '51738FEN', 90),
	(5, 'SSD', '256 GB', '2022-11-13 22:53:30', 'Izvađen stari HDD od 500GB te umjesto njega ugrađen SDD 256GB', 'KJKSZPJ', 90),
	(6, 'SSD', '512GB', '2022-11-20 23:29:49', 'Test', 'KJKSZPJ', 90),
	(7, 'SSD', '256GB', '2023-10-09 22:41:48', 'Ugrađen SSD kapaciteta od 256GB na zahtjev korisnika pod SD#6482948', 'S4PT4033', 90),
	(9, 'SSD', '512', '2023-10-11 13:26:11', 'Sefteđija', 'S4S54522', 92);

-- Dumping structure for table inventory.user
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `surname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `forname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `fullname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `local_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `telephone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `job_id` int unsigned NOT NULL,
  `department_id` int unsigned NOT NULL,
  `location_id` int unsigned NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `fk_user_job_id` (`job_id`),
  KEY `fk_user_department_id` (`department_id`),
  KEY `fk_user_location_id` (`location_id`),
  CONSTRAINT `fk_user_department_id` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_user_job_id` FOREIGN KEY (`job_id`) REFERENCES `job` (`job_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_user_location_id` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.user: ~88 rows (approximately)
INSERT INTO `user` (`user_id`, `surname`, `forname`, `fullname`, `local_number`, `telephone`, `email`, `password_hash`, `job_id`, `department_id`, `location_id`) VALUES
	(148, 'Mudžahid', 'Cerić', 'Cerić Mudžahid', '1696', '032/449-696', 'm.ceric@epbih.ba', 'A8E11064F018205C700B163E6AB9978077A5DF871F03AD1A43A569CC2D88957B1E44C92EE07EDBBC6523114B37002FE6BDEC5C7F4C03F1C87782312894DE3CB5', 2, 3, 2),
	(149, 'Sabit', 'Alić', 'Alić Sabit', '1608', '032/449-608', 's.alic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 7, 5, 2),
	(150, 'Emina', 'Hasić', 'Hasić Emina', '1613', '032/449-613', 'e.hasic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 6, 5, 2),
	(151, 'Zahid', 'Softić', 'Softić Zahid', '1682', '032/449-682', 'z.softic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 8, 5, 2),
	(152, 'Lejla', 'Pojskić', 'Pojskić Lejla', '1618', '032/449-618', 'l.carsimamovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 2, 2),
	(153, 'Kenan', 'Serdarević', 'Serdarević Kenan', '1617', '032/449-617', 'k.serdarevic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 8, 11, 2),
	(154, 'Lejla', 'Buza', 'Buza Lejla', '1651', '032/449-651', 'le.buza@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 27, 2),
	(155, 'Damir', 'Čauš', 'Čauš Damir', '1673', '032/449-673', 'd.caus@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 28, 2),
	(156, 'Edin', 'Arnaut', 'Arnaut Edin', '1601', '032/449-601', 'e.arnaut@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 12, 19, 2),
	(157, 'Ahmed', 'Mutapčić', 'Mutapčić Ahmed', '1602', '032-449-602', 'a.mutapcic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 13, 19, 2),
	(158, 'Azra', 'Talić', 'Talić Azra', '1603', '032/449-603', 'a.talic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 14, 19, 2),
	(159, 'Nedžad', 'Osmanović', 'Osmanović Nedžad', '1560', '032/449-560', 'ne.osmanovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 15, 19, 2),
	(160, 'Dženana', 'Skomorac - Kos', 'Skomorac - Kos Dženana', '1648', '032/449-648', 'dz.skomorac@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 20, 2),
	(161, 'Jasmin', 'Ćatić', 'Ćatić Jasmin', '1501', '032/449-501', 'j.catic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 16, 20, 2),
	(162, 'Asaf', 'Kajmaković', 'Kajmaković Asaf', '1501', '032/449-501', 'a.kajmakovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 16, 20, 2),
	(163, 'Raif', 'Mešić', 'Mešić Raif', '1501', '032/449-501', 'r.mesic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 16, 20, 2),
	(164, 'Halid', 'Zukić', 'Zukić Halid', '1657', '032/449-657', 'h.zukic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 21, 2),
	(165, 'Goran', 'Skočilić', 'Skočilić Goran', '1556', '032/449-556', 'g.skocilic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 17, 21, 2),
	(166, 'Nermin', 'Skenderović', 'Skenderović Nermin', '1557', '032/449-557', 'n.skenderovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 17, 21, 2),
	(167, 'Nihad', 'Kesić', 'Kesić Nihad', '1558', '032/449-558', 'n.kesic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 17, 21, 2),
	(168, 'Mirnes', 'Kaknjo', 'Kaknjo Mirnes', '1559', '032/449-559', 'm.kaknjo@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 17, 21, 2),
	(169, 'Enes', 'Krdžalić', 'Krdžalić Enes', '1612', '032/449-612', 'e.krdzalic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 18, 34, 2),
	(170, 'Edin', 'Kovač', 'Kovač Edin', '1612', '032/449-612', 'e.kovac@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 19, 34, 2),
	(171, 'Adnan', 'Ibreljić', 'Ibreljić Adnan', '1658', '032/449-658', 'a.ibreljic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 20, 34, 2),
	(172, 'Ernes', 'Bedak', 'Bedak Ernes', '1611', '032/449-611', 'e.bedak@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 6, 2),
	(173, 'Armin', 'Bašić', 'Bašić Armin', '1611', '032/449-611', 'ar.basic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 21, 6, 2),
	(174, 'Mirha', 'Ćatić', 'Ćatić Mirha', '1615', '032/449-615', 'm.catic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 10, 6, 2),
	(175, 'Mirha', 'Bašić', 'Bašić Mirha', '1614', '032/449-614', 'mirha.basic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 11, 6, 2),
	(176, 'Mirsad', 'Bečić', 'Bečić Mirsad', '1610', '032/449-610', 'm.becic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 7, 2),
	(177, 'Adis', 'Redžepović', 'Redžepović Adis', '1697', '032/449-697', 'a.redzepovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 22, 7, 2),
	(178, 'Amina', 'Kavazovic', 'Kavazovic Amina', '1694', '032/449-694', 'a.kavazovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 23, 7, 2),
	(179, 'Jasmina', 'Karić', 'Karić Jasmina', '1607', '032/449-607', 'j.cucukovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 24, 7, 2),
	(180, 'Armin', 'Maličbegović', 'Maličbegović Armin', '1609', '032/449-609', 'a.mlicbegovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 25, 7, 2),
	(181, 'Mirhat', 'Đuherić', 'Đuherić Mirhat', '1677', '032/449-677', 'm.dzuheric@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 26, 7, 2),
	(182, 'Rukija', 'Huseinspahić', 'Huseinspahić Rukija', '1622', '032/449-622', 'r.huseinspahic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 27, 7, 2),
	(183, 'Amra', 'Imamović', 'Imamović Amra', '1678', '032/449-678', 'am.imamovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 8, 2),
	(184, 'Sead', 'Kratina', 'Kratina Sead', '1606', '032/449-606', 's.kratina@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 28, 9, 2),
	(185, 'Smaragda', 'Imamović', 'Imamović Smaragda', '1606', '032/449-606', 's.imamovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 29, 9, 2),
	(186, 'Benjamin', 'Kovačević', 'Kovačević Benjamin', '1679', '032/449-679', 'b.kovacevuc@epbih.ba', 'D8C078577BE9F6B3F869EBF5E2E19009FFDF74C7BD3821BD6A8D0745F922E09A33C3AD3C41FEB58E5DC8B625E96CF39FF91416FDA190A362E5E9B1ABAE1AECEF', 9, 12, 2),
	(187, 'Kenan', 'Dželo', 'Dželo Kenan', '1619', '032/449-619', 'k.dzelo@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 31, 12, 2),
	(188, 'Asmir', 'Džidić', 'Džidić Asmir', '1674', '032/449-674', 'a.dzidic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 32, 12, 2),
	(189, 'Igor', 'Primorac', 'Primorac Igor', '1553', '032/449-553', 'i.primorac@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 13, 2),
	(190, 'Senad', 'Čaušević', 'Čaušević Senad', '1551', '032/449-551', 's.causevic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 33, 13, 2),
	(191, 'Hazim', 'Durmić', 'Durmić Hazim', '1551', '032/449-551', 'h.durmic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 33, 13, 2),
	(192, 'Samrudin', 'Kubat', 'Kubat Samrudin', '1551', '032/449-551', 'k.samrudin@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 33, 13, 2),
	(193, 'Samir', 'Kadić', 'Kadić Samir', '1552', '032/449-552', 's.kadic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 33, 13, 2),
	(194, 'Enes', 'Malkoć', 'Malkoć Enes', '1552', '032/449-552', 'e.malkoc@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 33, 13, 2),
	(195, 'Mirza', 'Serdarević', 'Serdarević Mirza', '1698', '032/449-698', 'm.serdarevic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 34, 13, 2),
	(196, 'Edin', 'Opardija', 'Opardija Edin', '1516', '032/449-516', 'e.opardija@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 35, 15, 3),
	(197, 'Ermin', 'Husagić', 'Husagić Ermin', '1518', '032/449-518', 'e.husagic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 36, 15, 3),
	(198, 'Admir', 'Nizamic', 'Nizamic Admir', '1518', '032/449-518', 'a.nizamic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 37, 15, 3),
	(199, 'Amel', 'Čajdrić', 'Čajdrić Amel', '1519', '032/449-519', 'a.cajdric@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 36, 3),
	(200, 'Amar', 'Kasap', 'Kasap Amar', '1666', '032/449-666', 'a.kasap@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 25, 2),
	(201, 'Hedina', 'Čaušević', 'Čaušević Hedina', '1635', '032/449-635', 'he.causevic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 39, 25, 2),
	(202, 'Senad', 'Ćatić', 'Ćatić Senad', '60847', '032/609-847', 'se.catic@elektroprivreda.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 42, 25, 35),
	(203, 'Kemal', 'Dautbegović', 'Dautbegović Kemal', '1641', '032/449-641', 'k.dautbegovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 40, 25, 2),
	(204, 'Edin', 'Heremić', 'Heremić Edin', '1532', '032/449-532', 'e.heremic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 41, 25, 3),
	(205, 'Subhija', 'Muharemović', 'Muharemović Subhija', '1636', '032/449-636', 's.muharemovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 40, 25, 2),
	(206, 'Mustafa', 'Omanović', 'Omanović Mustafa', '61080', '032/786-080', 'm.omanovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 42, 25, 36),
	(207, 'Amra', 'Pojskić', 'Pojskić Amra', '1621', '032/449-621', 'a.pojskic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 8, 29, 2),
	(208, 'Rašida', 'Hajdić', 'Hajdić Rašida', '1615', '032/449-615', 'r.hajdic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 32, 12, 2),
	(209, 'Emir', 'Hedžić', 'Hedžić Emir', '1654', '032/449-654', 'e.hedzic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 44, 3, 2),
	(210, 'Evel', 'Subašić', 'Subašić Evel', '1653', '062/449-653', 'evels@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 44, 3, 2),
	(211, 'Aidin', 'Pripoljac', 'Pripoljac Aidin', '1561', '032/449-561', 'a.pripoljac@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 45, 38, 37),
	(212, 'Tarik', 'Krivokapa', 'Krivokapa Tarik', '1615', '032/449-615', 't.krivokapa@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 11, 6, 2),
	(213, 'Vedad', 'Smailbegović', 'Smailbegović Vedad', '1619', '032/449-619', 'v.smailbegovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 32, 12, 2),
	(214, 'Irfan', 'Vilašević', 'Vilašević Irfan', '61700', '032/699-700', 'v.irfan@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 45, 39, 38),
	(215, 'Amina', 'Alibašić', 'Alibašić Amina', '1640', '032/449-640', 'a.alibasic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 46, 40, 2),
	(216, 'Derviša', 'Kalčo', 'Kalčo Derviša', '1640', '032/449-640', 'd.kalco@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 48, 24, 2),
	(217, 'Emira', 'Brajlović', 'Brajlović Emira', '1625', '032/449-625', 'em.brajlovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 47, 31, 2),
	(218, 'Mahir', 'Nurudinović', 'Nurudinović Mahir', '', '', 'm.nurudinovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 52, 44, 36),
	(219, 'Sanel', 'Begić', 'Begić Sanel', '', '', 's.begic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 51, 45, 36),
	(220, 'Nijaz', 'Ćosić', 'Ćosić Nijaz', '', '', 'n.cosic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 51, 44, 36),
	(221, 'Emir', 'Hrnjić', 'Hrnjić Emir', '', '', 'e.hrnjic@epbih.ba', 'CF83E1357EEFB8BDF1542850D66D8007D620E4050B5715DC83F4A921D36CE9CE47D0D13C5D85F2B0FF8318D2877EEC2F63B931BD47417A81A538327AF927DA3E', 45, 54, 36),
	(222, 'Hasan', 'Blažević', 'Blažević Hasan', '', '', 'h.blazevic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 50, 45, 36),
	(223, 'Omer', 'Dedić', 'Dedić Omer', '', '', 'o.dedic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 50, 44, 36),
	(224, 'Amina', 'Šabanović', 'Šabanović Amina', '', '', 'a.sabanovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 49, 32, 36),
	(225, 'Adis', 'Aslani', 'Aslani Adis', '', '', 'a.aslani@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 97, 57, 39),
	(226, 'Nedžad', 'Begić', 'Begić Nedžad', '', '', 'nedz.begic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 51, 44, 39),
	(227, 'Elvedina', 'Subašić', 'Subašić Elvedina', '', '', 'elv.subasic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 56, 32, 39),
	(228, 'Mufida', 'Mušija', 'Mušija Mufida', '', '', 'm.musija@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 55, 46, 39),
	(229, 'Binela', 'Trako', 'Trako Binela', '', '', 'b.trako@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 54, 31, 39),
	(230, 'Edina', 'Mehanović', 'Mehanović Edina', '', '', 'e.mehanovic@epbih.ba', '46BA74B0B0C2008A4CEBFAB218A713F46486305777B6FE3AD8D13003F9D551B1754EABD8984F63D93F366E793C8913670E5BC113CCEB0CC3D9970F0904C66D54', 53, 41, 39),
	(231, 'Mahir', 'Lopo', 'Lopo Mahir', '', '', 'ma.lopo@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 65, 44, 39),
	(232, 'Adnan', 'Husika', 'Husika Adnan', '', '', 'ad.husika@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 45, 46, 39),
	(233, 'Indira', 'Čaluk', 'Čaluk Indira', '', '', 'i.caluk@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 57, 32, 39),
	(234, 'Zijad', 'Kovač', 'Kovač Zijad', '', '', 'zi.kovac@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 58, 43, 39),
	(235, 'Dzemal', 'Pačariz', 'Pačariz Dzemal', '', '', 'dz.pacariz@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 50, 45, 39);

-- Dumping structure for table inventory.user_article
CREATE TABLE IF NOT EXISTS `user_article` (
  `user_article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL,
  `document_id` int unsigned NOT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `serial_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `status` enum('zaduženo','razduženo','otpisano') CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'zaduženo',
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `inv_broj` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `value` int DEFAULT NULL,
  PRIMARY KEY (`user_article_id`) USING BTREE,
  UNIQUE KEY `serial_number_status_timestamp` (`serial_number`,`status`,`timestamp`),
  KEY `fk_user_article_article_id` (`article_id`),
  KEY `fk_user_article_document_id` (`document_id`),
  KEY `fk_user_article_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `fk_user_article_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_user_article_document_id` FOREIGN KEY (`document_id`) REFERENCES `documents` (`documents_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_user_article_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.user_article: ~25 rows (approximately)
INSERT INTO `user_article` (`user_article_id`, `article_id`, `document_id`, `user_id`, `serial_number`, `status`, `timestamp`, `comment`, `inv_broj`, `value`) VALUES
	(290, 90, 293, 148, 'S4PT4033', 'zaduženo', '2023-09-25 11:34:42', 'Zaduženje nove opreme', 'ZE06878665', 1),
	(298, 90, 301, 157, 'S4PT4035', 'zaduženo', '2023-09-26 06:54:04', 'Zaduženje nove opreme', 'ZE06878661', 1),
	(299, 90, 302, 150, 'S4PT4047', 'zaduženo', '2023-09-26 06:54:41', 'Zaduženje nove opreme', 'ZE06878666', 1),
	(304, 90, 307, 152, 'S4PT4038', 'zaduženo', '2023-09-28 06:22:07', 'Zaduženje nove opreme', 'ZE06878662', 1),
	(305, 90, 308, 200, 'S4PT4040', 'zaduženo', '2023-09-28 07:59:58', 'Zaduženje nove opreme', 'ZE06878664', 1),
	(306, 90, 309, 201, 'S4PT4044', 'zaduženo', '2023-09-28 08:00:43', 'Zaduženje nove opreme', 'ZE06878663', 1),
	(307, 91, 310, 207, 'CZC1118K7Z', 'zaduženo', '2023-09-28 11:38:42', 'Zaduženje nove opreme', 'ZG0687167', 1),
	(308, 91, 312, 208, 'CZC1118K6N', 'zaduženo', '2023-09-28 11:39:45', 'Greška prilikom prvog zaduženje. U startu je ovaj računar bio zadužen na Rašidu Hajdić.', 'ZG0687152', 1),
	(309, 91, 313, 210, 'CZC1118K7L', 'zaduženo', '2023-09-28 12:05:37', 'Zaduženje nove opreme', 'ZE0687908', 1),
	(310, 91, 314, 209, 'CZC1118K77', 'zaduženo', '2023-09-28 12:05:57', 'Zaduženje nove opreme', 'ZE0687907', 1),
	(311, 91, 315, 211, 'CZC1118K8N', 'zaduženo', '2023-09-28 12:15:01', 'Zaduženje nove opreme', 'ZG0687151', 1),
	(312, 93, 316, 209, 'CN41060Z0V', 'zaduženo', '2023-09-28 12:16:34', 'Zaduženje nove opreme', 'ZE0687920', 1),
	(313, 92, 317, 149, 'S4S54781', 'zaduženo', '2023-09-28 12:19:59', 'Zaduženje nove opreme', 'ZE0687457', 1),
	(315, 92, 319, 174, 'S4G27223', 'zaduženo', '2023-09-28 12:21:12', 'Zaduženje nove opreme', 'ZE0687314', 1),
	(316, 92, 320, 175, 'S4G27129', 'zaduženo', '2023-09-28 12:21:36', 'Zaduženje nove opreme', 'ZE0687342', 1),
	(317, 92, 321, 181, 'S4G27201', 'zaduženo', '2023-09-28 12:22:09', 'Zaduženje nove opreme', 'ZE0687343', 1),
	(319, 92, 323, 177, 'S4S54522', 'zaduženo', '2023-09-28 12:26:54', 'Zaduženje nove opreme', 'ZE0687453', 1),
	(320, 92, 324, 186, 'S4S54794', 'zaduženo', '2023-09-28 12:27:55', 'Zaduženje nove opreme', 'ZG0686649', 1),
	(321, 92, 325, 179, 'S4S54204', 'zaduženo', '2023-09-28 12:28:27', 'Zaduženje nove opreme', 'ZE0687500', 1),
	(322, 92, 326, 188, 'S4S54766', 'zaduženo', '2023-09-28 12:32:25', 'Zaduženje nove opreme', 'ZE0687451', 1),
	(323, 92, 327, 173, 'S4S59266', 'zaduženo', '2023-09-28 12:32:53', 'Zaduženje nove opreme', 'ZE0687443', 1),
	(324, 92, 328, 169, 'S4G27138', 'zaduženo', '2023-09-28 12:33:28', 'Zaduženje nove opreme', 'ZE0687317', 1),
	(325, 92, 329, 151, 'S4S59287', 'zaduženo', '2023-09-28 12:34:09', 'Zaduženje nove opreme', 'ZG0686647', 1),
	(326, 92, 330, 212, 'S4S54800', 'zaduženo', '2023-09-28 12:39:01', 'Zaduženje nove opreme', 'ZG0686648', 1),
	(327, 92, 331, 213, 'S4S41757', 'zaduženo', '2023-09-28 12:39:21', 'Zaduženje nove opreme', 'ZE0687444', 1);

-- Dumping structure for table inventory.user_token
CREATE TABLE IF NOT EXISTS `user_token` (
  `user_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expire_at` datetime NOT NULL,
  `is_valid` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory.user_token: ~53 rows (approximately)
INSERT INTO `user_token` (`user_token_id`, `user_id`, `created_at`, `token`, `expire_at`, `is_valid`) VALUES
	(4, 1, '2022-03-12 23:44:18', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4MDcwNTguNjU2LCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy4yOC40IiwiaWF0IjoxNjQ3MTI4NjU4fQ.xunJeYa9nsAj7pDRMYKTSb28CdCxDxeO7F9SYu34yZk', '2022-04-12 23:44:18', 1),
	(5, 1, '2022-03-12 23:44:25', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4MDcwNjUuODUzLCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy4yOC40IiwiaWF0IjoxNjQ3MTI4NjY1fQ.3QFienwuIkBTzWAtYwK6GQw7wiXSKfdMYBmSk-pGHXg', '2022-04-12 23:44:25', 1),
	(6, 1, '2022-03-13 00:03:08', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4MDgxODguOTI3LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC41MSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MTI5Nzg4fQ.8HXyIqvNmT3ntccVzg3tJQKgMSdE0WGNLacFLWtEk0o', '2022-04-13 00:03:08', 1),
	(7, 1, '2022-03-13 00:07:35', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4MDg0NTUuNDA4LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC41MSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MTMwMDU1fQ.6BJ1ZnM_s-selm25njKi5u3LiIjwSEIATG05KdgP7Ro', '2022-04-13 00:07:35', 1),
	(8, 1, '2022-03-13 00:13:23', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4MDg4MDMuNTU1LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMjkiLCJ1YSI6Ik1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDEwXzE1XzYpIEFwcGxlV2ViS2l0LzYwNS4xLjE1IChLSFRNTCwgbGlrZSBHZWNrbykgVmVyc2lvbi8xNS40IFNhZmFyaS82MDUuMS4xNSIsImlhdCI6MTY0NzEzMDQwM30.DCyBg0xlLl7wNPR08d6uC9hXZuCcQoUKFpiw_Itvnuc', '2022-04-13 00:13:23', 1),
	(9, 1, '2022-03-13 12:07:59', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTE2NzkuOTY4LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMjgiLCJ1YSI6Ik1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDEwXzE1XzYpIEFwcGxlV2ViS2l0LzYwNS4xLjE1IChLSFRNTCwgbGlrZSBHZWNrbykgVmVyc2lvbi8xNS40IFNhZmFyaS82MDUuMS4xNSIsImlhdCI6MTY0NzE3MzI3OX0.oFzJQRHyc9HhBcSaeQEmegfu5PQR8f6qEEVxViRJe3I', '2022-04-13 12:07:59', 1),
	(10, 1, '2022-03-13 12:11:22', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTE4ODIuODI0LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMjkiLCJ1YSI6Ik1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDEwXzE1XzYpIEFwcGxlV2ViS2l0LzYwNS4xLjE1IChLSFRNTCwgbGlrZSBHZWNrbykgVmVyc2lvbi8xNS40IFNhZmFyaS82MDUuMS4xNSIsImlhdCI6MTY0NzE3MzQ4Mn0.gcfTC9vk3GPG-5g4Ul9KatWV6DqiTxPggXEsnQzFW9w', '2022-04-13 12:11:22', 1),
	(11, 1, '2022-03-13 12:35:22', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTMzMjIuNjU2LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC41MSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MTc0OTIyfQ.HBzaxlppBp2aplzDP8mV7HBbzPTVEqQthzuGrgy0oLY', '2022-04-13 12:35:22', 1),
	(12, 1, '2022-03-13 12:35:54', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTMzNTQuOTQ2LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC41MSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MTc0OTU0fQ.OPBCdKMAjJOthtADM0qD57Y_qXMgJAfh_8ZhKKVTEkU', '2022-04-13 12:35:54', 1),
	(13, 1, '2022-03-13 12:36:56', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTM0MTYuODYyLCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC41MSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MTc1MDE2fQ.YMY1KQoP446C9dWnZ3-ILvR-cJgVnupM_uGehPMXTXM', '2022-04-13 12:36:56', 1),
	(14, 1, '2022-03-13 12:37:22', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTM0NDIuNjA5LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCA2LjA7IE5leHVzIDUgQnVpbGQvTVJBNThOKSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTkuMC40ODQ0LjUxIE1vYmlsZSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MTc1MDQyfQ.GUNJxBBksM-7dPXKM2P6VIimx43zv3rKCW4WZPzW7BI', '2022-04-13 12:37:22', 1),
	(15, 1, '2022-03-13 12:37:29', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTM0NDkuNjcsImlwIjoiOjpmZmZmOjE5Mi4xNjguMC4xMyIsInVhIjoiTW96aWxsYS81LjAgKExpbnV4OyBBbmRyb2lkIDYuMDsgTmV4dXMgNSBCdWlsZC9NUkE1OE4pIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85OS4wLjQ4NDQuNTEgTW9iaWxlIFNhZmFyaS81MzcuMzYiLCJpYXQiOjE2NDcxNzUwNDl9.ZG4RkpEYfWvRZDi9R5uaPZbhiea9BfL7uIfuHA-591Q', '2022-04-13 12:37:29', 1),
	(16, 1, '2022-03-13 12:40:05', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTM2MDUuNTE5LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCA2LjA7IE5leHVzIDUgQnVpbGQvTVJBNThOKSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTkuMC40ODQ0LjUxIE1vYmlsZSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MTc1MjA1fQ.Fbt7-9nPHbFoTVY3pLaHPz3xWQ4fdvDkKV2eIXw-ax4', '2022-04-13 12:40:05', 1),
	(17, 1, '2022-03-13 12:41:12', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTM2NzIuMTY3LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCA2LjA7IE5leHVzIDUgQnVpbGQvTVJBNThOKSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTkuMC40ODQ0LjUxIE1vYmlsZSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MTc1MjcyfQ.9-UI4mABWAzeqvEkwnSk_cozazmmpa4dlQlDs8XawaM', '2022-04-13 12:41:12', 1),
	(18, 1, '2022-03-13 12:50:25', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NTQyMjUuNTMzLCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC41MSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MTc1ODI1fQ.IxF3WnYKunLjJbSnZcFpbGui4pIHR6zjmOo501xs1Yg', '2022-04-13 12:50:25', 1),
	(19, 1, '2022-03-13 15:07:49', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NjI0NjkuNzE0LCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy4yOC40IiwiaWF0IjoxNjQ3MTg0MDY5fQ.ARCXOm4fXBNpZMUpmBKRnFaz0WM0mHwyalOMqztS9xg', '2022-04-13 15:07:49', 1),
	(20, 1, '2022-03-13 15:09:55', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NjI1OTUuMzksImlwIjoiOjoxIiwidWEiOiJQb3N0bWFuUnVudGltZS83LjI4LjQiLCJpYXQiOjE2NDcxODQxOTV9.Sm_c3fXizvq08mXE6wKwUyOpTPeTFqw4jfpm2gtFZRo', '2022-04-13 15:09:55', 1),
	(21, 1, '2022-03-13 15:11:36', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NjI2OTYuMDExLCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy4yOC40IiwiaWF0IjoxNjQ3MTg0Mjk2fQ.kV9bMPwIvKgxQ2Mv4Pc0ezsyVkcJtptUjH2WsklpxSg', '2022-04-13 15:11:36', 1),
	(22, 1, '2022-03-13 15:28:37', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4NjM3MTcuNzcsImlwIjoiOjoxIiwidWEiOiJQb3N0bWFuUnVudGltZS83LjI4LjQiLCJpYXQiOjE2NDcxODUzMTd9.eOX9m8SeeM2AGD1QfnulcqTVnNQ4qO9UMtUmYiucmG4', '2022-04-13 15:28:37', 1),
	(23, 1, '2022-03-13 22:09:07', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4ODc3NDcuNzgyLCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChMaW51eDsgQW5kcm9pZCA2LjA7IE5leHVzIDUgQnVpbGQvTVJBNThOKSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTkuMC40ODQ0LjUxIE1vYmlsZSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MjA5MzQ3fQ.yvvrsJqGvwsUZBGLnQQi6mDSGfAovi5SoPn2jOac1qY', '2022-04-13 22:09:07', 1),
	(24, 1, '2022-03-13 22:12:59', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4ODc5NzkuNzE1LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC41MSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MjA5NTc5fQ.X0tfHLl3neE8hIb6g9kw9vXbeUiBeAu24jT2o9LB0Uc', '2022-04-13 22:12:59', 1),
	(25, 1, '2022-03-13 22:15:20', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4ODgxMjAuODUsImlwIjoiOjpmZmZmOjE5Mi4xNjguMC4xMyIsInVhIjoiTW96aWxsYS81LjAgKExpbnV4OyBBbmRyb2lkIDYuMDsgTmV4dXMgNSBCdWlsZC9NUkE1OE4pIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS85OS4wLjQ4NDQuNTEgTW9iaWxlIFNhZmFyaS81MzcuMzYiLCJpYXQiOjE2NDcyMDk3MjB9.FvV40jlOXjmj-xeBZbXQRvtn3q8PAN1URYFk3Vu9Vig', '2022-04-13 22:15:20', 1),
	(26, 1, '2022-03-13 23:01:30', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4OTA4OTAuMDc0LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk5LjAuNDg0NC41MSBTYWZhcmkvNTM3LjM2IiwiaWF0IjoxNjQ3MjEyNDkwfQ.e1gkGWlw6HbtXt67CgWyb2v9EWz_FYW9RkrAucBdHSo', '2022-04-13 23:01:30', 1),
	(27, 1, '2022-03-13 23:01:58', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NDk4OTA5MTguNDY0LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMjkiLCJ1YSI6Ik1vemlsbGEvNS4wIChNYWNpbnRvc2g7IEludGVsIE1hYyBPUyBYIDEwXzE1XzYpIEFwcGxlV2ViS2l0LzYwNS4xLjE1IChLSFRNTCwgbGlrZSBHZWNrbykgVmVyc2lvbi8xNS40IFNhZmFyaS82MDUuMS4xNSIsImlhdCI6MTY0NzIxMjUxOH0.SaUMV8BI6gT8y05u-tDBgYwxzBu-f4Z-vzveeSktSJc', '2022-04-13 23:01:58', 1),
	(28, 1, '2022-03-17 12:14:59', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAxOTc2OTkuODQzLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NTE5Mjk5fQ.qnrAM7irlHulC3iXcxMTTq5vQdR-iGUDzt4GCi71wQc', '2022-04-17 12:14:59', 1),
	(29, 1, '2022-03-18 11:49:02', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyODI1NDEuOTk3LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjA0MTQxfQ.bjC6_u0t0i7L972HSpCoSTXfZr_Foqec7dmWCNYlBz0', '2022-04-18 11:49:01', 1),
	(30, 1, '2022-03-18 11:50:53', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyODI2NTMuODc0LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjA0MjUzfQ.uyeb85e7tHPZX2q7yocq5qwj7wTDUswaQYWV2yMA7go', '2022-04-18 11:50:53', 1),
	(31, 1, '2022-03-18 11:55:16', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyODI5MTYuNTY5LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjA0NTE2fQ.nkQ3JsDHz3wkidFQibTBryJd0Z6i4OMuDZ9DsypVOYI', '2022-04-18 11:55:16', 1),
	(32, 1, '2022-03-18 11:59:22', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyODMxNjIuMDQyLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjA0NzYyfQ.FZ_SkKZQtfBBw9T6IbGISufHMsevPLhSKyan-dx516w', '2022-04-18 11:59:22', 1),
	(33, 1, '2022-03-18 12:00:17', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyODMyMTcuMjAxLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjA0ODE3fQ.niTimi_rAsK6cI_-ewqv9YFme40cG6rdZV909BBfFS8', '2022-04-18 12:00:17', 1),
	(34, 1, '2022-03-18 12:01:27', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyODMyODcuMTg5LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjA0ODg3fQ.7aGV_h-aNBXCumTSSg2vhzZj7H-anoxj13MaYoFhnCw', '2022-04-18 12:01:27', 1),
	(35, 1, '2022-03-18 12:05:16', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyODM1MTYuMjcyLCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjA1MTE2fQ.qjmprCO0ZoVXL9UWekpahVhAGKe1wUsgiuAPjD73wQ8', '2022-04-18 12:05:16', 1),
	(36, 1, '2022-03-18 12:10:24', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyODM4MjQuNDE2LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjA1NDI0fQ.WjkmRP5LY0RUrI8OiciPkOyg9SdU9vmTVloxpuDJ5VE', '2022-04-18 12:10:24', 1),
	(37, 1, '2022-03-18 12:12:11', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyODM5MzEuMTQ1LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjA1NTMxfQ.eQQxKsLyR91WfdFc9moR22QB9u2HPPXJdLdJT2Kr15M', '2022-04-18 12:12:11', 1),
	(38, 2, '2022-03-18 12:15:18', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoyLCJpZGVudGl0eSI6Imcua2Fyb3ZpY0BlcGJpaC5iYSIsImV4cCI6MTY1MDI4NDExOC42NDcsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTguMC40NzU4LjEwOSBTYWZhcmkvNTM3LjM2IE9QUi84NC4wLjQzMTYuMzYiLCJpYXQiOjE2NDc2MDU3MTh9.6A63PSOpPFnlPvzr3wVekAUua-VzdJWPE9KOPpLFPds', '2022-04-18 12:15:18', 1),
	(39, 2, '2022-03-18 12:16:35', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoyLCJpZGVudGl0eSI6Imcua2Fyb3ZpY0BlcGJpaC5iYSIsImV4cCI6MTY1MDI4NDE5NS4yMTEsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTguMC40NzU4LjEwOSBTYWZhcmkvNTM3LjM2IE9QUi84NC4wLjQzMTYuMzYiLCJpYXQiOjE2NDc2MDU3OTV9.Z7RKnhT1_kxdqCRtG7dt_NErPl0lGUWowyZxpddzpEE', '2022-04-18 12:16:35', 1),
	(40, 2, '2022-03-18 12:35:29', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoyLCJpZGVudGl0eSI6Imcua2Fyb3ZpY0BlcGJpaC5iYSIsImV4cCI6MTY1MDI4NTMyOS44ODMsImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTguMC40NzU4LjEwOSBTYWZhcmkvNTM3LjM2IE9QUi84NC4wLjQzMTYuMzYiLCJpYXQiOjE2NDc2MDY5Mjl9.YhdzXR1OenxqMWUQW9-0vpJbtZMCgT_9rRcVB2WHiWU', '2022-04-18 12:35:29', 1),
	(41, 2, '2022-03-18 13:54:03', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoyLCJpZGVudGl0eSI6Imcua2Fyb3ZpY0BlcGJpaC5iYSIsImV4cCI6MTY1MDI5MDA0My4zNDksImlwIjoiOjoxIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvOTguMC40NzU4LjEwOSBTYWZhcmkvNTM3LjM2IE9QUi84NC4wLjQzMTYuMzYiLCJpYXQiOjE2NDc2MTE2NDN9.f3KIkjIsMm3bMs9WN9uPVfomSwjAa7JN_kQd6CmtqNw', '2022-04-18 13:54:03', 1),
	(42, 1, '2022-03-18 14:43:37', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyOTMwMTcuMzc1LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjE0NjE3fQ.7QdTrWyyPm5yHUtG-DJiJsojLwtAKLvt5QLLXySoy4E', '2022-04-18 14:43:37', 1),
	(43, 1, '2022-03-18 14:43:52', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyOTMwMzIuNzQ0LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjE0NjMyfQ.cxiFXvqF6ccpQhUPxKyz7QYQ5TFpyco--JYzxw8qzeg', '2022-04-18 14:43:52', 1),
	(44, 1, '2022-03-18 14:48:24', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxLCJpZGVudGl0eSI6Im0uY2VyaWNAZXBiaWguYmEiLCJleHAiOjE2NTAyOTMzMDQuNDQ3LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzk4LjAuNDc1OC4xMDkgU2FmYXJpLzUzNy4zNiBPUFIvODQuMC40MzE2LjM2IiwiaWF0IjoxNjQ3NjE0OTA0fQ.7SqhUh5G8Zqv54lA2eP1C970eis6YuqWR2QQaICB4oI', '2022-04-18 14:48:24', 1),
	(45, 7, '2022-03-31 18:00:38', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo3LCJpZGVudGl0eSI6ImV2aWNhQGVwYmloLmJhIiwiZXhwIjoxNjUxNDI4MDM4LjY0LCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChYMTE7IExpbnV4IHg4Nl82NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwMC4wLjQ4OTYuNjAgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTY0ODc0OTYzOH0.fYz9cIe8QB-t7XqFlXQ-6VnwKuB7PKKMtADTBme-ngI', '2022-05-01 18:00:38', 1),
	(46, 7, '2022-03-31 18:05:01', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo3LCJpZGVudGl0eSI6ImV2aWNhQGVwYmloLmJhIiwiZXhwIjoxNjUxNDI4MzAxLjE0NCwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoWDExOyBMaW51eCB4ODZfNjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDAuMC40ODk2LjYwIFNhZmFyaS81MzcuMzYiLCJpYXQiOjE2NDg3NDk5MDF9.jO069O3c-MoCIlQ9clNPpUxSaFVPKuQP82wVRC2iQtY', '2022-05-01 18:05:01', 1),
	(47, 148, '2022-11-04 23:34:46', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxNDgsImlkZW50aXR5IjoibS5jZXJpY0BlcGJpaC5iYSIsImV4cCI6MTY3MDI4MzI4Ni44NzksImlwIjoiOjpmZmZmOjE5Mi4xNjguMC4xMyIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwNi4wLjAuMCBTYWZhcmkvNTM3LjM2IEVkZy8xMDYuMC4xMzcwLjQ3IiwiaWF0IjoxNjY3NjA0ODg2fQ.C76YeIGH1NQugyb3ut-ndX398pJmuuu8Mdregk5f-HM', '2022-12-05 23:34:46', 1),
	(48, 148, '2022-11-13 21:42:04', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxNDgsImlkZW50aXR5IjoibS5jZXJpY0BlcGJpaC5iYSIsImV4cCI6MTY3MTA1NDEyNC45OSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNy4wLjE0MTguNDIiLCJpYXQiOjE2NjgzNzU3MjR9.5yCEhStxY6REsFH8e9dngRHtqIl6ONPxMNm53q6BWKU', '2022-12-14 21:42:04', 1),
	(49, 152, '2022-11-13 21:43:01', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxNTIsImlkZW50aXR5IjoibC5jYXJzaW1hbW92aWNAZXBiaWguYmEiLCJleHAiOjE2NzEwNTQxODEuODIzLCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA3LjAuMTQxOC40MiIsImlhdCI6MTY2ODM3NTc4MX0.3lTdl2beEnuBUmhbAE11xIegCJtorwbN89voymmVhBA', '2022-12-14 21:43:01', 1),
	(50, 148, '2022-11-13 21:51:38', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxNDgsImlkZW50aXR5IjoibS5jZXJpY0BlcGJpaC5iYSIsImV4cCI6MTY3MTA1NDY5OC40NjksImlwIjoiOjpmZmZmOjE5Mi4xNjguMC4xMyIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwNy4wLjAuMCBTYWZhcmkvNTM3LjM2IEVkZy8xMDcuMC4xNDE4LjQyIiwiaWF0IjoxNjY4Mzc2Mjk4fQ.mba2tTq1uIa9t0JJVWrBCJcuxV25za2KFKwHA-YDDEw', '2022-12-14 21:51:38', 1),
	(51, 148, '2022-11-13 23:22:08', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxNDgsImlkZW50aXR5IjoibS5jZXJpY0BlcGJpaC5iYSIsImV4cCI6MTY3MTA2MDEyOC4yNjUsImlwIjoiOjpmZmZmOjE5Mi4xNjguMC4xMyIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwNy4wLjAuMCBTYWZhcmkvNTM3LjM2IEVkZy8xMDcuMC4xNDE4LjQyIiwiaWF0IjoxNjY4MzgxNzI4fQ.SYkGvPZYsk2jia3hB7zU9tm4rWsjyN7QYwI_KyHJNw8', '2022-12-14 23:22:08', 1),
	(52, 148, '2022-11-20 22:12:03', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxNDgsImlkZW50aXR5IjoibS5jZXJpY0BlcGJpaC5iYSIsImV4cCI6MTY3MTY2MDQxNi44MjksImlwIjoiOjpmZmZmOjEwLjEuOTEuMjIwIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNy4wLjE0MTguNDIiLCJpYXQiOjE2Njg5ODIwMTZ9.QtnkeXUFqk-zblvuO5OwC6LI0pVr5TJFjd2_gd07x4g', '2022-12-21 22:06:56', 1),
	(53, 148, '2022-11-23 19:59:44', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxNDgsImlkZW50aXR5IjoibS5jZXJpY0BlcGJpaC5iYSIsImV4cCI6MTY3MTkxMTY3Ny40NTksImlwIjoiMTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoTGludXg7IEFuZHJvaWQgMTI7IDIxMDgxMTExUkcpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDcuMC4wLjAgTW9iaWxlIFNhZmFyaS81MzcuMzYiLCJpYXQiOjE2NjkyMzMyNzd9.eUbIsAylLrfwz5quBGrGeV2VYBDYKu0na-4pHcZeQcM', '2022-12-24 19:54:37', 1),
	(54, 148, '2022-11-25 23:20:25', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxNDgsImlkZW50aXR5IjoibS5jZXJpY0BlcGJpaC5iYSIsImV4cCI6MTY3MjA5NjgyNS44ODgsImlwIjoiMTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNy4wLjE0MTguNTIiLCJpYXQiOjE2Njk0MTg0MjV9.OaKv8j9nkS1V2-78-obIFX2RHfLPHn02_vz0wG1gIzo', '2022-12-26 23:20:25', 1),
	(55, 148, '2022-11-28 12:06:18', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxNDgsImlkZW50aXR5IjoibS5jZXJpY0BlcGJpaC5iYSIsImV4cCI6MTY3MjMxNTU3OC4xMzksImlwIjoiMTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoTGludXg7IEFuZHJvaWQgMTI7IDIxMDgxMTExUkcgQnVpbGQvU1AxQS4yMTA4MTIuMDE2KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuNTMwNC4xNDEgTW9iaWxlIFNhZmFyaS81MzcuMzYgT1BYLzEuNyIsImlhdCI6MTY2OTYzNzE3OH0.wFbVBAEICkAVdjo74xjUFVKfbRG-4n7OJRWU9DtEwg0', '2022-12-29 12:06:18', 1),
	(56, 148, '2022-12-01 16:32:20', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxNDgsImlkZW50aXR5IjoibS5jZXJpY0BlcGJpaC5iYSIsImV4cCI6MTY3MjU5MDczOC41MTEsImlwIjoiOjpmZmZmOjE5Mi4xNjguMC4xMyIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwNy4wLjAuMCBTYWZhcmkvNTM3LjM2IEVkZy8xMDcuMC4xNDE4LjUyIiwiaWF0IjoxNjY5OTEyMzM4fQ.EyaPVcfd7BDstVyUjR2wSKkHRmWIBXmm8KXIZOJ5o8k', '2023-01-01 16:32:18', 1);

-- Dumping structure for trigger inventory.user_before_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `user_before_insert` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
SET NEW.fullname = (CONCAT(NEW.forname, ' ', NEW.surname));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger inventory.user_before_update
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `user_before_update` BEFORE UPDATE ON `user` FOR EACH ROW BEGIN
SET NEW.fullname = (CONCAT(NEW.forname, ' ', NEW.surname));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
