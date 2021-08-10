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

 Date: 10/08/2021 18:31:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for stock_realtime_today
-- ----------------------------
DROP TABLE IF EXISTS `stock_realtime_today`;
CREATE TABLE `stock_realtime_today`  (
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `pre_close` decimal(10, 2) NULL DEFAULT NULL COMMENT '昨收价格',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '实时价',
  `change_percent` decimal(10, 2) NULL DEFAULT NULL COMMENT '今日涨幅',
  `open` decimal(10, 2) NULL DEFAULT NULL COMMENT '开盘',
  `high` decimal(10, 2) NULL DEFAULT NULL COMMENT '最高',
  `low` decimal(10, 2) NULL DEFAULT NULL COMMENT '最低',
  `volume` bigint(15) NULL DEFAULT NULL COMMENT '成交量',
  `amount` decimal(20, 2) NULL DEFAULT NULL COMMENT '成交金额'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
