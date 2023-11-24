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
DROP DATABASE IF EXISTS `inventory_v2`;
CREATE DATABASE IF NOT EXISTS `inventory_v2` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `inventory_v2`;

-- Dumping structure for table inventory_v2.administrator
DROP TABLE IF EXISTS `administrator`;
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
DROP TABLE IF EXISTS `administrator_token`;
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

-- Dumping data for table inventory_v2.administrator_token: ~8 rows (approximately)
INSERT INTO `administrator_token` (`administrator_token_id`, `administrator_id`, `created_at`, `token`, `expire_at`, `is_valid`) VALUES
	(1, 1, '2023-10-23 15:45:05', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjk3ODE3MDk0LjI1LCJpcCI6Ijo6ZmZmZjoxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMTYuMC4wLjAgU2FmYXJpLzUzNy4zNiBPUFIvMTAyLjAuMC4wIiwiaWF0IjoxNjk3ODE2Nzk0fQ.eo_dswpWSSfpJRtDwMQBkV1aOz2ZkQUo6SRfgEPs9v8', '2023-10-23 15:45:01', 1),
	(2, 1, '2023-10-23 15:58:28', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNzAwNzU1MTA4LjQzOCwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjkuMiIsImlhdCI6MTY5ODA3NjcwOH0.JVttUD9sWrGeBklLbjiMMXHYyjDnzBkzjJSEx8Rb9-U', '2023-11-23 14:58:28', NULL),
	(3, 1, '2023-10-25 15:21:30', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNzAwOTI1NjkwLjA4LCJpcCI6Ijo6ZmZmZjoxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMTYuMC4wLjAgU2FmYXJpLzUzNy4zNiBPUFIvMTAyLjAuMC4wIiwiaWF0IjoxNjk4MjQ3MjkwfQ.lJjOB55aIFnNmTCzgNIsJwItCnBXDLygNLVlNukEcls', '2023-11-25 14:21:30', NULL),
	(4, 1, '2023-10-25 21:30:38', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNzAwOTQ3ODM4LjQ1NCwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjI4IiwidWEiOiJNb3ppbGxhLzUuMCAoTGludXg7IFU7IEFuZHJvaWQgMTM7IGVuLXVzOyBYaWFvbWkgMTFUIEJ1aWxkL1RQMUEuMjIwNjI0LjAxNCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgVmVyc2lvbi80LjAgQ2hyb21lLzEwMC4wLjQ4OTYuMTI3IE1vYmlsZSBTYWZhcmkvNTM3LjM2IFhpYW9NaS9NaXVpQnJvd3Nlci8xMy4yNS4yLjItZ24iLCJpYXQiOjE2OTgyNjk0Mzh9.1P2zScfO7dFepBVcyMbLk5S2UD5efLXg_cJdAMV6lME', '2023-11-25 20:30:38', NULL),
	(5, 1, '2023-10-25 21:36:14', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNzAwOTQ4MTc0LjkxMSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTE2LjAuMC4wIFNhZmFyaS81MzcuMzYgT1BSLzEwMi4wLjAuMCIsImlhdCI6MTY5ODI2OTc3NH0.0-lGyzkOSgqnFcMWEyqvWWk5vtkmDw_Stj1fuSU95_A', '2023-11-25 20:36:14', NULL),
	(6, 1, '2023-10-26 18:01:15', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNzAxMDIxNjc1LjMzNCwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTE2LjAuMC4wIFNhZmFyaS81MzcuMzYgT1BSLzEwMi4wLjAuMCIsImlhdCI6MTY5ODM0MzI3NX0.YQvVkFTlOykdcEytXiW-PxlgulcAmQSiNL5DI217SE0', '2023-11-26 17:01:15', NULL),
	(7, 1, '2023-10-28 11:27:14', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNzAxMTcwODMzLjk5NCwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMzMuMCIsImlhdCI6MTY5ODQ5MjQzM30.a6lhoLEiMzlWIDMr1o08kI6oSL8EEtytn26sFlp9IwA', '2023-11-28 10:27:13', NULL),
	(8, 1, '2023-10-28 21:31:09', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNzAxMjA3MDY5Ljg2OSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTE2LjAuMC4wIFNhZmFyaS81MzcuMzYgT1BSLzEwMi4wLjAuMCIsImlhdCI6MTY5ODUyODY2OX0.dljxW5kg5Hs9OlY3NpXISoYly9oYxFD6smbYs1mCxoc', '2023-11-28 20:31:09', NULL);

-- Dumping structure for table inventory_v2.article
DROP TABLE IF EXISTS `article`;
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

-- Dumping data for table inventory_v2.article: ~3 rows (approximately)
INSERT INTO `article` (`article_id`, `serial_number`, `inv_number`, `user_id`, `document_id`, `status`, `timestamp`, `stock_id`, `comment`, `category_id`) VALUES
	(3, 'S4PT4033', 'ZE06878665', 1, 1, 'zaduženo', '2023-10-25 22:03:32', 1, 'Zaduženje sa skladišta', 2),
	(4, 'CN41060Z0V', 'ZE0687920', 3, 2, 'zaduženo', '2023-10-25 22:03:37', 2, 'Komentar', 3),
	(7, 'SB5252525', 'ZE06852525', 2, 5, 'zaduženo', '2023-10-28 17:49:57', 1, 'Komentar', 2);

-- Dumping structure for table inventory_v2.article_timeline
DROP TABLE IF EXISTS `article_timeline`;
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

-- Dumping data for table inventory_v2.article_timeline: ~3 rows (approximately)
INSERT INTO `article_timeline` (`article_timeline_id`, `article_id`, `user_id`, `document_id`, `serial_number`, `status`, `timestamp`, `inv_number`, `comment`) VALUES
	(1, 3, 1, 1, 'S4PT4033', 'zaduženo', '2023-10-24 17:56:03', 'ZE06878665', 'Artikal dodan'),
	(2, 4, 3, 2, 'CN41060Z0V', 'zaduženo', '2023-10-25 15:37:13', 'ZE0687920', 'Artikal dodan'),
	(5, 7, 2, 5, 'SB5252525', 'zaduženo', '2023-10-26 22:09:33', 'ZE06852525', 'Artikal dodan');

-- Dumping structure for table inventory_v2.category
DROP TABLE IF EXISTS `category`;
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
DROP TABLE IF EXISTS `department`;
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
DROP TABLE IF EXISTS `department_job`;
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
DROP TABLE IF EXISTS `documents`;
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

-- Dumping data for table inventory_v2.documents: ~3 rows (approximately)
INSERT INTO `documents` (`documents_id`, `article_id`, `path`, `document_number`, `created_date`) VALUES
	(1, 3, 'prenosnica1.docx', 1, '2023-10-24 17:56:03'),
	(2, 4, 'prenosnica2.docx', 2, '2023-10-25 15:37:13'),
	(5, 7, 'prenosnica3.docx', 3, '2023-10-26 22:09:33');

-- Dumping structure for table inventory_v2.feature
DROP TABLE IF EXISTS `feature`;
CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`feature_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `feature_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.feature: ~11 rows (approximately)
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
	(10, 'Omjer kontrasta', 3),
	(11, 'MB', 2);

-- Dumping structure for table inventory_v2.job
DROP TABLE IF EXISTS `job`;
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
DROP TABLE IF EXISTS `location`;
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
DROP TABLE IF EXISTS `stock`;
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
  PRIMARY KEY (`stock_id`),
  KEY `FK_stock_category` (`category_id`),
  CONSTRAINT `FK_stock_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.stock: ~3 rows (approximately)
INSERT INTO `stock` (`stock_id`, `name`, `excerpt`, `description`, `contract`, `category_id`, `sap_number`, `value_on_contract`, `value_available`, `timestamp`) VALUES
	(1, '720 S', 'Novi sažetak', 'Novi opis', 'Novi ugovor', 2, 'Novi SAP broj', 6, 4, '2023-10-23 16:08:35'),
	(2, 'HP E24 G4 FHD Monitor', 'Kratko opis', 'Duži opis', 'EDB-255/2023', 3, '1300-200300', 13, 11, '2023-10-23 16:11:03'),
	(3, 'HP 7900', 'Novi sažetak', 'Novi opis', 'Novi ugovor', 2, 'Novi SAP broj', 6, 4, '2023-10-29 01:20:45');

-- Dumping structure for table inventory_v2.stock_feature
DROP TABLE IF EXISTS `stock_feature`;
CREATE TABLE IF NOT EXISTS `stock_feature` (
  `stock_feature_id` int NOT NULL AUTO_INCREMENT,
  `stock_id` int NOT NULL DEFAULT '0',
  `feature_id` int NOT NULL DEFAULT '0',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`stock_feature_id`) USING BTREE,
  KEY `FK_stock_feature_feature` (`feature_id`),
  KEY `FK_stock_feature_stock` (`stock_id`),
  CONSTRAINT `FK_stock_feature_feature` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`feature_id`),
  CONSTRAINT `FK_stock_feature_stock` FOREIGN KEY (`stock_id`) REFERENCES `stock` (`stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.stock_feature: ~11 rows (approximately)
INSERT INTO `stock_feature` (`stock_feature_id`, `stock_id`, `feature_id`, `value`) VALUES
	(1, 1, 1, 'Intel i7'),
	(2, 1, 2, '16 GB'),
	(3, 3, 3, '2 TB'),
	(4, 2, 4, '1xVGA, 4xUSB, 1xDP, 1xHDMI'),
	(5, 2, 5, '250 niti'),
	(6, 2, 6, '0.274 mm'),
	(7, 2, 7, 'FHD (1920 x 1080)'),
	(8, 2, 8, '24 inch'),
	(9, 2, 9, 'IPS'),
	(10, 2, 10, '1000:1'),
	(11, 1, 11, 'Primjer matične ');

-- Dumping structure for table inventory_v2.upgrade_feature
DROP TABLE IF EXISTS `upgrade_feature`;
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
DROP TABLE IF EXISTS `user`;
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
DROP TABLE IF EXISTS `user_token`;
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
DROP TRIGGER IF EXISTS `article_status_trigger`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `article_status_trigger` AFTER INSERT ON `article` FOR EACH ROW BEGIN
    INSERT INTO article_timeline (article_id, user_id, document_id, serial_number, status, inv_number, timestamp, comment)
    VALUES (NEW.article_id, NEW.user_id, NEW.document_id, NEW.serial_number, NEW.status, NEW.inv_number, NOW(), 'Artikal dodan');

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger inventory_v2.article_update_status_trigger
DROP TRIGGER IF EXISTS `article_update_status_trigger`;
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
DROP TRIGGER IF EXISTS `article_update_timestamp`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `article_update_timestamp` BEFORE UPDATE ON `article` FOR EACH ROW BEGIN
    SET NEW.timestamp = NOW();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger inventory_v2.before_user_insert
DROP TRIGGER IF EXISTS `before_user_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `before_user_insert` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
    SET NEW.fullname = CONCAT(NEW.forname, ' ', NEW.surname);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger inventory_v2.update_last_login
DROP TRIGGER IF EXISTS `update_last_login`;
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
DROP TRIGGER IF EXISTS `user_audit_trigger`;
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
