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
CREATE DATABASE IF NOT EXISTS `inventory` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `inventory`;

-- Dumping structure for table inventory.administrator
CREATE TABLE IF NOT EXISTS `administrator` (
  `administrator_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `password_hash` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  PRIMARY KEY (`administrator_id`),
  UNIQUE KEY `administrator_username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.administrator: ~0 rows (approximately)
DELETE FROM `administrator`;
INSERT INTO `administrator` (`administrator_id`, `username`, `password_hash`) VALUES
	(1, 'admin', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE');

-- Dumping structure for table inventory.administrator_token
CREATE TABLE IF NOT EXISTS `administrator_token` (
  `administrator_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `administrator_id` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` varchar(2550) COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `expire_at` datetime NOT NULL,
  `is_valid` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`administrator_token_id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.administrator_token: ~44 rows (approximately)
DELETE FROM `administrator_token`;
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
	(55, 1, '2022-11-13 17:40:11', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjcxMDM5NjExLjAwMSwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0KSBBcHBsZVdlYktpdC81MzcuMzYgKEtIVE1MLCBsaWtlIEdlY2tvKSBDaHJvbWUvMTA3LjAuMC4wIFNhZmFyaS81MzcuMzYgRWRnLzEwNy4wLjE0MTguNDIiLCJpYXQiOjE2NjgzNjEyMTF9.D9qC-S12ZabZcppYiNOd68Ss38StxGFpZ4ZEVRTHBAQ', '2022-12-14 17:40:11', 1);

-- Dumping structure for table inventory.article
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
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.article: ~11 rows (approximately)
DELETE FROM `article`;
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
	(98, 'ASUS VW199T-P 19"', '19 inča monitor', '19 inča monitor kocka', 'ABA-162819-272/2022', 10, 'Komentare brisemo', '1300-183994');

-- Dumping structure for table inventory.article_feature
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
) ENGINE=InnoDB AUTO_INCREMENT=387 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.article_feature: ~49 rows (approximately)
DELETE FROM `article_feature`;
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
	(365, 90, 11, 'Intel I7 7000'),
	(366, 90, 14, '1TB HDD'),
	(367, 90, 13, '16GB'),
	(368, 90, 10, 'SFF radna stanica'),
	(374, 98, 23, 'VGA/DVI x2'),
	(375, 98, 20, '1000000:1'),
	(376, 98, 19, '19"'),
	(377, 98, 24, '1440x900'),
	(383, 97, 11, 'Intel Core i7-3770'),
	(384, 97, 14, '500GB'),
	(385, 97, 13, '4GB'),
	(386, 97, 10, 'SFF');

-- Dumping structure for table inventory.category
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.category: ~8 rows (approximately)
DELETE FROM `category`;
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
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.debt_items: ~0 rows (approximately)
DELETE FROM `debt_items`;
INSERT INTO `debt_items` (`debt_items_id`, `user_article_id`, `article_id`, `user_id`, `document_id`, `value`, `timestamp`, `serial_number`, `status`, `comment`, `inv_broj`) VALUES
	(82, 275, 96, 152, 211, 1, '2022-11-13 23:36:20', '51738FEN', 'razduženo', '', 'ZE0621548');

-- Dumping structure for table inventory.department
CREATE TABLE IF NOT EXISTS `department` (
  `department_id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT 'undefined',
  `description` varchar(250) COLLATE utf8mb4_bs_0900_ai_ci DEFAULT NULL,
  `departmend_code` varchar(50) COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT 'undefined',
  `parent_department_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`department_id`) USING BTREE,
  KEY `FK_department_department` (`parent_department_id`),
  CONSTRAINT `FK_department_department` FOREIGN KEY (`parent_department_id`) REFERENCES `department` (`department_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.department: ~26 rows (approximately)
DELETE FROM `department`;
INSERT INTO `department` (`department_id`, `title`, `description`, `departmend_code`, `parent_department_id`) VALUES
	(2, 'Sektor za IKT', 'Sektor za informacione i komunikacione tehnologije IKT', '1302516462', NULL),
	(3, 'Služba za IKT Zenica', 'Sektor za informacione i komunikacione tehnologije IKT Zenica', '13025164621', 2),
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
	(31, 'Služba za naplatu i utuženja', '', '104020602', 29);

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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.department_job: ~19 rows (approximately)
DELETE FROM `department_job`;
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
	(33, 6, 11, 2);

-- Dumping structure for table inventory.destroyed
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.destroyed: ~0 rows (approximately)
DELETE FROM `destroyed`;

-- Dumping structure for table inventory.documents
CREATE TABLE IF NOT EXISTS `documents` (
  `documents_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL,
  `path` varchar(255) COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `document_number` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`documents_id`),
  KEY `fk_documents_article_id` (`article_id`),
  CONSTRAINT `fk_documents_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.documents: ~5 rows (approximately)
DELETE FROM `documents`;
INSERT INTO `documents` (`documents_id`, `article_id`, `path`, `document_number`) VALUES
	(204, 93, 'prenosnica1.docx', 1),
	(205, 93, 'prenosnica2.docx', 2),
	(206, 90, 'prenosnica3.docx', 3),
	(207, 93, 'prenosnica4.docx', 4),
	(208, 95, 'prenosnica5.docx', 5),
	(209, 96, 'prenosnica6.docx', 6),
	(210, 96, 'prenosnica7.docx', 7),
	(211, 96, 'prenosnica8.docx', 8);

-- Dumping structure for table inventory.feature
CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `uq_feature_category_id_name` (`category_id`,`name`),
  KEY `fk_feature_category_id` (`category_id`) USING BTREE,
  CONSTRAINT `fk_feature_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.feature: ~19 rows (approximately)
DELETE FROM `feature`;
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
	(48, 'Proizvođać', 12),
	(47, 'Tip', 18),
	(49, 'DPI', 20),
	(50, 'Tip', 20);

-- Dumping structure for table inventory.job
CREATE TABLE IF NOT EXISTS `job` (
  `job_id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(250) COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT 'undefined',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci DEFAULT NULL,
  `job_code` varchar(50) COLLATE utf8mb4_bs_0900_ai_ci NOT NULL DEFAULT 'undefined',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.job: ~7 rows (approximately)
DELETE FROM `job`;
INSERT INTO `job` (`job_id`, `title`, `description`, `job_code`) VALUES
	(2, 'Tehničar za IKT **', 'Tehničar za IKT ** Zenica', '936545'),
	(6, 'Koordinator za GIS', 'Koordinator za GIS', 'undefined'),
	(7, 'Projekt menadžer', 'Projekt menadžer', 'undefined'),
	(8, 'Rukovodilac sektora', 'Rukovodilac sektora', 'undefined'),
	(9, 'Rukovodilac službe', 'Rukovodilac službe', 'undefined'),
	(10, 'Referent za pripremu investicija', '', ''),
	(11, 'Stručni saradnik za pripremu investicija', '', '');

-- Dumping structure for table inventory.location
CREATE TABLE IF NOT EXISTS `location` (
  `location_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `parent_location_id` int unsigned DEFAULT NULL,
  PRIMARY KEY (`location_id`),
  KEY `FK_location_location` (`parent_location_id`),
  CONSTRAINT `FK_location_location` FOREIGN KEY (`parent_location_id`) REFERENCES `location` (`location_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.location: ~4 rows (approximately)
DELETE FROM `location`;
INSERT INTO `location` (`location_id`, `name`, `code`, `parent_location_id`) VALUES
	(1, 'ED Zenica', '101', NULL),
	(2, 'Direkcija Zenica', '103', 1),
	(3, 'PJD Zenica', '10303', 1),
	(34, 'PJD Visoko', '105', 1);

-- Dumping structure for table inventory.responsibility
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
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.responsibility: ~4 rows (approximately)
DELETE FROM `responsibility`;
INSERT INTO `responsibility` (`responsibility_id`, `user_article_id`, `user_id`, `article_id`, `document_id`, `value`, `status`, `timestamp`, `serial_number`, `inv_broj`) VALUES
	(128, 269, 148, 90, 206, 1, 'zaduženo', '2022-11-02 21:46:35', 'KJKSZPJ', 'ZE0621548'),
	(129, 270, 148, 93, 207, 1, 'zaduženo', '2022-11-13 18:31:51', 'HDIS63839', 'ZE0685862'),
	(130, 271, 148, 95, 208, 1, 'zaduženo', '2022-11-13 18:32:47', 'Bsjfhkakd', 'ZE06858778');

-- Dumping structure for table inventory.stock
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
) ENGINE=InnoDB AUTO_INCREMENT=446 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.stock: ~12 rows (approximately)
DELETE FROM `stock`;
INSERT INTO `stock` (`stock_id`, `article_id`, `value_on_concract`, `value_available`, `timestamp`, `sap_number`) VALUES
	(192, 91, 1, 0, '2022-03-14 22:45:34', '1300-100525'),
	(217, 84, 50, 38, '2022-03-18 14:42:55', '1300-200201'),
	(360, 97, 30, 30, '2022-03-31 16:05:38', '1300-005248'),
	(361, 98, 5, 5, '2022-03-31 16:26:03', '1300-183994'),
	(367, 85, 15, 17, '2022-03-31 17:58:45', '1300-200202'),
	(413, 92, 5, 0, '2022-04-30 03:48:59', '1300-132525'),
	(434, 102, 131, 2, '2022-10-22 17:26:31', 'ZE06879222'),
	(437, 83, 50, 29, '2022-10-22 17:41:16', '1300-200205'),
	(440, 90, 5, 2, '2022-11-02 21:46:35', '1300-100200'),
	(441, 93, 1, 2, '2022-11-13 18:31:51', 'ZE0687922'),
	(442, 95, 30, 29, '2022-11-13 18:32:47', '1300-551455'),
	(445, 96, 1, 1, '2022-11-13 23:36:20', '1300-005254');

-- Dumping structure for table inventory.upgrade_feature
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.upgrade_feature: ~3 rows (approximately)
DELETE FROM `upgrade_feature`;
INSERT INTO `upgrade_feature` (`upgrade_feature_id`, `name`, `value`, `timestamp`, `comment`, `serial_number`, `article_id`) VALUES
	(3, 'SSD', '256GB', '2022-07-14 10:08:32', 'Ugrađen SSD 256GB, ostavljen HDD 500GB zbog podataka. Urađeno detaljno čišćenje radne stanice.', 'KJKSZPJJJ', 92),
	(4, 'HDD', '500GB', '2022-10-21 18:05:27', 'Ugrađen HDD iz starog računara zbog podataka.', '51738FEN', 90),
	(5, 'SSD', '256 GB', '2022-11-13 22:53:30', 'Izvađen stari HDD od 500GB te umjesto njega ugrađen SDD 256GB', 'KJKSZPJ', 90);

-- Dumping structure for table inventory.user
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
) ENGINE=InnoDB AUTO_INCREMENT=156 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.user: ~8 rows (approximately)
DELETE FROM `user`;
INSERT INTO `user` (`user_id`, `surname`, `forname`, `fullname`, `local_number`, `telephone`, `email`, `password_hash`, `job_id`, `department_id`, `location_id`) VALUES
	(148, 'Mudžahid', 'Cerić', 'Cerić Mudžahid', '1696', '032/449-696', 'm.ceric@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 2, 3, 2),
	(149, 'Sabit', 'Alić', 'Alić Sabit', '1608', '032/449-608', 's.alic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 7, 5, 2),
	(150, 'Emina', 'Hasić', 'Hasić Emina', '1613', '032/449-613', 'e.hasic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 6, 5, 2),
	(151, 'Zahid', 'Softić', 'Softić Zahid', '1682', '032/449-682', 'z.softic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 8, 5, 2),
	(152, 'Lejla', 'Čaršimamović', 'Čaršimamović Lejla', '1618', '032/449-618', 'l.carsimamovic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 2, 2),
	(153, 'Kenan', 'Serdarević', 'Serdarević Kenan', '1617', '032/449-617', 'k.serdarevic@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 8, 11, 2),
	(154, 'Lejla', 'Buza', 'Buza Lejla', '1651', '032/449-651', 'le.buza@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 27, 2),
	(155, 'Damir', 'Čauš', 'Čauš Damir', '1673', '032/449-673', 'd.caus@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE', 9, 28, 2);

-- Dumping structure for table inventory.user_article
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
) ENGINE=InnoDB AUTO_INCREMENT=276 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.user_article: ~4 rows (approximately)
DELETE FROM `user_article`;
INSERT INTO `user_article` (`user_article_id`, `article_id`, `document_id`, `user_id`, `serial_number`, `status`, `timestamp`, `comment`, `inv_broj`) VALUES
	(269, 90, 206, 148, 'KJKSZPJ', 'zaduženo', '2022-11-02 21:46:35', 'Zaduženje nove opreme', 'ZE0621548'),
	(270, 93, 207, 148, 'HDIS63839', 'zaduženo', '2022-11-13 18:31:51', 'Zaduženje nove opreme', 'ZE0685862'),
	(271, 95, 208, 148, 'Bsjfhkakd', 'zaduženo', '2022-11-13 18:32:47', 'Zaduženje nove opreme', 'ZE06858778'),
	(272, 96, 208, 148, '51738FEN', 'zaduženo', '2022-11-13 23:29:22', 'Zaduženje opreme', 'ZE0621548'),
	(273, 96, 209, 148, '51738FEN', 'razduženo', '2022-11-13 23:30:54', '', 'ZE0621548'),
	(274, 96, 210, 152, '51738FEN', 'zaduženo', '2022-11-13 23:32:51', 'Zaduženje nove opreme', 'ZE0621548'),
	(275, 96, 211, 152, '51738FEN', 'razduženo', '2022-11-13 23:36:20', '', 'ZE0621548');

-- Dumping structure for table inventory.user_token
CREATE TABLE IF NOT EXISTS `user_token` (
  `user_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` varchar(2550) COLLATE utf8mb4_bs_0900_ai_ci NOT NULL,
  `expire_at` datetime NOT NULL,
  `is_valid` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_token_id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bs_0900_ai_ci;

-- Dumping data for table inventory.user_token: ~44 rows (approximately)
DELETE FROM `user_token`;
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
	(51, 148, '2022-11-13 23:22:08', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjoxNDgsImlkZW50aXR5IjoibS5jZXJpY0BlcGJpaC5iYSIsImV4cCI6MTY3MTA2MDEyOC4yNjUsImlwIjoiOjpmZmZmOjE5Mi4xNjguMC4xMyIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwNy4wLjAuMCBTYWZhcmkvNTM3LjM2IEVkZy8xMDcuMC4xNDE4LjQyIiwiaWF0IjoxNjY4MzgxNzI4fQ.SYkGvPZYsk2jia3hB7zU9tm4rWsjyN7QYwI_KyHJNw8', '2022-12-14 23:22:08', 1);

-- Dumping structure for trigger inventory.user_before_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `user_before_insert` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
SET NEW.fullname = (CONCAT(NEW.forname, ' ', NEW.surname));
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger inventory.user_before_update
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
