/*
 Navicat MySQL Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50633
 Source Host           : localhost:3306
 Source Schema         : stock

 Target Server Type    : MySQL
 Target Server Version : 50633
 File Encoding         : 65001

 Date: 09/08/2021 19:09:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for stock_realtime
-- ----------------------------
DROP TABLE IF EXISTS `stock_realtime`;
CREATE TABLE `stock_realtime`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '股票名字',
  `open` decimal(10, 3) NULL DEFAULT NULL COMMENT '今日开盘价',
  `pre_close` decimal(10, 3) NULL DEFAULT NULL COMMENT '昨日收盘价',
  `price` decimal(10, 3) NULL DEFAULT NULL COMMENT '当前价格',
  `high` decimal(10, 3) NULL DEFAULT NULL COMMENT '今日最高价',
  `low` decimal(10, 3) NULL DEFAULT NULL COMMENT '今日最低价',
  `bid` decimal(10, 3) NULL DEFAULT NULL COMMENT '竞买价，即“买一”报价',
  `ask` decimal(10, 3) NULL DEFAULT NULL COMMENT '竞卖价，即“卖一”报价',
  `volume` bigint(20) NULL DEFAULT NULL COMMENT '成交量',
  `amount` decimal(20, 3) NULL DEFAULT NULL COMMENT '成交金额（元 CNY）',
  `b1_v` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买一（笔数 bid volume）',
  `b1_p` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买一（价格 bid price）',
  `b2_v` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买2（笔数 bid volume）',
  `b2_p` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买2（价格 bid price）',
  `b3_v` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买3（价格 bid price）',
  `b3_p` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买3（价格 bid price）',
  `b4_v` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买4（价格 bid price）',
  `b4_p` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买4（价格 bid price）',
  `b5_v` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买5（价格 bid price）',
  `b5_p` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买5（价格 bid price）',
  `a1_v` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买1（笔数 bid volume）',
  `a1_p` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买一（价格 bid price）',
  `a2_v` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买2（笔数 bid volume）',
  `a2_p` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买2（价格 bid price）',
  `a3_v` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买3（价格 bid price）',
  `a3_p` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买3（价格 bid price）',
  `a4_v` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买4（价格 bid price）',
  `a4_p` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买4（价格 bid price）',
  `a5_v` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买5（价格 bid price）',
  `a5_p` decimal(10, 3) NULL DEFAULT NULL COMMENT '委买5（价格 bid price）',
  `date` datetime(0) NULL DEFAULT NULL COMMENT '日期',
  `time` time(0) NULL DEFAULT NULL COMMENT '时间',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'code',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2161 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
