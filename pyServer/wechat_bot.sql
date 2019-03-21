/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50045
Source Host           : localhost:3306
Source Database       : wechat_bot

Target Server Type    : MYSQL
Target Server Version : 50045
File Encoding         : 65001

Date: 2019-03-21 13:55:24
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wb_ck
-- ----------------------------

-- ----------------------------
-- Table structure for wb_gx
-- ----------------------------
DROP TABLE IF EXISTS `wb_gx`;
CREATE TABLE `wb_gx` (
  `id` int(11) NOT NULL auto_increment,
  `cid` int(11) default NULL,
  `kid` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `cid_2` (`cid`,`kid`),
  KEY `cid` (`cid`),
  KEY `kid` (`kid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wb_gx
-- ----------------------------
