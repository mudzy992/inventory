-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.1.0 - MySQL Community Server - GPL
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
  `username` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  PRIMARY KEY (`administrator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory_v2.administrator_token
CREATE TABLE IF NOT EXISTS `administrator_token` (
  `administrator_token_id` int NOT NULL AUTO_INCREMENT,
  `administrator_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `token` varchar(255) NOT NULL,
  `expire_at` timestamp NULL DEFAULT NULL,
  `is_valid` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`administrator_token_id`),
  KEY `administrator_id` (`administrator_id`),
  CONSTRAINT `administrator_token_ibfk_1` FOREIGN KEY (`administrator_id`) REFERENCES `administrator` (`administrator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory_v2.article
CREATE TABLE IF NOT EXISTS `article` (
  `article_id` int NOT NULL AUTO_INCREMENT,
  `serial_number` varchar(50) DEFAULT NULL,
  `inv_number` varchar(50) DEFAULT NULL,
  `user_id` int NOT NULL,
  `document_id` int NOT NULL,
  `status` enum('zaduženo','razduženo','otpisano') DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `stock_id` int DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`article_id`),
  KEY `user_id` (`user_id`),
  KEY `fk_article_stock` (`stock_id`),
  CONSTRAINT `article_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `article_ibfk_2` FOREIGN KEY (`stock_id`) REFERENCES `stock` (`stock_id`),
  CONSTRAINT `fk_article_stock` FOREIGN KEY (`stock_id`) REFERENCES `stock` (`stock_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

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
) ENGINE=InnoDB AUTO_INCREMENT=426 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Data exporting was unselected.

-- Dumping structure for table inventory_v2.article_timeline
CREATE TABLE IF NOT EXISTS `article_timeline` (
  `article_timeline_id` int NOT NULL AUTO_INCREMENT,
  `article_id` int NOT NULL,
  `user_id` int NOT NULL,
  `document_id` int NOT NULL,
  `serial_number` varchar(50) DEFAULT NULL,
  `status` enum('zaduženo','razduženo','otpisano') DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `inv_number` varchar(50) DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`article_timeline_id`),
  KEY `article_id` (`article_id`),
  KEY `user_id` (`user_id`),
  KEY `document_id` (`document_id`),
  CONSTRAINT `article_timeline_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`),
  CONSTRAINT `article_timeline_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `article_timeline_ibfk_3` FOREIGN KEY (`document_id`) REFERENCES `documents` (`documents_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory_v2.category
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `parent_category_id` int DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  KEY `parent_category_id` (`parent_category_id`),
  CONSTRAINT `category_ibfk_1` FOREIGN KEY (`parent_category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory_v2.department
CREATE TABLE IF NOT EXISTS `department` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `departmend_code` varchar(50) DEFAULT NULL,
  `parent_department_id` int DEFAULT NULL,
  PRIMARY KEY (`department_id`),
  KEY `parent_department_id` (`parent_department_id`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`parent_department_id`) REFERENCES `department` (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

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

-- Data exporting was unselected.

-- Dumping structure for table inventory_v2.documents
CREATE TABLE IF NOT EXISTS `documents` (
  `documents_id` int NOT NULL AUTO_INCREMENT,
  `article_id` int NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `document_number` varchar(50) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`documents_id`),
  KEY `article_id` (`article_id`),
  CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory_v2.feature
CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `category_id` int NOT NULL,
  PRIMARY KEY (`feature_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `feature_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory_v2.job
CREATE TABLE IF NOT EXISTS `job` (
  `job_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `description` text,
  `job_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory_v2.location
CREATE TABLE IF NOT EXISTS `location` (
  `location_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  `parent_location_id` int DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  UNIQUE KEY `code` (`code`),
  KEY `parent_location_id` (`parent_location_id`),
  CONSTRAINT `location_ibfk_1` FOREIGN KEY (`parent_location_id`) REFERENCES `location` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory_v2.stock
CREATE TABLE IF NOT EXISTS `stock` (
  `stock_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `excerpt` text,
  `description` text,
  `contract` varchar(255) DEFAULT NULL,
  `category_id` int NOT NULL,
  `sap_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `value_on_contract` int NOT NULL DEFAULT (0),
  `value_available` int NOT NULL DEFAULT (0),
  `timestamp` timestamp NOT NULL DEFAULT (now()),
  PRIMARY KEY (`stock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory_v2.upgrade_feature
CREATE TABLE IF NOT EXISTS `upgrade_feature` (
  `upgrade_feature_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `value` decimal(10,2) NOT NULL,
  `timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` text,
  `serial_number` varchar(50) DEFAULT NULL,
  `article_id` int NOT NULL,
  PRIMARY KEY (`upgrade_feature_id`),
  KEY `article_id` (`article_id`),
  CONSTRAINT `upgrade_feature_ibfk_1` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory_v2.user
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `surname` varchar(255) NOT NULL,
  `forname` varchar(255) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `local_number` varchar(50) NOT NULL,
  `telephone` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `job_id` int NOT NULL,
  `department_id` int NOT NULL,
  `location_id` int NOT NULL,
  `registration_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login_date` timestamp NULL DEFAULT NULL,
  `status` enum('aktivan','neaktivan') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'neaktivan',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `local_number` (`local_number`),
  KEY `job_id` (`job_id`),
  KEY `department_id` (`department_id`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `job` (`job_id`),
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`),
  CONSTRAINT `user_ibfk_3` FOREIGN KEY (`location_id`) REFERENCES `location` (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

-- Dumping structure for table inventory_v2.user_token
CREATE TABLE IF NOT EXISTS `user_token` (
  `user_token_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `token` varchar(255) NOT NULL,
  `expire_at` timestamp NULL DEFAULT NULL,
  `is_valid` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user_token_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_token_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Data exporting was unselected.

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
