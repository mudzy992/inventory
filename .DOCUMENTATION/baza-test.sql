-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
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
DROP DATABASE IF EXISTS `inventory`;
CREATE DATABASE IF NOT EXISTS `inventory` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `inventory`;

-- Dumping structure for table inventory.administrator
DROP TABLE IF EXISTS `administrator`;
CREATE TABLE IF NOT EXISTS `administrator` (
  `administrator_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `password_hash` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  PRIMARY KEY (`administrator_id`),
  UNIQUE KEY `administrator_username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory.administrator_token
DROP TABLE IF EXISTS `administrator_token`;
CREATE TABLE IF NOT EXISTS `administrator_token` (
  `administrator_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `administrator_id` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` varchar(2550) COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `expire_at` datetime NOT NULL,
  `is_valid` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`administrator_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory.article
DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT '0',
  `excerpt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT '0',
  `description` varchar(450) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT '0',
  `concract` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci DEFAULT NULL,
  `sap_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`article_id`),
  KEY `fk_article_category_id` (`category_id`),
  CONSTRAINT `fk_article_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory.article_feature
DROP TABLE IF EXISTS `article_feature`;
CREATE TABLE IF NOT EXISTS `article_feature` (
  `article_feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `feature_id` int unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`article_feature_id`),
  UNIQUE KEY `uq_article_feature_article_id_feature_id` (`article_id`,`feature_id`) USING BTREE,
  KEY `fk_article_feature_feature_id` (`feature_id`) USING BTREE,
  CONSTRAINT `fk_article_feature_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_article_feature_feature_id` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`feature_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory.category
DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT '0',
  `image_path` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT '',
  `parent__category_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uq_category_name` (`name`),
  UNIQUE KEY `uq_category_image_path` (`image_path`),
  KEY `fk_category_parent__category_id` (`parent__category_id`) USING BTREE,
  CONSTRAINT `FK_category_category` FOREIGN KEY (`parent__category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory.debt_items
DROP TABLE IF EXISTS `debt_items`;
CREATE TABLE IF NOT EXISTS `debt_items` (
  `debt_items_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_article_id` int unsigned NOT NULL,
  `article_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `document_id` int unsigned NOT NULL,
  `value` int NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serial_number` varchar(255) COLLATE utf8mb4_bs_0900_ai_ci DEFAULT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT 'razduženo',
  `comment` varchar(255) COLLATE utf8mb4_bs_0900_ai_ci DEFAULT NULL,
  `inv_broj` varchar(50) COLLATE utf8mb4_bs_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`debt_items_id`),
  UNIQUE KEY `article_id_user_id_timestamp_serial_number` (`article_id`,`user_id`,`timestamp`,`serial_number`) USING BTREE,
  KEY `fk_debt_items_document_id` (`document_id`),
  KEY `FK_debt_items_user_article` (`user_id`) USING BTREE,
  KEY `fk_debt_items_user_article_id` (`user_article_id`) USING BTREE,
  CONSTRAINT `fk_debt_items_article_di` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_debt_items_document_id` FOREIGN KEY (`document_id`) REFERENCES `documents` (`documents_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_debt_items_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_debt_items_user_article_id` FOREIGN KEY (`user_article_id`) REFERENCES `user_article` (`user_article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory.department
DROP TABLE IF EXISTS `department`;
CREATE TABLE IF NOT EXISTS `department` (
  `department_id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT 'undefined',
  `description` varchar(250) COLLATE utf8mb4_bs_0900_ai_ci DEFAULT NULL,
  `departmend_code` varchar(50) COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT 'undefined',
  `parent_department_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`department_id`) USING BTREE,
  KEY `FK_department_department` (`parent_department_id`),
  CONSTRAINT `FK_department_department` FOREIGN KEY (`parent_department_id`) REFERENCES `department` (`department_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory.department_job
DROP TABLE IF EXISTS `department_job`;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory.destroyed
DROP TABLE IF EXISTS `destroyed`;
CREATE TABLE IF NOT EXISTS `destroyed` (
  `destroyed_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_article_id` int unsigned NOT NULL,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `document_id` int unsigned NOT NULL,
  `value` int NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serial_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT 'otpisano',
  `comment` varchar(255) COLLATE utf8mb4_bs_0900_ai_ci DEFAULT NULL,
  `inv_broj` varchar(50) COLLATE utf8mb4_bs_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`destroyed_id`),
  UNIQUE KEY `article_id_user_id_serial_number` (`article_id`,`user_id`,`serial_number`) USING BTREE,
  KEY `fk_destroyed_document_id` (`document_id`),
  KEY `fk_destroyed_user_id` (`user_id`) USING BTREE,
  KEY `fk_destroyed_user_article_id` (`user_article_id`) USING BTREE,
  CONSTRAINT `fk_destroyed_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_destroyed_document_id` FOREIGN KEY (`document_id`) REFERENCES `documents` (`documents_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_destroyed_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_destroyed_user_article_id` FOREIGN KEY (`user_article_id`) REFERENCES `user_article` (`user_article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory.documents
DROP TABLE IF EXISTS `documents`;
CREATE TABLE IF NOT EXISTS `documents` (
  `documents_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `document_number` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`documents_id`),
  KEY `fk_documents_article_id` (`article_id`),
  CONSTRAINT `fk_documents_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory.feature
DROP TABLE IF EXISTS `feature`;
CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `uq_feature_category_id_name` (`category_id`,`name`),
  KEY `fk_feature_category_id` (`category_id`) USING BTREE,
  CONSTRAINT `fk_feature_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory.job
DROP TABLE IF EXISTS `job`;
CREATE TABLE IF NOT EXISTS `job` (
  `job_id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(250) COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT 'undefined',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci DEFAULT NULL,
  `job_code` varchar(50) COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT 'undefined',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory.location
DROP TABLE IF EXISTS `location`;
CREATE TABLE IF NOT EXISTS `location` (
  `location_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `parent_location_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  KEY `FK_location_location` (`parent_location_id`),
  CONSTRAINT `FK_location_location` FOREIGN KEY (`parent_location_id`) REFERENCES `location` (`location_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory.responsibility
DROP TABLE IF EXISTS `responsibility`;
CREATE TABLE IF NOT EXISTS `responsibility` (
  `responsibility_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_article_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `document_id` int unsigned NOT NULL,
  `value` int NOT NULL DEFAULT '0',
  `status` enum('zaduženo','razduženo','otpisano') CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT 'zaduženo',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `serial_number` varchar(255) COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `inv_broj` varchar(50) COLLATE utf8mb4_bs_0900_ai_ci DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory.stock
DROP TABLE IF EXISTS `stock`;
CREATE TABLE IF NOT EXISTS `stock` (
  `stock_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `value_on_concract` int NOT NULL DEFAULT '0',
  `value_available` int NOT NULL DEFAULT '0',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sap_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`stock_id`),
  KEY `fk_stock_article_id` (`article_id`),
  CONSTRAINT `fk_stock_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory.upgrade_feature
DROP TABLE IF EXISTS `upgrade_feature`;
CREATE TABLE IF NOT EXISTS `upgrade_feature` (
  `upgrade_feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `value` varchar(50) COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` varchar(255) COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `serial_number` varchar(50) COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `article_id` int unsigned NOT NULL,
  PRIMARY KEY (`upgrade_feature_id`),
  KEY `fk_upgrade_feature_serial_number_user_article_serial_number` (`serial_number`),
  KEY `upgrade_feature_article_id_article_article_id` (`article_id`),
  CONSTRAINT `upgrade_feature_article_id_article_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `surname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT '0',
  `forname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT '0',
  `fullname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci DEFAULT NULL,
  `local_number` varchar(50) COLLATE utf8mb4_bs_0900_ai_ci DEFAULT NULL,
  `telephone` varchar(50) COLLATE utf8mb4_bs_0900_ai_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory.user_article
DROP TABLE IF EXISTS `user_article`;
CREATE TABLE IF NOT EXISTS `user_article` (
  `user_article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL,
  `document_id` int unsigned NOT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `serial_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `status` enum('zaduženo','razduženo','otpisano') CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci DEFAULT 'zaduženo',
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` varchar(255) COLLATE utf8mb4_bs_0900_ai_ci DEFAULT NULL,
  `inv_broj` varchar(50) COLLATE utf8mb4_bs_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`user_article_id`) USING BTREE,
  UNIQUE KEY `serial_number_status_timestamp` (`serial_number`,`status`,`timestamp`),
  KEY `fk_user_article_article_id` (`article_id`),
  KEY `fk_user_article_document_id` (`document_id`),
  KEY `fk_user_article_user_id` (`user_id`) USING BTREE,
  CONSTRAINT `fk_user_article_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_user_article_document_id` FOREIGN KEY (`document_id`) REFERENCES `documents` (`documents_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_user_article_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory.user_token
DROP TABLE IF EXISTS `user_token`;
CREATE TABLE IF NOT EXISTS `user_token` (
  `user_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` varchar(2550) COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `expire_at` datetime NOT NULL,
  `is_valid` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for trigger inventory.user_before_insert
DROP TRIGGER IF EXISTS `user_before_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `user_before_insert` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
SET NEW.fullname = (CONCAT(NEW.forname, ' ', NEW.surname));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger inventory.user_before_update
DROP TRIGGER IF EXISTS `user_before_update`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
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
