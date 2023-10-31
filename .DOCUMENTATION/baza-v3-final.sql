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

-- Dumping data for table inventory_v2.administrator: ~1 rows (approximately)
INSERT INTO `administrator` (`administrator_id`, `username`, `password_hash`) VALUES
	(1, 'Admin', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE');

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

-- Dumping data for table inventory_v2.administrator_token: ~0 rows (approximately)
INSERT INTO `administrator_token` (`administrator_token_id`, `administrator_id`, `created_at`, `token`, `expire_at`, `is_valid`) VALUES
	(1, 1, '2023-10-31 18:21:30', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6IkFkbWluIiwiZXhwIjoxNzAxNDU0ODkwLjIyLCJpcCI6Ijo6ZmZmZjoxOTIuMTY4LjAuMTMiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMTYuMC4wLjAgU2FmYXJpLzUzNy4zNiBPUFIvMTAyLjAuMC4wIiwiaWF0IjoxNjk4Nzc2NDkwfQ.yNPMq36TUfGnhR_mtFChBRFhd5irPIAZS32cPJa9t2s', '2023-12-01 17:21:30', NULL);

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

-- Dumping data for table inventory_v2.article: ~0 rows (approximately)
INSERT INTO `article` (`article_id`, `serial_number`, `inv_number`, `user_id`, `document_id`, `status`, `timestamp`, `stock_id`, `comment`, `category_id`) VALUES
	(1, 'S4PT4033', 'ZE06878665', 148, 1, 'zaduženo', '2023-10-31 18:30:46', 1, '', 2),
	(2, 'S4PT4035', 'ZE06878661', 157, 2, 'zaduženo', '2023-10-31 18:31:22', 1, '', 2),
	(3, 'S4PT4047', 'ZE06878666', 150, 3, 'zaduženo', '2023-10-31 18:31:43', 1, '', 2),
	(4, 'S4PT4038', 'ZE06878662', 152, 4, 'zaduženo', '2023-10-31 18:32:01', 1, '', 2),
	(5, 'S4PT4040', 'ZE06878664', 200, 5, 'zaduženo', '2023-10-31 18:32:20', 1, '', 2),
	(6, 'S4PT4044', 'ZE06878663', 201, 6, 'zaduženo', '2023-10-31 18:34:27', 1, '', 2),
	(7, 'CZC1118K7Z', 'ZG0687167', 207, 7, 'zaduženo', '2023-10-31 22:09:55', 2, '', 2),
	(8, 'CZC1118K6N', 'ZG0687152', 208, 8, 'zaduženo', '2023-10-31 22:10:17', 2, '', 2),
	(9, 'CZC1118K7L', 'ZE0687908', 210, 9, 'zaduženo', '2023-10-31 22:10:32', 2, '', 2),
	(10, 'CZC1118K77', 'ZE0687907', 209, 10, 'zaduženo', '2023-10-31 22:10:52', 2, '', 2),
	(11, 'CZC1118K8N	', 'ZG0687151', 211, 11, 'zaduženo', '2023-10-31 22:11:06', 2, '', 2),
	(12, 'S4S54781', 'ZE0687457', 149, 12, 'zaduženo', '2023-10-31 22:13:21', 3, '', 2),
	(13, 'S4G27223', 'ZE0687314', 174, 13, 'zaduženo', '2023-10-31 22:13:50', 3, '', 2),
	(14, 'S4G27129', 'ZE0687342', 175, 14, 'zaduženo', '2023-10-31 22:14:02', 3, '', 2),
	(15, 'S4G27201', 'ZE0687343', 181, 15, 'zaduženo', '2023-10-31 22:14:21', 3, '', 2),
	(16, 'S4S54522', 'ZE0687453', 177, 16, 'zaduženo', '2023-10-31 22:14:34', 3, '', 2),
	(17, 'S4S54794', 'ZG0686649', 186, 17, 'zaduženo', '2023-10-31 22:14:50', 3, '', 2),
	(18, 'S4S54204', 'ZE0687500', 179, 18, 'zaduženo', '2023-10-31 22:15:05', 3, '', 2),
	(19, 'S4S54766', 'ZE0687451', 188, 19, 'zaduženo', '2023-10-31 22:15:25', 3, '', 2),
	(20, 'S4S59266', 'ZE0687443', 173, 20, 'zaduženo', '2023-10-31 22:15:43', 3, '', 2),
	(21, 'S4G27138', 'ZE0687317', 169, 21, 'zaduženo', '2023-10-31 22:29:19', 3, '', 2),
	(22, 'S4S59287', 'ZG0686647', 151, 22, 'zaduženo', '2023-10-31 22:29:35', 3, '', 2),
	(23, 'S4S54800', 'ZG0686648', 212, 23, 'zaduženo', '2023-10-31 22:29:56', 3, '', 2),
	(24, 'S4S41757', 'ZE0687444', 213, 24, 'zaduženo', '2023-10-31 22:30:11', 3, '', 2);

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

-- Dumping data for table inventory_v2.article_timeline: ~0 rows (approximately)
INSERT INTO `article_timeline` (`article_timeline_id`, `article_id`, `user_id`, `document_id`, `serial_number`, `status`, `timestamp`, `inv_number`, `comment`) VALUES
	(1, 1, 148, 1, 'S4PT4033', 'zaduženo', '2023-10-31 18:30:46', 'ZE06878665', 'Artikal dodan'),
	(2, 2, 157, 2, 'S4PT4035', 'zaduženo', '2023-10-31 18:31:22', 'ZE06878661', 'Artikal dodan'),
	(3, 3, 150, 3, 'S4PT4047', 'zaduženo', '2023-10-31 18:31:43', 'ZE06878666', 'Artikal dodan'),
	(4, 4, 152, 4, 'S4PT4038', 'zaduženo', '2023-10-31 18:32:01', 'ZE06878662', 'Artikal dodan'),
	(5, 5, 200, 5, 'S4PT4040', 'zaduženo', '2023-10-31 18:32:20', 'ZE06878664', 'Artikal dodan'),
	(6, 6, 201, 6, 'S4PT4044', 'zaduženo', '2023-10-31 18:34:27', 'ZE06878663', 'Artikal dodan'),
	(7, 7, 207, 7, 'CZC1118K7Z', 'zaduženo', '2023-10-31 22:09:55', 'ZG0687167', 'Artikal dodan'),
	(8, 8, 208, 8, 'CZC1118K6N', 'zaduženo', '2023-10-31 22:10:17', 'ZG0687152', 'Artikal dodan'),
	(9, 9, 210, 9, 'CZC1118K7L', 'zaduženo', '2023-10-31 22:10:32', 'ZE0687908', 'Artikal dodan'),
	(10, 10, 209, 10, 'CZC1118K77', 'zaduženo', '2023-10-31 22:10:52', 'ZE0687907', 'Artikal dodan'),
	(11, 11, 211, 11, 'CZC1118K8N	', 'zaduženo', '2023-10-31 22:11:06', 'ZG0687151', 'Artikal dodan'),
	(12, 12, 149, 12, 'S4S54781', 'zaduženo', '2023-10-31 22:13:21', 'ZE0687457', 'Artikal dodan'),
	(13, 13, 174, 13, 'S4G27223', 'zaduženo', '2023-10-31 22:13:50', 'ZE0687314', 'Artikal dodan'),
	(14, 14, 175, 14, 'S4G27129', 'zaduženo', '2023-10-31 22:14:02', 'ZE0687342', 'Artikal dodan'),
	(15, 15, 181, 15, 'S4G27201', 'zaduženo', '2023-10-31 22:14:21', 'ZE0687343', 'Artikal dodan'),
	(16, 16, 177, 16, 'S4S54522', 'zaduženo', '2023-10-31 22:14:34', 'ZE0687453', 'Artikal dodan'),
	(17, 17, 186, 17, 'S4S54794', 'zaduženo', '2023-10-31 22:14:50', 'ZG0686649', 'Artikal dodan'),
	(18, 18, 179, 18, 'S4S54204', 'zaduženo', '2023-10-31 22:15:05', 'ZE0687500', 'Artikal dodan'),
	(19, 19, 188, 19, 'S4S54766', 'zaduženo', '2023-10-31 22:15:25', 'ZE0687451', 'Artikal dodan'),
	(20, 20, 173, 20, 'S4S59266', 'zaduženo', '2023-10-31 22:15:43', 'ZE0687443', 'Artikal dodan'),
	(21, 21, 169, 21, 'S4G27138', 'zaduženo', '2023-10-31 22:29:19', 'ZE0687317', 'Artikal dodan'),
	(22, 22, 151, 22, 'S4S59287', 'zaduženo', '2023-10-31 22:29:35', 'ZG0686647', 'Artikal dodan'),
	(23, 23, 212, 23, 'S4S54800', 'zaduženo', '2023-10-31 22:29:56', 'ZG0686648', 'Artikal dodan'),
	(24, 24, 213, 24, 'S4S41757', 'zaduženo', '2023-10-31 22:30:11', 'ZE0687444', 'Artikal dodan');

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

-- Dumping data for table inventory_v2.category: ~8 rows (approximately)
INSERT INTO `category` (`category_id`, `name`, `image_path`, `parent_category_id`) VALUES
	(1, 'Rač. oprema', 'bi bi-pc-display', NULL),
	(2, 'Radne stanice', 'bi bi-pc-display-horizontal', 1),
	(3, 'Memorija pohrane', 'bi bi-hdd', 2),
	(4, 'Monitor', 'bi bi-display', 1),
	(5, 'Telefoni', 'bi bi-telephone-fill', NULL),
	(6, 'Bežični telefon', 'bi bi-phone-fill', 5),
	(7, 'Žični telefon', 'bi bi-phone', 5),
	(8, 'Miš', 'bi bi-mouse2-fill', 1);

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

-- Dumping data for table inventory_v2.department: ~0 rows (approximately)
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

-- Dumping data for table inventory_v2.department_job: ~0 rows (approximately)
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

-- Dumping data for table inventory_v2.documents: ~0 rows (approximately)
INSERT INTO `documents` (`documents_id`, `article_id`, `path`, `document_number`, `created_date`) VALUES
	(1, 1, 'prenosnica1.docx', 1, '2023-10-31 18:30:46'),
	(2, 2, 'prenosnica2.docx', 2, '2023-10-31 18:31:22'),
	(3, 3, 'prenosnica3.docx', 3, '2023-10-31 18:31:43'),
	(4, 4, 'prenosnica4.docx', 4, '2023-10-31 18:32:01'),
	(5, 5, 'prenosnica5.docx', 5, '2023-10-31 18:32:20'),
	(6, 6, 'prenosnica6.docx', 6, '2023-10-31 18:34:27'),
	(7, 7, 'prenosnica7.docx', 7, '2023-10-31 22:09:55'),
	(8, 8, 'prenosnica8.docx', 8, '2023-10-31 22:10:17'),
	(9, 9, 'prenosnica9.docx', 9, '2023-10-31 22:10:32'),
	(10, 10, 'prenosnica10.docx', 10, '2023-10-31 22:10:52'),
	(11, 11, 'prenosnica11.docx', 11, '2023-10-31 22:11:06'),
	(12, 12, 'prenosnica12.docx', 12, '2023-10-31 22:13:21'),
	(13, 13, 'prenosnica13.docx', 13, '2023-10-31 22:13:50'),
	(14, 14, 'prenosnica14.docx', 14, '2023-10-31 22:14:02'),
	(15, 15, 'prenosnica15.docx', 15, '2023-10-31 22:14:21'),
	(16, 16, 'prenosnica16.docx', 16, '2023-10-31 22:14:34'),
	(17, 17, 'prenosnica17.docx', 17, '2023-10-31 22:14:50'),
	(18, 18, 'prenosnica18.docx', 18, '2023-10-31 22:15:05'),
	(19, 19, 'prenosnica19.docx', 19, '2023-10-31 22:15:25'),
	(20, 20, 'prenosnica20.docx', 20, '2023-10-31 22:15:43'),
	(21, 21, 'prenosnica21.docx', 21, '2023-10-31 22:29:19'),
	(22, 22, 'prenosnica22.docx', 22, '2023-10-31 22:29:35'),
	(23, 23, 'prenosnica23.docx', 23, '2023-10-31 22:29:56'),
	(24, 24, 'prenosnica24.docx', 24, '2023-10-31 22:30:11');

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

-- Dumping data for table inventory_v2.feature: ~0 rows (approximately)
INSERT INTO `feature` (`feature_id`, `name`, `category_id`) VALUES
	(8, 'Kapacitet', 3),
	(9, 'Tip', 3),
	(10, 'Tip', 2),
	(11, 'CPU', 2),
	(13, 'RAM', 2),
	(14, 'Memorija', 2),
	(16, 'MAC', 2),
	(17, 'Vrsta prikaza', 4),
	(19, 'Rezolucija', 4),
	(20, 'Omjer kontrasta', 4),
	(21, 'Svjetlina', 4),
	(22, 'Visina piksela', 4),
	(23, 'Konektori', 4),
	(24, 'Rezolucija slike', 4),
	(47, 'Tip', 7),
	(48, 'Proizvo?a?', 6),
	(49, 'DPI', 8),
	(50, 'Tip', 8),
	(51, 'IP Adresa', 2);

-- Dumping structure for table inventory_v2.job
DROP TABLE IF EXISTS `job`;
CREATE TABLE IF NOT EXISTS `job` (
  `job_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `job_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.job: ~0 rows (approximately)
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
	(1, 'ED Zenica', '101', NULL),
	(2, 'Direkcija Zenica', '103', 1),
	(3, 'PJD Zenica', '10303', 1),
	(34, 'PJD Visoko', '105', 1),
	(35, 'PJD Maglaj', '103080607', 1),
	(36, 'PJD Breza', '103080604', 1),
	(37, 'PJD Zenica', '101-6', 1),
	(38, 'PJD Doboj Jug', '101-7', 1),
	(39, 'PJD Kakanj', '101-8', 1),
	(40, 'PJD Vareš', '101-9', 1),
	(41, 'PJD Olovo', '101-10', 1),
	(42, 'PJD Begov Han', '101-11', 1),
	(43, 'PJD Zavidovići', '101-12', 1),
	(45, 'PJD Tešanj', '101-13', 1);

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

-- Dumping data for table inventory_v2.stock: ~0 rows (approximately)
INSERT INTO `stock` (`stock_id`, `name`, `excerpt`, `description`, `contract`, `category_id`, `sap_number`, `value_on_contract`, `value_available`, `timestamp`) VALUES
	(1, 'ThinkCentre 720S', 'Kratki opis opreme', 'Detaljan opis opreme', 'Ugovor broj 1/2023', 2, '1300-100200', 6, 0, '2023-10-31 18:29:38'),
	(2, 'HP ProDesk 600 G6', 'Small Form Factor PC', 'Opis računara', 'Ugovor 2/2023', 2, '1300-100525', 10, 5, '2023-10-31 20:58:45'),
	(3, 'ThinkCentre M93', 'Small Form Factor PC', 'Opis računara', 'Ugovor 3/2023', 2, '1300-132525', 31, 18, '2023-10-31 21:00:27'),
	(4, 'HP Compaq dc7900 Small Form Factor', 'SFF', 'Energetski učinkovite tehnologije, vodeća rješenja za upravljanje na daljinu i tri fleksibilna faktora oblika dizajnirana da odgovaraju vašim specifičnim poslovnim potrebama -- HP Compaq dc7900 PC stabilna je platforma koja smanjuje troškove posjedovanja.', 'Ugovor 4/2023', 2, '1300-551455', 91, 91, '2023-10-31 21:01:33'),
	(5, 'ThinkCentre M83 SFF Pro Desktop', 'SFF', 'The new small form factor (SFF) pro design features the compactness of the SFF with the expansion ability of a tower. The SFF desktops weigh in at 16.5 lbs / 7.8 kg and support both horizontal and vertical orientations.', 'Ugovor 5/2023', 2, '1300-005254', 33, 33, '2023-10-31 21:02:26'),
	(6, 'ThinkCentre M92/M92p Tiny, Small, Tower', 'SFF', 'This Tiny desktop packs a powerful enterprise performance and Intel Pro manageability into an ultra-compact form factor thats energy-efficient and easy to manage.', 'Ugovor 6/2023', 2, '1300-005248', 32, 32, '2023-10-31 21:03:23'),
	(7, 'Računar Dell OptiPlex 3090 SFF', 'SFF', 'Detaljan opis', 'Ugovor 7/2023', 2, '1300-525456', 23, 23, '2023-10-31 21:04:19'),
	(8, 'HP Compaq 8200 Elite Small Form Factor PC', 'SFF', 'HP Compaq 8200 Elite Small Form Factor PC', 'Ugovor 7/2023', 2, '1300-100002', 18, 18, '2023-10-31 21:05:13'),
	(9, 'HP E24 G4 FHD Monitor', 'Opis monitor', 'Opis monitor', 'Ugovor 8/2023', 4, '1300-252525', 13, 13, '2023-10-31 21:06:36'),
	(10, 'ASUS VW199T-P 19"', '19 inča monitor kocka', '19 inča monitor kocka', 'Ugovor 9/2023', 4, '1300-183994', 24, 24, '2023-10-31 21:07:33'),
	(11, 'Philips 170S', 'Monitor Philips', 'Monitor Philips', 'Ugovor 11/2023', 4, '1300-100000', 37, 37, '2023-10-31 21:08:27'),
	(12, 'Philips S Line 20', 'Monitor Philips S Line 20"', 'Monitor Philips S Line 20"', 'Ugovor 12/2023', 4, '1300-100001', 27, 27, '2023-10-31 21:09:16'),
	(13, 'Dell 21,5"', 'Dell 21,5"', 'Dell 21,5"', 'Ugovor 13/2023', 4, '1300-100003', 31, 31, '2023-10-31 21:10:01'),
	(14, 'HP Compaq L1506', 'HP Compaq L1506', 'Monitor HP Compaq L1506 je osnovni model koji je pružao standardne performanse za osnovne računarske zadatke. Nema naprednih karakteristika ili tehnologija koje biste očekivali na modernijim monitorima.', 'Ugovor 14/2023', 4, '1300-100004', 3, 3, '2023-10-31 21:10:55');

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

-- Dumping data for table inventory_v2.stock_feature: ~0 rows (approximately)
INSERT INTO `stock_feature` (`stock_feature_id`, `stock_id`, `feature_id`, `value`) VALUES
	(1, 1, 10, 'SFF'),
	(2, 1, 11, 'Intel I7 7000'),
	(3, 1, 13, '16GB'),
	(4, 1, 14, '512 SSD'),
	(5, 2, 10, 'Small Form Factor PC'),
	(6, 2, 11, 'Intel Core i5-10500 @ 3,1GHz'),
	(7, 2, 13, '8 GB'),
	(8, 2, 14, 'SSD-256GB'),
	(9, 3, 10, 'Small Form Factor PC'),
	(10, 3, 11, 'Intel Core i3-4130 CPU @ 3.40GHz'),
	(11, 3, 13, '8 GB'),
	(12, 3, 14, 'HDD-500GB'),
	(13, 4, 10, 'SFF'),
	(14, 4, 11, 'Intel Core 2 Duo E7200 processor 2.53 GHz, 3 MB L2 cache, 1066 MHz FSB'),
	(15, 4, 13, '4GB'),
	(16, 4, 14, 'HDD-256GB'),
	(17, 5, 10, 'SFF'),
	(18, 5, 11, 'Intel Core i7-4770'),
	(19, 5, 13, '8GB'),
	(20, 5, 14, '500GB'),
	(21, 6, 10, 'SFF'),
	(22, 6, 11, 'Intel Core i7-3770'),
	(23, 6, 13, '4GB'),
	(24, 6, 14, 'HDD - 500GB'),
	(25, 7, 10, 'SFF'),
	(26, 7, 11, 'I5 10500'),
	(27, 7, 13, '8GB'),
	(28, 7, 14, '256GB SSD'),
	(29, 8, 10, 'SFF'),
	(30, 8, 11, 'Intel Core i3'),
	(31, 8, 13, '8 GB'),
	(32, 8, 14, 'HDD - 500GB'),
	(33, 9, 17, 'IPS'),
	(34, 9, 19, '24 inch'),
	(35, 9, 20, '1000:1'),
	(36, 9, 21, '250 niti'),
	(37, 9, 22, '0.274 mm'),
	(38, 9, 23, '1xVGA, 4xUSB, 1xDP, 1xHDMI'),
	(39, 9, 24, 'FHD (1920 x 1080)'),
	(40, 10, 19, '19"'),
	(41, 10, 20, '1000000:1'),
	(42, 10, 23, 'VGA/DVI x2'),
	(43, 10, 24, '1440x900'),
	(44, 11, 19, '1280*1024'),
	(45, 11, 23, 'VGA'),
	(46, 12, 19, '1280*1024'),
	(47, 12, 22, '20'),
	(48, 12, 23, 'VGA'),
	(49, 12, 24, '1280*1024'),
	(50, 13, 17, '21,5'),
	(51, 13, 19, '1920*1080'),
	(52, 13, 23, 'VGA/HDMI'),
	(53, 14, 19, '1024*768'),
	(54, 14, 20, '400:1'),
	(55, 14, 21, '250 nits'),
	(56, 14, 23, 'VGA');

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
  KEY `job_id` (`job_id`),
  KEY `department_id` (`department_id`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `job` (`job_id`),
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`),
  CONSTRAINT `user_ibfk_3` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table inventory_v2.user: ~88 rows (approximately)
INSERT INTO `user` (`user_id`, `surname`, `forname`, `fullname`, `local_number`, `telephone`, `email`, `password_hash`, `job_id`, `department_id`, `location_id`, `registration_date`, `last_login_date`, `status`) VALUES
	(148, 'Mudžahid', 'Cerić', 'Cerić Mudžahid', '1696', '032/449-696', 'm.ceric@epbih.ba', 'A8E11064F018205C700B163E6AB9978077A5DF871F03AD1A43A569CC2D88957B1E44C92EE07EDBBC6523114B37002FE6BDEC5C7F4C03F1C87782312894DE3CB5', 2, 3, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(149, 'Sabit', 'Alić', 'Alić Sabit', '1608', '032/449-608', 's.alic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 7, 5, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(150, 'Emina', 'Hasić', 'Hasić Emina', '1613', '032/449-613', 'e.hasic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 6, 5, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(151, 'Zahid', 'Softić', 'Softić Zahid', '1682', '032/449-682', 'z.softic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 8, 5, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(152, 'Lejla', 'Pojskić', 'Pojskić Lejla', '1618', '032/449-618', 'l.carsimamovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 2, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(153, 'Kenan', 'Serdarević', 'Serdarević Kenan', '1617', '032/449-617', 'k.serdarevic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 8, 11, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(154, 'Lejla', 'Buza', 'Buza Lejla', '1651', '032/449-651', 'le.buza@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 27, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(155, 'Damir', 'Čauš', 'Čauš Damir', '1673', '032/449-673', 'd.caus@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 28, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(156, 'Edin', 'Arnaut', 'Arnaut Edin', '1601', '032/449-601', 'e.arnaut@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 12, 19, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(157, 'Ahmed', 'Mutapčić', 'Mutapčić Ahmed', '1602', '032-449-602', 'a.mutapcic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 13, 19, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(158, 'Azra', 'Talić', 'Talić Azra', '1603', '032/449-603', 'a.talic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 14, 19, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(159, 'Nedžad', 'Osmanović', 'Osmanović Nedžad', '1560', '032/449-560', 'ne.osmanovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 15, 19, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(160, 'Dženana', 'Skomorac - Kos', 'Skomorac - Kos Dženana', '1648', '032/449-648', 'dz.skomorac@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 20, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(161, 'Jasmin', 'Ćatić', 'Ćatić Jasmin', '1501', '032/449-501', 'j.catic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 16, 20, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(162, 'Asaf', 'Kajmaković', 'Kajmaković Asaf', '1501', '032/449-501', 'a.kajmakovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 16, 20, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(163, 'Raif', 'Mešić', 'Mešić Raif', '1501', '032/449-501', 'r.mesic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 16, 20, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(164, 'Halid', 'Zukić', 'Zukić Halid', '1657', '032/449-657', 'h.zukic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 21, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(165, 'Goran', 'Skočilić', 'Skočilić Goran', '1556', '032/449-556', 'g.skocilic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 17, 21, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(166, 'Nermin', 'Skenderović', 'Skenderović Nermin', '1557', '032/449-557', 'n.skenderovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 17, 21, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(167, 'Nihad', 'Kesić', 'Kesić Nihad', '1558', '032/449-558', 'n.kesic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 17, 21, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(168, 'Mirnes', 'Kaknjo', 'Kaknjo Mirnes', '1559', '032/449-559', 'm.kaknjo@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 17, 21, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(169, 'Enes', 'Krdžalić', 'Krdžalić Enes', '1612', '032/449-612', 'e.krdzalic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 18, 34, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(170, 'Edin', 'Kovač', 'Kovač Edin', '1612', '032/449-612', 'e.kovac@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 19, 34, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(171, 'Adnan', 'Ibreljić', 'Ibreljić Adnan', '1658', '032/449-658', 'a.ibreljic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 20, 34, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(172, 'Ernes', 'Bedak', 'Bedak Ernes', '1611', '032/449-611', 'e.bedak@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 6, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(173, 'Armin', 'Bašić', 'Bašić Armin', '1611', '032/449-611', 'ar.basic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 21, 6, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(174, 'Mirha', 'Ćatić', 'Ćatić Mirha', '1615', '032/449-615', 'm.catic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 10, 6, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(175, 'Mirha', 'Bašić', 'Bašić Mirha', '1614', '032/449-614', 'mirha.basic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 11, 6, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(176, 'Mirsad', 'Bečić', 'Bečić Mirsad', '1610', '032/449-610', 'm.becic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 7, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(177, 'Adis', 'Redžepović', 'Redžepović Adis', '1697', '032/449-697', 'a.redzepovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 22, 7, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(178, 'Amina', 'Kavazovic', 'Kavazovic Amina', '1694', '032/449-694', 'a.kavazovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 23, 7, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(179, 'Jasmina', 'Karić', 'Karić Jasmina', '1607', '032/449-607', 'j.cucukovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 24, 7, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(180, 'Armin', 'Maličbegović', 'Maličbegović Armin', '1609', '032/449-609', 'a.mlicbegovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 25, 7, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(181, 'Mirhat', 'Đuherić', 'Đuherić Mirhat', '1677', '032/449-677', 'm.dzuheric@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 26, 7, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(182, 'Rukija', 'Huseinspahić', 'Huseinspahić Rukija', '1622', '032/449-622', 'r.huseinspahic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 27, 7, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(183, 'Amra', 'Imamović', 'Imamović Amra', '1678', '032/449-678', 'am.imamovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 8, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(184, 'Sead', 'Kratina', 'Kratina Sead', '1606', '032/449-606', 's.kratina@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 28, 9, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(185, 'Smaragda', 'Imamović', 'Imamović Smaragda', '1606', '032/449-606', 's.imamovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 29, 9, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(186, 'Benjamin', 'Kovačević', 'Kovačević Benjamin', '1679', '032/449-679', 'b.kovacevuc@epbih.ba', 'D8C078577BE9F6B3F869EBF5E2E19009FFDF74C7BD3821BD6A8D0745F922E09A33C3AD3C41FEB58E5DC8B625E96CF39FF91416FDA190A362E5E9B1ABAE1AECEF', 9, 12, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(187, 'Kenan', 'Dželo', 'Dželo Kenan', '1619', '032/449-619', 'k.dzelo@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 31, 12, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(188, 'Asmir', 'Džidić', 'Džidić Asmir', '1674', '032/449-674', 'a.dzidic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 32, 12, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(189, 'Igor', 'Primorac', 'Primorac Igor', '1553', '032/449-553', 'i.primorac@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 13, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(190, 'Senad', 'Čaušević', 'Čaušević Senad', '1551', '032/449-551', 's.causevic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 33, 13, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(191, 'Hazim', 'Durmić', 'Durmić Hazim', '1551', '032/449-551', 'h.durmic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 33, 13, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(192, 'Samrudin', 'Kubat', 'Kubat Samrudin', '1551', '032/449-551', 'k.samrudin@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 33, 13, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(193, 'Samir', 'Kadić', 'Kadić Samir', '1552', '032/449-552', 's.kadic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 33, 13, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(194, 'Enes', 'Malkoć', 'Malkoć Enes', '1552', '032/449-552', 'e.malkoc@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 33, 13, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(195, 'Mirza', 'Serdarević', 'Serdarević Mirza', '1698', '032/449-698', 'm.serdarevic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 34, 13, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(196, 'Edin', 'Opardija', 'Opardija Edin', '1516', '032/449-516', 'e.opardija@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 35, 15, 3, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(197, 'Ermin', 'Husagić', 'Husagić Ermin', '1518', '032/449-518', 'e.husagic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 36, 15, 3, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(198, 'Admir', 'Nizamic', 'Nizamic Admir', '1518', '032/449-518', 'a.nizamic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 37, 15, 3, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(199, 'Amel', 'Čajdrić', 'Čajdrić Amel', '1519', '032/449-519', 'a.cajdric@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 36, 3, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(200, 'Amar', 'Kasap', 'Kasap Amar', '1666', '032/449-666', 'a.kasap@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 25, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(201, 'Hedina', 'Čaušević', 'Čaušević Hedina', '1635', '032/449-635', 'he.causevic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 39, 25, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(202, 'Senad', 'Ćatić', 'Ćatić Senad', '60847', '032/609-847', 'se.catic@elektroprivreda.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 42, 25, 35, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(203, 'Kemal', 'Dautbegović', 'Dautbegović Kemal', '1641', '032/449-641', 'k.dautbegovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 40, 25, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(204, 'Edin', 'Heremić', 'Heremić Edin', '1532', '032/449-532', 'e.heremic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 41, 25, 3, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(205, 'Subhija', 'Muharemović', 'Muharemović Subhija', '1636', '032/449-636', 's.muharemovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 40, 25, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(206, 'Mustafa', 'Omanović', 'Omanović Mustafa', '61080', '032/786-080', 'm.omanovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 42, 25, 36, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(207, 'Amra', 'Pojskić', 'Pojskić Amra', '1621', '032/449-621', 'a.pojskic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 8, 29, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(208, 'Rašida', 'Hajdić', 'Hajdić Rašida', '1615', '032/449-615', 'r.hajdic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 32, 12, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(209, 'Emir', 'Hedžić', 'Hedžić Emir', '1654', '032/449-654', 'e.hedzic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 44, 3, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(210, 'Evel', 'Subašić', 'Subašić Evel', '1653', '062/449-653', 'evels@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 44, 3, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(211, 'Aidin', 'Pripoljac', 'Pripoljac Aidin', '1561', '032/449-561', 'a.pripoljac@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 45, 38, 37, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(212, 'Tarik', 'Krivokapa', 'Krivokapa Tarik', '1615', '032/449-615', 't.krivokapa@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 11, 6, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(213, 'Vedad', 'Smailbegović', 'Smailbegović Vedad', '1619', '032/449-619', 'v.smailbegovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 32, 12, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(214, 'Irfan', 'Vilašević', 'Vilašević Irfan', '61700', '032/699-700', 'v.irfan@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 45, 39, 38, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(215, 'Amina', 'Alibašić', 'Alibašić Amina', '1640', '032/449-640', 'a.alibasic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 46, 40, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(216, 'Derviša', 'Kalčo', 'Kalčo Derviša', '1640', '032/449-640', 'd.kalco@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 48, 24, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(217, 'Emira', 'Brajlović', 'Brajlović Emira', '1625', '032/449-625', 'em.brajlovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 47, 31, 2, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(218, 'Mahir', 'Nurudinović', 'Nurudinović Mahir', '', '', 'm.nurudinovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 52, 44, 36, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(219, 'Sanel', 'Begić', 'Begić Sanel', '', '', 's.begic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 51, 45, 36, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(220, 'Nijaz', 'Ćosić', 'Ćosić Nijaz', '', '', 'n.cosic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 51, 44, 36, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(221, 'Emir', 'Hrnjić', 'Hrnjić Emir', '', '', 'e.hrnjic@epbih.ba', 'CF83E1357EEFB8BDF1542850D66D8007D620E4050B5715DC83F4A921D36CE9CE47D0D13C5D85F2B0FF8318D2877EEC2F63B931BD47417A81A538327AF927DA3E', 45, 54, 36, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(222, 'Hasan', 'Blažević', 'Blažević Hasan', '', '', 'h.blazevic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 50, 45, 36, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(223, 'Omer', 'Dedić', 'Dedić Omer', '', '', 'o.dedic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 50, 44, 36, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(224, 'Amina', 'Šabanović', 'Šabanović Amina', '', '', 'a.sabanovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 49, 32, 36, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(225, 'Adis', 'Aslani', 'Aslani Adis', '', '', 'a.aslani@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 97, 57, 39, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(226, 'Nedžad', 'Begić', 'Begić Nedžad', '', '', 'nedz.begic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 51, 44, 39, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(227, 'Elvedina', 'Subašić', 'Subašić Elvedina', '', '', 'elv.subasic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 56, 32, 39, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(228, 'Mufida', 'Mušija', 'Mušija Mufida', '', '', 'm.musija@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 55, 46, 39, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(229, 'Binela', 'Trako', 'Trako Binela', '', '', 'b.trako@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 54, 31, 39, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(230, 'Edina', 'Mehanović', 'Mehanović Edina', '', '', 'e.mehanovic@epbih.ba', '46BA74B0B0C2008A4CEBFAB218A713F46486305777B6FE3AD8D13003F9D551B1754EABD8984F63D93F366E793C8913670E5BC113CCEB0CC3D9970F0904C66D54', 53, 41, 39, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(231, 'Mahir', 'Lopo', 'Lopo Mahir', '', '', 'ma.lopo@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 65, 44, 39, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(232, 'Adnan', 'Husika', 'Husika Adnan', '', '', 'ad.husika@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 45, 46, 39, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(233, 'Indira', 'Čaluk', 'Čaluk Indira', '', '', 'i.caluk@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 57, 32, 39, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(234, 'Zijad', 'Kovač', 'Kovač Zijad', '', '', 'zi.kovac@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 58, 43, 39, '2023-10-31 18:20:23', NULL, 'neaktivan'),
	(235, 'Dzemal', 'Pačariz', 'Pačariz Dzemal', '', '', 'dz.pacariz@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 50, 45, 39, '2023-10-31 18:20:23', NULL, 'neaktivan');

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
