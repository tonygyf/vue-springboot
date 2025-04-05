/*
 Navicat Premium Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80037 (8.0.37)
 Source Host           : localhost:3306
 Source Schema         : recomblog

 Target Server Type    : MySQL
 Target Server Version : 80037 (8.0.37)
 File Encoding         : 65001

 Date: 10/12/2024 13:51:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for blogs
-- ----------------------------
DROP TABLE IF EXISTS `blogs`;
CREATE TABLE `blogs`  (
  `blog_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`blog_id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `blogs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blogs
-- ----------------------------
INSERT INTO `blogs` VALUES (1, NULL, '第一篇博客', '这是第一篇博客的内容。12', '2024-12-06 17:59:57', '2024-12-06 17:59:57', 0);
INSERT INTO `blogs` VALUES (2, 2, '第二篇博客', '这是第二篇博客的内容。', '2024-11-24 15:42:07', '2024-11-24 15:42:07', 0);
INSERT INTO `blogs` VALUES (6, NULL, 'cnm', 'cnm', '2024-12-01 13:14:53', '2024-12-01 13:14:53', 0);
INSERT INTO `blogs` VALUES (9, 11, '这个是一个测试', '这是一个测试', '2024-12-04 15:15:58', '2024-12-04 15:15:58', 0);
INSERT INTO `blogs` VALUES (14, NULL, 'cnmsssss', '11312342131231', '2024-12-06 16:26:51', '2024-12-06 16:26:51', 0);
INSERT INTO `blogs` VALUES (17, 11, '这个是一个测试2222', '哈哈哈哈哈哈哈哈哈和   ', '2024-12-06 17:23:43', '2024-12-06 17:23:43', 0);
INSERT INTO `blogs` VALUES (20, NULL, 'dsasdad', 'dasfefafeafaeef', '2024-12-10 13:35:48', '2024-12-10 13:35:48', 0);

-- ----------------------------
-- Table structure for chat_responses
-- ----------------------------
DROP TABLE IF EXISTS `chat_responses`;
CREATE TABLE `chat_responses`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `prompt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `response` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat_responses
-- ----------------------------
INSERT INTO `chat_responses` VALUES (1, 'hello', '{\"id\":\"chatcmpl-AcnLksamMCLHtkPZoZ6CRzU6ZkOSU\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1733809528,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":8,\"completion_tokens\":9,\"total_tokens\":17,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2024-12-10 13:45:47');
INSERT INTO `chat_responses` VALUES (2, '你好，今天的天气怎么样？', '{\"id\":\"chatcmpl-AcnPYBtxP9AjLVEPG4JT76EzzyA7Y\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"你好，我不确定今天的天气如何，但你可以查看天气预报或问当地的气象台了解最新的天气情况。祝你过一个愉快的一天！有什么我可以帮助你的吗？\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1733809764,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":21,\"completion_tokens\":74,\"total_tokens\":95,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2024-12-10 13:49:43');

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `blog_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `blog_id`(`blog_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`blog_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (3, 2, 1, '有趣的观点。ssss', '2024-12-10 13:27:20');
INSERT INTO `comments` VALUES (25, 17, 11, '666jasdad', '2024-12-10 13:36:00');
INSERT INTO `comments` VALUES (26, 9, 11, '哈哈哈哈', '2024-12-06 17:47:42');
INSERT INTO `comments` VALUES (27, 1, 24, '哈哈哈哈', '2024-12-07 22:28:54');
INSERT INTO `comments` VALUES (29, 2, 11, '哈哈哈哈哈哈', '2024-12-10 13:31:39');

-- ----------------------------
-- Table structure for likes
-- ----------------------------
DROP TABLE IF EXISTS `likes`;
CREATE TABLE `likes`  (
  `like_id` int NOT NULL AUTO_INCREMENT,
  `blog_id` int NULL DEFAULT NULL,
  `user_id` int NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`like_id`) USING BTREE,
  INDEX `blog_id`(`blog_id` ASC) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`blog_id`) REFERENCES `blogs` (`blog_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of likes
-- ----------------------------
INSERT INTO `likes` VALUES (1, 1, 2, '2024-11-24 15:51:38');
INSERT INTO `likes` VALUES (2, 1, 3, '2024-11-24 15:51:38');
INSERT INTO `likes` VALUES (3, 2, 1, '2024-11-24 15:51:38');
INSERT INTO `likes` VALUES (5, 1, 1, '2024-12-03 19:02:35');
INSERT INTO `likes` VALUES (6, 1, 1, '2024-12-03 19:40:59');
INSERT INTO `likes` VALUES (7, 1, 1, '2024-12-03 19:41:00');
INSERT INTO `likes` VALUES (8, 1, 1, '2024-12-03 19:41:02');
INSERT INTO `likes` VALUES (9, 1, 1, '2024-12-03 21:43:52');
INSERT INTO `likes` VALUES (10, 1, 1, '2024-12-04 13:40:10');
INSERT INTO `likes` VALUES (11, 6, 11, '2024-12-04 13:48:05');
INSERT INTO `likes` VALUES (12, 6, 11, '2024-12-04 13:48:06');
INSERT INTO `likes` VALUES (13, 6, 11, '2024-12-04 13:48:07');
INSERT INTO `likes` VALUES (14, 6, 11, '2024-12-04 13:48:08');
INSERT INTO `likes` VALUES (49, 17, 11, '2024-12-06 17:23:45');
INSERT INTO `likes` VALUES (50, 9, 11, '2024-12-06 17:47:39');
INSERT INTO `likes` VALUES (55, 2, 11, '2024-12-10 13:31:34');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '123456', 'admin@example.com', 'admin', '2024-11-24 15:40:37', '2024-11-24 15:41:42');
INSERT INTO `users` VALUES (2, 'client_user1', '123456', 'client1@example.com', 'client', '2024-11-24 15:40:37', '2024-11-24 15:41:27');
INSERT INTO `users` VALUES (3, 'client_user2', '123456', 'client2@example.com', 'client', '2024-11-24 15:40:37', '2024-11-24 15:41:35');
INSERT INTO `users` VALUES (9, 'admin3', '123456', '1563426658@qq.com', 'client', '2024-11-26 14:46:02', '2024-11-26 14:46:02');
INSERT INTO `users` VALUES (10, 'admin56sdasd', '123456', '221310213@mail.dhu.edu.cn', 'client', '2024-11-26 14:50:00', '2024-12-10 13:35:21');
INSERT INTO `users` VALUES (11, 'gyf12', 'a.123456', '1563426958@qq.com', 'client', '2024-12-01 11:16:17', '2024-12-01 11:16:17');
INSERT INTO `users` VALUES (21, 'admin222', '123456', '1563426958111111sss@qq.com', 'client', '2024-12-07 22:26:57', '2024-12-07 22:27:03');
INSERT INTO `users` VALUES (22, 'gyf', '123456', '221310213wwww@mail.dhu.edu.cn', 'client', '2024-12-07 22:27:31', '2024-12-07 22:27:31');
INSERT INTO `users` VALUES (24, 'gyfs', 'a.123456', '1563421sss@qq.com', 'client', '2024-12-07 22:28:22', '2024-12-07 22:28:22');

SET FOREIGN_KEY_CHECKS = 1;
