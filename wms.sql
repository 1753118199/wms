/*
 Navicat MySQL Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : wms

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 19/12/2023 20:51:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '货名',
  `storage` int NOT NULL COMMENT '仓库',
  `goodsType` int NOT NULL COMMENT '分类',
  `count` int NULL DEFAULT NULL COMMENT '数量',
  `remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, '联想笔记本', 1, 2, 100, NULL);
INSERT INTO `goods` VALUES (2, 'hp笔记本', 1, 2, 48, '');
INSERT INTO `goods` VALUES (3, '软件项目管理', 3, 1, 80, '');
INSERT INTO `goods` VALUES (4, '软件体系结构', 3, 1, 120, '');
INSERT INTO `goods` VALUES (5, '实训日志', 3, 1, 150, '');
INSERT INTO `goods` VALUES (6, '操作系统', 2, 1, 300, '');

-- ----------------------------
-- Table structure for goodstype
-- ----------------------------
DROP TABLE IF EXISTS `goodstype`;
CREATE TABLE `goodstype`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名',
  `remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goodstype
-- ----------------------------
INSERT INTO `goodstype` VALUES (1, '图书', NULL);
INSERT INTO `goodstype` VALUES (2, '电脑', '');
INSERT INTO `goodstype` VALUES (3, '食品', NULL);

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int NOT NULL,
  `menuCode` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单编码',
  `menuName` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名字',
  `menuLevel` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单级别',
  `menuParentCode` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单的父code',
  `menuClick` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '点击触发的函数',
  `menuRight` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '权限 0超级管理员，1表示管理员，2表示普通用户，可以用逗号组合使用',
  `menuComponent` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `menuIcon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '001', '管理员管理', '1', NULL, 'Admin', '0', 'admin/AdminManage.vue', 'el-icon-s-custom');
INSERT INTO `menu` VALUES (2, '002', '用户管理', '1', NULL, 'User', '0,1', 'user/UserManage.vue', 'el-icon-user-solid');
INSERT INTO `menu` VALUES (3, '003', '仓库管理', '1', NULL, 'Storage', '0,1', 'storage/StorageManage', 'el-icon-office-building');
INSERT INTO `menu` VALUES (4, '004', '物品分类管理', '1', NULL, 'Goodstype', '0,1', 'goodstype/GoodstypeManage', 'el-icon-menu');
INSERT INTO `menu` VALUES (5, '005', '物品管理 ', '1', NULL, 'Goods', '0,1,2', 'goods/GoodsManage', 'el-icon-s-management');
INSERT INTO `menu` VALUES (6, '006', '记录管理', '1', NULL, 'Record', '0,1,2', 'record/RecordManage', 'el-icon-s-order');
INSERT INTO `menu` VALUES (7, '007', '数据分析管理', '1', NULL, 'Analysis', '0,1', 'analysis/Analysis.vue', 'el-icon-search');

-- ----------------------------
-- Table structure for record
-- ----------------------------
DROP TABLE IF EXISTS `record`;
CREATE TABLE `record`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods` int NOT NULL COMMENT '货品id',
  `userId` int NULL DEFAULT NULL COMMENT '取货人/补货人',
  `admin_id` int NULL DEFAULT NULL COMMENT '操作人id',
  `count` int NULL DEFAULT NULL COMMENT '数量',
  `createtime` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of record
-- ----------------------------
INSERT INTO `record` VALUES (1, 1, 3, 1, 200, '2023-12-18 11:15:57', '');
INSERT INTO `record` VALUES (2, 1, 3, 1, -600, '2023-12-18 11:16:16', '');
INSERT INTO `record` VALUES (3, 4, 6, 1, -20, '2023-12-18 17:28:51', '');
INSERT INTO `record` VALUES (4, 2, 10, 1, -2, '2023-12-18 17:29:04', '');
INSERT INTO `record` VALUES (5, 5, 3, 1, -50, '2023-12-19 16:19:54', '');
INSERT INTO `record` VALUES (6, 1, 4, 1, 50, '2023-12-19 20:27:55', '');
INSERT INTO `record` VALUES (7, 6, 4, 1, -200, '2023-12-19 20:28:07', '');
INSERT INTO `record` VALUES (8, 6, 3, 1, -50, '2023-12-17 20:36:33', NULL);
INSERT INTO `record` VALUES (9, 4, 8, 1, 50, '2023-12-16 20:37:25', NULL);
INSERT INTO `record` VALUES (10, 3, 7, 1, -40, '2023-12-19 20:50:07', '');

-- ----------------------------
-- Table structure for storage
-- ----------------------------
DROP TABLE IF EXISTS `storage`;
CREATE TABLE `storage`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '仓库名',
  `remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of storage
-- ----------------------------
INSERT INTO `storage` VALUES (1, '仓库1', '仓库1');
INSERT INTO `storage` VALUES (2, '仓库2', '仓库2');
INSERT INTO `storage` VALUES (3, '仓库3', '仓库3');
INSERT INTO `storage` VALUES (4, '仓库4', '仓库4');
INSERT INTO `storage` VALUES (5, '仓库5', '仓库5');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `no` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账号',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名字',
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `age` int NULL DEFAULT NULL,
  `sex` int NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `role_id` int NULL DEFAULT NULL COMMENT '角色 0超级管理员，1管理员，2普通账号',
  `isValid` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'Y' COMMENT '是否有效，Y有效，其他无效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'root', '超级管理员', '123', 18, 1, '111', 0, 'Y');
INSERT INTO `user` VALUES (2, '123', 'zhuwenyu', '123', 21, 1, '18134543812', 1, 'Y');
INSERT INTO `user` VALUES (3, '38548', '于安琪', 'SznbO8X3ni', 22, 1, '21-051-8173', 2, 'Y');
INSERT INTO `user` VALUES (4, '97170', '雷子韬', 'akOTQZUzhw', 36, 1, '10-2681-2451', 2, 'Y');
INSERT INTO `user` VALUES (5, '79221', '贺詩涵', 'VLbNYYJgVH', 26, 0, '21-0023-5928', 2, 'Y');
INSERT INTO `user` VALUES (6, '32312', '汪杰宏', 'G6niVfJCfr', 35, 1, '173-2740-1286', 2, 'Y');
INSERT INTO `user` VALUES (7, '97318', '武宇宁', 'fxlgewxLJx', 29, 0, '755-880-6183', 2, 'Y');
INSERT INTO `user` VALUES (8, '04430', '吴璐', 'Q581CIy48p', 25, 1, '187-3274-4656', 2, 'Y');
INSERT INTO `user` VALUES (9, '94637', '陆秀英', '5fQXb1IuN8', 30, 0, '760-8864-0961', 2, 'Y');
INSERT INTO `user` VALUES (10, '75145', '蔡安琪', 'bvJFnQEWjW', 26, 0, '28-635-2434', 2, 'Y');
INSERT INTO `user` VALUES (11, '90605', '钟子异', 'j0QJyrR3BM', 20, 0, '28-457-2854', 2, 'Y');
INSERT INTO `user` VALUES (12, '21860', '汪致远', 'S0jEiFY5hJ', 31, 1, '755-2875-3846', 2, 'Y');
INSERT INTO `user` VALUES (13, '07057', '潘云熙', 'cgGuNTLN2W', 36, 1, '164-9752-6210', 2, 'Y');
INSERT INTO `user` VALUES (14, '91560', '冯云熙', 'X3owIcFNb2', 33, 1, '195-7493-6752', 2, 'Y');
INSERT INTO `user` VALUES (15, '86957', '戴岚', 'F2Up8vqh9a', 27, 0, '10-183-0565', 2, 'Y');
INSERT INTO `user` VALUES (16, '55125', '江岚', 'WteMuOp3be', 37, 1, '159-7740-4106', 2, 'Y');
INSERT INTO `user` VALUES (17, '98964', '冯杰宏', 'uaLiSLZMZC', 29, 1, '191-4489-2385', 2, 'Y');
INSERT INTO `user` VALUES (18, '09011', '冯岚', 'vx5RDrXHB9', 33, 0, '755-754-1681', 2, 'Y');
INSERT INTO `user` VALUES (19, '89942', '汪杰宏', 'FSINAGLe7U', 30, 0, '21-1285-5409', 2, 'Y');
INSERT INTO `user` VALUES (20, '26930', '邱子异', 'hxoPVIJwFR', 25, 0, '183-9087-4346', 2, 'Y');
INSERT INTO `user` VALUES (21, '41084', '彭璐', 'CJVXEVS8Lu', 26, 1, '10-9758-8544', 2, 'Y');
INSERT INTO `user` VALUES (22, '39415', '毛宇宁', '8wMbRy0haw', 35, 0, '769-6627-5217', 2, 'Y');
INSERT INTO `user` VALUES (23, '45130', '莫嘉伦', 'iQlhSU9TpV', 38, 1, '184-2263-9085', 2, 'Y');
INSERT INTO `user` VALUES (24, '97435', '贾杰宏', '1UjPVLrhL7', 25, 0, '769-988-4237', 2, 'Y');
INSERT INTO `user` VALUES (25, '90326', '孔致远', 'FUZCxD6SEq', 24, 0, '186-9202-0128', 2, 'Y');
INSERT INTO `user` VALUES (26, '26018', '曹杰宏', 'Hlt8Irmmef', 28, 0, '165-9657-1340', 2, 'Y');
INSERT INTO `user` VALUES (27, '65279', '杨云熙', 'c8deVpk8D2', 24, 0, '192-8619-7871', 2, 'Y');
INSERT INTO `user` VALUES (28, '44544', '宋秀英', 'C547lvhVE3', 31, 0, '151-0527-9183', 2, 'Y');
INSERT INTO `user` VALUES (29, '17405', '谢安琪', 'H1r73APBCJ', 33, 1, '769-848-1028', 2, 'Y');
INSERT INTO `user` VALUES (30, '85457', '罗睿', 'Ud7EFRU9k9', 38, 0, '188-8304-9268', 2, 'Y');
INSERT INTO `user` VALUES (31, '06003', '赵嘉伦', 'WtEDd75ymy', 29, 1, '133-7854-4128', 2, 'Y');
INSERT INTO `user` VALUES (32, '12878', '陈致远', 'EpMr7N38Fo', 22, 0, '10-7510-3815', 2, 'Y');
INSERT INTO `user` VALUES (33, '06257', '夏嘉伦', 'P7oRKMAbyF', 22, 0, '28-591-7807', 2, 'Y');
INSERT INTO `user` VALUES (34, '69208', '丁嘉伦', 'vZbQRfxM9w', 30, 0, '28-7536-0175', 2, 'Y');
INSERT INTO `user` VALUES (35, '84648', '蔡云熙', 'gOXroAX06G', 30, 1, '760-592-9428', 2, 'Y');
INSERT INTO `user` VALUES (36, '69327', '谢安琪', 'dAJcsYwBu4', 25, 0, '21-004-1450', 2, 'Y');
INSERT INTO `user` VALUES (37, '71976', '毛云熙', 'EpAO9g7tFh', 37, 1, '178-8293-5110', 2, 'Y');
INSERT INTO `user` VALUES (38, '02341', '严睿', 'y2w97AM7Ey', 38, 0, '154-6425-9400', 2, 'Y');
INSERT INTO `user` VALUES (39, '41058', '秦詩涵', 'TgSbmMlMDO', 24, 1, '155-3532-0328', 2, 'Y');
INSERT INTO `user` VALUES (40, '33564', '江詩涵', 'UKVTDqbJg2', 34, 1, '20-922-4854', 2, 'Y');
INSERT INTO `user` VALUES (41, '27105', '杜璐', 'Q4rkQAmsBC', 38, 0, '20-0644-9880', 2, 'Y');
INSERT INTO `user` VALUES (42, '60292', '夏云熙', 'bVhaeayrsF', 32, 1, '21-543-5269', 2, 'Y');
INSERT INTO `user` VALUES (43, '47465', '陆秀英', 'BBFBLEVjAb', 37, 0, '162-9940-7243', 2, 'Y');
INSERT INTO `user` VALUES (44, '93585', '廖震南', 'XnCvTHqBTl', 30, 1, '191-7657-7330', 2, 'Y');
INSERT INTO `user` VALUES (45, '61254', '郭岚', 'lrT9mERiOz', 24, 0, '191-6406-8563', 2, 'Y');
INSERT INTO `user` VALUES (46, '01977', '蔡岚', 'DaLo0dzrYf', 31, 0, '28-7881-1949', 2, 'Y');
INSERT INTO `user` VALUES (47, '09488', '顾晓明', 'KZN9w4vtdO', 24, 1, '769-258-0291', 2, 'Y');
INSERT INTO `user` VALUES (48, '76932', '贾詩涵', 'URmC89TZLw', 36, 0, '165-3518-2938', 2, 'Y');
INSERT INTO `user` VALUES (49, '51001', '陈安琪', 'lDJANIXmyS', 33, 1, '755-140-0196', 2, 'Y');
INSERT INTO `user` VALUES (50, '90303', '程震南', 'qqzJYx8la7', 26, 1, '20-114-9268', 2, 'Y');
INSERT INTO `user` VALUES (51, '83747', '贺云熙', 'krxI9CM4Zu', 34, 0, '20-0582-1984', 2, 'Y');
INSERT INTO `user` VALUES (52, '76265', '常岚', 'oLCvMC1C2J', 25, 1, '769-9521-7093', 2, 'Y');
INSERT INTO `user` VALUES (53, '75337', '龚秀英', '2WdNKlUkR2', 28, 1, '10-483-6659', 2, 'Y');
INSERT INTO `user` VALUES (54, '11983', '陆云熙', 'M3WSzLQQ9Q', 37, 0, '755-477-8422', 2, 'Y');
INSERT INTO `user` VALUES (55, '28557', '郝詩涵', 'nieCErBvCH', 26, 1, '760-292-7160', 2, 'Y');
INSERT INTO `user` VALUES (56, '94674', '孙睿', 'K2CsntovHy', 38, 1, '21-818-4830', 2, 'Y');
INSERT INTO `user` VALUES (57, '32963', '曾云熙', 'KZtdCmGXQN', 34, 1, '20-6570-2359', 2, 'Y');
INSERT INTO `user` VALUES (58, '57052', '曾震南', 'HU3McibB3p', 36, 1, '21-5611-6067', 2, 'Y');
INSERT INTO `user` VALUES (59, '01616', '赵嘉伦', '52RqM8Pj5r', 31, 0, '28-3298-5984', 2, 'Y');
INSERT INTO `user` VALUES (60, '76358', '田晓明', 'JjsFnU3eQu', 27, 1, '21-585-6082', 2, 'Y');
INSERT INTO `user` VALUES (61, '80117', '于云熙', 'LegZEeBmUK', 28, 0, '21-622-3847', 2, 'Y');
INSERT INTO `user` VALUES (62, '15869', '蔡宇宁', 'IfH6NIeqV1', 29, 0, '760-071-8862', 2, 'Y');
INSERT INTO `user` VALUES (63, '56767', '邹嘉伦', '8lnzAEp1CM', 27, 1, '10-1179-8026', 2, 'Y');
INSERT INTO `user` VALUES (64, '70489', '熊杰宏', 'oCSmSmyqDi', 34, 1, '178-2789-0058', 2, 'Y');
INSERT INTO `user` VALUES (65, '86501', '魏璐', 'ZSI6qOj0vp', 23, 1, '21-802-6022', 2, 'Y');
INSERT INTO `user` VALUES (66, '77903', '常璐', 'KEiy2I7h6v', 39, 1, '28-128-3896', 2, 'Y');
INSERT INTO `user` VALUES (67, '64117', '高璐', 'cwT9jvymb7', 37, 1, '170-1915-5894', 2, 'Y');
INSERT INTO `user` VALUES (68, '31849', '段秀英', 'elKWaAmD20', 30, 0, '21-6133-3260', 2, 'Y');
INSERT INTO `user` VALUES (69, '10445', '范岚', 'jp8v8KRU6f', 25, 0, '148-0384-0485', 2, 'Y');
INSERT INTO `user` VALUES (70, '20421', '向震南', 'wDoZKUA6P4', 27, 1, '147-6139-1993', 2, 'Y');
INSERT INTO `user` VALUES (71, '18296', '卢詩涵', 'IT3pJCMh8i', 21, 0, '154-5631-6836', 2, 'Y');
INSERT INTO `user` VALUES (72, '70217', '韩睿', 'LCUrMpujza', 23, 1, '769-430-7376', 2, 'Y');
INSERT INTO `user` VALUES (73, '99018', '蔡子韬', 'en1ebkMKtg', 26, 0, '140-0263-8888', 2, 'Y');
INSERT INTO `user` VALUES (74, '42419', '史嘉伦', 'lmZzZXgxaW', 37, 1, '177-9253-7269', 2, 'Y');
INSERT INTO `user` VALUES (75, '58961', '石致远', 'GbnVi84jKr', 32, 1, '755-1544-2133', 2, 'Y');
INSERT INTO `user` VALUES (76, '80307', '秦璐', 'bbEmrXMuZu', 21, 0, '132-3356-5443', 2, 'Y');
INSERT INTO `user` VALUES (77, '93211', '戴子异', 'nrgwmdnWzg', 23, 0, '169-3325-2535', 2, 'Y');
INSERT INTO `user` VALUES (78, '74498', '陶致远', 'Y6A4Bn8IjS', 31, 1, '153-6487-0981', 2, 'Y');
INSERT INTO `user` VALUES (79, '57788', '雷云熙', '20AU9cKXhI', 40, 0, '148-6768-7388', 2, 'Y');
INSERT INTO `user` VALUES (80, '92014', '莫安琪', 'ycpb7tjNIv', 25, 0, '164-9384-4372', 2, 'Y');
INSERT INTO `user` VALUES (81, '76282', '程詩涵', '4iIvmjM7d1', 25, 1, '133-1825-8652', 2, 'Y');
INSERT INTO `user` VALUES (82, '50184', '孙子异', '5pAj5bT5Zk', 23, 0, '169-3831-9434', 2, 'Y');
INSERT INTO `user` VALUES (83, '63569', '冯秀英', 'XAE7O5Eafy', 24, 0, '21-8477-7300', 2, 'Y');
INSERT INTO `user` VALUES (84, '74960', '严震南', 'IfUE2ddf1h', 37, 1, '178-9523-7957', 2, 'Y');
INSERT INTO `user` VALUES (85, '56149', '许云熙', 'Ugxh8eMIzy', 38, 1, '141-1800-4195', 2, 'Y');
INSERT INTO `user` VALUES (86, '40653', '曹致远', '1SJ79wafSL', 37, 1, '769-8030-9055', 2, 'Y');
INSERT INTO `user` VALUES (87, '68701', '夏子韬', 'xwXxXZVlUj', 39, 0, '187-7250-7892', 2, 'Y');
INSERT INTO `user` VALUES (88, '09101', '向子异', '9aHdlP1gDd', 33, 0, '28-6391-8882', 2, 'Y');
INSERT INTO `user` VALUES (89, '83173', '冯岚', 'z5t9kGLIgd', 26, 1, '28-094-2129', 2, 'Y');
INSERT INTO `user` VALUES (90, '17865', '许睿', 'MNFl7CoGQf', 37, 0, '192-5933-9354', 2, 'Y');
INSERT INTO `user` VALUES (91, '85413', '谭子韬', 'UP9kaBenjL', 29, 1, '20-417-3787', 2, 'Y');
INSERT INTO `user` VALUES (92, '89019', '蒋晓明', 'hzqkNS6K6Z', 27, 0, '194-1492-8793', 2, 'Y');
INSERT INTO `user` VALUES (93, '57388', '黄睿', 'ncTE4ocbZs', 23, 0, '20-7786-2556', 2, 'Y');
INSERT INTO `user` VALUES (94, '08865', '贾致远', 'HoIvzjkHLc', 34, 1, '176-9061-5265', 2, 'Y');
INSERT INTO `user` VALUES (95, '92057', '金子韬', 'cob2Tbb5KS', 30, 1, '168-9261-3285', 2, 'Y');
INSERT INTO `user` VALUES (96, '07671', '黄岚', 'ih1rjdicHm', 35, 0, '769-378-9790', 2, 'Y');
INSERT INTO `user` VALUES (97, '87170', '赵致远', 'LuqC67rJ4H', 38, 0, '769-232-4393', 2, 'Y');
INSERT INTO `user` VALUES (98, '83681', '廖璐', 'H34Nk04Su5', 26, 0, '10-4689-2761', 2, 'Y');
INSERT INTO `user` VALUES (99, '44841', '何晓明', 'BpLPjqavOa', 36, 0, '187-1550-2539', 2, 'Y');
INSERT INTO `user` VALUES (100, '21894', '蒋云熙', 'KPoOF3Rkfl', 38, 1, '177-8307-7682', 2, 'Y');
INSERT INTO `user` VALUES (101, '33133', '江嘉伦', 'a5ADHI0T3S', 35, 0, '189-7343-2012', 2, 'Y');
INSERT INTO `user` VALUES (102, '76981', '魏秀英', 'az5uFWRs58', 38, 1, '760-9759-9540', 2, 'Y');
INSERT INTO `user` VALUES (103, '124', 'wanghaiyang', '23456', 21, 1, '15955953301', 1, 'Y');
INSERT INTO `user` VALUES (104, '125', 'suozhengpeng', '68974', 21, 1, '13944623333', 1, 'Y');
INSERT INTO `user` VALUES (105, '126', 'longqiuyu', '985412', 20, 0, '15264204252', 1, 'Y');

-- ----------------------------
-- View structure for record_in
-- ----------------------------
DROP VIEW IF EXISTS `record_in`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `record_in` AS select cast(`record`.`createtime` as date) AS `date`,`record`.`count` AS `count` from `record` where (`record`.`count` > 0) order by cast(`record`.`createtime` as date);

-- ----------------------------
-- View structure for record_out
-- ----------------------------
DROP VIEW IF EXISTS `record_out`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `record_out` AS select cast(`record`.`createtime` as date) AS `date`,`record`.`count` AS `count` from `record` where (`record`.`count` < 0) order by cast(`record`.`createtime` as date);

SET FOREIGN_KEY_CHECKS = 1;
