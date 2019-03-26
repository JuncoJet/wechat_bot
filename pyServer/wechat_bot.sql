/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50045
Source Host           : localhost:3306
Source Database       : wechat_bot

Target Server Type    : MYSQL
Target Server Version : 50045
File Encoding         : 65001

Date: 2019-03-25 14:30:45
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for wb_ck
-- ----------------------------
DROP TABLE IF EXISTS `wb_ck`;
CREATE TABLE `wb_ck` (
  `id` int(11) NOT NULL auto_increment,
  `cy` varchar(255) default NULL COMMENT '词语',
  `cx` varchar(255) default NULL COMMENT '词性',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `cy` (`cy`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wb_ck
-- ----------------------------
INSERT INTO `wb_ck` VALUES ('1', '你', 'r');
INSERT INTO `wb_ck` VALUES ('2', '好', 'a');
INSERT INTO `wb_ck` VALUES ('3', '你是谁', 'n');
INSERT INTO `wb_ck` VALUES ('4', '呀', 'u');
INSERT INTO `wb_ck` VALUES ('5', '你妈', 'n');
INSERT INTO `wb_ck` VALUES ('6', '真', 'd');
INSERT INTO `wb_ck` VALUES ('7', '讨厌', 'v');
INSERT INTO `wb_ck` VALUES ('8', '其实', 'd');
INSERT INTO `wb_ck` VALUES ('9', '我', 'r');
INSERT INTO `wb_ck` VALUES ('10', '很', 'd');
INSERT INTO `wb_ck` VALUES ('11', '喜欢', 'v');
INSERT INTO `wb_ck` VALUES ('12', '害羞', 'v');
INSERT INTO `wb_ck` VALUES ('13', '了', 'u');
INSERT INTO `wb_ck` VALUES ('14', '机器人', 'n');
INSERT INTO `wb_ck` VALUES ('15', '的', 'u');
INSERT INTO `wb_ck` VALUES ('16', '爸爸', 'n');
INSERT INTO `wb_ck` VALUES ('17', '是', 'v');
INSERT INTO `wb_ck` VALUES ('18', '谁', 'r');
INSERT INTO `wb_ck` VALUES ('19', '现在', 'n');
INSERT INTO `wb_ck` VALUES ('20', '帮', 'v');
INSERT INTO `wb_ck` VALUES ('21', '训练', 'v');
INSERT INTO `wb_ck` VALUES ('22', '妈妈', 'n');
INSERT INTO `wb_ck` VALUES ('23', '吃', 'v');
INSERT INTO `wb_ck` VALUES ('24', '什么', 'r');
INSERT INTO `wb_ck` VALUES ('25', '最近', 'n');
INSERT INTO `wb_ck` VALUES ('26', '想', 'v');
INSERT INTO `wb_ck` VALUES ('27', '减肥', 'v');
INSERT INTO `wb_ck` VALUES ('28', '啦', 'u');
INSERT INTO `wb_ck` VALUES ('29', '不是', 'v');
INSERT INTO `wb_ck` VALUES ('30', '真人', 'n');
INSERT INTO `wb_ck` VALUES ('31', '啊', 'u');
INSERT INTO `wb_ck` VALUES ('32', '终于', 'd');
INSERT INTO `wb_ck` VALUES ('33', '写', 'v');
INSERT INTO `wb_ck` VALUES ('34', '给', 'p');
INSERT INTO `wb_ck` VALUES ('35', '看', 'v');
INSERT INTO `wb_ck` VALUES ('36', '一下', 'm');
INSERT INTO `wb_ck` VALUES ('37', '不给', 'v');
INSERT INTO `wb_ck` VALUES ('38', '不要', 'v');
INSERT INTO `wb_ck` VALUES ('39', '去', 'v');
INSERT INTO `wb_ck` VALUES ('40', '吧', 'u');
INSERT INTO `wb_ck` VALUES ('41', '不去', 'v');
INSERT INTO `wb_ck` VALUES ('42', '啥', 'r');
INSERT INTO `wb_ck` VALUES ('43', '明天', 'n');
INSERT INTO `wb_ck` VALUES ('44', '就', 'd');
INSERT INTO `wb_ck` VALUES ('45', '要', 'v');
INSERT INTO `wb_ck` VALUES ('46', '出发', 'v');
INSERT INTO `wb_ck` VALUES ('47', '走', 'v');
INSERT INTO `wb_ck` VALUES ('48', '好吃', 'a');
INSERT INTO `wb_ck` VALUES ('49', '吃鱼', 'v');
INSERT INTO `wb_ck` VALUES ('50', '哪里', 'r');
INSERT INTO `wb_ck` VALUES ('51', '玩了', 'v');
INSERT INTO `wb_ck` VALUES ('52', '吗', 'u');
INSERT INTO `wb_ck` VALUES ('53', '泰国', 'n');
INSERT INTO `wb_ck` VALUES ('54', '也', 'd');
INSERT INTO `wb_ck` VALUES ('55', '还', 'd');
INSERT INTO `wb_ck` VALUES ('56', '不错', 'a');
INSERT INTO `wb_ck` VALUES ('57', '矮', 'a');
INSERT INTO `wb_ck` VALUES ('58', '油', 'n');
INSERT INTO `wb_ck` VALUES ('59', '哦', 'e');
INSERT INTO `wb_ck` VALUES ('60', '假', 'a');
INSERT INTO `wb_ck` VALUES ('61', '哈哈', 'o');
INSERT INTO `wb_ck` VALUES ('62', '今天', 'n');
INSERT INTO `wb_ck` VALUES ('63', '天气', 'n');
INSERT INTO `wb_ck` VALUES ('64', '这个', 'r');
INSERT INTO `wb_ck` VALUES ('65', '语法', 'n');
INSERT INTO `wb_ck` VALUES ('66', '分析器', 'n');
INSERT INTO `wb_ck` VALUES ('67', '如何', 'r');
INSERT INTO `wb_ck` VALUES ('68', '创造', 'v');
INSERT INTO `wb_ck` VALUES ('69', '人类', 'n');
INSERT INTO `wb_ck` VALUES ('70', '不知道', 'v');
INSERT INTO `wb_ck` VALUES ('71', '可爱', 'a');
INSERT INTO `wb_ck` VALUES ('72', '这样', 'r');

-- ----------------------------
-- Table structure for wb_gx
-- ----------------------------
DROP TABLE IF EXISTS `wb_gx`;
CREATE TABLE `wb_gx` (
  `id` int(11) NOT NULL auto_increment,
  `cid` int(11) default NULL,
  `kid` int(11) default NULL,
  `qz` int(11) default '0' COMMENT '权重',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `cid_2` (`cid`,`kid`),
  KEY `cid` (`cid`),
  KEY `kid` (`kid`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wb_gx
-- ----------------------------
INSERT INTO `wb_gx` VALUES ('1', '1', '1', '5');
INSERT INTO `wb_gx` VALUES ('2', '2', '2', '2');
INSERT INTO `wb_gx` VALUES ('3', '3', '5', '2');
INSERT INTO `wb_gx` VALUES ('4', '1', '9', '3');
INSERT INTO `wb_gx` VALUES ('5', '11', '12', '1');
INSERT INTO `wb_gx` VALUES ('6', '4', '13', '1');
INSERT INTO `wb_gx` VALUES ('7', '3', '14', '1');
INSERT INTO `wb_gx` VALUES ('8', '18', '9', '2');
INSERT INTO `wb_gx` VALUES ('9', '15', '15', '1');
INSERT INTO `wb_gx` VALUES ('10', '16', '16', '1');
INSERT INTO `wb_gx` VALUES ('11', '17', '17', '2');
INSERT INTO `wb_gx` VALUES ('12', '22', '16', '2');
INSERT INTO `wb_gx` VALUES ('13', '22', '22', '1');
INSERT INTO `wb_gx` VALUES ('14', '24', '9', '2');
INSERT INTO `wb_gx` VALUES ('15', '24', '24', '1');
INSERT INTO `wb_gx` VALUES ('16', '23', '11', '3');
INSERT INTO `wb_gx` VALUES ('17', '23', '23', '2');
INSERT INTO `wb_gx` VALUES ('18', '29', '29', '1');
INSERT INTO `wb_gx` VALUES ('19', '33', '33', '1');
INSERT INTO `wb_gx` VALUES ('20', '13', '13', '1');
INSERT INTO `wb_gx` VALUES ('21', '35', '37', '2');
INSERT INTO `wb_gx` VALUES ('22', '35', '38', '1');
INSERT INTO `wb_gx` VALUES ('23', '39', '41', '2');
INSERT INTO `wb_gx` VALUES ('24', '46', '39', '1');
INSERT INTO `wb_gx` VALUES ('25', '47', '47', '2');
INSERT INTO `wb_gx` VALUES ('26', '47', '39', '1');
INSERT INTO `wb_gx` VALUES ('27', '23', '49', '1');
INSERT INTO `wb_gx` VALUES ('28', '51', '26', '2');
INSERT INTO `wb_gx` VALUES ('29', '51', '39', '1');
INSERT INTO `wb_gx` VALUES ('30', '56', '6', '2');
INSERT INTO `wb_gx` VALUES ('31', '56', '60', '1');
INSERT INTO `wb_gx` VALUES ('32', '6', '54', '2');
INSERT INTO `wb_gx` VALUES ('33', '64', '9', '1');
INSERT INTO `wb_gx` VALUES ('34', '66', '16', '1');
INSERT INTO `wb_gx` VALUES ('35', '67', '64', '3');
INSERT INTO `wb_gx` VALUES ('36', '67', '9', '2');
INSERT INTO `wb_gx` VALUES ('37', '68', '17', '2');
INSERT INTO `wb_gx` VALUES ('38', '69', '14', '1');
INSERT INTO `wb_gx` VALUES ('39', '68', '70', '1');
INSERT INTO `wb_gx` VALUES ('40', '1', '72', '1');
