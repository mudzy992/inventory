/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE IF NOT EXISTS `inventory` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `inventory`;

CREATE TABLE IF NOT EXISTS `administrator` (
  `administrator_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password_hash` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`administrator_id`),
  UNIQUE KEY `administrator_username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `administrator`;
INSERT INTO `administrator` (`administrator_id`, `username`, `password_hash`) VALUES
	(1, 'admin', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE');

CREATE TABLE IF NOT EXISTS `administrator_token` (
  `administrator_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `administrator_id` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` varchar(2550) NOT NULL,
  `expire_at` datetime NOT NULL,
  `is_valid` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`administrator_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
	(31, 1, '2022-10-20 12:32:30', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYWRtaW5pc3RyYXRvciIsImlkIjoxLCJpZGVudGl0eSI6ImFkbWluIiwiZXhwIjoxNjY4OTQ3NTUwLjMxMiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDYuMC4wLjAgU2FmYXJpLzUzNy4zNiBFZGcvMTA2LjAuMTM3MC40NyIsImlhdCI6MTY2NjI2OTE1MH0.Pi-RudNDKicI66M8kjTN7YQ-bFVb_P5VScxDqVCF6co', '2022-11-20 12:32:30', 1);

CREATE TABLE IF NOT EXISTS `article` (
  `article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `excerpt` varchar(255) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `description` varchar(450) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `concract` varchar(255) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  `comment` varchar(255) CHARACTER SET utf32 COLLATE utf32_unicode_ci DEFAULT NULL,
  `sap_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`article_id`),
  KEY `fk_article_category_id` (`category_id`),
  CONSTRAINT `fk_article_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `article`;
INSERT INTO `article` (`article_id`, `name`, `excerpt`, `description`, `concract`, `category_id`, `comment`, `sap_number`) VALUES
	(83, 'ACME SSD HD11 1TB', 'Kratki opis 1', 'Detaljan opis', 'EPU-25154/2022', 8, '', '1300-200200'),
	(84, 'ACME SSD HD11 1024GB', 'Kratki opis', 'Detaljan opis', 'EPU-25154/2022', 8, 'Komentar 1024GB', '1300-200201'),
	(85, 'ACME SSD HD11 1024MB', 'Kratki opis', 'Detaljan opis', 'EPU-25154/2022', 8, 'Komentar 1024MB serverski', '1300-200202'),
	(90, 'ThinkCentre 720S', 'RaÄunar 720S', 'Detaljan opis raÄunara', 'EPU-25158/2022', 9, 'Komentarcicc', '1300-100200'),
	(91, 'HP ProDesk 600 G6', 'Small Form Factor PC', 'Opis raÄunara', 'EPU-232158/2022', 9, '', '1300-1005254'),
	(92, 'ThinkCentre M93', 'Small Form Factor PC', 'Opis raÄunara', 'EPU-233248/2022', 9, '', '1300-1325254'),
	(93, 'HP E24 G4 FHD Monitor', 'HP E24 G4 FHD Monitor', 'Opis monitor', 'EPU-232558/2022', 10, '', 'ZE0687922'),
	(95, 'HP Compaq dc7900 Small Form Factor', 'HP Compaq dc7900 poslovno raÄunalo', 'Energetski uÄinkovite tehnologije, vodeÄ‡a rjeÅ¡enja za upravljanje na daljinu i tri fleksibilna faktora oblika dizajnirana da odgovaraju vaÅ¡im specifiÄnim poslovnim potrebama -- HP Compaq dc7900 PC stabilna je platforma koja smanjuje troÅ¡kove posjedovanja.', '0', 9, NULL, '0'),
	(96, 'ThinkCentre M83 SFF Pro Desktop', 'The new small form factor (SFF) pro design features the compactness of the SFF with the expansion ability of a tower. The SFF desktops weigh in at 16.5 lbs / 7.8 kg and support both horizontal and vertical orientations.', 'The new small form factor (SFF) pro design features the compactness of the SFF with the expansion ability of a tower. The SFF desktops weigh in at 16.5 lbs / 7.8 kg and support both horizontal and vertical orientations.', 'EZE-254584/2022', 9, 'Komentare Ä‡e trebati ukinuti', '1300-005254'),
	(97, 'ThinkCentre M92/M92p Tiny, Small, Tower', 'This Tiny desktop packs a powerful enterprise performance and IntelÂ® vPro manageability into an ultra-compact form factor thatâ€™s energy-efficient and easy to manage.', 'This Tiny desktop packs a powerful enterprise performance and IntelÂ® vPro manageability into an ultra-compact form factor thatâ€™s energy-efficient and easy to manage.', 'EZE-58479/2022', 9, 'Komentare briÅ¡emo', '1300-005248'),
	(98, 'ASUS VW199T-P 19â€', '19 inÄa monitor', '19 inÄa monitor kocka', 'ABA-162819-272/2022', 10, 'Komentare brisemo', '1300-183994'),
	(99, 'Test', 'HP E24 G4 FHD Monitor', 'Opis monitor', 'EPU-232558/2022', 10, '', '1400-1538199'),
	(102, 'HP E23 G43 FHD Monitor', 'HP E24 G4 FHD Monitor ffff', 'Monitor je u idealnom stanju', 'EPU-232558/2023', 10, 'Nema komentara', 'ZE06879222');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
	(110, 96, 11, 'IntelÂ® Coreâ„¢ i7-4770'),
	(112, 96, 14, '500GB'),
	(113, 96, 13, '8GB'),
	(114, 96, 10, 'SFF'),
	(115, 97, 11, 'IntelÂ® Coreâ„¢ i7-3770'),
	(117, 97, 14, '500GB'),
	(118, 97, 13, '4GB'),
	(119, 97, 10, 'SFF'),
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
	(376, 98, 19, '19â€'),
	(377, 98, 24, '1440x900');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `category`;
INSERT INTO `category` (`category_id`, `name`, `image_path`, `parent__category_id`) VALUES
	(7, 'RaÄunarska oprema', 'bi bi-pc-display', NULL),
	(8, 'Memorija pohrane', 'bi bi-hdd', 9),
	(9, 'Radne stanice', 'bi bi-pc-display-horizontal', 7),
	(10, 'Monitor', 'bi bi-display', 7),
	(11, 'Telefoni', 'bi bi-telephone-fill', NULL),
	(12, 'BeÅ¾iÄni telefon', 'bi bi-phone-fill', 11),
	(18, 'Å½iÄni telefon', 'bi bi-phone', 11),
	(20, 'MiÅ¡', 'bi bi-mouse2-fill', 7);

CREATE TABLE IF NOT EXISTS `debt_items` (
  `debt_items_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_article_id` int unsigned NOT NULL,
  `article_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `document_id` int unsigned NOT NULL,
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
  KEY `fk_debt_items_document_id` (`document_id`),
  CONSTRAINT `fk_debt_items_article_di` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_debt_items_document_id` FOREIGN KEY (`document_id`) REFERENCES `documents` (`documents_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_debt_items_user_article_id` FOREIGN KEY (`user_article_id`) REFERENCES `user_article` (`user_article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_debt_items_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `debt_items`;
INSERT INTO `debt_items` (`debt_items_id`, `user_article_id`, `article_id`, `user_id`, `document_id`, `value`, `timestamp`, `serial_number`, `status`, `comment`, `inv_broj`) VALUES
	(72, 228, 83, 1, 139, 1, '2022-03-29 18:00:24', 'OHDUDE', 'razduÅ¾eno', 'RazduÅ¾ujem na skladiÅ¡te', 'ZE0685487'),
	(75, 235, 96, 7, 146, 1, '2022-03-31 17:55:39', 'HOHOHO3', 'razduÅ¾eno', 'RazduÅ¾ujem s Evela opremu. Oprema bi na prenosnici trebala da ode u skladiÅ¡te. Aplikativno bi trebala da se nalazi u Debt, i trebala bi da bude dostupna za zaduÅ¾enje u stock.', 'ZE0687290');

CREATE TABLE IF NOT EXISTS `department` (
  `department_id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'undefined',
  `description` varchar(250) DEFAULT NULL,
  `departmend_code` varchar(50) NOT NULL DEFAULT 'undefined',
  PRIMARY KEY (`department_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `department`;

CREATE TABLE IF NOT EXISTS `department_job` (
  `department_job_id` int unsigned NOT NULL AUTO_INCREMENT,
  `department_id` int unsigned NOT NULL DEFAULT '0',
  `job_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`department_job_id`),
  KEY `department_job_department_id` (`department_id`),
  KEY `department_job_job_id` (`job_id`),
  CONSTRAINT `department_job_department_id` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `department_job_job_id` FOREIGN KEY (`job_id`) REFERENCES `job` (`job_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `department_job`;

CREATE TABLE IF NOT EXISTS `destroyed` (
  `destroyed_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_article_id` int unsigned NOT NULL,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `document_id` int unsigned NOT NULL,
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
  KEY `fk_destroyed_document_id` (`document_id`),
  CONSTRAINT `fk_destroyed_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_destroyed_document_id` FOREIGN KEY (`document_id`) REFERENCES `documents` (`documents_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_destroyed_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_destroyed_user_article_id` FOREIGN KEY (`user_article_id`) REFERENCES `user_article` (`user_article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `destroyed`;
INSERT INTO `destroyed` (`destroyed_id`, `user_article_id`, `article_id`, `user_id`, `document_id`, `value`, `timestamp`, `serial_number`, `status`, `comment`, `inv_broj`) VALUES
	(1, 238, 85, 7, 149, 1, '2022-03-31 17:59:27', 'BRISANJE', 'otpisano', 'Artikal ide na otpis. I u ovom koraku isti sluÄaj kada ide sa korisnika na otpis treba poseban mehanizam.', 'ZE0685456');

CREATE TABLE IF NOT EXISTS `documents` (
  `documents_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL,
  `path` varchar(255) NOT NULL,
  `document_number` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`documents_id`),
  KEY `fk_documents_article_id` (`article_id`),
  CONSTRAINT `fk_documents_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `documents`;
INSERT INTO `documents` (`documents_id`, `article_id`, `path`, `document_number`) VALUES
	(126, 83, 'prenosnica48.docx', 48),
	(132, 83, 'prenosnica54.docx', 54),
	(133, 83, 'prenosnica4.docx', 4),
	(134, 83, 'prenosnica5.docx', 5),
	(135, 83, 'prenosnica6.docx', 6),
	(136, 83, 'prenosnica7.docx', 7),
	(137, 83, 'prenosnica8.docx', 8),
	(138, 83, 'prenosnica9.docx', 9),
	(139, 83, 'prenosnica10.docx', 10),
	(140, 83, 'prenosnica11.docx', 11),
	(141, 92, 'prenosnica11.docx', 11),
	(142, 92, 'prenosnica12.docx', 12),
	(143, 96, 'prenosnica13.docx', 13),
	(144, 96, 'prenosnica14.docx', 14),
	(145, 96, 'prenosnica15.docx', 15),
	(146, 96, 'prenosnica16.docx', 16),
	(147, 90, 'prenosnica17.docx', 17),
	(148, 85, 'prenosnica18.docx', 18),
	(149, 85, 'prenosnica.docx', 19),
	(150, 90, 'prenosnica20.docx', 20),
	(151, 90, 'prenosnica21.docx', 21),
	(152, 90, 'prenosnica22.docx', 22),
	(153, 99, 'prenosnica23.docx', 23),
	(154, 99, 'prenosnica24.docx', 24),
	(155, 99, 'prenosnica25.docx', 25),
	(156, 99, 'prenosnica26.docx', 26),
	(157, 102, 'prenosnica27.docx', 27),
	(158, 90, 'prenosnica28.docx', 28),
	(159, 92, 'prenosnica29.docx', 29),
	(160, 96, 'prenosnica30.docx', 30),
	(161, 96, 'prenosnica31.docx', 31),
	(162, 83, 'prenosnica32.docx', 32),
	(163, 83, 'prenosnica33.docx', 33),
	(164, 83, 'prenosnica34.docx', 34);

CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `uq_feature_category_id_name` (`category_id`,`name`),
  KEY `fk_feature_category_id` (`category_id`) USING BTREE,
  CONSTRAINT `fk_feature_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
	(48, 'ProizvoÄ‘aÄ‡', 12),
	(47, 'Tip', 18),
	(49, 'DPI', 20),
	(50, 'Tip', 20);

CREATE TABLE IF NOT EXISTS `job` (
  `job_id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL DEFAULT 'undefined',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `job_code` varchar(50) NOT NULL DEFAULT 'undefined',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `job`;

CREATE TABLE IF NOT EXISTS `responsibility` (
  `responsibility_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_article_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `document_id` int unsigned NOT NULL,
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
  KEY `fk_responsibility_document_id` (`document_id`),
  CONSTRAINT `fk_responsibility_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_responsibility_document_id` FOREIGN KEY (`document_id`) REFERENCES `documents` (`documents_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_responsibility_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_responsibility_user_article_id` FOREIGN KEY (`user_article_id`) REFERENCES `user_article` (`user_article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `responsibility`;
INSERT INTO `responsibility` (`responsibility_id`, `user_article_id`, `user_id`, `article_id`, `document_id`, `value`, `status`, `timestamp`, `serial_number`, `inv_broj`) VALUES
	(91, 224, 6, 93, 135, 1, '', '2022-03-29 16:52:50', 'FSSAR5AS3', 'ZE0689878'),
	(98, 236, 7, 90, 147, 1, '', '2022-03-31 17:58:01', 'BELAJ', 'ZE0687290'),
	(103, 245, 7, 99, 156, 1, '', '2022-04-02 16:53:00', 'HDJDBAI63', 'M53837'),
	(104, 246, 1, 102, 157, 1, '', '2022-04-17 01:27:05', '374FS5DS45', 'ZE06898745'),
	(105, 247, 2, 90, 158, 1, '', '2022-04-17 02:37:51', 'HJUG78H9S', 'ZE0689526'),
	(106, 248, 1, 92, 159, 1, '', '2022-04-30 03:48:59', 'KJKSZPJJJ', 'ZE0689528'),
	(108, 250, 2, 96, 161, 1, '', '2022-04-30 04:04:08', 'MAROJE33', 'ZE0684368'),
	(109, 251, 2, 83, 162, 1, '', '2022-04-30 14:11:39', 'AEZAKMI', 'ZE0685859'),
	(110, 252, 6, 83, 163, 1, '', '2022-04-30 14:12:04', 'KLSJDOSJ', 'ZE0685860'),
	(111, 253, 7, 83, 164, 1, '', '2022-04-30 14:12:20', 'ASÄŒDGAA', 'ZE0685862');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `stock`;
INSERT INTO `stock` (`stock_id`, `article_id`, `value_on_concract`, `value_available`, `timestamp`, `sap_number`) VALUES
	(192, 91, 1, 0, '2022-03-14 22:45:34', '1300-100525'),
	(217, 84, 50, 38, '2022-03-18 14:42:55', '1300-200201'),
	(349, 93, 1, 4, '2022-03-29 16:52:50', 'ZE0687922'),
	(358, 95, 30, 30, '2022-03-31 15:48:24', '1300-551455'),
	(360, 97, 30, 30, '2022-03-31 16:05:38', '1300-005248'),
	(361, 98, 5, 5, '2022-03-31 16:26:03', '1300-183994'),
	(367, 85, 15, 17, '2022-03-31 17:58:45', '1300-200202'),
	(411, 102, 131, 2, '2022-04-17 01:27:05', 'ZE06879222'),
	(412, 90, 5, 4, '2022-04-17 02:37:51', '1300-100200'),
	(413, 92, 5, 0, '2022-04-30 03:48:59', '1300-132525'),
	(415, 96, 1, 0, '2022-04-30 04:04:08', '1300-005254'),
	(418, 83, 50, 30, '2022-04-30 14:12:20', '1300-200205');

CREATE TABLE IF NOT EXISTS `upgrade_feature` (
  `upgrade_feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `value` varchar(50) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` varchar(255) NOT NULL,
  `serial_number` varchar(50) NOT NULL,
  `article_id` int unsigned NOT NULL,
  PRIMARY KEY (`upgrade_feature_id`),
  KEY `fk_upgrade_feature_serial_number_user_article_serial_number` (`serial_number`),
  KEY `upgrade_feature_article_id_article_article_id` (`article_id`),
  CONSTRAINT `upgrade_feature_article_id_article_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `upgrade_feature`;
INSERT INTO `upgrade_feature` (`upgrade_feature_id`, `name`, `value`, `timestamp`, `comment`, `serial_number`, `article_id`) VALUES
	(3, 'SSD', '256GB', '2022-07-14 10:08:32', 'Ugrađen SSD 256GB, ostavljen HDD 500GB zbog podataka. Urađeno detaljno čišćenje radne stanice.', 'KJKSZPJJJ', 92);

CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int unsigned NOT NULL AUTO_INCREMENT,
  `surname` varchar(64) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `forname` varchar(64) CHARACTER SET utf32 COLLATE utf32_unicode_ci NOT NULL DEFAULT '0',
  `job_title` varchar(64) CHARACTER SET utf32 COLLATE utf32_unicode_ci DEFAULT NULL,
  `department` varchar(64) CHARACTER SET utf32 COLLATE utf32_unicode_ci DEFAULT NULL,
  `location` varchar(64) CHARACTER SET utf32 COLLATE utf32_unicode_ci DEFAULT '0',
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `user`;
INSERT INTO `user` (`user_id`, `surname`, `forname`, `job_title`, `department`, `location`, `email`, `password_hash`) VALUES
	(1, 'Mudžahid', 'Cerić', 'Tehničar za IKT', 'Služba za IKT', 'Direkcija Zenica', 'm.ceric@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE'),
	(2, 'Goran ', 'Karović', 'Stručni saradnik', 'Sektor za IKT', 'Direkcija', 'g.karovic@epbih.ba', 'AD27CCAFBB4429CEE9F60CEAA26F213E27037107434AC50F70314AC83D1D7CCBC73966453BE06B01ECEC83B0915C27DD2A8901A292B2D55C1D6E53B779471ADC'),
	(6, 'Emir', 'Hedzic', 'Stručni saradnik za IKT', 'Sektor za IKT', 'Direkcija Zenica', '', '3'),
	(7, 'Evel', 'Subasic', 'Vodeci strucni saradnik za IKT', 'Sektor za IKT', 'Direkcija Zenica', 'evica@epbih.ba', 'A5DFA812369F37FFD1755CA396C471CCEBC16B19DAEC09A1442287BCE01BD2BDC7603A2B86DF587FDAFA3EDEF4DA3E9D76E8B8194D24E696DCCA329CDD1429DE'),
	(9, 'Adis', 'Redžepović', 'Inženjer za građevinski nadzor', 'Služba za realizaciju investicija', 'Direkcija Zenica', 'a.redzepovic@epbih.ba', '1C5AACD4CA5406D8C96D1084DF911ADADBD5BD1A9EAC5278C4A6F3565AB1599A36B6EBA5DBB28CB8BFD2336E205645707C16F49CF609A733F9ED3D5BAC282806'),
	(10, 'Admir', 'Nizamić', 'Tehničar za ispitivanja **', 'Odjeljenje za zaštitu i kvalitet električne energije', 'PJ Zenica - Radakovo', 'a.nizamic@epbih.ba', '1C5AACD4CA5406D8C96D1084DF911ADADBD5BD1A9EAC5278C4A6F3565AB1599A36B6EBA5DBB28CB8BFD2336E205645707C16F49CF609A733F9ED3D5BAC282806'),
	(11, 'Adnan', 'Begagić', 'Elektromonter **', 'Odjeljenje obračunskih mjerenja i očitanja', 'PJ Zenica - Radakovo', 'a.begagic@epbih.ba', '1C5AACD4CA5406D8C96D1084DF911ADADBD5BD1A9EAC5278C4A6F3565AB1599A36B6EBA5DBB28CB8BFD2336E205645707C16F49CF609A733F9ED3D5BAC282806'),
	(12, 'Adnan', 'Ibreljić', 'Služba za sigurnost i zaštitu', 'Stručni saradnik za sigurnost', 'PJ Zenica - Radakovo', 'ad.ibreljic@epbih.ba', '1C5AACD4CA5406D8C96D1084DF911ADADBD5BD1A9EAC5278C4A6F3565AB1599A36B6EBA5DBB28CB8BFD2336E205645707C16F49CF609A733F9ED3D5BAC282806'),
	(13, 'Adnan', 'Mlinarić', 'Vodeći elektromonter **', 'Odjeljenje upravljanja i održavanja mreže i postrojenja', 'PJ Zenica - Radakovo', 'a.mlinaric@epbih.ba', '1C5AACD4CA5406D8C96D1084DF911ADADBD5BD1A9EAC5278C4A6F3565AB1599A36B6EBA5DBB28CB8BFD2336E205645707C16F49CF609A733F9ED3D5BAC282806'),
	(14, 'Ahmed', 'Mutapčić', 'Tehnički direktor', 'Ured Direktora', 'Direkcija Zenica', 'a.mutapcic@epbih.ba', '1C5AACD4CA5406D8C96D1084DF911ADADBD5BD1A9EAC5278C4A6F3565AB1599A36B6EBA5DBB28CB8BFD2336E205645707C16F49CF609A733F9ED3D5BAC282806'),
	(15, 'Aida', 'Ajanović', 'Samostalni referent za obračun *', 'Služba za obračun', 'Direkcija Zenica', 'ai.ajanovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(16, 'Aidin', 'Pripoljac', 'Rukovodilac PJD', 'Poslovna jedinica distribucije Zenica', 'PJ Zenica - Radakovo', 'a.pripoljac@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(17, 'Alen', 'Zečić', 'Rukovodilac Službe za analitičke evidencije', 'Služba za analitičke evidencije', 'Direkcija Zenica', 'a.zecic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(18, 'Alma', 'Kišija', 'Stručni saradnik za pravne i kadrovske poslove', 'Služba za pravne i kadrovske poslove', 'Direkcija Zenica', 'a.kisija@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(19, 'Alma', 'Secerovic', 'Strucni saradnik za finansijske i racuno', 'Služba za finansije i racunovodstvo', 'Direkcija Zenica', 'a.secerovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(20, 'Amar', 'Kasap', 'Rukovodilac službe', 'Služba za komercijalne poslove', 'Direkcija Zenica', 'a.kasap@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(21, 'Amel', 'Cajdric', 'Rukovodilac Službe', 'Služba za održavanje mreža i postrojenja Zenica', 'Direkcija Zenica', 'a.cajdric@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(22, 'Amel', 'Zejnirovic', 'Referent za investicije', 'Služba za realizaciju investicija', 'Direkcija Zenica', 'a.zejnirovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(23, 'Amela', 'Serdarevic', 'Samostalni referent za naplatu i utuž*', 'Služba za naplatu i utuženja', 'Direkcija Zenica', 'a.serdarevic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(24, 'Amina', 'Alibasic', 'Strucni saradnik za planiranje', 'Služba za plan .analizu i izvještavanje', 'Direkcija Zenica', 'a.alibasic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(25, 'Amina', 'Kavazovic', 'Strucni saradnik za prikljucenja **', 'Služba za realizaciju investicija', 'Direkcija Zenica', 'am.kavazovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(26, 'Amina', 'Patkovic', 'Referent za analiticke evidencije**', 'Služba za analiticke evidencije', 'Direkcija Zenica', 'a.patkovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(27, 'Amir', 'Buzo', 'Tehnicar za pripremu', 'Služba za održavanje mreža i postrojenja Zenica', 'Direkcija Zenica', 'am.buzo@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(28, 'Amir', 'Hasagic', 'Inženjer za mreže i postrojenja', 'Služba za održavanje mreža i postrojenja Zenica', 'Direkcija Zenica', 'am.hasagic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(29, 'Amira', 'Pracic', 'Referent za analiticke evidencije**', 'Služba za analiticke evidencije', 'Direkcija Zenica', 'a.pracic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(30, 'Amra', 'Imamovic', 'Rukovodilac službe', 'Služba za imovinsko-pravne odnose', 'Direkcija Zenica', 'am.imamovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(31, 'Amra', 'Pojskic', 'Rukovodilac podrucja', 'Podrucje snabdijevanja Zenica', 'Direkcija Zenica', 'a.pojskic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(32, 'Armin', 'Basic', 'Projektant', 'Služba za pripremu investicija', 'Direkcija Zenica', 'ar.basic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(33, 'Armin', 'Malicbegovic', 'Strucni saradnik za realizaciju investic', 'Služba za realizaciju investicija', 'Direkcija Zenica', 'a.malicbegovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(34, 'Armin', 'Miskic', 'Strucni saradnik za  prikupljanje i obra', 'Odjeljenje za prikupljanje i obradu mjernih podataka', 'Direkcija Zenica', 'ar.miskic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(35, 'Arzija', 'Hrustic', 'Referent za prikupljanje i obradu mjerni', 'Odjeljenje za prikupljanje i obradu mjernih podataka', 'Direkcija Zenica', 'ar.hrustic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(36, 'Asaf', 'Kajmakovic', 'Samostalni referent za kontrolu**', 'Služba za internu kontrolu', 'Direkcija Zenica', 'a.kajmakovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(37, 'Asima', 'Mulasmajic', 'Referent za analiticke evidencije**', 'Služba za analiticke evidencije', 'Direkcija Zenica', 'as.mulasmajic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(38, 'Asmir', 'Dzidic', 'Inženjer za pristup mreži', 'Služba za pristup mreži', 'Direkcija Zenica', 'a.dzidic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(39, 'Azra', 'Talic', 'Tehnicki sekretar', 'Ured Direktora', 'Direkcija Zenica', 'a.talic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(40, 'Benaris', 'Kahriman', 'Referent za racunovodstvo**', 'Služba za finansije i racunovodstvo', 'Direkcija Zenica', 'be.kahriman@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(41, 'Benjamin', 'Kovacevic', 'Rukovodilac službe', 'Služba za pristup mreži', 'Direkcija Zenica', 'b.kovacevic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(42, 'Damir', 'Caus', 'Rukovodilac službe', 'Služba za opce poslove', 'Direkcija Zenica', 'd.caus@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(43, 'Denis', 'Spahic', 'Referent za transport', 'Služba za transport', 'Direkcija Zenica', 'd.spahic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(44, 'Dervisa', 'Kalco', 'Strucni saradnik za finansijske i racuno', 'Služba za finansije i racunovodstvo', 'Direkcija Zenica', 'd.kalco@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(45, 'Dispeceri', 'Zenica', ' ', 'Djelatnost distribucije', 'Direkcija Zenica', 'ze.dispecer@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(46, 'Dzanan', 'Frndic', 'Strucni saradnik za finansijske i racuno', 'Služba za finansije i racunovodstvo', 'Direkcija Zenica', 'dz.frndic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(47, 'Dzenana', 'Skomorac', 'Rukovodilac službe', 'Služba za internu kontrolu', 'Direkcija Zenica', 'dz.skomorac@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(48, 'Edib', 'Vrazalic', 'Tehnicar za pripremu **', 'Odjeljenje za planiranje i održavanje mjernih mjesta', 'Direkcija Zenica', 'e.vrazalic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(49, 'Edin', 'Arnaut', 'Direktor', 'Podružnica "Elektrodistribucija" Zenica', 'Direkcija Zenica', 'e.arnaut@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(50, 'Edin', 'Heremic', 'Vodeci skladištar**', 'Služba za komercijalne poslove', 'Direkcija Zenica', 'e.heremic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(51, 'Edin', 'Kovac', 'Strucni saradnik za okolinsko upravljanj', 'Služba za sigurnost i zaštitu', 'Direkcija Zenica', 'ed.kovac@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(52, 'Edin', 'Omerovic', 'Referent za pripremu', 'Odjeljenje upravljanja i održavanja mreža i postrojenja (ZE)', 'Direkcija Zenica', 'e.omerovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(53, 'Edin', 'Opardija', 'Inženjer za zaštitu i kvalitet elektricn', 'Odjeljenje za zaštitu i kvalitet elektricne energije', 'Direkcija Zenica', 'e.opardija@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(54, 'Edina', 'Kubat', 'Referent za kadrovske poslove', 'Služba za pravne i kadrovske poslove', 'Direkcija Zenica', 'e.kubat@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(55, 'Edisej', 'Sjerotanovic', 'Rukovodilac sektora', 'Sektor obracunskih mjerenja i ocitanja', 'Direkcija Zenica', 'e.sjerotanovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(56, 'Edmir', 'Vranic', 'Vodeci skladištar**', 'Služba za komercijalne poslove', 'Direkcija Zenica', 'e.vranic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(57, 'Ehlimana', 'Sivac', 'Strucni saradnik za stvarna prava na pos', 'Odjeljenje za postojecu imovinu', 'Direkcija Zenica', 'eh.sivac@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(58, 'Elma', 'Frkatovic', 'Referent za finansija', 'Služba za finansije i racunovodstvo', 'Direkcija Zenica', 'e.frkatovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(59, 'Elvedina', 'Subasic', 'Referent za analiticke evidencije**', 'Služba za analiticke evidencije', 'Direkcija Zenica', 'elv.subasic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(60, 'Elvedina', 'Vejzagic', 'Samostalni referent za naplatu i utuž*', 'Služba za naplatu i utuženja', 'Direkcija Zenica', 'e.vejzagic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(61, 'Emina', 'Hasic', 'Koordinator za GIS', 'Sektor za investicije', 'Direkcija Zenica', 'e.hasic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(62, 'Emina', 'Serdarevic', 'Arhivar *', 'Služba za opce poslove', 'Direkcija Zenica', 'e.serdarevic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(63, 'Emir', 'Dzafic', 'Referent za pripremu', 'Poslovna jedinica distribucije Breza', 'Direkcija Zenica', 'em.dzafic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(65, 'Emir', 'Smajic', 'Strucni saradnik za analiticke evidencij', 'Služba za analiticke evidencije', 'Direkcija Zenica', 'e.smajic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(66, 'Emira', 'Brajlovic', 'Vodeci referent za naplatu i utuženja*', 'Služba za naplatu i utuženja', 'Direkcija Zenica', 'em.brajlovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(67, 'Enes', 'Krdzalic', 'Strucni saradnik za zaštitu zdravlja i s', 'Služba za sigurnost i zaštitu', 'Direkcija Zenica', 'en.krdzalic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(68, 'Enes', 'Malkoc', 'Dispecer za srednji i niski napon*', 'Odjeljenje za dispeciranje', 'Direkcija Zenica', 'e.malkoc@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(69, 'Ermin', 'Husagic', 'Vodeci elektromehanicar *', 'Odjeljenje za zaštitu i kvalitet elektricne energije', 'Direkcija Zenica', 'e.husagic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(70, 'Ernes', 'Bedak', 'Rukovodilac službe', 'Služba za pripremu investicija', 'Direkcija Zenica', 'e.bedak@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(72, 'Fata', 'Bajtarevic', 'Referent za racunovodstvo**', 'Služba za finansije i racunovodstvo', 'Direkcija Zenica', 'fa.bajtarevic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(74, 'Goran', 'Skocilic', 'Referent za odnose sa javnošcu i komunik', 'Služba za odnose s javnošcu i informisanje kupaca', 'Direkcija Zenica', 'g.skocilic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(75, 'Hadis', 'Zukic', 'Referent za racunovodstvo**', 'Služba za finansije i racunovodstvo', 'Direkcija Zenica', 'ha.zukic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(76, 'Halid', 'Zukic', 'Rukovodilac službe', 'Služba za odnose s javnošcu i informisanje kupaca', 'Direkcija Zenica', 'h.zukic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(77, 'Haris', 'Buric', 'Elektromonter**', 'Odjeljenje upravljanja i održavanja mreža i postrojenja (ZE)', 'Direkcija Zenica', 'h.buric@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(78, 'Haris', 'Imamovic', 'Strucni saradnik za tržišne operacije', 'Sektor za tržišno snabdijevanje', 'Direkcija Zenica', 'ha.imamovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(79, 'Haris', 'Kulic', 'Tehnicar za pristup mreži', 'Odjeljenje za pristup mreži (ZE)', 'Direkcija Zenica', 'h.kulic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(80, 'Hedina', 'Causevic', 'Samostalni referent nabavke*', 'Služba za komercijalne poslove', 'Direkcija Zenica', 'he.causevic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(81, 'Ibrahim', 'Mucic', 'Rukovodilac Službe za naplatu i utuženja', 'Služba za naplatu i utuženja', 'Direkcija Zenica', 'i.mucic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(82, 'Igor', 'Primorac', 'Rukovodilac službe', 'Služba za upravljanje i operativne analize', 'Direkcija Zenica', 'i.primorac@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(83, 'Ilma', 'Kopic', 'Strucni saradnik za finansijske i racuno', 'Služba za finansije i racunovodstvo', 'Direkcija Zenica', 'i.kopic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(84, 'Jasmin', 'Catic', 'Samostalni referent za kontrolu**', 'Služba za internu kontrolu', 'Direkcija Zenica', 'j.catic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(85, 'Jasmina', 'Cucukovic', 'Strucni saradnik za prikljucenja **', 'Služba za realizaciju investicija', 'Direkcija Zenica', 'j.cucukovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(86, 'Kemal', 'Dautbegovic', 'Strucni saradnik za nabavku i ugovaranje', 'Služba za komercijalne poslove', 'Direkcija Zenica', 'k.dautbegovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(87, 'Kenan', 'Dzelo', 'Inženjer za pristup mreži', 'Služba za pristup mreži', 'Direkcija Zenica', 'k.dzelo@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(88, 'Kenan', 'Hadzimejlic', 'Strucni saradnik za obracun i realizacij', 'Služba za obracun', 'Direkcija Zenica', 'k.hadzimejlic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(89, 'Kenan', 'Prguda', 'Vodeci referent opcih poslova*', 'Služba za opce poslove', 'Direkcija Zenica', 'k.prguda@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(90, 'Kenan', 'Serdarevic', 'Rukovodilac sektora', 'Sektor za pristup mreži i upravljanje', 'Direkcija Zenica', 'k.serdarevic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(91, 'Laris', 'Maglic', 'Rukovodilac službe', 'Služba za transport', 'Direkcija Zenica', 'l.maglic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(92, 'Lejla', 'Buza', 'Rukovodilac službe', 'Služba za pravne i kadrovske poslove', 'Direkcija Zenica', 'le.buza@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(93, 'Lejla', 'Carsimamovic', 'Rukovodilac službe', 'Služba za IKT Zenica', 'Direkcija Zenica', 'l.carsimamovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(94, 'Lejla', 'Rizvic', ' ', 'Odjeljenje obracuna', 'Direkcija Zenica', 'l.rizvic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(95, 'Mahir', 'Avdic', 'Vozac *', 'Služba za transport', 'Direkcija Zenica', 'ma.avdic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(96, 'Mahir', 'Mesic', 'Mašinbravar za mašinsku opremu II', 'Pogon održavanje', 'Direkcija Zenica', 'm.mesic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(97, 'Medina', 'Dizdarevic', ' ', ' ', 'Direkcija Zenica', 'm.dizdarevic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(98, 'Mekrema', 'Pušcul', ' ', ' ', 'Direkcija Zenica', 'm.puscul@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(99, 'Meliha', 'Becic', 'Referent za racunovodstvo**', 'Služba za finansije i racunovodstvo', 'Direkcija Zenica', 'me.becic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(100, 'Melita', 'Burkic', 'Vodeci referent za racunovodstvo *', 'Služba za finansije i racunovodstvo', 'Direkcija Zenica', 'm.burkic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(101, 'Mensud', 'Durmic', 'Rukovodilac sektora', 'Sektor za ekonomske poslove', 'Direkcija Zenica', 'm.durmic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(102, 'Mirha', 'Bašic', 'Strucni saradnik za pripremu investicija', 'Služba za pripremu investicija', 'Direkcija Zenica', 'mirha.basic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(103, 'Mirha', 'Catic', 'Referent za pripremu investicija', 'Služba za pripremu investicija', 'Direkcija Zenica', 'm.catic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(104, 'Mirhat', 'Djuheric', 'Referent za investicije', 'Služba za realizaciju investicija', 'Direkcija Zenica', 'm.dzuheric@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(105, 'Mirsad', 'Becic', 'Rukovodilac službe', 'Služba za realizaciju investicija', 'Direkcija Zenica', 'm.becic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(106, 'Mirsada', 'Sarajlic', 'Strucni saradnik za pravne i kadrovske p', 'Služba za pravne i kadrovske poslove', 'Direkcija Zenica', 'mi.sarajlic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(107, 'Mirza', 'Alic', 'Inženjer za nadzor i investicije', 'Služba za realizaciju investicija', 'Direkcija Zenica', 'm.alic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(108, 'Mirza', 'Serdarevic', 'Glavni dispecer', 'Odjeljenje za dispeciranje', 'Direkcija Zenica', 'm.serdarevic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(110, 'Muhamed', 'Druzic', 'Elektromonter', 'Odjeljenje za planiranje i održavanje mjernih mjesta', 'Direkcija Zenica', 'm.druzic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(111, 'Muris', 'Isakovic', 'Voditelj protokola', 'Služba za opce poslove', 'Direkcija Zenica', 'mu.isakovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(112, 'Muris', 'Pasalic', 'Elektromonter', 'Odjeljenje za planiranje i održavanje mjernih mjesta', 'Direkcija Zenica', 'mu.pasalic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(113, 'Mustafa', 'Pašalic', 'Elektromonter**', 'Odjeljenje obracunskih mjerenja i ocitanja (ZE)', 'Direkcija Zenica', 'm.pasalic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(114, 'Nadira', 'Mehicic', ' ', 'Odjeljenje obracuna i naplate elektricne energije Zenica', 'Direkcija Zenica', 'n.mehicic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(115, 'Nedim', 'Alic', 'Strucni saradnik za planiranje i održava', 'Odjeljenje za planiranje i održavanje mjernih mjesta', 'Direkcija Zenica', 'ne.alic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(116, 'Nedim', 'Islambegovic', 'Rukovodilac službe', 'Služba za finansije i racunovodstvo', 'Direkcija Zenica', 'n.islambegovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(117, 'Nedzad', 'Osmanovic', 'Pomocnik direktora', 'Ured Direktora', 'Direkcija Zenica', 'ne.osmanovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(118, 'Nermin', 'Skenderovic', ' ', ' ', 'Direkcija Zenica', 'n.skenderovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(119, 'Nermina', 'Pesto', ' ', 'Odjeljenje obracuna i naplate elektricne energije Zenica', 'Direkcija Zenica', 'n.pesto@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(120, 'Nihad', 'Kesic', 'Referent za odnose sa javnošcu i komunik', 'Služba za odnose s javnošcu i informisanje kupaca', 'Direkcija Zenica', 'n.kesic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(121, 'Nisveta', 'Skaljo', 'Referent za upravno-administrativne posl', 'Služba za pravne i kadrovske poslove', 'Direkcija Zenica', 'n.skaljo@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(122, 'Ranko', 'Lazic', 'Elektromonter**', 'Odjeljenje obracunskih mjerenja i ocitanja (ZE)', 'Direkcija Zenica', 'r.lazic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(123, 'Rizah', 'Kos', 'Vodeci elektromonter', 'Odjeljenje za planiranje i održavanje mjernih mjesta', 'Direkcija Zenica', 'r.kos@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(124, 'Rukija', 'Huseinspahic', 'Referent za prikljucenja', 'Služba za realizaciju investicija', 'Direkcija Zenica', 'r.huseinspahic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(125, 'Sabit', 'Alic', 'Projekt menadžer', 'Sektor za investicije', 'Direkcija Zenica', 'sabit.alic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(126, 'Saliha', 'Cabro', ' ', 'Služba ugovaranja i prodaje elektricne energije', 'Direkcija Zenica', 's.cabro@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(127, 'Samir', 'Imamovic', ' ', 'Odjeljenje obracuna i naplate elektricne energije Kakanj', 'Direkcija Zenica', 'sam.imamovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(128, 'Samir', 'Kadic', 'Dispecer za srednji i niski napon*', 'Odjeljenje za dispeciranje', 'Direkcija Zenica', 'sam.kadic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(129, 'Samra', 'Buric', 'Voda smjene', 'Pogon Hidroelektrana Jablanica', 'Direkcija Zenica', 's.buric@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(130, 'Samra', 'Grahic', ' ', 'Odjeljenje obracuna i naplate elektricne energije Zenica', 'Direkcija Zenica', 's.grahic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(131, 'Samra', 'Verlasevic', 'Referent za finansije', 'Služba za finansije i racunovodstvo', 'Direkcija Zenica', 's.verlasevic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(132, 'Sanel', 'Golic', 'Vodeci automehanicar-kontrolor *', 'Služba za transport', 'Direkcija Zenica', 's.golic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(133, 'Sanja', 'Toromanovic', ' ', ' ', 'Direkcija Zenica', 's.toromanovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(134, 'Sead', 'Kratina', 'Strucni saradnik za rješavanje imovinsko', 'Odjeljenje za nova prava', 'Direkcija Zenica', 's.kratina@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(135, 'Selma', 'Becic', 'Referent za prikupljanje i obradu mjerni', 'Odjeljenje za prikupljanje i obradu mjernih podataka', 'Direkcija Zenica', 's.becic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(136, 'Senada', 'Dervisaj', 'Tehnicar za pripremu **', 'Odjeljenje za planiranje i održavanje mjernih mjesta', 'Direkcija Zenica', 's.dervisaj@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(137, 'Senada', 'Fazlic', ' ', 'Odjeljenje obracuna i naplate elektricne energije Visoko', 'Direkcija Zenica', 's.fazlic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(138, 'Senada', 'Hrvic', 'Referent opcih poslova **', 'Služba za opce poslove', 'Direkcija Zenica', 's.hrvic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(139, 'Slobodan', 'Vasiljevic', 'Vodeci elektromonter**', 'Odjeljenje upravljanja i održavanja mreža i postrojenja (ZE)', 'Direkcija Zenica', 's.vasiljevic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(140, 'Smaragda', 'Imamovic', 'Strucni saradnik za rješavanje imovinsko', 'Odjeljenje za nova prava', 'Direkcija Zenica', 'sm.imamovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(141, 'Suad', 'Jaran', 'Elektromonter**', 'Odjeljenje upravljanja i održavanja mreža i postrojenja (ZE)', 'Direkcija Zenica', 'su.jaran@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(142, 'Subhija', 'Muharemovic', 'Strucni saradnik za nabavku i ugovaranje', 'Služba za komercijalne poslove', 'Direkcija Zenica', 's.muharemovic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(143, 'Tarik', 'Cerim', 'Vodeci elektromonter', 'Odjeljenje obracunskih mjerenja i ocitanja (ZE)', 'Direkcija Zenica', 'ta.cerim@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(144, 'Vikica', 'Vujica', 'Strucni saradnik za finansijske i racuno', 'Služba za finansije i racunovodstvo', 'Direkcija Zenica', 'v.vujica@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(145, 'Zahid', 'Softic', 'Rukovodilac sektora', 'Sektor za investicije', 'Direkcija Zenica', 'z.softic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(146, 'Zlatan', 'Hadzic', 'Rukovodilac sektora', 'Sektor za pravne kadrovske i opce poslove', 'Direkcija Zenica', 'z.hadzic@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58'),
	(147, 'Zumra', 'Okan', ' ', 'Odjeljenje obracuna i naplate elektricne energije Zenica', 'Direkcija Zenica', 'z.okan@epbih.ba', '5E2AD17212BEFA047B476FDC6E5F35450E483B6018797FFEF5C032BBDC45658D1C7CC05E4EB7782664CB65E8FDF8DCF5B848FBE6BC219863CADA1E9AC4545F58');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `user_article`;
INSERT INTO `user_article` (`user_article_id`, `article_id`, `document_id`, `user_id`, `serial_number`, `status`, `timestamp`, `comment`, `inv_broj`) VALUES
	(215, 83, 126, 6, 'OHDUDE', 'razduženo', '2022-03-26 15:48:36', 'Raspodjela opreme', 'ZE0685487'),
	(221, 93, 132, 2, 'FSSAR5AS3', 'razduženo', '2022-03-29 15:26:10', 'Zaduženje na Gorana', 'ZE0689878'),
	(222, 93, 133, 1, 'FSSAR5AS3', 'razduženo', '2022-03-29 16:15:53', 'Zaduženje na Gorana', 'ZE0689878'),
	(223, 93, 134, 2, 'FSSAR5AS3', 'razduženo', '2022-03-29 16:16:58', 'Oprema zadužena sa Gorana na Emira', 'ZE0689878'),
	(224, 93, 135, 6, 'FSSAR5AS3', 'zaduženo', '2022-03-29 16:52:50', 'Zaduženje nove opreme', 'ZE0689878'),
	(225, 83, 136, 1, 'OHDUDE', 'zaduženo', '2022-03-29 17:52:48', 'Zaduženje nove opreme', 'ZE0685487'),
	(226, 83, 137, 1, 'OHDUDE', 'razduženo', '2022-03-29 17:54:40', 'Razdužujem opremu', 'ZE0685487'),
	(227, 83, 138, 1, 'OHDUDE', 'zaduženo', '2022-03-29 17:59:47', 'Zaduženje nove opreme', 'ZE0685487'),
	(228, 83, 139, 1, 'OHDUDE', 'razduženo', '2022-03-29 18:00:24', 'Razdužujem na skladište', 'ZE0685487'),
	(229, 90, 140, 1, 'HJUG78H9S', 'zaduženo', '2022-03-29 21:12:15', 'Zaduženje nove opreme', 'ZE0689526'),
	(230, 92, 141, 1, 'KJKSZPJJJ', 'zaduženo', '2022-03-30 19:49:45', 'Zaduženje nove opreme', 'ZE0689528'),
	(231, 92, 142, 1, 'KJKSZPJJJ', 'razduženo', '2022-03-30 19:50:54', 'Razduženje na skladište', 'ZE0689528'),
	(232, 96, 143, 7, 'HOHOHO3', 'zaduženo', '2022-03-31 17:44:12', 'Zaduženje nove opreme', 'ZE0687290'),
	(233, 96, 144, 7, 'HOHOHO3', 'razduženo', '2022-03-31 17:46:22', 'Razdužujem, ovdje ima greška, gdje artikal kada se razdužuje s korisnika na skladište, ponovo na korisnika. Ispraviti u backend-u', 'ZE0687290'),
	(234, 96, 145, 7, 'HOHOHO3', 'zaduženo', '2022-03-31 17:54:22', 'Zaduženje nove opreme', 'ZE0687290'),
	(235, 96, 146, 7, 'HOHOHO3', 'razduženo', '2022-03-31 17:55:39', 'Razdužujem s Evela opremu. Oprema bi na prenosnici trebala da ode u skladište. Aplikativno bi trebala da se nalazi u Debt, i trebala bi da bude dostupna za zaduženje u stock.', 'ZE0687290'),
	(236, 90, 147, 7, 'BELAJ', 'zaduženo', '2022-03-31 17:58:01', 'Zaduženje nove opreme', 'ZE0687290'),
	(237, 85, 148, 7, 'BRISANJE', 'zaduženo', '2022-03-31 17:58:45', 'Zaduženje nove opreme', 'ZE0685456'),
	(238, 85, 149, 7, 'BRISANJE', 'otpisano', '2022-03-31 17:59:27', 'Artikal ide na otpis. I u ovom koraku isti slučaj kada ide sa korisnika na otpis treba poseban mehanizam.', 'ZE0685456'),
	(239, 90, 150, 1, 'HJUG78H9S', 'razduženo', '2022-04-01 22:05:37', 'Razduženje u skladište', 'ZE0689526'),
	(240, 90, 151, 1, 'HJUG78H9S', 'zaduženo', '2022-04-01 22:06:58', 'Zaduženje nove opreme', 'ZE0689526'),
	(241, 90, 152, 1, 'HJUG78H9S', 'razduženo', '2022-04-01 22:07:52', 'Vraćam ga na skladište da vidim situaciju na profilu.', 'ZE0689526'),
	(242, 99, 153, 1, 'HDJDBAI63', 'zaduženo', '2022-04-02 16:51:18', 'Zaduženje nove opreme', 'M53837'),
	(243, 99, 154, 1, 'HDJDBAI63', 'razduženo', '2022-04-02 16:52:01', 'Razdužuje na skladište, treba biti 2/2 šta je', 'M53837'),
	(244, 99, 155, 2, 'HDJDBAI63', 'razduženo', '2022-04-02 16:52:35', 'A onda sa Gorana na Evela', 'M53837'),
	(245, 99, 156, 7, 'HDJDBAI63', 'zaduženo', '2022-04-02 16:53:00', 'Zaduženje nove opreme', 'M53837'),
	(246, 102, 157, 1, '374FS5DS45', 'zaduženo', '2022-04-17 01:27:05', 'Zaduženje nove opreme', 'ZE06898745'),
	(247, 90, 158, 2, 'HJUG78H9S', 'zaduženo', '2022-04-17 02:37:51', 'Zaduženje nove opreme', 'ZE0689526');

CREATE TABLE IF NOT EXISTS `user_token` (
  `user_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` varchar(2550) NOT NULL,
  `expire_at` datetime NOT NULL,
  `is_valid` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`user_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
	(46, 7, '2022-03-31 18:05:01', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoidXNlciIsImlkIjo3LCJpZGVudGl0eSI6ImV2aWNhQGVwYmloLmJhIiwiZXhwIjoxNjUxNDI4MzAxLjE0NCwiaXAiOiI6OmZmZmY6MTkyLjE2OC4wLjEzIiwidWEiOiJNb3ppbGxhLzUuMCAoWDExOyBMaW51eCB4ODZfNjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS8xMDAuMC40ODk2LjYwIFNhZmFyaS81MzcuMzYiLCJpYXQiOjE2NDg3NDk5MDF9.jO069O3c-MoCIlQ9clNPpUxSaFVPKuQP82wVRC2iQtY', '2022-05-01 18:05:01', 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
