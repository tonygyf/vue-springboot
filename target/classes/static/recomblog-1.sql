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

 Date: 07/04/2025 20:01:32
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
  `is_deleted` bit(1) NOT NULL,
  PRIMARY KEY (`blog_id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `blogs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of blogs
-- ----------------------------
INSERT INTO `blogs` VALUES (1, NULL, '第一篇博客', '这是第一篇博客的内容。12', '2024-12-06 17:59:57', '2024-12-06 17:59:57', b'0');
INSERT INTO `blogs` VALUES (2, 2, '第二篇博客', '这是第二篇博客的内容。', '2024-11-24 15:42:07', '2024-11-24 15:42:07', b'0');
INSERT INTO `blogs` VALUES (6, NULL, 'cnm', 'cnm', '2024-12-01 13:14:53', '2025-04-07 03:49:46', b'1');
INSERT INTO `blogs` VALUES (9, 11, '这个是一个测试', '这是一个测试', '2024-12-04 15:15:58', '2025-04-07 11:27:18', b'1');
INSERT INTO `blogs` VALUES (14, NULL, 'cnmsssss', '11312342131231', '2024-12-06 16:26:51', '2024-12-06 16:26:51', b'0');
INSERT INTO `blogs` VALUES (17, 11, '这个是一个测试2222', '哈哈哈哈哈哈哈哈哈和   ', '2024-12-06 17:23:43', '2024-12-06 17:23:43', b'0');
INSERT INTO `blogs` VALUES (20, NULL, 'dsasdad', 'dasfefafeafaeef', '2024-12-10 13:35:48', '2024-12-10 13:35:48', b'0');
INSERT INTO `blogs` VALUES (22, 28, 'aaaaaaaa', 'aaaaaaaaaaaaaaaaaaas', '2025-04-06 07:11:12', '2025-04-07 01:28:59', b'1');
INSERT INTO `blogs` VALUES (23, 28, '这个是为了我的博客测试1', '这个是为了我的博客测试', '2025-04-06 09:29:22', '2025-04-07 11:26:37', b'0');
INSERT INTO `blogs` VALUES (24, 1, '我的博客测试', '111111111', '2025-04-07 02:25:19', '2025-04-07 03:49:30', b'0');

-- ----------------------------
-- Table structure for chat_responses
-- ----------------------------
DROP TABLE IF EXISTS `chat_responses`;
CREATE TABLE `chat_responses`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `prompt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `response` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat_responses
-- ----------------------------
INSERT INTO `chat_responses` VALUES (1, 'hello', '{\"id\":\"chatcmpl-AcnLksamMCLHtkPZoZ6CRzU6ZkOSU\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1733809528,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":8,\"completion_tokens\":9,\"total_tokens\":17,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2024-12-10 13:45:47');
INSERT INTO `chat_responses` VALUES (2, '你好，今天的天气怎么样？', '{\"id\":\"chatcmpl-AcnPYBtxP9AjLVEPG4JT76EzzyA7Y\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"你好，我不确定今天的天气如何，但你可以查看天气预报或问当地的气象台了解最新的天气情况。祝你过一个愉快的一天！有什么我可以帮助你的吗？\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1733809764,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":21,\"completion_tokens\":74,\"total_tokens\":95,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2024-12-10 13:49:43');
INSERT INTO `chat_responses` VALUES (3, '企业java是什么', '{\"id\":\"chatcmpl-AcsLesXiEJpehhCzR9fmWo3DIFTlv\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"企业Java是指在企业级应用程序开发中使用Java编程语言的实践和技术。企业Java通常涉及使用Java平台的各种框架、库和工具，以构建大规模、高性能、稳定和安全的应用程序。企业Java开发人员通常需要掌握Java编程语言的基础知识，并熟悉常用的企业级开发框架和技术，如Spring、Hibernate、Java EE等。企业Java应用程序通常用于支持企业的核心业务功能，如电子商务、客户关系管理、供应链管理等。\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1733828742,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":14,\"completion_tokens\":176,\"total_tokens\":190,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2024-12-10 19:05:46');
INSERT INTO `chat_responses` VALUES (4, '什么是计算机网络', '{\"id\":\"chatcmpl-AcsuAbenhDr7cWIp6DoEcoA7yhqKR\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"计算机网络是指将多台计算机通过通信设备和通信线路连接起来，以便实现信息和资源的共享。计算机网络可以是局域网（LAN）、城域网（MAN）、广域网（WAN）等不同规模和范围的网络。通过计算机网络，用户可以互相传输数据、共享文件、访问远程资源、进行在线交流等。计算机网络也是互联网的基础，是连接全球各地计算机和设备的网络体系结构。\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1733830882,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":15,\"completion_tokens\":147,\"total_tokens\":162,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2024-12-10 19:41:26');
INSERT INTO `chat_responses` VALUES (5, '给我 喜剧 类别的电影', '{\"id\":\"chatcmpl-AfKdtGwWKVvtHFQ70ZU9MuUCmph9Z\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"1.《喜剧之王》\\n2.《功夫》\\n3.《透明人大电影》\\n4.《爸爸去哪儿》\\n5.《唐伯虎点秋香》\\n6.《欢乐喜剧人》\\n7.《宝贝计划》\\n8.《功守道》\\n9.《千王之王》\\n10.《夜店王》\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1734414161,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":19,\"completion_tokens\":119,\"total_tokens\":138,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2024-12-17 13:42:44');
INSERT INTO `chat_responses` VALUES (6, '给我 动作 类别的电影', '{\"id\":\"chatcmpl-AfKe0xJNkoecnCpdyh4sliWsQHw01\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"1. 动作片\\n\\n2. 武侠片\\n\\n3. 警匪片\\n\\n4. 战争片\\n\\n5. 科幻动作片\\n\\n6. 恐怖动作片\\n\\n7. 犯罪动作片\\n\\n8. 灾难动作片\\n\\n9. 冒险动作片\\n\\n10. 惊悚动作片\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1734414168,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":17,\"completion_tokens\":96,\"total_tokens\":113,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2024-12-17 13:42:50');
INSERT INTO `chat_responses` VALUES (7, '给我 动作, 恐怖 类别的电影', '{\"id\":\"chatcmpl-AfKe5nvJodlp6dE94IBlBHa0DxX0h\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"《惊悚大街》\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1734414173,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":23,\"completion_tokens\":10,\"total_tokens\":33,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2024-12-17 13:42:55');
INSERT INTO `chat_responses` VALUES (8, '给我 动画 类别的电影', '{\"id\":\"chatcmpl-AfKeDbAg9PegJuVMGrvhVIPxbjmPS\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"1. 童话故事类：《白雪公主与七个小矮人》\\n2. 冒险类：《狮子王》\\n3. 喜剧类：《神偷奶爸》\\n4. 科幻类：《机器人总动员》\\n5. 动作类：《蜘蛛侠：英雄归来》\\n6. 魔幻类：《哈利·波特》\\n7. 战争类：《风中的幸福》\\n8. 爱情类：《冰雪奇缘》\\n9. 神话类：《阿凡达》\\n10. 警匪类：《神探夏洛克》\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1734414181,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":17,\"completion_tokens\":201,\"total_tokens\":218,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2024-12-17 13:43:04');
INSERT INTO `chat_responses` VALUES (9, '1+1=？', '{\"id\":\"chatcmpl-AfKeZ97cUotm1HuJ4cG9SqCmDk2m7\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"2\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1734414203,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":12,\"completion_tokens\":1,\"total_tokens\":13,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2024-12-17 13:43:26');
INSERT INTO `chat_responses` VALUES (10, '企业java是什么', '{\"id\":\"chatcmpl-AfNxT8Kpff1OZT7UxdP4np42iIg74\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"企业Java是指用Java语言开发企业级应用程序的过程。企业Java通常涉及使用Java EE（Enterprise Edition）平台来构建复杂的、高性能的、安全的企业级应用程序，这些应用程序通常需要大量的数据处理、事务管理和并发处理。企业Java开发还可能涉及使用一些流行的开发框架和工具，如Spring、Hibernate、Maven等。企业Java开发人员通常需要具备扎实的Java编程基础和对企业级开发相关技术和工具的熟悉度。\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1734426907,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":14,\"completion_tokens\":163,\"total_tokens\":177,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2024-12-17 17:15:13');
INSERT INTO `chat_responses` VALUES (11, '给我 动作 类别的电影', '{\"id\":\"chatcmpl-AfNyFZkMvbc4S0a9PxolM9yiDxJyw\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"1. 动作冒险片：比如《指环王》、《加勒比海盗》\\n2. 武打片：比如《功夫》、《少林足球》\\n3. 特工片：比如《007系列》、《谍影重重》\\n4. 武侠片：比如《霸王别姬》、《笑傲江湖》\\n5. 警匪片：比如《非常警察》、《疯狂的石头》\\n6. 战争片：比如《拯救大兵瑞恩》、《黑鹰坠落》\\n7. 超级英雄片：比如《复仇者联盟》、《蝙蝠侠》\\n8. 科幻动作片：比如《终结者》、《变形金刚》\\n9. 格斗片：比如《斗罗大陆》、《拳霸》\\n10. 犯罪动作片：比如《无间道》、《教父》\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1734426955,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":17,\"completion_tokens\":288,\"total_tokens\":305,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2024-12-17 17:15:59');
INSERT INTO `chat_responses` VALUES (12, '给我 动作, 喜剧 类别的电影', '{\"id\":\"chatcmpl-AfNyNe2YCBFX7L8uSsCxcLEFYRuFK\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"《玩具总动员》\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1734426963,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":23,\"completion_tokens\":8,\"total_tokens\":31,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2024-12-17 17:16:07');
INSERT INTO `chat_responses` VALUES (13, '给我 爱情 类别的电影', '{\"id\":\"chatcmpl-AfNyctPock02cKaTLtkQeEBoGOxzf\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"1. 《罗马假日》\\n2. 《泰坦尼克号》\\n3. 《与神同行》\\n4. 《爱情是什么》\\n5. 《这个男人来自地球》\\n6. 《心灵捕手》\\n7. 《初恋这件小事》\\n8. 《恋恋笔记本》\\n9. 《听见涛声》\\n10. 《剪刀手爱德华》\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1734426978,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":18,\"completion_tokens\":131,\"total_tokens\":149,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2024-12-17 17:16:21');
INSERT INTO `chat_responses` VALUES (14, 'hello', '{\"id\":\"chatcmpl-AfNzIGtYSoAoKVN3796RrVM0Q7yN0\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1734427020,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":8,\"completion_tokens\":9,\"total_tokens\":17,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2024-12-17 17:17:04');
INSERT INTO `chat_responses` VALUES (15, '给我 喜剧 类别的电影', '{\"id\":\"chatcmpl-AniT79XTHCBNqynMxHOcXnArZoS6O\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"1.《美国派》(American Pie)\\n2.《超级玛丽》(Super Mario Bros.)\\n3.《小鬼当家》(Home Alone)\\n4.《山炮进城》(Outrageous Fortune)\\n5.《特工老爸》(Central Intelligence)\\n6.《空中监狱》(Airplane!)\\n7.《逃学威龙》(Fight Back to School)\\n8.《欢乐喜剧人》(Happy Times)\\n9.《憨豆先生》(Mr. Bean)\\n10.《全面开战》(Tropic Thunder)\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1736412373,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":19,\"completion_tokens\":150,\"total_tokens\":169,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2025-01-09 16:46:21');
INSERT INTO `chat_responses` VALUES (16, '刘艳秋你认识吗‘、', '{\"id\":\"chatcmpl-AniTW0JloZaw6EOjizLQhALXhaNGn\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"抱歉，我不清楚刘艳秋是谁。可能是我没有听说过他/她。需要我帮你查找相关信息吗？\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1736412398,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":21,\"completion_tokens\":45,\"total_tokens\":66,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2025-01-09 16:46:45');
INSERT INTO `chat_responses` VALUES (17, '东华大学是什么', '{\"id\":\"chatcmpl-AniTgA4T3wugocw7bSypAUPDCzu2l\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"东华大学是中国上海的一所综合性大学，前身为创立于1951年的华东纺织工学院，2005年更名为东华大学。学校以工为主，文、理、管理、艺术等学科设置齐全，是国家“211工程”重点支持的高校之一。东华大学在纺织、服装设计、材料科学、化学工程等领域具有一定的优势和影响力。\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1736412408,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":15,\"completion_tokens\":140,\"total_tokens\":155,\"completion_tokens_details\":{\"audio_tokens\":0,\"reasoning_tokens\":0},\"prompt_tokens_details\":{\"audio_tokens\":0,\"cached_tokens\":0}},\"system_fingerprint\":null}', '2025-01-09 16:46:55');
INSERT INTO `chat_responses` VALUES (18, '给我 纪录片 类别的电影', '{\"id\":\"chatcmpl-BJcXanHvAGizGtBDg59C0wLOREiIZ\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"1. \\\"13th\\\" (2016) - 导演：艾娜·杜瑞恩\\n2. \\\"海洋\\\" (2009) - 导演：雅克·贝汉\\n3. \\\"地球脉动\\\" (2006) - 导演：阿尔瓦·斯科格\\n4. \\\"血与沙：男士运动\\\" (2012) - 导演：保罗·汉斯福德\\n5. \\\"上帝的拳头\\\" (2015) - 导演：大卫·卡娜\\n6. \\\"寻找失控的孩子\\\" (2006) - 导演：丹尼·普哈兰\\n7. \\\"塔夫特夫克尼\\\" (2010) - 导演：凯蒂·库里克\\n8. \\\"会说话的猩猩\\\" (2011) - 导演：詹姆斯·马什\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744016082,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":19,\"completion_tokens\":263,\"total_tokens\":282},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 16:54:46');
INSERT INTO `chat_responses` VALUES (19, 'hello', '{\"id\":\"chatcmpl-BJcsaA903xVHzkadL36rNOIK1Ss1p\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744017384,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":8,\"completion_tokens\":9,\"total_tokens\":17},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 09:16:26');
INSERT INTO `chat_responses` VALUES (20, 'hello', '{\"id\":\"chatcmpl-BJcxfRwZc50XyShcqvKuz4YZnhqEw\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744017699,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":8,\"completion_tokens\":9,\"total_tokens\":17},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 09:21:41');
INSERT INTO `chat_responses` VALUES (21, '你好', '{\"id\":\"chatcmpl-BJcxnMtKYdDxb4hP26Hf4ystd47CZ\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"你好！有什么可以帮助你的吗？\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744017707,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":9,\"completion_tokens\":17,\"total_tokens\":26},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 09:21:49');
INSERT INTO `chat_responses` VALUES (22, 'hello', '{\"id\":\"chatcmpl-BJcxwc6Nwb9lETNvYlZInjBKfMuvr\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744017716,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":8,\"completion_tokens\":9,\"total_tokens\":17},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 09:21:58');
INSERT INTO `chat_responses` VALUES (23, 'hello', '{\"id\":\"chatcmpl-BJd0pNVVuAnJNG81jLxsHhkVTpx06\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744017895,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":8,\"completion_tokens\":9,\"total_tokens\":17},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 09:24:57');
INSERT INTO `chat_responses` VALUES (24, 'hello', '{\"id\":\"chatcmpl-BJd162ZzVl3WDguWZDnwWyeOL0YiG\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744017912,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":8,\"completion_tokens\":9,\"total_tokens\":17},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 09:25:14');
INSERT INTO `chat_responses` VALUES (25, 'hello', '{\"id\":\"chatcmpl-BJd3wIEHbhbtTZ5vKhgHGHYRBVNEk\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744018088,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":8,\"completion_tokens\":9,\"total_tokens\":17},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 09:28:10');
INSERT INTO `chat_responses` VALUES (26, 'hello', '{\"id\":\"chatcmpl-BJd4GO2Fe04JCv58R2GP85BeNK2hO\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744018108,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":8,\"completion_tokens\":9,\"total_tokens\":17},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 09:28:30');
INSERT INTO `chat_responses` VALUES (27, 'hello', '{\"id\":\"chatcmpl-BJd7bASH3TpkM7p8ej5sAMV1AZnuq\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744018315,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":8,\"completion_tokens\":9,\"total_tokens\":17},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 09:31:57');
INSERT INTO `chat_responses` VALUES (28, 'hello', '{\"id\":\"chatcmpl-BJd9OBHpKNxhpRXi2NuomCwVkFwoM\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744018426,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":8,\"completion_tokens\":9,\"total_tokens\":17},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 09:33:48');
INSERT INTO `chat_responses` VALUES (29, 'hello', '{\"id\":\"chatcmpl-BJdA34diIIvEWOZR3qRXUiOcLP0Ql\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744018467,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":8,\"completion_tokens\":9,\"total_tokens\":17},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 09:34:29');
INSERT INTO `chat_responses` VALUES (30, 'hello', '{\"id\":\"chatcmpl-BJdABAY3exR8FEkDffwoSuNA0xatB\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744018475,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":8,\"completion_tokens\":9,\"total_tokens\":17},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 09:34:37');
INSERT INTO `chat_responses` VALUES (31, 'hello', '{\"id\":\"chatcmpl-BJdMeNT4BP9g2xL4qq3kmyMTadMj8\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744019248,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":8,\"completion_tokens\":9,\"total_tokens\":17},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 09:47:30');
INSERT INTO `chat_responses` VALUES (32, '123', '{\"id\":\"chatcmpl-BJdOsj2YIWvT3SNSX5ogJbOqpsecG\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744019386,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":8,\"completion_tokens\":9,\"total_tokens\":17},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 09:49:48');
INSERT INTO `chat_responses` VALUES (33, '·12222', '{\"id\":\"chatcmpl-BJdP6QDnJ5crMbbs2qyHnHfgPcFEW\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Thank you for providing the current year as 2022. Is there anything specific you would like to know or discuss?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744019400,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":10,\"completion_tokens\":24,\"total_tokens\":34},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 09:50:02');
INSERT INTO `chat_responses` VALUES (34, '你好', '{\"id\":\"chatcmpl-BJdU5YV2HSWfkQhdFtIbBUMRhnOQi\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"你好！有什么可以帮助你的吗？\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744019709,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":9,\"completion_tokens\":17,\"total_tokens\":26},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 09:55:12');
INSERT INTO `chat_responses` VALUES (35, 'hello', '{\"id\":\"chatcmpl-BJdbWT0JSKchmueSDX2VKiE4wtW8q\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744020170,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":8,\"completion_tokens\":9,\"total_tokens\":17},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 10:02:53');
INSERT INTO `chat_responses` VALUES (36, '111111', '{\"id\":\"chatcmpl-BJdbp6wxrbjPDxj2YnDHAufzcqsRZ\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744020189,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":9,\"completion_tokens\":9,\"total_tokens\":18},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 10:03:11');
INSERT INTO `chat_responses` VALUES (37, '11111', '{\"id\":\"chatcmpl-BJdc2SvBy0ZfTqq4WKR2wmauWnMbv\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744020202,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":9,\"completion_tokens\":9,\"total_tokens\":18},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 10:03:24');
INSERT INTO `chat_responses` VALUES (38, '1111111', '{\"id\":\"chatcmpl-BJdcZx6wGVwRfxTk5dLpsCzR78Xzu\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744020235,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":10,\"completion_tokens\":9,\"total_tokens\":19},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 10:03:57');
INSERT INTO `chat_responses` VALUES (39, '111111', '{\"id\":\"chatcmpl-BJddKdNAwZunKrV2bl9MSU6hRI1Ip\",\"choices\":[{\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"Hello! How can I assist you today?\"},\"logprobs\":null,\"finish_reason\":\"stop\"}],\"created\":1744020282,\"model\":\"gpt-3.5-turbo-0125\",\"object\":\"chat.completion\",\"usage\":{\"prompt_tokens\":9,\"completion_tokens\":9,\"total_tokens\":18},\"system_fingerprint\":\"fp_0165350fbb\"}', '2025-04-07 10:04:44');
INSERT INTO `chat_responses` VALUES (40, '111111111111', 'Hello! How can I assist you today?', '2025-04-07 10:09:21');
INSERT INTO `chat_responses` VALUES (41, '哈哈哈', '哈哈哈，有什么好笑的事情要分享吗？', '2025-04-07 11:26:31');

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
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (27, 1, 24, '哈哈哈哈', '2024-12-07 22:28:54');
INSERT INTO `comments` VALUES (31, 2, 11, 'hahha', '2025-03-03 15:39:01');
INSERT INTO `comments` VALUES (32, 20, 1, '哈哈哈', '2025-04-05 08:19:52');
INSERT INTO `comments` VALUES (33, 20, 1, 'hahhah', '2025-04-05 09:08:48');
INSERT INTO `comments` VALUES (34, 20, 1, '哈哈哈哈', '2025-04-06 06:58:55');
INSERT INTO `comments` VALUES (46, 24, 1, 'aaa', '2025-04-07 12:00:41');

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
) ENGINE = InnoDB AUTO_INCREMENT = 112 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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
INSERT INTO `likes` VALUES (60, 20, 11, '2025-01-09 16:46:11');

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
  `avatar_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户头像链接',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  UNIQUE INDEX `email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'admin', '123456', 'admin@example.com', 'admin', '2024-11-24 15:40:37', '2025-04-05 17:56:24', '/avatars/admin.png');
INSERT INTO `users` VALUES (2, 'client_user1', '123456', 'client1@example.com', 'client', '2024-11-24 15:40:37', '2025-04-05 17:59:21', '/avatars/client.png');
INSERT INTO `users` VALUES (3, 'client_user2', '123456', 'client2@example.com', 'client', '2024-11-24 15:40:37', '2025-04-05 17:59:20', '/avatars/client.png');
INSERT INTO `users` VALUES (9, 'admin3', '123456', '1563426658@qq.com', 'client', '2024-11-26 14:46:02', '2025-04-05 17:58:01', '/avatars/admin.png');
INSERT INTO `users` VALUES (10, 'admin56sdasd', '123456', '221310213@mail.dhu.edu.cn', 'client', '2024-11-26 14:50:00', '2025-04-05 17:58:03', '/avatars/admin.png');
INSERT INTO `users` VALUES (11, 'gyf12', 'a.123456', '1563426958@qq.com', 'client', '2024-12-01 11:16:17', '2025-04-05 17:59:15', '/avatars/client.png');
INSERT INTO `users` VALUES (24, 'gyfssaa', 'a.123456', '1563421sss@qq.com', 'client', '2024-12-07 22:28:22', '2025-04-05 17:59:19', '/avatars/client.png');
INSERT INTO `users` VALUES (28, 'admin1', 'a.123456', '221310213s2@mail.dhu.edu.cn', 'client', '2025-04-03 06:47:09', '2025-04-07 11:26:48', '/avatars/admin1.png');
INSERT INTO `users` VALUES (29, 'admin2', '123456', '156342695ss8@qq.com', 'client', '2025-04-05 07:35:30', '2025-04-05 17:58:06', '/avatars/admin.png');

SET FOREIGN_KEY_CHECKS = 1;
