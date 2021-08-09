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

 Date: 09/08/2021 19:09:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for stock_history
-- ----------------------------
DROP TABLE IF EXISTS `stock_history`;
CREATE TABLE `stock_history`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `date_trade` datetime(0) NULL DEFAULT NULL,
  `pre_close` decimal(10, 3) NULL DEFAULT NULL,
  `close` decimal(10, 3) NULL DEFAULT NULL,
  `change_v` decimal(10, 3) NULL DEFAULT NULL,
  `pct_chg` decimal(10, 3) NULL DEFAULT NULL,
  `vol` int(255) NULL DEFAULT NULL,
  `amount` decimal(10, 3) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_stock_history_code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 730474 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

SET FOREIGN_KEY_CHECKS = 1;
