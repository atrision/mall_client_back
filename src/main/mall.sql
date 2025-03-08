/*
 Navicat Premium Dump SQL

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80013 (8.0.13)
 Source Host           : localhost:3306
 Source Schema         : mall

 Target Server Type    : MySQL
 Target Server Version : 80013 (8.0.13)
 File Encoding         : 65001

 Date: 05/03/2025 21:37:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for banners
-- ----------------------------
DROP TABLE IF EXISTS `banners`;
CREATE TABLE `banners`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '轮播图ID',
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图片URL',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标题',
  `link_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '跳转链接',
  `sort_order` int(11) NULL DEFAULT 0 COMMENT '排序顺序',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sort_status`(`sort_order` ASC, `status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '轮播图表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of banners
-- ----------------------------
INSERT INTO `banners` VALUES (1, 'https://misuzu.oss-cn-beijing.aliyuncs.com/28000068_170750303080_2.jpg', '轮播图1', 'https://www.yuanshen.com/#/', 0, 1, '2025-02-24 10:00:43', '2025-02-25 19:18:59');
INSERT INTO `banners` VALUES (2, 'https://misuzu.oss-cn-beijing.aliyuncs.com/Lm9M6ws7Xw.jpg', '轮播图2', 'https://www.yuanshen.com/#/', 0, 1, '2025-02-24 10:00:43', '2025-02-24 10:06:34');
INSERT INTO `banners` VALUES (3, 'https://misuzu.oss-cn-beijing.aliyuncs.com/3107.jpg_wh860.jpg', '轮播图3', 'https://www.yuanshen.com/#/', 0, 1, '2025-02-24 10:00:43', '2025-02-24 10:06:34');

-- ----------------------------
-- Table structure for cart_items
-- ----------------------------
DROP TABLE IF EXISTS `cart_items`;
CREATE TABLE `cart_items`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '购物车项ID',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户ID',
  `product_id` int(10) UNSIGNED NOT NULL COMMENT '商品ID',
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '数量',
  `selected` tinyint(1) NULL DEFAULT 1 COMMENT '是否选中：0-否，1-是',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_product`(`user_id` ASC, `product_id` ASC) USING BTREE,
  INDEX `product_id`(`product_id` ASC) USING BTREE,
  CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '购物车表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of cart_items
-- ----------------------------

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `icon` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类图标',
  `parent_id` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '父分类ID',
  `level` tinyint(4) NULL DEFAULT 1 COMMENT '层级：1-一级分类，2-二级分类',
  `sort_order` int(11) NULL DEFAULT 0 COMMENT '排序顺序',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_parent_sort`(`parent_id` ASC, `sort_order` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, '男装', NULL, 0, 1, 0, 1, '2025-02-24 10:01:27', '2025-02-24 10:05:58');
INSERT INTO `categories` VALUES (2, '女装', NULL, 0, 1, 0, 1, '2025-02-24 10:01:27', '2025-02-24 10:05:58');
INSERT INTO `categories` VALUES (3, '童装', NULL, 0, 1, 0, 1, '2025-02-24 10:01:27', '2025-02-24 10:05:58');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'users', '用户表', NULL, NULL, 'Users', 'crud', 'element-plus', 'com.mall.manage', 'manage', 'users', '用户管理', 'misuzu', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2025-02-26 10:08:14', '', '2025-03-05 17:58:42', NULL);
INSERT INTO `gen_table` VALUES (2, 'orders', '订单表', NULL, NULL, 'Orders', 'crud', 'element-plus', 'com.mall.manage', 'manage', 'orders', '订单管理', 'misuzu', '0', '/', '{\"parentMenuId\":\"2000\"}', 'admin', '2025-02-26 14:29:26', '', '2025-02-26 14:48:11', NULL);
INSERT INTO `gen_table` VALUES (3, 'products', '商品表', NULL, NULL, 'Products', 'crud', 'element-plus', 'com.mall.manage', 'manage', 'products', '商品管理', 'ruoyi', '0', '/', '{\"parentMenuId\":\"2019\"}', 'admin', '2025-02-26 15:01:39', '', '2025-02-26 15:20:18', NULL);
INSERT INTO `gen_table` VALUES (4, 'banners', '轮播图表', NULL, NULL, 'Banners', 'crud', 'element-plus', 'com.mall.manage', 'manage', 'banners', '轮播图', 'misuzu', '0', '/', '{\"parentMenuId\":2019}', 'admin', '2025-02-26 15:24:43', '', '2025-02-26 15:29:23', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint(20) NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, 1, 'id', '用户ID', 'int(10) unsigned', 'Integer', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-26 10:08:14', '', '2025-03-05 17:58:42');
INSERT INTO `gen_table_column` VALUES (2, 1, 'username', '用户名', 'varchar(50)', 'String', 'username', '0', '0', '1', '0', '0', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-02-26 10:08:14', '', '2025-03-05 17:58:42');
INSERT INTO `gen_table_column` VALUES (3, 1, 'password', '密码', 'varchar(255)', 'String', 'password', '0', '0', '1', '0', '0', '1', '0', 'EQ', 'input', '', 3, 'admin', '2025-02-26 10:08:14', '', '2025-03-05 17:58:42');
INSERT INTO `gen_table_column` VALUES (5, 1, 'status', '状态：0-禁用，1-启用', 'tinyint(1)', 'Integer', 'status', '0', '0', '0', '0', '0', '1', '1', 'EQ', 'radio', 'user_status', 5, 'admin', '2025-02-26 10:08:14', '', '2025-03-05 17:58:42');
INSERT INTO `gen_table_column` VALUES (6, 1, 'created_at', '创建时间', 'timestamp', 'Date', 'createdAt', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'datetime', '', 6, 'admin', '2025-02-26 10:08:14', '', '2025-03-05 17:58:42');
INSERT INTO `gen_table_column` VALUES (7, 1, 'updated_at', '更新时间', 'timestamp', 'Date', 'updatedAt', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'datetime', '', 7, 'admin', '2025-02-26 10:08:14', '', '2025-03-05 17:58:42');
INSERT INTO `gen_table_column` VALUES (8, 2, 'id', '订单ID', 'int(10) unsigned', 'Integer', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-26 14:29:26', '', '2025-02-26 14:48:11');
INSERT INTO `gen_table_column` VALUES (9, 2, 'user_id', '用户ID', 'int(10) unsigned', 'Integer', 'userId', '0', '0', '1', '1', '0', '1', '1', 'EQ', 'input', '', 2, 'admin', '2025-02-26 14:29:26', '', '2025-02-26 14:48:11');
INSERT INTO `gen_table_column` VALUES (10, 2, 'order_status', '订单状态：0-待支付，1-已支付，2-已发货，3-已完成，4-已取消', 'tinyint(1)', 'Integer', 'orderStatus', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', 'order_status', 3, 'admin', '2025-02-26 14:29:26', '', '2025-02-26 14:48:11');
INSERT INTO `gen_table_column` VALUES (11, 2, 'total_amount', '订单总金额', 'decimal(10,2)', 'BigDecimal', 'totalAmount', '0', '0', '1', '1', '0', '1', '0', 'EQ', 'input', '', 4, 'admin', '2025-02-26 14:29:26', '', '2025-02-26 14:48:11');
INSERT INTO `gen_table_column` VALUES (12, 2, 'created_at', '创建时间', 'timestamp', 'Date', 'createdAt', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'datetime', '', 5, 'admin', '2025-02-26 14:29:26', '', '2025-02-26 14:48:11');
INSERT INTO `gen_table_column` VALUES (13, 2, 'updated_at', '更新时间', 'timestamp', 'Date', 'updatedAt', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'datetime', '', 6, 'admin', '2025-02-26 14:29:26', '', '2025-02-26 14:48:11');
INSERT INTO `gen_table_column` VALUES (14, 3, 'id', '商品ID', 'int(10) unsigned', 'Integer', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-26 15:01:39', '', '2025-02-26 15:20:18');
INSERT INTO `gen_table_column` VALUES (15, 3, 'category_id', '分类ID', 'int(10) unsigned', 'Integer', 'categoryId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', 'category', 2, 'admin', '2025-02-26 15:01:39', '', '2025-02-26 15:20:18');
INSERT INTO `gen_table_column` VALUES (16, 3, 'title', '商品标题', 'varchar(100)', 'String', 'title', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-02-26 15:01:39', '', '2025-02-26 15:20:18');
INSERT INTO `gen_table_column` VALUES (17, 3, 'image_url', '商品图片URL', 'varchar(500)', 'String', 'imageUrl', '0', '0', '1', '1', '1', '0', '0', 'EQ', 'textarea', '', 4, 'admin', '2025-02-26 15:01:39', '', '2025-02-26 15:20:18');
INSERT INTO `gen_table_column` VALUES (18, 3, 'price', '商品价格', 'decimal(10,2)', 'BigDecimal', 'price', '0', '0', '1', '1', '1', '1', '0', 'EQ', 'input', '', 5, 'admin', '2025-02-26 15:01:39', '', '2025-02-26 15:20:18');
INSERT INTO `gen_table_column` VALUES (19, 3, 'status', '状态：0-下架，1-上架', 'tinyint(1)', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', 'products_status', 6, 'admin', '2025-02-26 15:01:39', '', '2025-02-26 15:20:18');
INSERT INTO `gen_table_column` VALUES (20, 3, 'created_at', '创建时间', 'timestamp', 'Date', 'createdAt', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'datetime', '', 7, 'admin', '2025-02-26 15:01:39', '', '2025-02-26 15:20:18');
INSERT INTO `gen_table_column` VALUES (21, 3, 'updated_at', '更新时间', 'timestamp', 'Date', 'updatedAt', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'datetime', '', 8, 'admin', '2025-02-26 15:01:39', '', '2025-02-26 15:20:18');
INSERT INTO `gen_table_column` VALUES (22, 3, 'rate', '销量', 'int(11)', 'Long', 'rate', '0', '0', '0', '0', '0', '1', '0', 'EQ', 'input', '', 9, 'admin', '2025-02-26 15:01:39', '', '2025-02-26 15:20:18');
INSERT INTO `gen_table_column` VALUES (23, 4, 'id', '轮播图ID', 'int(10) unsigned', 'Integer', 'id', '1', '1', '0', '0', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-02-26 15:24:43', '', '2025-02-26 15:29:23');
INSERT INTO `gen_table_column` VALUES (24, 4, 'image_url', '图片URL', 'varchar(500)', 'String', 'imageUrl', '0', '0', '1', '1', '1', '0', '0', 'EQ', 'textarea', '', 2, 'admin', '2025-02-26 15:24:43', '', '2025-02-26 15:29:23');
INSERT INTO `gen_table_column` VALUES (25, 4, 'title', '标题', 'varchar(100)', 'String', 'title', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2025-02-26 15:24:43', '', '2025-02-26 15:29:23');
INSERT INTO `gen_table_column` VALUES (26, 4, 'link_url', '跳转链接', 'varchar(255)', 'String', 'linkUrl', '0', '0', '0', '1', '1', '1', '0', 'EQ', 'input', '', 4, 'admin', '2025-02-26 15:24:43', '', '2025-02-26 15:29:23');
INSERT INTO `gen_table_column` VALUES (27, 4, 'sort_order', '排序顺序', 'int(11)', 'Long', 'sortOrder', '0', '0', '0', '1', '1', '0', '0', 'EQ', 'input', '', 5, 'admin', '2025-02-26 15:24:43', '', '2025-02-26 15:29:23');
INSERT INTO `gen_table_column` VALUES (28, 4, 'status', '状态：0-禁用，1-启用', 'tinyint(1)', 'Integer', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', 'banner_status', 6, 'admin', '2025-02-26 15:24:43', '', '2025-02-26 15:29:23');
INSERT INTO `gen_table_column` VALUES (29, 4, 'created_at', '创建时间', 'timestamp', 'Date', 'createdAt', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'datetime', '', 7, 'admin', '2025-02-26 15:24:43', '', '2025-02-26 15:29:23');
INSERT INTO `gen_table_column` VALUES (30, 4, 'updated_at', '更新时间', 'timestamp', 'Date', 'updatedAt', '0', '0', '0', '0', '0', '0', '0', 'EQ', 'datetime', '', 8, 'admin', '2025-02-26 15:24:43', '', '2025-02-26 15:29:23');
INSERT INTO `gen_table_column` VALUES (31, 1, 'email', '邮箱地址', 'varchar(500)', 'String', 'email', '0', '0', '0', '0', '0', '1', '0', 'EQ', 'textarea', '', 4, '', '2025-03-05 17:56:42', '', '2025-03-05 17:58:42');

-- ----------------------------
-- Table structure for order_items
-- ----------------------------
DROP TABLE IF EXISTS `order_items`;
CREATE TABLE `order_items`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单详情ID',
  `order_id` int(10) UNSIGNED NOT NULL COMMENT '订单ID',
  `product_id` int(10) UNSIGNED NOT NULL COMMENT '商品ID',
  `quantity` int(10) UNSIGNED NOT NULL COMMENT '商品数量',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `unit_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '下单时单价',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order_id`(`order_id` ASC) USING BTREE,
  INDEX `idx_product_id`(`product_id` ASC) USING BTREE,
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单详情表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of order_items
-- ----------------------------
INSERT INTO `order_items` VALUES (1, 3, 1, 1, '2025-03-03 18:12:14', '2025-03-03 18:12:14', 89.00);
INSERT INTO `order_items` VALUES (2, 3, 3, 1, '2025-03-03 18:12:14', '2025-03-03 18:12:14', 129.00);
INSERT INTO `order_items` VALUES (3, 4, 1, 1, '2025-03-03 19:02:02', '2025-03-03 19:02:02', 89.00);
INSERT INTO `order_items` VALUES (4, 5, 1, 1, '2025-03-03 19:05:43', '2025-03-03 19:05:43', 89.00);
INSERT INTO `order_items` VALUES (5, 5, 2, 1, '2025-03-03 19:05:43', '2025-03-03 19:05:43', 179.00);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户ID',
  `order_status` tinyint(1) NOT NULL COMMENT '订单状态：0-待支付，1-已支付，2-已发货，3-已完成，4-已取消',
  `total_amount` decimal(10, 2) NOT NULL COMMENT '订单总金额',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_order_status`(`order_status` ASC) USING BTREE COMMENT '订单状态索引',
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 1, 3, 100.00, '2025-02-26 10:35:35', '2025-02-26 10:35:35');
INSERT INTO `orders` VALUES (2, 1, 4, 200.00, '2025-02-26 10:35:35', '2025-02-26 10:35:35');
INSERT INTO `orders` VALUES (3, 2, 0, 218.00, '2025-03-03 18:12:14', '2025-03-03 18:12:14');
INSERT INTO `orders` VALUES (4, 2, 3, 89.00, '2025-03-03 19:02:02', '2025-03-03 19:02:47');
INSERT INTO `orders` VALUES (5, 2, 1, 268.00, '2025-03-03 19:05:43', '2025-03-03 19:06:18');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `category_id` int(10) UNSIGNED NOT NULL COMMENT '分类ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品标题',
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品图片URL',
  `price` decimal(10, 2) NOT NULL COMMENT '商品价格',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态：0-下架，1-上架',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `rate` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_category`(`category_id` ASC) USING BTREE,
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '商品表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES (1, 1, '男士T恤', 'https://misuzu.oss-cn-beijing.aliyuncs.com/%E7%94%B7%E5%A3%ABT%E6%81%A4.jpg', 89.00, 1, '2025-02-24 10:06:21', '2025-02-25 20:22:13', 3);
INSERT INTO `products` VALUES (2, 1, '男士牛仔裤', 'https://misuzu.oss-cn-beijing.aliyuncs.com/%E7%94%B7%E5%A3%AB%E7%89%9B%E4%BB%94%E8%A3%A4.jpg', 179.00, 1, '2025-02-24 10:06:21', '2025-02-25 20:22:15', 3);
INSERT INTO `products` VALUES (3, 1, '男士衬衫', 'https://misuzu.oss-cn-beijing.aliyuncs.com/%E7%94%B7%E5%A3%AB%E8%A1%AC%E8%A1%AB.jpg', 129.00, 1, '2025-02-24 10:06:21', '2025-02-25 20:22:16', 2);
INSERT INTO `products` VALUES (4, 1, '男士外套', 'https://misuzu.oss-cn-beijing.aliyuncs.com/%E7%94%B7%E5%A3%AB%E5%A4%96%E5%A5%97.jpg', 249.00, 1, '2025-02-24 10:06:21', '2025-02-25 20:22:17', 2);
INSERT INTO `products` VALUES (5, 2, '女士连衣裙', 'https://misuzu.oss-cn-beijing.aliyuncs.com/%E5%A5%B3%E5%A3%AB%E8%BF%9E%E8%A1%A3%E8%A3%99.jpg', 199.00, 1, '2025-02-24 10:06:21', '2025-02-25 20:22:21', 1);
INSERT INTO `products` VALUES (6, 2, '女士T恤', 'https://misuzu.oss-cn-beijing.aliyuncs.com/%E5%A5%B3%E5%A3%ABT%E6%81%A4.jpg', 79.00, 1, '2025-02-24 10:06:21', '2025-02-24 10:07:14', NULL);
INSERT INTO `products` VALUES (7, 2, '女士牛仔裤', 'https://misuzu.oss-cn-beijing.aliyuncs.com/%E5%A5%B3%E5%A3%AB%E7%89%9B%E4%BB%94%E8%A3%A4.jpg', 159.00, 1, '2025-02-24 10:06:21', '2025-02-24 10:07:14', NULL);
INSERT INTO `products` VALUES (8, 2, '女士外套', 'https://misuzu.oss-cn-beijing.aliyuncs.com/%E5%A5%B3%E5%A3%AB%E5%A4%96%E5%A5%97.jpg', 239.00, 1, '2025-02-24 10:06:21', '2025-02-24 10:07:14', NULL);
INSERT INTO `products` VALUES (9, 3, '儿童T恤', 'https://misuzu.oss-cn-beijing.aliyuncs.com/%E5%84%BF%E7%AB%A5T%E6%81%A4.jpg', 59.00, 1, '2025-02-24 10:06:21', '2025-02-24 10:07:14', NULL);
INSERT INTO `products` VALUES (10, 3, '儿童裤子', 'https://misuzu.oss-cn-beijing.aliyuncs.com/%E5%84%BF%E7%AB%A5%E8%A3%A4%E5%AD%90.jpg', 79.00, 1, '2025-02-24 10:06:21', '2025-02-24 10:07:14', NULL);
INSERT INTO `products` VALUES (11, 3, '儿童连衣裙', 'https://misuzu.oss-cn-beijing.aliyuncs.com/%E5%84%BF%E7%AB%A5%E8%BF%9E%E8%A1%A3%E8%A3%99.jpg', 109.00, 1, '2025-02-24 10:06:21', '2025-02-24 10:07:14', NULL);
INSERT INTO `products` VALUES (12, 3, '儿童外套', 'https://misuzu.oss-cn-beijing.aliyuncs.com/%E5%84%BF%E7%AB%A5%E5%A4%96%E5%A5%97.jpg', 139.00, 1, '2025-02-24 10:06:21', '2025-02-24 10:07:14', NULL);

-- ----------------------------
-- Table structure for recommendations
-- ----------------------------
DROP TABLE IF EXISTS `recommendations`;
CREATE TABLE `recommendations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '推荐商品ID',
  `user_id` int(10) UNSIGNED NOT NULL COMMENT '用户ID',
  `category_id` int(10) UNSIGNED NOT NULL COMMENT '分类ID',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '商品标题',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '商品描述',
  `image_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主图URL',
  `stock` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '库存数量',
  `sales` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '销量',
  `is_recommend` tinyint(1) NULL DEFAULT 0 COMMENT '是否推荐：0-否，1-是',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态：0-下架，1-上架',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_category_status`(`category_id` ASC, `status` ASC) USING BTREE,
  INDEX `idx_recommend`(`is_recommend` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `recommendations_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `recommendations_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '推荐表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of recommendations
-- ----------------------------
INSERT INTO `recommendations` VALUES (1, 1, 1, '打底衫', NULL, 'https://misuzu.oss-cn-beijing.aliyuncs.com/%E6%89%93%E5%BA%95%E8%A1%AB.jpg', 0, 0, 0, 1, '2025-02-24 10:06:01', '2025-02-24 10:07:24');
INSERT INTO `recommendations` VALUES (2, 1, 1, '牛仔裤', NULL, 'https://misuzu.oss-cn-beijing.aliyuncs.com/%E7%89%9B%E4%BB%94%E8%A3%A4.jpg', 0, 0, 0, 1, '2025-02-24 10:06:01', '2025-02-24 10:07:24');
INSERT INTO `recommendations` VALUES (3, 1, 1, '运动鞋', NULL, 'https://misuzu.oss-cn-beijing.aliyuncs.com/%E8%BF%90%E5%8A%A8%E9%9E%8B.jpg', 0, 0, 0, 1, '2025-02-24 10:06:01', '2025-02-24 10:07:24');
INSERT INTO `recommendations` VALUES (4, 1, 1, '裙子', NULL, 'https://misuzu.oss-cn-beijing.aliyuncs.com/%E8%A3%99%E5%AD%90.jpg', 0, 0, 0, 1, '2025-02-24 10:06:01', '2025-02-24 10:07:24');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-02-25 17:11:19', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-02-25 17:11:19', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-02-25 17:11:19', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2025-02-25 17:11:19', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2025-02-25 17:11:19', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-02-25 17:11:19', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-25 17:11:16', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-25 17:11:16', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-25 17:11:16', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-25 17:11:16', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-25 17:11:16', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-25 17:11:16', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-25 17:11:16', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-25 17:11:16', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-25 17:11:16', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2025-02-25 17:11:16', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 114 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 1, '待支付', '0', 'order_status', NULL, 'default', 'N', '0', 'admin', '2025-02-26 14:36:53', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (101, 2, '已支付', '1', 'order_status', NULL, 'default', 'N', '0', 'admin', '2025-02-26 14:37:19', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (102, 3, '已发货', '2', 'order_status', NULL, 'default', 'N', '0', 'admin', '2025-02-26 14:37:37', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (103, 4, '已完成', '3', 'order_status', NULL, 'default', 'N', '0', 'admin', '2025-02-26 14:37:58', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (104, 5, '已取消', '4', 'order_status', NULL, 'default', 'N', '0', 'admin', '2025-02-26 14:38:15', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (105, 1, '下架', '0', 'products_status', NULL, 'default', 'N', '0', 'admin', '2025-02-26 15:05:32', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (106, 2, '上架', '1', 'products_status', NULL, 'default', 'N', '0', 'admin', '2025-02-26 15:05:43', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (107, 1, '男装', '1', 'category', NULL, 'default', 'N', '0', 'admin', '2025-02-26 15:08:01', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (108, 2, '女装', '2', 'category', NULL, 'default', 'N', '0', 'admin', '2025-02-26 15:08:10', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (109, 3, '童装', '3', 'category', NULL, 'default', 'N', '0', 'admin', '2025-02-26 15:08:24', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (110, 1, '禁用', '0', 'banner_status', NULL, 'default', 'N', '0', 'admin', '2025-02-26 15:27:35', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (111, 2, '启用', '1', 'banner_status', NULL, 'default', 'N', '0', 'admin', '2025-02-26 15:27:46', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (112, 1, '禁用', '0', 'user_status', NULL, 'default', 'N', '0', 'admin', '2025-03-05 17:55:26', '', NULL, NULL);
INSERT INTO `sys_dict_data` VALUES (113, 2, '启用', '1', 'user_status', NULL, 'default', 'N', '0', 'admin', '2025-03-05 17:55:39', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-02-25 17:11:18', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '订单状态', 'order_status', '0', 'admin', '2025-02-26 14:35:40', '', NULL, '订单状态：0-待支付，1-已支付，2-已发货，3-已完成，4-已取消');
INSERT INTO `sys_dict_type` VALUES (101, '商品上下架', 'products_status', '0', 'admin', '2025-02-26 15:04:49', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (102, '商品分类', 'category', '0', 'admin', '2025-02-26 15:07:33', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (103, '广告上下架', 'banner_status', '0', 'admin', '2025-02-26 15:26:01', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (104, '用户状态', 'user_status', '0', 'admin', '2025-03-05 17:54:56', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-02-25 17:11:19', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-02-25 17:11:19', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-02-25 17:11:19', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 133 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-02-25 17:17:15');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-02-25 17:32:53');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-02-25 17:32:58');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-02-25 17:33:09');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-02-25 17:33:42');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-02-26 08:37:23');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-02-26 09:44:15');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-02-26 10:51:40');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-02-26 14:28:14');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '验证码错误', '2025-02-26 16:40:04');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '1', '验证码错误', '2025-02-26 16:40:05');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-26 16:40:08');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-02-26 19:47:52');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-26 19:51:07');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-26 20:07:57');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-26 20:08:08');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-26 20:09:46');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-26 20:09:54');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-26 20:23:40');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-26 20:23:44');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '退出成功', '2025-02-26 20:46:54');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-26 20:46:58');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-02-26 20:47:16');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-26 20:49:19');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-27 14:16:05');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-02-27 16:11:47');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-02-27 16:53:56');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-03 13:53:12');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-03-03 17:25:34');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-05 17:15:10');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-03-05 17:52:46');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-03-05 17:53:28');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Chrome 13', 'Windows 10', '0', '登录成功', '2025-03-05 18:31:15');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int(1) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2044 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '1', '', 'system', 'admin', '2025-02-25 17:11:17', 'admin', '2025-03-05 18:20:58', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '1', '', 'monitor', 'admin', '2025-02-25 17:11:17', 'admin', '2025-03-05 18:06:58', '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '1', '', 'tool', 'admin', '2025-02-25 17:11:17', 'admin', '2025-03-05 18:09:54', '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '0', '1', '', 'guide', 'admin', '2025-02-25 17:11:17', 'admin', '2025-02-25 17:30:40', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-02-25 17:11:17', 'admin', '2025-02-27 16:29:23', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-02-25 17:11:17', 'admin', '2025-02-27 16:29:26', '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-02-25 17:11:17', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-02-25 17:11:17', 'admin', '2025-02-27 16:29:29', '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-02-25 17:11:17', 'admin', '2025-02-27 16:29:33', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-02-25 17:11:17', 'admin', '2025-02-27 16:29:35', '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-02-25 17:11:17', 'admin', '2025-02-27 16:29:38', '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-02-25 17:11:17', 'admin', '2025-02-27 16:29:41', '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-02-25 17:11:17', 'admin', '2025-02-27 16:29:45', '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '1', 'monitor:online:list', 'online', 'admin', '2025-02-25 17:11:17', 'admin', '2025-03-05 18:06:03', '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '1', 'monitor:job:list', 'job', 'admin', '2025-02-25 17:11:17', 'admin', '2025-03-05 18:06:00', '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '1', 'monitor:druid:list', 'druid', 'admin', '2025-02-25 17:11:17', 'admin', '2025-03-05 18:05:57', '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务器监控', 0, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-02-25 17:11:17', 'admin', '2025-03-05 18:06:35', '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '1', 'monitor:cache:list', 'redis', 'admin', '2025-02-25 17:11:17', 'admin', '2025-03-05 18:06:11', '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '1', 'monitor:cache:list', 'redis-list', 'admin', '2025-02-25 17:11:17', 'admin', '2025-03-05 18:06:14', '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-02-25 17:11:17', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-02-25 17:11:17', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-02-25 17:11:17', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-02-25 17:11:17', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-02-25 17:11:17', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-02-25 17:11:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '用户订单管理', 0, 4, 'users', NULL, NULL, '', 1, 0, 'M', '0', '1', '', 'peoples', 'admin', '2025-02-26 10:10:15', 'admin', '2025-03-05 18:07:26', '');
INSERT INTO `sys_menu` VALUES (2013, '订单管理', 0, 1, 'orders', 'manage/orders/index', NULL, '', 1, 0, 'C', '0', '0', 'manage:orders:list', 'money', 'admin', '2025-02-26 14:55:01', 'admin', '2025-03-05 18:08:30', '订单管理菜单');
INSERT INTO `sys_menu` VALUES (2014, '订单管理查询', 2013, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:orders:query', '#', 'admin', '2025-02-26 14:55:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '订单管理新增', 2013, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:orders:add', '#', 'admin', '2025-02-26 14:55:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '订单管理修改', 2013, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:orders:edit', '#', 'admin', '2025-02-26 14:55:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '订单管理删除', 2013, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:orders:remove', '#', 'admin', '2025-02-26 14:55:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '订单管理导出', 2013, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:orders:export', '#', 'admin', '2025-02-26 14:55:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '商品业务管理', 0, 5, 'shopping', NULL, NULL, '', 1, 0, 'M', '0', '1', '', 'shopping', 'admin', '2025-02-26 15:01:15', 'admin', '2025-03-05 18:07:46', '');
INSERT INTO `sys_menu` VALUES (2026, '商品管理', 0, 1, 'products', 'manage/products/index', NULL, '', 1, 0, 'C', '0', '0', 'manage:products:list', 'shopping', 'admin', '2025-02-26 15:22:15', 'admin', '2025-03-05 18:08:39', '商品管理菜单');
INSERT INTO `sys_menu` VALUES (2027, '商品管理查询', 2026, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:products:query', '#', 'admin', '2025-02-26 15:22:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2028, '商品管理新增', 2026, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:products:add', '#', 'admin', '2025-02-26 15:22:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2029, '商品管理修改', 2026, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:products:edit', '#', 'admin', '2025-02-26 15:22:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2030, '商品管理删除', 2026, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:products:remove', '#', 'admin', '2025-02-26 15:22:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2031, '商品管理导出', 2026, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:products:export', '#', 'admin', '2025-02-26 15:22:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2032, '广告管理', 0, 1, 'banners', 'manage/banners/index', NULL, '', 1, 0, 'C', '0', '0', 'manage:banners:list', 'wechat', 'admin', '2025-02-26 15:30:44', 'admin', '2025-03-05 18:09:07', '轮播图菜单');
INSERT INTO `sys_menu` VALUES (2033, '轮播图查询', 2032, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:banners:query', '#', 'admin', '2025-02-26 15:30:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2034, '轮播图新增', 2032, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:banners:add', '#', 'admin', '2025-02-26 15:30:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2035, '轮播图修改', 2032, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:banners:edit', '#', 'admin', '2025-02-26 15:30:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2036, '轮播图删除', 2032, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:banners:remove', '#', 'admin', '2025-02-26 15:30:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2037, '轮播图导出', 2032, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:banners:export', '#', 'admin', '2025-02-26 15:30:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2038, '用户管理', 0, 1, 'users', 'manage/users/index', NULL, '', 1, 0, 'C', '0', '0', 'manage:users:list', 'user', 'admin', '2025-03-05 18:02:08', 'admin', '2025-03-05 18:09:17', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (2039, '用户管理查询', 2038, 1, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:users:query', '#', 'admin', '2025-03-05 18:02:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2040, '用户管理新增', 2038, 2, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:users:add', '#', 'admin', '2025-03-05 18:02:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2041, '用户管理修改', 2038, 3, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:users:edit', '#', 'admin', '2025-03-05 18:02:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2042, '用户管理删除', 2038, 4, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:users:remove', '#', 'admin', '2025-03-05 18:02:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2043, '用户管理导出', 2038, 5, '#', '', NULL, '', 1, 0, 'F', '0', '0', 'manage:users:export', '#', 'admin', '2025-03-05 18:02:09', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2025-02-25 17:11:19', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2025-02-25 17:11:19', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(1) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(20) NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 237 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-25 17:30:40', 50);
INSERT INTO `sys_oper_log` VALUES (101, '代码生成', 6, 'com.mall.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"users\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 10:08:14', 205);
INSERT INTO `sys_oper_log` VALUES (102, '菜单管理', 1, 'com.mall.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"用户管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"users\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 10:10:15', 88);
INSERT INTO `sys_oper_log` VALUES (103, '代码生成', 2, 'com.mall.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"users\",\"className\":\"Users\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"用户ID\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"int(10) unsigned\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 10:08:14\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Integer\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Username\",\"columnComment\":\"用户名\",\"columnId\":2,\"columnName\":\"username\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 10:08:14\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"username\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Password\",\"columnComment\":\"密码\",\"columnId\":3,\"columnName\":\"password\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 10:08:14\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"password\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"AvatarUrl\",\"columnComment\":\"头像URL\",\"columnId\":4,\"columnName\":\"avatar_url\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 10:08:14\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequir', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 10:15:20', 133);
INSERT INTO `sys_oper_log` VALUES (104, '代码生成', 2, 'com.mall.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"users\",\"className\":\"Users\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"用户ID\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"int(10) unsigned\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 10:08:14\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Integer\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-02-26 10:15:20\",\"usableColumn\":false},{\"capJavaField\":\"Username\",\"columnComment\":\"用户名\",\"columnId\":2,\"columnName\":\"username\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 10:08:14\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"username\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-02-26 10:15:20\",\"usableColumn\":false},{\"capJavaField\":\"Password\",\"columnComment\":\"密码\",\"columnId\":3,\"columnName\":\"password\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 10:08:14\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"password\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-02-26 10:15:20\",\"usableColumn\":false},{\"capJavaField\":\"AvatarUrl\",\"columnComment\":\"头像URL\",\"columnId\":4,\"columnName\":\"avatar_url\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 10:08:14\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"textarea\",\"increment\":false,\"in', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 10:19:22', 100);
INSERT INTO `sys_oper_log` VALUES (105, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-02-26 10:10:15\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"用户管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"users\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 10:19:42', 110);
INSERT INTO `sys_oper_log` VALUES (106, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-02-26 10:10:15\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"用户订单管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"users\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 10:20:05', 79);
INSERT INTO `sys_oper_log` VALUES (107, '代码生成', 8, 'com.mall.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"users\"}', NULL, 0, NULL, '2025-02-26 10:20:16', 408);
INSERT INTO `sys_oper_log` VALUES (108, '用户管理', 2, 'com.mall.manage.controller.UsersController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/users', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-02-24 10:04:28\",\"id\":1,\"params\":{},\"status\":1,\"updatedAt\":\"2025-02-24 10:04:28\",\"username\":\"user1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 10:24:31', 23);
INSERT INTO `sys_oper_log` VALUES (109, '代码生成', 6, 'com.mall.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"orders\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:29:26', 109);
INSERT INTO `sys_oper_log` VALUES (110, '字典类型', 1, 'com.mall.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"订单状态\",\"dictType\":\"order_status\",\"params\":{},\"remark\":\"订单状态：0-待支付，1-已支付，2-已发货，3-已完成，4-已取消\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:35:40', 68);
INSERT INTO `sys_oper_log` VALUES (111, '字典数据', 1, 'com.mall.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"待支付\",\"dictSort\":1,\"dictType\":\"order_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:36:53', 75);
INSERT INTO `sys_oper_log` VALUES (112, '字典数据', 1, 'com.mall.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"已支付\",\"dictSort\":2,\"dictType\":\"order_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:37:19', 67);
INSERT INTO `sys_oper_log` VALUES (113, '字典数据', 1, 'com.mall.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"已发货\",\"dictSort\":3,\"dictType\":\"order_status\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:37:38', 35);
INSERT INTO `sys_oper_log` VALUES (114, '字典数据', 1, 'com.mall.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"已完成\",\"dictSort\":4,\"dictType\":\"order_status\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:37:58', 118);
INSERT INTO `sys_oper_log` VALUES (115, '字典数据', 1, 'com.mall.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"已取消\",\"dictSort\":5,\"dictType\":\"order_status\",\"dictValue\":\"4\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:38:16', 101);
INSERT INTO `sys_oper_log` VALUES (116, '代码生成', 2, 'com.mall.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"orders\",\"className\":\"Orders\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"订单ID\",\"columnId\":8,\"columnName\":\"id\",\"columnType\":\"int(10) unsigned\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 14:29:26\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Integer\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID\",\"columnId\":9,\"columnName\":\"user_id\",\"columnType\":\"int(10) unsigned\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 14:29:26\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Integer\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"OrderStatus\",\"columnComment\":\"订单状态：0-待支付，1-已支付，2-已发货，3-已完成，4-已取消\",\"columnId\":10,\"columnName\":\"order_status\",\"columnType\":\"tinyint(1)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 14:29:26\",\"dictType\":\"order_status\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,\"insert\":false,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"orderStatus\",\"javaType\":\"Integer\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"TotalAmount\",\"columnComment\":\"订单总金额\",\"columnId\":11,\"columnName\":\"total_amount\",\"columnType\":\"decimal(10,2)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 14:29:26\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isIn', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:40:35', 41);
INSERT INTO `sys_oper_log` VALUES (117, '代码生成', 8, 'com.mall.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"orders\"}', NULL, 0, NULL, '2025-02-26 14:40:44', 252);
INSERT INTO `sys_oper_log` VALUES (118, '代码生成', 8, 'com.mall.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"orders\"}', NULL, 0, NULL, '2025-02-26 14:41:15', 28);
INSERT INTO `sys_oper_log` VALUES (119, '代码生成', 8, 'com.mall.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"orders\"}', NULL, 0, NULL, '2025-02-26 14:41:40', 41);
INSERT INTO `sys_oper_log` VALUES (120, '订单管理', 2, 'com.mall.manage.controller.OrdersController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/orders', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-02-26 10:35:35\",\"id\":1,\"orderStatus\":3,\"params\":{},\"totalAmount\":100,\"updatedAt\":\"2025-02-26 10:35:35\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:45:47', 23);
INSERT INTO `sys_oper_log` VALUES (121, '订单管理', 2, 'com.mall.manage.controller.OrdersController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/orders', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-02-26 10:35:35\",\"id\":2,\"orderStatus\":1,\"params\":{},\"totalAmount\":200,\"updatedAt\":\"2025-02-26 10:35:35\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:45:49', 5);
INSERT INTO `sys_oper_log` VALUES (122, '订单管理', 2, 'com.mall.manage.controller.OrdersController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/orders', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-02-26 10:35:35\",\"id\":1,\"orderStatus\":3,\"params\":{},\"totalAmount\":100,\"updatedAt\":\"2025-02-26 10:35:35\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:47:06', 4);
INSERT INTO `sys_oper_log` VALUES (123, '代码生成', 2, 'com.mall.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"orders\",\"className\":\"Orders\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"订单ID\",\"columnId\":8,\"columnName\":\"id\",\"columnType\":\"int(10) unsigned\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 14:29:26\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Integer\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-02-26 14:40:35\",\"usableColumn\":false},{\"capJavaField\":\"UserId\",\"columnComment\":\"用户ID\",\"columnId\":9,\"columnName\":\"user_id\",\"columnType\":\"int(10) unsigned\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 14:29:26\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"userId\",\"javaType\":\"Integer\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-02-26 14:40:35\",\"usableColumn\":false},{\"capJavaField\":\"OrderStatus\",\"columnComment\":\"订单状态：0-待支付，1-已支付，2-已发货，3-已完成，4-已取消\",\"columnId\":10,\"columnName\":\"order_status\",\"columnType\":\"tinyint(1)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 14:29:26\",\"dictType\":\"order_status\",\"edit\":true,\"htmlType\":\"radio\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"orderStatus\",\"javaType\":\"Integer\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"updateTime\":\"2025-02-26 14:40:35\",\"usableColumn\":false},{\"capJavaField\":\"TotalAmount\",\"columnComment\":\"订单总金额\",\"columnId\":11,\"columnName\":\"total_amount\",\"columnType\":\"decimal(10,2)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 14:29:26\",\"dictType\":\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:48:11', 67);
INSERT INTO `sys_oper_log` VALUES (124, '订单管理', 2, 'com.mall.manage.controller.OrdersController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/orders', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-02-26 10:35:35\",\"id\":1,\"orderStatus\":3,\"params\":{},\"totalAmount\":100,\"updatedAt\":\"2025-02-26 10:35:35\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:48:26', 3);
INSERT INTO `sys_oper_log` VALUES (125, '菜单管理', 3, 'com.mall.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2011', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:49:24', 110);
INSERT INTO `sys_oper_log` VALUES (126, '菜单管理', 3, 'com.mall.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2008', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:49:42', 37);
INSERT INTO `sys_oper_log` VALUES (127, '菜单管理', 3, 'com.mall.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2009', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:49:44', 17);
INSERT INTO `sys_oper_log` VALUES (128, '菜单管理', 3, 'com.mall.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2010', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:49:46', 29);
INSERT INTO `sys_oper_log` VALUES (129, '菜单管理', 3, 'com.mall.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2012', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:49:48', 19);
INSERT INTO `sys_oper_log` VALUES (130, '菜单管理', 3, 'com.mall.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2007', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:49:50', 27);
INSERT INTO `sys_oper_log` VALUES (131, '代码生成', 8, 'com.mall.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"orders\"}', NULL, 0, NULL, '2025-02-26 14:54:10', 443);
INSERT INTO `sys_oper_log` VALUES (132, '订单管理', 2, 'com.mall.manage.controller.OrdersController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/orders', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-02-26 10:35:35\",\"id\":2,\"orderStatus\":4,\"params\":{},\"totalAmount\":200,\"updatedAt\":\"2025-02-26 10:35:35\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 14:57:20', 133);
INSERT INTO `sys_oper_log` VALUES (133, '菜单管理', 1, 'com.mall.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"商品业务管理\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"shopping\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:01:15', 133);
INSERT INTO `sys_oper_log` VALUES (134, '代码生成', 6, 'com.mall.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"products\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:01:39', 142);
INSERT INTO `sys_oper_log` VALUES (135, '字典类型', 1, 'com.mall.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"商品上下架\",\"dictType\":\"products_status\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:04:49', 46);
INSERT INTO `sys_oper_log` VALUES (136, '字典数据', 1, 'com.mall.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"下架\",\"dictSort\":1,\"dictType\":\"products_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:05:32', 16);
INSERT INTO `sys_oper_log` VALUES (137, '字典数据', 1, 'com.mall.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"上架\",\"dictSort\":2,\"dictType\":\"products_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:05:43', 65);
INSERT INTO `sys_oper_log` VALUES (138, '字典类型', 1, 'com.mall.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"商品分类\",\"dictType\":\"category\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:07:33', 106);
INSERT INTO `sys_oper_log` VALUES (139, '字典数据', 1, 'com.mall.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"男装\",\"dictSort\":1,\"dictType\":\"category\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:08:01', 118);
INSERT INTO `sys_oper_log` VALUES (140, '字典数据', 1, 'com.mall.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"女装\",\"dictSort\":2,\"dictType\":\"category\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:08:10', 49);
INSERT INTO `sys_oper_log` VALUES (141, '字典数据', 1, 'com.mall.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"cssClass\":\"\",\"default\":false,\"dictLabel\":\"童装\",\"dictSort\":3,\"dictType\":\"category\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:08:24', 107);
INSERT INTO `sys_oper_log` VALUES (142, '代码生成', 2, 'com.mall.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"products\",\"className\":\"Products\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"商品ID\",\"columnId\":14,\"columnName\":\"id\",\"columnType\":\"int(10) unsigned\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 15:01:39\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Integer\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"CategoryId\",\"columnComment\":\"分类ID\",\"columnId\":15,\"columnName\":\"category_id\",\"columnType\":\"int(10) unsigned\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 15:01:39\",\"dictType\":\"category\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"categoryId\",\"javaType\":\"Integer\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"商品标题\",\"columnId\":16,\"columnName\":\"title\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 15:01:39\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"title\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ImageUrl\",\"columnComment\":\"商品图片URL\",\"columnId\":17,\"columnName\":\"image_url\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 15:01:39\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuer', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:12:39', 87);
INSERT INTO `sys_oper_log` VALUES (143, '代码生成', 8, 'com.mall.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"products\"}', NULL, 0, NULL, '2025-02-26 15:12:43', 45);
INSERT INTO `sys_oper_log` VALUES (144, '订单管理', 5, 'com.mall.manage.controller.OrdersController.export()', 'POST', 1, 'admin', '研发部门', '/manage/orders/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2025-02-26 15:19:20', 873);
INSERT INTO `sys_oper_log` VALUES (145, '代码生成', 2, 'com.mall.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"products\",\"className\":\"Products\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"商品ID\",\"columnId\":14,\"columnName\":\"id\",\"columnType\":\"int(10) unsigned\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 15:01:39\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Integer\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2025-02-26 15:12:39\",\"usableColumn\":false},{\"capJavaField\":\"CategoryId\",\"columnComment\":\"分类ID\",\"columnId\":15,\"columnName\":\"category_id\",\"columnType\":\"int(10) unsigned\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 15:01:39\",\"dictType\":\"category\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"categoryId\",\"javaType\":\"Integer\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2025-02-26 15:12:39\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"商品标题\",\"columnId\":16,\"columnName\":\"title\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 15:01:39\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"title\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"updateTime\":\"2025-02-26 15:12:39\",\"usableColumn\":false},{\"capJavaField\":\"ImageUrl\",\"columnComment\":\"商品图片URL\",\"columnId\":17,\"columnName\":\"image_url\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 15:01:39\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"inc', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:20:19', 113);
INSERT INTO `sys_oper_log` VALUES (146, '代码生成', 8, 'com.mall.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"products\"}', NULL, 0, NULL, '2025-02-26 15:20:23', 44);
INSERT INTO `sys_oper_log` VALUES (147, '菜单管理', 3, 'com.mall.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2021', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:21:40', 59);
INSERT INTO `sys_oper_log` VALUES (148, '菜单管理', 3, 'com.mall.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2022', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:21:41', 45);
INSERT INTO `sys_oper_log` VALUES (149, '菜单管理', 3, 'com.mall.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2023', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:21:43', 44);
INSERT INTO `sys_oper_log` VALUES (150, '菜单管理', 3, 'com.mall.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2024', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:21:44', 37);
INSERT INTO `sys_oper_log` VALUES (151, '菜单管理', 3, 'com.mall.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2025', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:21:45', 11);
INSERT INTO `sys_oper_log` VALUES (152, '菜单管理', 3, 'com.mall.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2020', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:21:48', 39);
INSERT INTO `sys_oper_log` VALUES (153, '用户管理', 2, 'com.mall.manage.controller.UsersController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/users', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-02-24 10:04:28\",\"id\":1,\"params\":{},\"status\":1,\"updatedAt\":\"2025-02-24 10:04:28\",\"username\":\"user1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:24:17', 12);
INSERT INTO `sys_oper_log` VALUES (154, '代码生成', 6, 'com.mall.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"banners\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:24:43', 36);
INSERT INTO `sys_oper_log` VALUES (155, '代码生成', 2, 'com.mall.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"banners\",\"className\":\"Banners\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"轮播图ID\",\"columnId\":23,\"columnName\":\"id\",\"columnType\":\"int(10) unsigned\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 15:24:43\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Integer\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"ImageUrl\",\"columnComment\":\"图片URL\",\"columnId\":24,\"columnName\":\"image_url\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 15:24:43\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"imageUrl\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"标题\",\"columnId\":25,\"columnName\":\"title\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 15:24:43\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"title\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"LinkUrl\",\"columnComment\":\"跳转链接\",\"columnId\":26,\"columnName\":\"link_url\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 15:24:43\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"j', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:25:18', 43);
INSERT INTO `sys_oper_log` VALUES (156, '字典类型', 1, 'com.mall.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"广告上下架\",\"dictType\":\"banner_status\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:26:01', 101);
INSERT INTO `sys_oper_log` VALUES (157, '字典数据', 1, 'com.mall.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"禁用\",\"dictSort\":1,\"dictType\":\"banner_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:27:35', 85);
INSERT INTO `sys_oper_log` VALUES (158, '字典数据', 1, 'com.mall.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"启用\",\"dictSort\":2,\"dictType\":\"banner_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:27:46', 37);
INSERT INTO `sys_oper_log` VALUES (159, '代码生成', 2, 'com.mall.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"banners\",\"className\":\"Banners\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"轮播图ID\",\"columnId\":23,\"columnName\":\"id\",\"columnType\":\"int(10) unsigned\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 15:24:43\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Integer\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2025-02-26 15:25:18\",\"usableColumn\":false},{\"capJavaField\":\"ImageUrl\",\"columnComment\":\"图片URL\",\"columnId\":24,\"columnName\":\"image_url\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 15:24:43\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"0\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"imageUrl\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2025-02-26 15:25:18\",\"usableColumn\":false},{\"capJavaField\":\"Title\",\"columnComment\":\"标题\",\"columnId\":25,\"columnName\":\"title\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 15:24:43\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"title\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"updateTime\":\"2025-02-26 15:25:18\",\"usableColumn\":false},{\"capJavaField\":\"LinkUrl\",\"columnComment\":\"跳转链接\",\"columnId\":26,\"columnName\":\"link_url\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 15:24:43\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":t', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:29:23', 49);
INSERT INTO `sys_oper_log` VALUES (160, '代码生成', 8, 'com.mall.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"banners\"}', NULL, 0, NULL, '2025-02-26 15:30:08', 46);
INSERT INTO `sys_oper_log` VALUES (161, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/banners/index\",\"createTime\":\"2025-02-26 15:30:44\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2032,\"menuName\":\"广告管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2019,\"path\":\"banners\",\"perms\":\"manage:banners:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:31:15', 57);
INSERT INTO `sys_oper_log` VALUES (162, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"系统监控\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 15:35:49', 112);
INSERT INTO `sys_oper_log` VALUES (163, '订单管理', 2, 'com.mall.manage.controller.OrdersController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/orders', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-02-26 10:35:35\",\"id\":1,\"orderStatus\":4,\"params\":{},\"totalAmount\":100,\"updatedAt\":\"2025-02-26 10:35:35\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 16:14:49', 286);
INSERT INTO `sys_oper_log` VALUES (164, '商品管理', 5, 'com.mall.manage.controller.ProductsController.export()', 'POST', 1, 'admin', '研发部门', '/manage/products/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2025-02-26 19:51:18', 1105);
INSERT INTO `sys_oper_log` VALUES (165, '用户头像', 2, 'com.mall.web.controller.system.SysProfileController.avatar()', 'POST', 1, 'admin', '研发部门', '/system/user/profile/avatar', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"imgUrl\":\"/profile/avatar/2025/02/26/QQ图片20220828214209_20250226200738A001.jpg\",\"code\":200}', 0, NULL, '2025-02-26 20:07:38', 96);
INSERT INTO `sys_oper_log` VALUES (166, '商品管理', 2, 'com.mall.manage.controller.ProductsController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/products', '127.0.0.1', '内网IP', '{\"categoryId\":3,\"createdAt\":\"2025-02-24 10:06:21\",\"id\":10,\"imageUrl\":\"https://misuzu.oss-cn-beijing.aliyuncs.com/%E5%84%BF%E7%AB%A5%E8%A3%A4%E5%AD%90.jpg\",\"params\":{},\"price\":79,\"status\":0,\"title\":\"儿童裤子\",\"updatedAt\":\"2025-02-24 10:07:14\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\86136\\Desktop\\shopping\\mall-vue-master\\mall\\mall-manage\\target\\classes\\mapper\\manage\\ProductsMapper.xml]\r\n### The error may involve com.mall.manage.mapper.ProductsMapper.updateProducts-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update products          SET category_id = ?,             title = ?,             image_url = ?,             price = ?,             status = ?,             created_at = ?,             updated_at = ?          where id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'', '2025-02-26 20:12:54', 115);
INSERT INTO `sys_oper_log` VALUES (167, '商品管理', 2, 'com.mall.manage.controller.ProductsController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/products', '127.0.0.1', '内网IP', '{\"categoryId\":3,\"createdAt\":\"2025-02-24 10:06:21\",\"id\":10,\"imageUrl\":\"https://misuzu.oss-cn-beijing.aliyuncs.com/%E5%84%BF%E7%AB%A5%E8%A3%A4%E5%AD%90.jpg\",\"params\":{},\"price\":79,\"status\":0,\"title\":\"儿童裤子\",\"updatedAt\":\"2025-02-24 10:07:14\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\86136\\Desktop\\shopping\\mall-vue-master\\mall\\mall-manage\\target\\classes\\mapper\\manage\\ProductsMapper.xml]\r\n### The error may involve com.mall.manage.mapper.ProductsMapper.updateProducts-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update products          SET category_id = ?,             title = ?,             image_url = ?,             price = ?,             status = ?,             created_at = ?,             updated_at = ?          where id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'', '2025-02-26 20:14:18', 82);
INSERT INTO `sys_oper_log` VALUES (168, '商品管理', 2, 'com.mall.manage.controller.ProductsController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/products', '127.0.0.1', '内网IP', '{\"categoryId\":3,\"createdAt\":\"2025-02-24 10:06:21\",\"id\":10,\"imageUrl\":\"https://misuzu.oss-cn-beijing.aliyuncs.com/%E5%84%BF%E7%AB%A5%E8%A3%A4%E5%AD%90.jpg\",\"params\":{},\"price\":79,\"status\":1,\"title\":\"儿童裤子\",\"updatedAt\":\"2025-02-24 10:07:14\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\86136\\Desktop\\shopping\\mall-vue-master\\mall\\mall-manage\\target\\classes\\mapper\\manage\\ProductsMapper.xml]\r\n### The error may involve com.mall.manage.mapper.ProductsMapper.updateProducts-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update products          SET category_id = ?,             title = ?,             image_url = ?,             price = ?,             status = ?,             created_at = ?,             updated_at = ?          where id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'', '2025-02-26 20:14:34', 7);
INSERT INTO `sys_oper_log` VALUES (169, '商品管理', 2, 'com.mall.manage.controller.ProductsController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/products', '127.0.0.1', '内网IP', '{\"categoryId\":1,\"createdAt\":\"2025-02-24 10:06:21\",\"id\":1,\"imageUrl\":\"https://misuzu.oss-cn-beijing.aliyuncs.com/%E7%94%B7%E5%A3%ABT%E6%81%A4.jpg\",\"params\":{},\"price\":890,\"rate\":3,\"status\":1,\"title\":\"男士T恤\",\"updatedAt\":\"2025-02-25 20:22:13\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\86136\\Desktop\\shopping\\mall-vue-master\\mall\\mall-manage\\target\\classes\\mapper\\manage\\ProductsMapper.xml]\r\n### The error may involve com.mall.manage.mapper.ProductsMapper.updateProducts-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update products          SET category_id = ?,             title = ?,             image_url = ?,             price = ?,             status = ?,             created_at = ?,             updated_at = ?,             rate = ?          where id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'', '2025-02-26 20:14:42', 25);
INSERT INTO `sys_oper_log` VALUES (170, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 20:47:41', 113);
INSERT INTO `sys_oper_log` VALUES (171, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-02-26 10:10:15\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"用户订单管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"users\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 20:48:04', 60);
INSERT INTO `sys_oper_log` VALUES (172, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-02-26 10:10:15\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"用户订单管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"users\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-26 20:48:15', 94);
INSERT INTO `sys_oper_log` VALUES (173, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/user/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":100,\"menuName\":\"用户管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"user\",\"perms\":\"system:user:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 14:16:35', 89);
INSERT INTO `sys_oper_log` VALUES (174, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/role/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":101,\"menuName\":\"角色管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1,\"path\":\"role\",\"perms\":\"system:role:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 14:16:42', 40);
INSERT INTO `sys_oper_log` VALUES (175, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/dept/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"tree\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":103,\"menuName\":\"部门管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":1,\"path\":\"dept\",\"perms\":\"system:dept:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 14:16:45', 24);
INSERT INTO `sys_oper_log` VALUES (176, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/post/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"post\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":104,\"menuName\":\"岗位管理\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":1,\"path\":\"post\",\"perms\":\"system:post:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 14:16:49', 23);
INSERT INTO `sys_oper_log` VALUES (177, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/dict/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":105,\"menuName\":\"字典管理\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":1,\"path\":\"dict\",\"perms\":\"system:dict:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 14:16:53', 17);
INSERT INTO `sys_oper_log` VALUES (178, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/config/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":106,\"menuName\":\"参数设置\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":1,\"path\":\"config\",\"perms\":\"system:config:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 14:16:56', 40);
INSERT INTO `sys_oper_log` VALUES (179, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/notice/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"message\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":107,\"menuName\":\"通知公告\",\"menuType\":\"C\",\"orderNum\":8,\"params\":{},\"parentId\":1,\"path\":\"notice\",\"perms\":\"system:notice:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 14:17:00', 47);
INSERT INTO `sys_oper_log` VALUES (180, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"log\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":108,\"menuName\":\"日志管理\",\"menuType\":\"M\",\"orderNum\":9,\"params\":{},\"parentId\":1,\"path\":\"log\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 14:17:04', 32);
INSERT INTO `sys_oper_log` VALUES (181, '商品管理', 2, 'com.mall.manage.controller.ProductsController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/products', '127.0.0.1', '内网IP', '{\"categoryId\":1,\"createdAt\":\"2025-02-24 10:06:21\",\"id\":1,\"imageUrl\":\"https://misuzu.oss-cn-beijing.aliyuncs.com/%E7%94%B7%E5%A3%ABT%E6%81%A4.jpg\",\"params\":{},\"price\":89,\"rate\":3,\"status\":0,\"title\":\"男士T恤\",\"updatedAt\":\"2025-02-25 20:22:13\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\86136\\Desktop\\shopping\\mall-vue-master\\mall\\mall-manage\\target\\classes\\mapper\\manage\\ProductsMapper.xml]\r\n### The error may involve com.mall.manage.mapper.ProductsMapper.updateProducts-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update products          SET category_id = ?,             title = ?,             image_url = ?,             price = ?,             status = ?,             created_at = ?,             updated_at = ?,             rate = ?          where id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'', '2025-02-27 14:17:34', 185);
INSERT INTO `sys_oper_log` VALUES (182, '商品管理', 2, 'com.mall.manage.controller.ProductsController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/products', '127.0.0.1', '内网IP', '{\"categoryId\":1,\"createdAt\":\"2025-02-24 10:06:21\",\"id\":1,\"imageUrl\":\"https://misuzu.oss-cn-beijing.aliyuncs.com/%E7%94%B7%E5%A3%ABT%E6%81%A4.jpg\",\"params\":{},\"price\":89,\"rate\":3,\"status\":0,\"title\":\"男士T恤\",\"updatedAt\":\"2025-02-25 20:22:13\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\86136\\Desktop\\shopping\\mall-vue-master\\mall\\mall-manage\\target\\classes\\mapper\\manage\\ProductsMapper.xml]\r\n### The error may involve com.mall.manage.mapper.ProductsMapper.updateProducts-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update products          SET category_id = ?,             title = ?,             image_url = ?,             price = ?,             status = ?,             created_at = ?,             updated_at = ?,             rate = ?          where id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'', '2025-02-27 14:24:05', 53);
INSERT INTO `sys_oper_log` VALUES (183, '商品管理', 2, 'com.mall.manage.controller.ProductsController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/products', '127.0.0.1', '内网IP', '{\"categoryId\":1,\"createdAt\":\"2025-02-24 10:06:21\",\"id\":1,\"imageUrl\":\"https://misuzu.oss-cn-beijing.aliyuncs.com/%E7%94%B7%E5%A3%ABT%E6%81%A4.jpg\",\"params\":{},\"price\":89,\"rate\":3,\"status\":0,\"title\":\"男士T恤\",\"updatedAt\":\"2025-02-25 20:22:13\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\86136\\Desktop\\shopping\\mall-vue-master\\mall\\mall-manage\\target\\classes\\mapper\\manage\\ProductsMapper.xml]\r\n### The error may involve com.mall.manage.mapper.ProductsMapper.updateProducts-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update products          SET category_id = ?,             title = ?,             image_url = ?,             price = ?,             status = ?,             created_at = ?,             updated_at = ?,             rate = ?          where id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'', '2025-02-27 14:26:08', 51);
INSERT INTO `sys_oper_log` VALUES (184, '商品管理', 2, 'com.mall.manage.controller.ProductsController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/products', '127.0.0.1', '内网IP', '{\"categoryId\":1,\"createdAt\":\"2025-02-24 10:06:21\",\"id\":1,\"imageUrl\":\"https://misuzu.oss-cn-beijing.aliyuncs.com/%E7%94%B7%E5%A3%ABT%E6%81%A4.jpg\",\"params\":{},\"price\":89,\"rate\":3,\"status\":0,\"title\":\"男士T恤\",\"updatedAt\":\"2025-02-25 20:22:13\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'\r\n### The error may exist in file [C:\\Users\\86136\\Desktop\\shopping\\mall-vue-master\\mall\\mall-manage\\target\\classes\\mapper\\manage\\ProductsMapper.xml]\r\n### The error may involve com.mall.manage.mapper.ProductsMapper.updateProducts-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update products          SET category_id = ?,             title = ?,             image_url = ?,             price = ?,             status = ?,             created_at = ?,             updated_at = ?,             rate = ?          where id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: Unknown column \'oi.unit_price\' in \'field list\'', '2025-02-27 14:29:49', 36);
INSERT INTO `sys_oper_log` VALUES (185, '商品管理', 2, 'com.mall.manage.controller.ProductsController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/products', '127.0.0.1', '内网IP', '{\"categoryId\":1,\"createdAt\":\"2025-02-24 10:06:21\",\"id\":1,\"imageUrl\":\"https://misuzu.oss-cn-beijing.aliyuncs.com/%E7%94%B7%E5%A3%ABT%E6%81%A4.jpg\",\"params\":{},\"price\":890,\"rate\":3,\"status\":1,\"title\":\"男士T恤\",\"updatedAt\":\"2025-02-25 20:22:13\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 14:34:33', 91);
INSERT INTO `sys_oper_log` VALUES (186, '订单管理', 2, 'com.mall.manage.controller.OrdersController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/orders', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-02-26 10:35:35\",\"id\":1,\"orderStatus\":3,\"params\":{},\"totalAmount\":100,\"updatedAt\":\"2025-02-26 10:35:35\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 14:37:49', 101);
INSERT INTO `sys_oper_log` VALUES (187, '轮播图', 2, 'com.mall.manage.controller.BannersController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/banners', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-02-24 10:00:43\",\"id\":1,\"imageUrl\":\"https://misuzu.oss-cn-beijing.aliyuncs.com/28000068_170750303080_2.jpg\",\"linkUrl\":\"https://www.yuanshen.com/#/\",\"params\":{},\"sortOrder\":0,\"status\":1,\"title\":\"轮播图1\",\"updatedAt\":\"2025-02-25 19:18:59\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 14:43:13', 64);
INSERT INTO `sys_oper_log` VALUES (188, '轮播图', 2, 'com.mall.manage.controller.BannersController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/banners', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-02-24 10:00:43\",\"id\":2,\"imageUrl\":\"https://misuzu.oss-cn-beijing.aliyuncs.com/Lm9M6ws7Xw.jpg\",\"linkUrl\":\"https://www.yuanshen.com/#/\",\"params\":{},\"sortOrder\":0,\"status\":1,\"title\":\"轮播图2\",\"updatedAt\":\"2025-02-24 10:06:34\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 14:43:44', 40);
INSERT INTO `sys_oper_log` VALUES (189, '轮播图', 2, 'com.mall.manage.controller.BannersController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/banners', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-02-24 10:00:43\",\"id\":3,\"imageUrl\":\"https://misuzu.oss-cn-beijing.aliyuncs.com/3107.jpg_wh860.jpg\",\"linkUrl\":\"https://www.yuanshen.com/#/\",\"params\":{},\"sortOrder\":0,\"status\":1,\"title\":\"轮播图3\",\"updatedAt\":\"2025-02-24 10:06:34\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 14:43:47', 25);
INSERT INTO `sys_oper_log` VALUES (190, '订单管理', 2, 'com.mall.manage.controller.OrdersController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/orders', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-02-26 10:35:35\",\"id\":1,\"orderStatus\":3,\"params\":{},\"totalAmount\":100,\"updatedAt\":\"2025-02-26 10:35:35\",\"userId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 16:11:55', 15);
INSERT INTO `sys_oper_log` VALUES (191, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/user/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":100,\"menuName\":\"用户管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"user\",\"perms\":\"system:user:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 16:29:23', 64);
INSERT INTO `sys_oper_log` VALUES (192, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/role/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":101,\"menuName\":\"角色管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1,\"path\":\"role\",\"perms\":\"system:role:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 16:29:26', 24);
INSERT INTO `sys_oper_log` VALUES (193, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/dept/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"tree\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":103,\"menuName\":\"部门管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":1,\"path\":\"dept\",\"perms\":\"system:dept:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 16:29:29', 22);
INSERT INTO `sys_oper_log` VALUES (194, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/post/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"post\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":104,\"menuName\":\"岗位管理\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":1,\"path\":\"post\",\"perms\":\"system:post:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 16:29:33', 22);
INSERT INTO `sys_oper_log` VALUES (195, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/dict/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":105,\"menuName\":\"字典管理\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":1,\"path\":\"dict\",\"perms\":\"system:dict:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 16:29:35', 14);
INSERT INTO `sys_oper_log` VALUES (196, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/config/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":106,\"menuName\":\"参数设置\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":1,\"path\":\"config\",\"perms\":\"system:config:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 16:29:38', 22);
INSERT INTO `sys_oper_log` VALUES (197, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/notice/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"message\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":107,\"menuName\":\"通知公告\",\"menuType\":\"C\",\"orderNum\":8,\"params\":{},\"parentId\":1,\"path\":\"notice\",\"perms\":\"system:notice:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 16:29:41', 18);
INSERT INTO `sys_oper_log` VALUES (198, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"log\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":108,\"menuName\":\"日志管理\",\"menuType\":\"M\",\"orderNum\":9,\"params\":{},\"parentId\":1,\"path\":\"log\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 16:29:45', 47);
INSERT INTO `sys_oper_log` VALUES (199, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"系统监控\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 16:29:52', 36);
INSERT INTO `sys_oper_log` VALUES (200, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"系统监控\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 16:29:55', 12);
INSERT INTO `sys_oper_log` VALUES (201, '商品管理', 2, 'com.mall.manage.controller.ProductsController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/products', '127.0.0.1', '内网IP', '{\"categoryId\":1,\"createdAt\":\"2025-02-24 10:06:21\",\"id\":1,\"imageUrl\":\"https://misuzu.oss-cn-beijing.aliyuncs.com/%E7%94%B7%E5%A3%ABT%E6%81%A4.jpg\",\"params\":{},\"price\":89,\"rate\":3,\"status\":1,\"title\":\"男士T恤\",\"updatedAt\":\"2025-02-25 20:22:13\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-02-27 16:35:15', 15);
INSERT INTO `sys_oper_log` VALUES (202, '字典类型', 1, 'com.mall.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"用户状态\",\"dictType\":\"user_status\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 17:54:56', 113);
INSERT INTO `sys_oper_log` VALUES (203, '字典数据', 1, 'com.mall.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"禁用\",\"dictSort\":1,\"dictType\":\"user_status\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 17:55:26', 52);
INSERT INTO `sys_oper_log` VALUES (204, '字典数据', 1, 'com.mall.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"启用\",\"dictSort\":2,\"dictType\":\"user_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 17:55:39', 73);
INSERT INTO `sys_oper_log` VALUES (205, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 17:55:57', 53);
INSERT INTO `sys_oper_log` VALUES (206, '代码生成', 2, 'com.mall.generator.controller.GenController.synchDb()', 'GET', 1, 'admin', '研发部门', '/tool/gen/synchDb/users', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 17:56:42', 142);
INSERT INTO `sys_oper_log` VALUES (207, '代码生成', 2, 'com.mall.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"users\",\"className\":\"Users\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"用户ID\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"int(10) unsigned\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 10:08:14\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":false,\"isIncrement\":\"1\",\"isInsert\":\"0\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Integer\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-03-05 17:56:42\",\"usableColumn\":false},{\"capJavaField\":\"Username\",\"columnComment\":\"用户名\",\"columnId\":2,\"columnName\":\"username\",\"columnType\":\"varchar(50)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 10:08:14\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"1\",\"javaField\":\"username\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":true,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-03-05 17:56:42\",\"usableColumn\":false},{\"capJavaField\":\"Password\",\"columnComment\":\"密码\",\"columnId\":3,\"columnName\":\"password\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-02-26 10:08:14\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":false,\"isEdit\":\"0\",\"isIncrement\":\"0\",\"isInsert\":\"0\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"0\",\"isRequired\":\"1\",\"javaField\":\"password\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":false,\"queryType\":\"EQ\",\"required\":true,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2025-03-05 17:56:42\",\"usableColumn\":false},{\"capJavaField\":\"Email\",\"columnComment\":\"邮箱地址\",\"columnId\":31,\"columnName\":\"email\",\"columnType\":\"varchar(500)\",\"createBy\":\"\",\"createTime\":\"2025-03-05 17:56:42\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":false,\"i', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 17:58:42', 35);
INSERT INTO `sys_oper_log` VALUES (208, '菜单管理', 3, 'com.mall.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2002', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 17:58:56', 73);
INSERT INTO `sys_oper_log` VALUES (209, '菜单管理', 3, 'com.mall.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2003', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 17:58:58', 17);
INSERT INTO `sys_oper_log` VALUES (210, '菜单管理', 3, 'com.mall.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2004', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 17:59:00', 23);
INSERT INTO `sys_oper_log` VALUES (211, '菜单管理', 3, 'com.mall.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2005', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 17:59:03', 10);
INSERT INTO `sys_oper_log` VALUES (212, '菜单管理', 3, 'com.mall.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2006', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 17:59:05', 20);
INSERT INTO `sys_oper_log` VALUES (213, '菜单管理', 3, 'com.mall.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2001', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 17:59:07', 22);
INSERT INTO `sys_oper_log` VALUES (214, '代码生成', 8, 'com.mall.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"users\"}', NULL, 0, NULL, '2025-03-05 17:59:29', 148);
INSERT INTO `sys_oper_log` VALUES (215, '用户管理', 2, 'com.mall.manage.controller.UsersController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/users', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-02-24 10:04:28\",\"id\":1,\"params\":{},\"status\":1,\"updatedAt\":\"2025-02-24 10:04:28\",\"username\":\"user1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:03:19', 8);
INSERT INTO `sys_oper_log` VALUES (216, '用户管理', 2, 'com.mall.manage.controller.UsersController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/users', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-02-24 10:04:28\",\"id\":1,\"params\":{},\"status\":1,\"updatedAt\":\"2025-02-24 10:04:28\",\"username\":\"user1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:04:59', 2);
INSERT INTO `sys_oper_log` VALUES (217, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"monitor/druid/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"druid\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":111,\"menuName\":\"数据监控\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2,\"path\":\"druid\",\"perms\":\"monitor:druid:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:05:57', 83);
INSERT INTO `sys_oper_log` VALUES (218, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"monitor/job/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"job\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":110,\"menuName\":\"定时任务\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2,\"path\":\"job\",\"perms\":\"monitor:job:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:06:00', 18);
INSERT INTO `sys_oper_log` VALUES (219, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"monitor/online/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"online\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":109,\"menuName\":\"在线用户\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2,\"path\":\"online\",\"perms\":\"monitor:online:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:06:03', 19);
INSERT INTO `sys_oper_log` VALUES (220, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"monitor/cache/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"redis\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":113,\"menuName\":\"缓存监控\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2,\"path\":\"cache\",\"perms\":\"monitor:cache:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:06:11', 23);
INSERT INTO `sys_oper_log` VALUES (221, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"monitor/cache/list\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"redis-list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":114,\"menuName\":\"缓存列表\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":2,\"path\":\"cacheList\",\"perms\":\"monitor:cache:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:06:14', 9);
INSERT INTO `sys_oper_log` VALUES (222, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"monitor/server/index\",\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"server\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":112,\"menuName\":\"服务器监控\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"server\",\"perms\":\"monitor:server:list\",\"query\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:06:35', 13);
INSERT INTO `sys_oper_log` VALUES (223, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"系统监控\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:06:59', 50);
INSERT INTO `sys_oper_log` VALUES (224, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/orders/index\",\"createTime\":\"2025-02-26 14:55:01\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"订单管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"orders\",\"perms\":\"manage:orders:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:07:12', 79);
INSERT INTO `sys_oper_log` VALUES (225, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/users/index\",\"createTime\":\"2025-03-05 18:02:08\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2038,\"menuName\":\"用户管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"users\",\"perms\":\"manage:users:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:07:16', 23);
INSERT INTO `sys_oper_log` VALUES (226, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-02-26 10:10:15\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"用户订单管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"users\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:07:26', 40);
INSERT INTO `sys_oper_log` VALUES (227, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/products/index\",\"createTime\":\"2025-02-26 15:22:15\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2026,\"menuName\":\"商品管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"products\",\"perms\":\"manage:products:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:07:33', 18);
INSERT INTO `sys_oper_log` VALUES (228, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/banners/index\",\"createTime\":\"2025-02-26 15:30:44\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2032,\"menuName\":\"广告管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"banners\",\"perms\":\"manage:banners:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:07:39', 25);
INSERT INTO `sys_oper_log` VALUES (229, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-02-26 15:01:15\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2019,\"menuName\":\"商品业务管理\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"shopping\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:07:46', 27);
INSERT INTO `sys_oper_log` VALUES (230, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/orders/index\",\"createTime\":\"2025-02-26 14:55:01\",\"icon\":\"money\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2013,\"menuName\":\"订单管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"orders\",\"perms\":\"manage:orders:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:08:30', 46);
INSERT INTO `sys_oper_log` VALUES (231, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/products/index\",\"createTime\":\"2025-02-26 15:22:15\",\"icon\":\"shopping\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2026,\"menuName\":\"商品管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"products\",\"perms\":\"manage:products:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:08:39', 25);
INSERT INTO `sys_oper_log` VALUES (232, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/banners/index\",\"createTime\":\"2025-02-26 15:30:44\",\"icon\":\"wechat\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2032,\"menuName\":\"广告管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"banners\",\"perms\":\"manage:banners:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:09:07', 90);
INSERT INTO `sys_oper_log` VALUES (233, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"manage/users/index\",\"createTime\":\"2025-03-05 18:02:08\",\"icon\":\"user\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2038,\"menuName\":\"用户管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"users\",\"perms\":\"manage:users:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:09:17', 30);
INSERT INTO `sys_oper_log` VALUES (234, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:09:54', 64);
INSERT INTO `sys_oper_log` VALUES (235, '菜单管理', 2, 'com.mall.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-02-25 17:11:17\",\"icon\":\"system\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":1,\"menuName\":\"系统管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"query\":\"\",\"routeName\":\"\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:20:58', 83);
INSERT INTO `sys_oper_log` VALUES (236, '订单管理', 2, 'com.mall.manage.controller.OrdersController.edit()', 'PUT', 1, 'admin', '研发部门', '/manage/orders', '127.0.0.1', '内网IP', '{\"createdAt\":\"2025-03-03 19:02:02\",\"id\":4,\"orderStatus\":3,\"params\":{},\"totalAmount\":89,\"updatedAt\":\"2025-03-03 19:02:47\",\"userId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-03-05 18:21:57', 98);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2025-02-25 17:11:16', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-02-25 17:11:16', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-02-25 17:11:16', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-02-25 17:11:16', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-02-25 17:11:17', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2025-02-25 17:11:17', '', NULL, '普通角色');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '/profile/avatar/2025/02/26/QQ图片20220828214209_20250226200738A001.jpg', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-03-05 18:31:16', 'admin', '2025-02-25 17:11:16', '', '2025-03-05 18:31:15', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-02-25 17:11:16', 'admin', '2025-02-25 17:11:16', '', NULL, '测试员');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `email` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱地址',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_username`(`username` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE COMMENT '状态索引'
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'user1', 'password1', NULL, 0, '2025-02-24 10:04:28', '2025-03-05 18:05:09');
INSERT INTO `users` VALUES (2, '123', '$2a$10$mmYPFgyOce85FYxovKVQ7eYF0rXBoOWRYt0tinmSEL/hfnxaByLUe', '1411498103@qq.com', 1, '2025-03-03 18:11:33', '2025-03-03 18:11:33');

-- ----------------------------
-- Triggers structure for table order_items
-- ----------------------------
DROP TRIGGER IF EXISTS `update_order_total_after_insert`;
delimiter ;;
CREATE TRIGGER `update_order_total_after_insert` AFTER INSERT ON `order_items` FOR EACH ROW BEGIN
    UPDATE orders SET total_amount = (
        SELECT SUM(oi.quantity * p.price)
        FROM order_items oi
                 JOIN products p ON oi.product_id = p.id
        WHERE oi.order_id = NEW.order_id
    )
    WHERE id = NEW.order_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table order_items
-- ----------------------------
DROP TRIGGER IF EXISTS `update_order_total_after_update`;
delimiter ;;
CREATE TRIGGER `update_order_total_after_update` AFTER UPDATE ON `order_items` FOR EACH ROW BEGIN
    UPDATE orders SET total_amount = (
        SELECT SUM(oi.quantity * p.price)
        FROM order_items oi
                 JOIN products p ON oi.product_id = p.id
        WHERE oi.order_id = NEW.order_id
    )
    WHERE id = NEW.order_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table order_items
-- ----------------------------
DROP TRIGGER IF EXISTS `update_order_total_after_delete`;
delimiter ;;
CREATE TRIGGER `update_order_total_after_delete` AFTER DELETE ON `order_items` FOR EACH ROW BEGIN
    UPDATE orders SET total_amount = (
        SELECT COALESCE(SUM(oi.quantity * p.price), 0)
        FROM order_items oi
                 JOIN products p ON oi.product_id = p.id
        WHERE oi.order_id = OLD.order_id
    )
    WHERE id = OLD.order_id;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
