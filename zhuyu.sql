/*
Navicat MySQL Data Transfer

Source Server         : my
Source Server Version : 50720
Source Host           : localhost:3306
Source Database       : zhuyu

Target Server Type    : MYSQL
Target Server Version : 50720
File Encoding         : 65001

Date: 2018-05-09 17:25:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `t_auto_msg`
-- ----------------------------
DROP TABLE IF EXISTS `t_auto_msg`;
CREATE TABLE `t_auto_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `keyz` varchar(255) DEFAULT NULL,
  `ask_count` int(11) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6gmf1ly8fi6a17qhw2l81d4e9` (`type_id`),
  CONSTRAINT `FK6gmf1ly8fi6a17qhw2l81d4e9` FOREIGN KEY (`type_id`) REFERENCES `t_auto_msg_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_auto_msg
-- ----------------------------
INSERT INTO `t_auto_msg` VALUES ('5', '<p>下单后24小时内发货</p>', '2018-04-17 18:25:17.450000', '1', '1', '什么时候发货？', '发货，出货，快递', '0', '2');
INSERT INTO `t_auto_msg` VALUES ('6', '<p>目前支持所有的物流公司 ，谢谢。</p>', '2018-04-17 18:26:15.144000', '1', '1', '支持哪些快递？', '发货，出货，快递，顺丰，EMS，申通，中通，韵达', '0', '2');

-- ----------------------------
-- Table structure for `t_auto_msg_type`
-- ----------------------------
DROP TABLE IF EXISTS `t_auto_msg_type`;
CREATE TABLE `t_auto_msg_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_auto_msg_type
-- ----------------------------
INSERT INTO `t_auto_msg_type` VALUES ('1', null, '2018-04-16 10:52:50.939000', '1', '1', '提现问题');
INSERT INTO `t_auto_msg_type` VALUES ('2', null, '2018-04-16 10:53:05.972000', '1', '1', '发货问题');
INSERT INTO `t_auto_msg_type` VALUES ('3', null, '2018-04-16 10:53:13.430000', '1', '1', '收货问题');
INSERT INTO `t_auto_msg_type` VALUES ('4', null, '2018-04-16 10:53:18.902000', '1', '1', '退货问题');

-- ----------------------------
-- Table structure for `t_cart`
-- ----------------------------
DROP TABLE IF EXISTS `t_cart`;
CREATE TABLE `t_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `buy_count` int(11) DEFAULT NULL,
  `commodity_id` int(11) DEFAULT NULL,
  `member_id` int(11) DEFAULT NULL,
  `commodity_specification_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8dtpxijuf9v8tbuxsasaebxuu` (`commodity_id`),
  KEY `FK2ckgige4332nph2yf3h9j5y4g` (`member_id`),
  KEY `FK4kubw8dxq765puwrcwb810wsl` (`commodity_specification_id`),
  CONSTRAINT `FK2ckgige4332nph2yf3h9j5y4g` FOREIGN KEY (`member_id`) REFERENCES `t_member` (`id`),
  CONSTRAINT `FK4kubw8dxq765puwrcwb810wsl` FOREIGN KEY (`commodity_specification_id`) REFERENCES `t_commodity_specification` (`id`),
  CONSTRAINT `FK8dtpxijuf9v8tbuxsasaebxuu` FOREIGN KEY (`commodity_id`) REFERENCES `t_commodity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_cart
-- ----------------------------

-- ----------------------------
-- Table structure for `t_commodity`
-- ----------------------------
DROP TABLE IF EXISTS `t_commodity`;
CREATE TABLE `t_commodity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `activity` varchar(255) DEFAULT NULL,
  `appraise_count` int(11) DEFAULT NULL,
  `cost` double DEFAULT NULL,
  `default_bulk` double DEFAULT NULL,
  `default_weight` double DEFAULT NULL,
  `free_postage` int(11) DEFAULT NULL,
  `freight` double DEFAULT NULL,
  `imge_list_show` varchar(255) DEFAULT NULL,
  `imger_path` varchar(255) DEFAULT NULL,
  `original_price` double DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `sales_volume` int(11) DEFAULT NULL,
  `show_discount` double DEFAULT NULL,
  `show_price` double DEFAULT NULL,
  `show_remarks` varchar(255) DEFAULT NULL,
  `total_stock` int(11) DEFAULT NULL,
  `commodity_class_id` int(11) DEFAULT NULL,
  `sort` varchar(255) DEFAULT NULL,
  `specifications` varchar(255) DEFAULT NULL,
  `browse` int(11) DEFAULT NULL,
  `comment` int(11) DEFAULT NULL,
  `praise` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKc8bls7f1uecbw0r58lmxico0c` (`commodity_class_id`),
  CONSTRAINT `FKc8bls7f1uecbw0r58lmxico0c` FOREIGN KEY (`commodity_class_id`) REFERENCES `t_commodity_class` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_commodity
-- ----------------------------
INSERT INTO `t_commodity` VALUES ('1', null, '2018-04-23 16:06:21.903000', '1', '1', '红酒', '1', '1211', '22', '77', '77', '12', '10.5', '/static/upload/image/20180414/1523698701783090640.jpg|/static/upload/image/20180414/1523698704945011965.jpg', '/static/upload/image/20180414/1523698695572079772.jpg', '99', '你好啊', '99', '9.8', '0.01', '你哈哦', '48', '2', null, '10瓶/一箱', '1111', '2222', '333');
INSERT INTO `t_commodity` VALUES ('2', null, '2018-04-23 16:07:36.993000', '1', '1', '白酒', null, '97', '97', '97', '97', '97', '97', '/static/upload/image/20180414/1523698730246017472.jpg|/static/upload/image/20180414/1523698733458007875.jpg', '/static/upload/image/20180414/1523698727048027243.jpg', '99', '好酒', '99', '99', '0.01', '好酒', '65', '3', null, '9瓶/一箱', '1232', '3213', '321');
INSERT INTO `t_commodity` VALUES ('3', null, '2018-04-23 16:08:09.625000', '1', '1', '威士忌', '1', '99', '99', '99', '99', '99', '999', '/static/upload/image/20180414/1523698777501008904.jpg|/static/upload/image/20180414/1523698784179055257.jpg|/static/upload/image/20180414/1523698788259049000.jpg|/static/upload/image/20180414/1523698791008036100.png', '/static/upload/image/20180414/1523698770688097391.jpg', '999', '999', '999', '999', '0.01', '999', '963', '3', null, '2瓶/一箱', '42', '321', '312');
INSERT INTO `t_commodity` VALUES ('4', null, '2018-04-16 15:07:22.056000', '2', '1', 'fsdfs', null, null, null, null, null, null, null, '', '', null, '', null, '34', '0.01', '', null, '2', null, null, '678', '534', '534');

-- ----------------------------
-- Table structure for `t_commodity_appraise`
-- ----------------------------
DROP TABLE IF EXISTS `t_commodity_appraise`;
CREATE TABLE `t_commodity_appraise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `appraise_details` varchar(255) DEFAULT NULL,
  `level` varchar(255) DEFAULT NULL,
  `reply_deails` varchar(255) DEFAULT NULL,
  `reply_time` datetime(6) DEFAULT NULL,
  `commodity_evaluation_id` int(11) DEFAULT NULL,
  `member_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9wr5dmw1qdx5l7nkwu5mr858g` (`commodity_evaluation_id`),
  KEY `FKj14v3ll2m3jn4vu20e44ya5dd` (`member_id`),
  CONSTRAINT `FK9wr5dmw1qdx5l7nkwu5mr858g` FOREIGN KEY (`commodity_evaluation_id`) REFERENCES `t_commodity_evaluation` (`id`),
  CONSTRAINT `FKj14v3ll2m3jn4vu20e44ya5dd` FOREIGN KEY (`member_id`) REFERENCES `t_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_commodity_appraise
-- ----------------------------

-- ----------------------------
-- Table structure for `t_commodity_bill`
-- ----------------------------
DROP TABLE IF EXISTS `t_commodity_bill`;
CREATE TABLE `t_commodity_bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `balance` decimal(19,2) DEFAULT NULL,
  `deal_time` datetime(6) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  `gain_time` datetime(6) DEFAULT NULL,
  `pathway` int(11) DEFAULT NULL,
  `record_money` decimal(19,2) DEFAULT NULL,
  `total_money` decimal(19,2) DEFAULT NULL,
  `member_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKs0vaobwbocj8pt4hxkjnhuggh` (`member_id`),
  CONSTRAINT `FKs0vaobwbocj8pt4hxkjnhuggh` FOREIGN KEY (`member_id`) REFERENCES `t_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_commodity_bill
-- ----------------------------

-- ----------------------------
-- Table structure for `t_commodity_class`
-- ----------------------------
DROP TABLE IF EXISTS `t_commodity_class`;
CREATE TABLE `t_commodity_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKao35d6rukphu6l9qerel530nb` (`parent_id`),
  CONSTRAINT `FKao35d6rukphu6l9qerel530nb` FOREIGN KEY (`parent_id`) REFERENCES `t_commodity_class` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_commodity_class
-- ----------------------------
INSERT INTO `t_commodity_class` VALUES ('1', null, '2018-04-14 09:55:04.692000', '1', '1', '酒', null);
INSERT INTO `t_commodity_class` VALUES ('2', null, '2018-04-14 09:55:23.659000', '1', '1', '红酒', '1');
INSERT INTO `t_commodity_class` VALUES ('3', null, '2018-04-14 09:55:32.081000', '1', '1', '白酒', '1');
INSERT INTO `t_commodity_class` VALUES ('4', null, '2018-04-16 15:02:18.945000', '1', '1', '法国红酒', '2');

-- ----------------------------
-- Table structure for `t_commodity_evaluation`
-- ----------------------------
DROP TABLE IF EXISTS `t_commodity_evaluation`;
CREATE TABLE `t_commodity_evaluation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `audit` int(11) DEFAULT NULL,
  `browse` int(11) DEFAULT NULL,
  `comment` int(11) DEFAULT NULL,
  `evaluation_details` varchar(255) DEFAULT NULL,
  `evaluation_time` datetime(6) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `praise` int(11) DEFAULT NULL,
  `reply` int(11) DEFAULT NULL,
  `reply_time` datetime(6) DEFAULT NULL,
  `replydetails` varchar(255) DEFAULT NULL,
  `commodity_id` int(11) DEFAULT NULL,
  `member_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `commodity_appraise_id` int(11) DEFAULT NULL,
  `order_item_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKtfoocrhffj106juowqv97pgka` (`commodity_id`),
  KEY `FKtbtka1qf5hchrrj2b0nph0xe2` (`member_id`),
  KEY `FKdw14n402cf6tkly4h8eptf7dm` (`user_id`),
  KEY `FKguvcxmnl0iwpcq49qmjfk9f7d` (`commodity_appraise_id`),
  KEY `FKrj2hd5w33bbo0aai5gocm4uut` (`order_item_id`),
  CONSTRAINT `FKdw14n402cf6tkly4h8eptf7dm` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`),
  CONSTRAINT `FKguvcxmnl0iwpcq49qmjfk9f7d` FOREIGN KEY (`commodity_appraise_id`) REFERENCES `t_commodity_appraise` (`id`),
  CONSTRAINT `FKrj2hd5w33bbo0aai5gocm4uut` FOREIGN KEY (`order_item_id`) REFERENCES `t_order_item` (`id`),
  CONSTRAINT `FKtbtka1qf5hchrrj2b0nph0xe2` FOREIGN KEY (`member_id`) REFERENCES `t_member` (`id`),
  CONSTRAINT `FKtfoocrhffj106juowqv97pgka` FOREIGN KEY (`commodity_id`) REFERENCES `t_commodity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_commodity_evaluation
-- ----------------------------

-- ----------------------------
-- Table structure for `t_commodity_specification`
-- ----------------------------
DROP TABLE IF EXISTS `t_commodity_specification`;
CREATE TABLE `t_commodity_specification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `bulks` double DEFAULT NULL,
  `describes` varchar(255) DEFAULT NULL,
  `prices` double DEFAULT NULL,
  `weights` double DEFAULT NULL,
  `commodity_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKu4nplyt3eahvkm7finko86pq` (`commodity_id`),
  CONSTRAINT `FKu4nplyt3eahvkm7finko86pq` FOREIGN KEY (`commodity_id`) REFERENCES `t_commodity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_commodity_specification
-- ----------------------------
INSERT INTO `t_commodity_specification` VALUES ('1', null, '2018-04-14 17:24:11.950000', '1', '1', '规格', '99', '规格：10瓶/箱', '99', '99', '3');
INSERT INTO `t_commodity_specification` VALUES ('2', null, '2018-04-17 17:10:56.603000', '1', '1', '规格', '999', '9瓶/一箱', '999', '999', '1');

-- ----------------------------
-- Table structure for `t_dian_nao`
-- ----------------------------
DROP TABLE IF EXISTS `t_dian_nao`;
CREATE TABLE `t_dian_nao` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `bid` varchar(255) DEFAULT NULL,
  `peizhi` varchar(255) DEFAULT NULL,
  `pin_pai` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_dian_nao
-- ----------------------------

-- ----------------------------
-- Table structure for `t_draw`
-- ----------------------------
DROP TABLE IF EXISTS `t_draw`;
CREATE TABLE `t_draw` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `amount` decimal(19,2) DEFAULT NULL,
  `flow_no` varchar(255) DEFAULT NULL,
  `member` tinyblob,
  `remark` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `member_id` int(11) DEFAULT NULL,
  `oprator_id` int(11) DEFAULT NULL,
  `deal_date` datetime(6) DEFAULT NULL,
  `card_no` varchar(255) DEFAULT NULL,
  `card_user` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKtcxphjabb0iu1em403aq0t92m` (`member_id`),
  KEY `FKcxc6ls6q4mi4pklqqkgj4x5fr` (`oprator_id`),
  CONSTRAINT `FKcxc6ls6q4mi4pklqqkgj4x5fr` FOREIGN KEY (`oprator_id`) REFERENCES `t_user` (`id`),
  CONSTRAINT `FKtcxphjabb0iu1em403aq0t92m` FOREIGN KEY (`member_id`) REFERENCES `t_member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_draw
-- ----------------------------
INSERT INTO `t_draw` VALUES ('1', null, '2018-04-28 11:10:07.162000', '1', '1', null, '500.00', null, null, null, '1', '14', null, null, '11111111', '哈哈');
INSERT INTO `t_draw` VALUES ('2', null, '2018-04-28 11:28:29.737000', '1', '1', null, '50.00', null, null, null, '5', '14', null, null, '7548584411285', '嘿嘿');

-- ----------------------------
-- Table structure for `t_login_log`
-- ----------------------------
DROP TABLE IF EXISTS `t_login_log`;
CREATE TABLE `t_login_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `login_ip` varchar(255) DEFAULT NULL,
  `longin_time` datetime(6) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKcymi7qmui33qy2i3ecpw5oim9` (`user_id`),
  CONSTRAINT `FKcymi7qmui33qy2i3ecpw5oim9` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_login_log
-- ----------------------------
INSERT INTO `t_login_log` VALUES ('1', null, '2018-04-13 17:27:43.669000', '1', '1', null, '0:0:0:0:0:0:0:1', '2018-04-13 17:27:43.669000', '1');
INSERT INTO `t_login_log` VALUES ('2', null, '2018-04-13 17:30:15.771000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('3', null, '2018-04-14 08:57:14.612000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('4', null, '2018-04-14 09:07:41.901000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('5', null, '2018-04-14 09:13:42.524000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('6', null, '2018-04-14 09:31:32.140000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('7', null, '2018-04-14 09:32:08.248000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('8', null, '2018-04-14 09:33:12.390000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('9', null, '2018-04-14 09:33:34.472000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('10', null, '2018-04-14 09:34:11.710000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('11', null, '2018-04-14 09:37:11.273000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('12', null, '2018-04-14 09:37:54.333000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('13', null, '2018-04-14 09:39:27.703000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('14', null, '2018-04-14 09:39:49.763000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('15', null, '2018-04-14 09:50:47.320000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('16', null, '2018-04-14 09:52:30.091000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('17', null, '2018-04-14 10:06:10.820000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('18', null, '2018-04-14 10:06:44.552000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('19', null, '2018-04-14 10:07:26.156000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('20', null, '2018-04-14 10:28:45.024000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('21', null, '2018-04-14 10:49:25.888000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('22', null, '2018-04-14 10:52:21.622000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('23', null, '2018-04-14 10:57:15.575000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('24', null, '2018-04-14 11:05:59.955000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('25', null, '2018-04-14 11:11:23.492000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('26', null, '2018-04-14 11:34:26.883000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('27', null, '2018-04-14 11:41:02.741000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('28', null, '2018-04-14 11:42:38.519000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('29', null, '2018-04-14 11:44:09.078000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('30', null, '2018-04-14 11:44:57.427000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('31', null, '2018-04-14 11:46:55.489000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('32', null, '2018-04-14 11:59:23.995000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('33', null, '2018-04-14 12:05:38.873000', '1', '1', null, '127.0.0.1', null, '4');
INSERT INTO `t_login_log` VALUES ('34', null, '2018-04-14 13:49:34.871000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('35', null, '2018-04-14 13:49:35.214000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('36', null, '2018-04-14 14:02:54.437000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('37', null, '2018-04-14 14:06:03.762000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('38', null, '2018-04-14 14:06:40.042000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('39', null, '2018-04-14 14:08:20.783000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('40', null, '2018-04-14 14:12:29.503000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('41', null, '2018-04-14 14:35:34.484000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('42', null, '2018-04-14 14:42:25.244000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('43', null, '2018-04-14 14:47:33.916000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('44', null, '2018-04-14 15:00:32.805000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('45', null, '2018-04-14 15:18:03.140000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('46', null, '2018-04-14 15:24:01.524000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('47', null, '2018-04-14 15:25:16.802000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('48', null, '2018-04-14 15:32:12.607000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('49', null, '2018-04-14 15:38:08.839000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('50', null, '2018-04-14 15:40:57.756000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('51', null, '2018-04-14 15:42:06.216000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('52', null, '2018-04-14 15:52:05.506000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('53', null, '2018-04-14 15:55:18.867000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('54', null, '2018-04-14 16:00:08.751000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('55', null, '2018-04-14 16:01:59.109000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('56', null, '2018-04-14 16:02:55.906000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('57', null, '2018-04-14 16:20:50.652000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('58', null, '2018-04-14 16:22:38.784000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('59', null, '2018-04-14 16:24:07.676000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('60', null, '2018-04-14 17:21:05.866000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('61', null, '2018-04-14 17:36:43.425000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('62', null, '2018-04-14 17:36:45.781000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('63', null, '2018-04-14 17:43:14.122000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('64', null, '2018-04-14 17:47:59.840000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('65', null, '2018-04-14 17:50:47.859000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('66', null, '2018-04-14 18:07:45.551000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('67', null, '2018-04-16 09:08:50.209000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('68', null, '2018-04-16 10:01:31.230000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('69', null, '2018-04-16 10:11:44.257000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('70', null, '2018-04-16 10:14:10.955000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('71', null, '2018-04-16 10:46:49.159000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('72', null, '2018-04-16 10:47:35.216000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('73', null, '2018-04-16 10:48:21.630000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('74', null, '2018-04-16 10:53:32.396000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('75', null, '2018-04-16 10:54:50.336000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('76', null, '2018-04-16 10:55:43.071000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('77', null, '2018-04-16 11:00:27.192000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('78', null, '2018-04-16 11:11:10.703000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('79', null, '2018-04-16 11:19:45.858000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('80', null, '2018-04-16 11:20:38.626000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('81', null, '2018-04-16 11:22:26.042000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('82', null, '2018-04-16 11:26:10.367000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('83', null, '2018-04-16 11:34:13.787000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('84', null, '2018-04-16 12:09:42.046000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('85', null, '2018-04-16 12:12:15.924000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('86', null, '2018-04-16 13:42:04.723000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('87', null, '2018-04-16 13:42:47.507000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('88', null, '2018-04-16 14:10:29.731000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('89', null, '2018-04-16 14:49:15.674000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('90', null, '2018-04-16 15:06:37.346000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('91', null, '2018-04-16 15:11:12.549000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('92', null, '2018-04-16 15:27:17.910000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('93', null, '2018-04-16 15:27:00.823000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('94', null, '2018-04-16 15:30:57.391000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('95', null, '2018-04-16 17:23:20.150000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('96', null, '2018-04-17 09:03:48.421000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('97', null, '2018-04-17 09:13:53.205000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('98', null, '2018-04-17 09:24:20.729000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('99', null, '2018-04-17 09:30:56.330000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('100', null, '2018-04-17 09:32:42.082000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('101', null, '2018-04-17 09:44:01.566000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('102', null, '2018-04-17 10:11:42.283000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('103', null, '2018-04-17 10:12:39.033000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('104', null, '2018-04-17 10:20:09.120000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('105', null, '2018-04-17 10:30:00.581000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('106', null, '2018-04-17 10:35:57.913000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('107', null, '2018-04-17 10:39:33.041000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('108', null, '2018-04-17 10:41:01.232000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('109', null, '2018-04-17 10:45:06.059000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('110', null, '2018-04-17 10:49:25.396000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('111', null, '2018-04-17 12:08:13.374000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('112', null, '2018-04-17 13:59:06.253000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('113', null, '2018-04-17 14:03:16.475000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('114', null, '2018-04-17 14:05:16.780000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('115', null, '2018-04-17 14:55:59.770000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('116', null, '2018-04-17 16:02:02.669000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('117', null, '2018-04-17 16:35:20.883000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('118', null, '2018-04-17 17:06:23.691000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('119', null, '2018-04-17 17:43:16.203000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('120', null, '2018-04-17 18:20:24.650000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('121', null, '2018-04-17 18:24:42.374000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('122', null, '2018-04-17 18:39:44.184000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('123', null, '2018-04-23 09:01:40.357000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('124', null, '2018-04-23 10:23:08.019000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('125', null, '2018-04-23 10:24:07.920000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('126', null, '2018-04-23 11:11:23.249000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('127', null, '2018-04-23 11:46:40.779000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('128', null, '2018-04-23 12:03:19.784000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('129', null, '2018-04-23 13:56:28.002000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('130', null, '2018-04-23 14:00:01.244000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('131', null, '2018-04-23 15:38:36.709000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('132', null, '2018-04-23 15:39:30.573000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('133', null, '2018-04-24 09:03:00.931000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('134', null, '2018-04-24 09:33:28.818000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('135', null, '2018-04-24 11:55:04.509000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('136', null, '2018-04-24 11:58:27.966000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('137', null, '2018-04-24 12:48:32.186000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('138', null, '2018-04-24 15:12:43.077000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('139', null, '2018-04-24 15:53:23.598000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('140', null, '2018-04-24 16:25:13.685000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('141', null, '2018-04-25 09:03:01.342000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('142', null, '2018-04-25 09:07:53.215000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('143', null, '2018-04-25 09:41:26.264000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('144', null, '2018-04-25 09:41:26.265000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('145', null, '2018-04-25 09:42:18.564000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('146', null, '2018-04-25 10:20:38.441000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('147', null, '2018-04-25 10:45:07.326000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('148', null, '2018-04-25 11:04:54.205000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('149', null, '2018-04-25 11:31:52.875000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('150', null, '2018-04-25 11:35:35.585000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('151', null, '2018-04-25 11:43:48.729000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('152', null, '2018-04-25 11:52:31.570000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '2');
INSERT INTO `t_login_log` VALUES ('153', null, '2018-04-25 11:53:39.012000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('154', null, '2018-04-25 11:57:53.278000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('155', null, '2018-04-25 12:05:20.566000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('156', null, '2018-04-25 13:58:55.534000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('157', null, '2018-04-25 14:03:22.340000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('158', null, '2018-04-25 14:07:58.637000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('159', null, '2018-04-25 17:44:05.185000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('160', null, '2018-04-27 09:05:05.669000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('161', null, '2018-04-27 09:15:05.949000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('162', null, '2018-04-27 11:15:04.919000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('163', null, '2018-04-27 14:44:44.565000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('164', null, '2018-04-27 16:52:45.442000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('165', null, '2018-04-27 17:16:25.646000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('166', null, '2018-04-27 17:17:40.175000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('167', null, '2018-04-28 08:58:30.597000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('168', null, '2018-04-28 09:52:33.709000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('169', null, '2018-05-02 09:12:58.701000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('170', null, '2018-05-02 10:25:11.953000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('171', null, '2018-05-02 11:14:30.511000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('172', null, '2018-05-02 14:21:39.937000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('173', null, '2018-05-02 14:31:36.860000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('174', null, '2018-05-02 14:30:46.357000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('175', null, '2018-05-02 15:24:30.824000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('176', null, '2018-05-02 15:26:38.446000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('177', null, '2018-05-02 15:29:13.711000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('178', null, '2018-05-02 16:03:56.627000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('179', null, '2018-05-02 16:05:20.136000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('180', null, '2018-05-02 16:06:05.291000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('181', null, '2018-05-02 16:06:44.467000', '1', '1', null, '127.0.0.1', null, '1');
INSERT INTO `t_login_log` VALUES ('182', null, '2018-05-02 16:08:25.050000', '1', '1', null, '127.0.0.1', null, '1');
INSERT INTO `t_login_log` VALUES ('183', null, '2018-05-02 16:13:40.820000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('184', null, '2018-05-04 09:09:58.633000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('185', null, '2018-05-04 15:24:19.850000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '4');
INSERT INTO `t_login_log` VALUES ('186', null, '2018-05-04 15:29:00.822000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');
INSERT INTO `t_login_log` VALUES ('187', null, '2018-05-04 16:12:19.374000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '1');

-- ----------------------------
-- Table structure for `t_member`
-- ----------------------------
DROP TABLE IF EXISTS `t_member`;
CREATE TABLE `t_member` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `balance` decimal(19,2) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `consume` decimal(19,2) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `gender` int(11) DEFAULT NULL,
  `generalize_cost` decimal(19,2) DEFAULT NULL,
  `generalize_id` varchar(255) DEFAULT NULL,
  `integral` int(11) DEFAULT NULL,
  `ioc_url` varchar(255) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `login_time` datetime(6) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `openid` varchar(50) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `referrer_nickname` varchar(255) DEFAULT NULL,
  `total_revenue` decimal(19,2) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `qr_code` text,
  `after_sales_problem` varchar(255) DEFAULT NULL,
  `commodity_issues` varchar(255) DEFAULT NULL,
  `how_to_buy` varchar(255) DEFAULT NULL,
  `logistics_problem` varchar(255) DEFAULT NULL,
  `order_problem` varchar(255) DEFAULT NULL,
  `promotion_of_problem` varchar(255) DEFAULT NULL,
  `the_invoice_issue` varchar(255) DEFAULT NULL,
  `chang_referrer` int(11) DEFAULT NULL,
  `referrer_generalize_id` varchar(255) DEFAULT NULL,
  `tree` decimal(19,2) DEFAULT NULL,
  `love` int(11) DEFAULT NULL,
  `set_meal` int(11) DEFAULT NULL,
  `agency_id` varchar(255) DEFAULT NULL,
  `agency_nickname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_member
-- ----------------------------
INSERT INTO `t_member` VALUES ('14', null, '2018-04-27 17:19:11.036000', '1', '1', '丽江人', '青秀区', '4500.00', '南宁', '0.00', '中国', '1', '0.00', '100001', '1', 'http://thirdwx.qlogo.cn/mmopen/vi_32/XWia0jSNN1Mq6LSJbgrgQldnYRVjJDe0lp6ssrzIdN9CvAJBqib1r95aP2ia3MDTRtyVIcQ4R3iajknRjQjLrwIxxw/132', '2', null, '13244556987', '收割机', 'orSud0boso97jxgoaDKgkPl3KWOc', '1', '广西', '星愿', '0.00', null, '/static/member/qrcode/DA9EC7E2D7691FFAAA8A9ADFE7F4524F.png', null, null, null, null, null, null, null, '1', '100003', null, '1', '1', null, null);
INSERT INTO `t_member` VALUES ('22', null, '2018-04-28 17:08:51.064000', '1', '1', 'snow', '西乡塘区', '5633.00', '', '6699.00', '阿尔及利亚', '1', '12236.00', '100002', '1', 'http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTKARWSGics4fJNSmbfGIxaicA3ITToK31vmNf2jSUicmo06jS8CjQH6RGoAN5AicOjvQy8ObBwjVrgVEA/132', '3', null, '13277883139', '江南皮革厂', 'orSud0ZLL4Y101ZMlTYCeS7QBpYQ', null, '广西', '收割机', '556.00', null, '/static/member/qrcode/0EB7F487D88A33BB20CC3B5B70A22AF6.png', null, null, null, null, null, null, null, '1', '100004', null, '5', '2', null, null);
INSERT INTO `t_member` VALUES ('23', null, '2018-04-28 17:14:11.927000', '1', '1', 'eagle', null, '0.00', '南宁', '0.00', '中国', '1', '0.00', '', null, 'http://thirdwx.qlogo.cn/mmopen/vi_32/V67tP5lDrlChwSicGV8rRJLJfmCXmOJ1zxMgCFIdBfeLQPEp1UfQtH57THr8Hm5ibBcb7neibtpb6rNarX6oTW20A/132', '1', null, null, '星愿', 'orSud0csNJ6SJWCREAUtSHjDglk4', null, '广西', '002', '0.00', null, null, null, null, null, null, null, null, null, '0', '100004', null, '0', '1', '23', null);
INSERT INTO `t_member` VALUES ('24', null, '2018-04-28 17:16:10.855000', '1', '1', 'arvan', null, '0.00', '南宁', '0.00', '中国', '1', '0.00', '100004', null, 'http://thirdwx.qlogo.cn/mmopen/vi_32/IPaLVGGMNViaCbnc7QH8phIU0sc6yVD5MRz8RM8ArNkpcG296e9eicE843HljYkoQDI49ybgt6cjRP4L5iazcZ80A/132', '1', null, null, '收割机', 'orSud0X4TcfBnnz5pQYsP-hTkbpM', null, '广西', '003', '0.00', null, null, null, null, null, null, null, null, null, '0', '100005', null, '0', '1', null, null);
INSERT INTO `t_member` VALUES ('25', null, '2018-05-09 09:16:29.977000', '1', '1', null, null, '0.00', null, '0.00', null, '0', '0.00', null, null, null, '1', null, null, null, 'orSud0YlPtGmmSgYCnR7Q62jvL-s', null, null, null, '0.00', null, null, null, null, null, null, null, null, null, '0', null, null, '0', '1', null, null);

-- ----------------------------
-- Table structure for `t_member_address`
-- ----------------------------
DROP TABLE IF EXISTS `t_member_address`;
CREATE TABLE `t_member_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `default_address` int(11) DEFAULT NULL COMMENT '1：默认 2：非默认',
  `mobile` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `member_id` int(11) DEFAULT NULL,
  `member` tinyblob,
  `pca` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKq45q01fbke1ajsv883qx60b77` (`member_id`),
  CONSTRAINT `FKq45q01fbke1ajsv883qx60b77` FOREIGN KEY (`member_id`) REFERENCES `t_member` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_member_address
-- ----------------------------
INSERT INTO `t_member_address` VALUES ('35', null, '2018-05-02 16:43:28.235000', '1', '1', '灰灰', '民族大道99号佳和大厦601', null, null, '2', '18871458744', null, null, null, '14', null, '广西壮族自治区 南宁市 青秀区');
INSERT INTO `t_member_address` VALUES ('36', null, '2018-05-03 13:59:31.674000', '1', '1', 'eagle1', '亚航金融中心1010', null, null, '2', '13244556967', null, null, null, '22', null, '北京 北京市 东城区');
INSERT INTO `t_member_address` VALUES ('37', null, '2018-05-02 14:09:23.726000', '2', '1', 'snow', '地王大厦1205', null, null, '2', '13244556968', null, null, null, '22', null, '上海 上海市 黄浦区');
INSERT INTO `t_member_address` VALUES ('38', null, '2018-05-02 14:10:11.047000', '2', '1', 'snow', '地王大厦1205', null, null, '2', '13244556968', null, null, null, '22', null, '上海 上海市 黄浦区');
INSERT INTO `t_member_address` VALUES ('39', null, '2018-05-02 14:11:27.960000', '2', '1', 'arvin91', '地王大厦1506', null, null, '2', '13244556969', null, null, null, '22', null, '辽宁省 沈阳市 和平区');
INSERT INTO `t_member_address` VALUES ('40', null, '2018-05-02 14:13:28.401000', '2', '1', 'snow', '地王大厦1204', null, null, '2', '13244556968', null, null, null, '22', null, '黑龙江省 哈尔滨市 道里区');
INSERT INTO `t_member_address` VALUES ('41', null, '2018-05-03 13:59:46.066000', '2', '1', '1', '', null, null, '2', '1', null, null, null, '22', null, '北京 北京市 东城区');
INSERT INTO `t_member_address` VALUES ('42', null, '2018-05-03 14:00:28.966000', '2', '1', '1', '', null, null, '2', '1', null, null, null, '22', null, '北京 北京市 东城区');
INSERT INTO `t_member_address` VALUES ('43', null, '2018-05-03 14:12:11.698000', '1', '1', '健康', '航洋国际中心1201', null, null, '1', '13244556968', null, null, null, '22', null, '北京 北京市 东城区');

-- ----------------------------
-- Table structure for `t_member_appraise`
-- ----------------------------
DROP TABLE IF EXISTS `t_member_appraise`;
CREATE TABLE `t_member_appraise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_member_appraise
-- ----------------------------

-- ----------------------------
-- Table structure for `t_member_brokerage`
-- ----------------------------
DROP TABLE IF EXISTS `t_member_brokerage`;
CREATE TABLE `t_member_brokerage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `apply_for` decimal(19,2) DEFAULT NULL,
  `due_in` decimal(19,2) DEFAULT NULL,
  `due_in_cargo` decimal(19,2) DEFAULT NULL,
  `no_compute` decimal(19,2) DEFAULT NULL,
  `no_effect` decimal(19,2) DEFAULT NULL,
  `pathway_brokerage` int(11) DEFAULT NULL,
  `total_brokerage` decimal(19,2) DEFAULT NULL,
  `withdraw_cash` decimal(19,2) DEFAULT NULL,
  `withdrawed_cash` decimal(19,2) DEFAULT NULL,
  `member_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKq60f6fw6p56rqdik5hq45ku24` (`member_id`),
  CONSTRAINT `FKq60f6fw6p56rqdik5hq45ku24` FOREIGN KEY (`member_id`) REFERENCES `t_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_member_brokerage
-- ----------------------------

-- ----------------------------
-- Table structure for `t_member_buy`
-- ----------------------------
DROP TABLE IF EXISTS `t_member_buy`;
CREATE TABLE `t_member_buy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `buy_count` int(11) DEFAULT NULL,
  `commodity_id` int(11) DEFAULT NULL,
  `member_id` int(11) DEFAULT NULL,
  `price` decimal(19,2) DEFAULT NULL,
  `is_return` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2lwnjd1bbrtxxdfytmcabmx19` (`commodity_id`),
  KEY `FK92h9nby45qupwppvt75btr03i` (`member_id`),
  CONSTRAINT `FK2lwnjd1bbrtxxdfytmcabmx19` FOREIGN KEY (`commodity_id`) REFERENCES `t_commodity` (`id`),
  CONSTRAINT `FK92h9nby45qupwppvt75btr03i` FOREIGN KEY (`member_id`) REFERENCES `t_member` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_member_buy
-- ----------------------------

-- ----------------------------
-- Table structure for `t_member_evaluation`
-- ----------------------------
DROP TABLE IF EXISTS `t_member_evaluation`;
CREATE TABLE `t_member_evaluation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_member_evaluation
-- ----------------------------

-- ----------------------------
-- Table structure for `t_msg`
-- ----------------------------
DROP TABLE IF EXISTS `t_msg`;
CREATE TABLE `t_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `cat` varchar(255) DEFAULT NULL,
  `from_id` int(11) DEFAULT NULL,
  `readed` int(11) DEFAULT NULL,
  `to_id` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=439 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_msg
-- ----------------------------
INSERT INTO `t_msg` VALUES ('412', '<div class=\"chat_faqbox\"><div class=\"chat_faq_dt\">常见问题</div><ul class=\"chat_faqlist\"><li><a href=\'javascript:void(0);\' onClick=\'getAutoMsgByType(1,\" 提现问题 \")\'><p>提现问题</p></a></li><li><a href=\'javascript:void(0);\' onClick=\'getAutoMsgByType(2,\" 发货问题 \")\'><p>发货问题</p></a></li><li><a href=\'javascript:void(0);\' onClick=\'getAutoMsgByType(3,\" 收货问题 \")\'><p>收货问题</p></a></li><li><a href=\'javascript:void(0);\' onClick=\'getAutoMsgByType(4,\" 退货问题 \")\'><p>退货问题</p></a></li></ul></div>', '2018-05-02 16:35:20.406000', '1', '1', null, 'KF_TO_MEMBER', '1', '2', '14', 'TEXT');
INSERT INTO `t_msg` VALUES ('413', '嘿嘿', '2018-05-02 16:37:26.178000', '1', '1', null, 'MEMBER_TO_KF', '14', '2', '1', 'TEXT');
INSERT INTO `t_msg` VALUES ('414', '哈哈', '2018-05-02 16:37:29.122000', '1', '1', null, 'MEMBER_TO_KF', '14', '2', '1', 'TEXT');
INSERT INTO `t_msg` VALUES ('415', '你妹', '2018-05-02 16:37:31.044000', '1', '1', null, 'MEMBER_TO_KF', '14', '2', '1', 'TEXT');
INSERT INTO `t_msg` VALUES ('416', '人', '2018-05-02 16:37:31.888000', '1', '1', null, 'MEMBER_TO_KF', '14', '2', '1', 'TEXT');
INSERT INTO `t_msg` VALUES ('417', '有', '2018-05-02 16:37:32.579000', '1', '1', null, 'MEMBER_TO_KF', '14', '2', '1', 'TEXT');
INSERT INTO `t_msg` VALUES ('418', '我', '2018-05-02 16:37:33.358000', '1', '1', null, 'MEMBER_TO_KF', '14', '2', '1', 'TEXT');
INSERT INTO `t_msg` VALUES ('419', '擦', '2018-05-02 16:37:37.125000', '1', '1', null, 'MEMBER_TO_KF', '14', '2', '1', 'TEXT');
INSERT INTO `t_msg` VALUES ('420', '？？？', '2018-05-02 16:37:43.690000', '1', '1', null, 'KF_TO_MEMBER', '1', '1', '14', 'TEXT');
INSERT INTO `t_msg` VALUES ('421', '说人话', '2018-05-02 16:37:49.230000', '1', '1', null, 'KF_TO_MEMBER', '1', '1', '14', 'TEXT');
INSERT INTO `t_msg` VALUES ('422', '！一？，好想', '2018-05-02 16:38:33.198000', '1', '1', null, 'MEMBER_TO_KF', '14', '1', '1', 'TEXT');
INSERT INTO `t_msg` VALUES ('423', '<div class=\"chat_faqbox\"><div class=\"chat_faq_dt\">常见问题</div><ul class=\"chat_faqlist\"><li><a href=\'javascript:void(0);\' onClick=\'getAutoMsgByType(1,\" 提现问题 \")\'><p>提现问题</p></a></li><li><a href=\'javascript:void(0);\' onClick=\'getAutoMsgByType(2,\" 发货问题 \")\'><p>发货问题</p></a></li><li><a href=\'javascript:void(0);\' onClick=\'getAutoMsgByType(3,\" 收货问题 \")\'><p>收货问题</p></a></li><li><a href=\'javascript:void(0);\' onClick=\'getAutoMsgByType(4,\" 退货问题 \")\'><p>退货问题</p></a></li></ul></div>', '2018-05-03 13:58:31.296000', '1', '1', null, 'KF_TO_MEMBER', '1', '1', '22', 'TEXT');
INSERT INTO `t_msg` VALUES ('424', '111', '2018-05-03 13:58:41.734000', '1', '1', null, 'MEMBER_TO_KF', '22', '1', '1', 'TEXT');
INSERT INTO `t_msg` VALUES ('425', '？？？？', '2018-05-04 17:48:23.939000', '1', '1', null, 'MEMBER_TO_KF', '22', '1', '1', 'TEXT');
INSERT INTO `t_msg` VALUES ('426', '？？？', '2018-05-04 17:48:30.731000', '1', '1', null, 'MEMBER_TO_KF', '22', '1', '1', 'TEXT');
INSERT INTO `t_msg` VALUES ('427', ' 发货问题 ', '2018-05-04 17:48:33.372000', '1', '1', null, 'MEMBER_TO_KF', '22', '1', '1', 'TEXT');
INSERT INTO `t_msg` VALUES ('428', '<div class=\"chat_faqbox\"><div class=\"chat_faq_dt\">请选择</div><ul class=\"chat_faqlist\"><a href=\"javascript:void(0);\" onClick=\"showContent(\'什么时候发货？\',\'<p>下单后24小时内发货</p>\')\"><p>什么时候发货？</p></a><a href=\"javascript:void(0);\" onClick=\"showContent(\'支持哪些快递？\',\'<p>目前支持所有的物流公司 ，谢谢。</p>\')\"><p>支持哪些快递？</p></a></ul></div>', '2018-05-04 17:48:33.820000', '1', '1', null, 'KF_TO_MEMBER', '1', '1', '22', 'TEXT');
INSERT INTO `t_msg` VALUES ('429', '什么时候发货？', '2018-05-04 17:48:35.246000', '1', '1', null, 'MEMBER_TO_KF', '22', '1', '1', 'TEXT');
INSERT INTO `t_msg` VALUES ('430', '<p>下单后24小时内发货</p>', '2018-05-04 17:48:35.716000', '1', '1', null, 'KF_TO_MEMBER', '1', '1', '22', 'TEXT');
INSERT INTO `t_msg` VALUES ('431', '支持哪些快递？', '2018-05-04 17:48:37.033000', '1', '1', null, 'MEMBER_TO_KF', '22', '1', '1', 'TEXT');
INSERT INTO `t_msg` VALUES ('432', '<p>目前支持所有的物流公司 ，谢谢。</p>', '2018-05-04 17:48:37.529000', '1', '1', null, 'KF_TO_MEMBER', '1', '1', '22', 'TEXT');
INSERT INTO `t_msg` VALUES ('433', ' 退货问题 ', '2018-05-04 17:48:42.976000', '1', '1', null, 'MEMBER_TO_KF', '22', '1', '1', 'TEXT');
INSERT INTO `t_msg` VALUES ('434', '<div class=\"chat_faqbox\"><div class=\"chat_faq_dt\">请选择</div><ul class=\"chat_faqlist\"></ul></div>', '2018-05-04 17:48:43.509000', '1', '1', null, 'KF_TO_MEMBER', '1', '1', '22', 'TEXT');
INSERT INTO `t_msg` VALUES ('435', '支持哪些快递？', '2018-05-08 15:54:48.029000', '1', '1', null, 'MEMBER_TO_KF', '22', '1', '1', 'TEXT');
INSERT INTO `t_msg` VALUES ('436', '<p>目前支持所有的物流公司 ，谢谢。</p>', '2018-05-08 15:54:48.539000', '1', '1', null, 'KF_TO_MEMBER', '1', '1', '22', 'TEXT');
INSERT INTO `t_msg` VALUES ('437', ' 提现问题 ', '2018-05-08 15:54:57.154000', '1', '1', null, 'MEMBER_TO_KF', '22', '1', '1', 'TEXT');
INSERT INTO `t_msg` VALUES ('438', '<div class=\"chat_faqbox\"><div class=\"chat_faq_dt\">请选择</div><ul class=\"chat_faqlist\"></ul></div>', '2018-05-08 15:54:57.481000', '1', '1', null, 'KF_TO_MEMBER', '1', '1', '22', 'TEXT');

-- ----------------------------
-- Table structure for `t_opt_log`
-- ----------------------------
DROP TABLE IF EXISTS `t_opt_log`;
CREATE TABLE `t_opt_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `opt_ip` varchar(255) DEFAULT NULL,
  `opt_time` datetime(6) DEFAULT NULL,
  `opt_uri` varchar(255) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK56xgvnksn8373s5p4iuvx5e8r` (`user_id`),
  CONSTRAINT `FK56xgvnksn8373s5p4iuvx5e8r` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2328 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_opt_log
-- ----------------------------
INSERT INTO `t_opt_log` VALUES ('1', null, '2018-04-13 17:54:24.613000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2', null, '2018-04-13 17:54:27.114000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '1');
INSERT INTO `t_opt_log` VALUES ('3', null, '2018-04-13 17:54:35.810000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('4', null, '2018-04-13 17:54:38.079000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '1');
INSERT INTO `t_opt_log` VALUES ('5', null, '2018-04-13 17:54:44.462000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('6', null, '2018-04-13 17:54:46.460000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '1');
INSERT INTO `t_opt_log` VALUES ('7', null, '2018-04-13 17:54:53.608000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('8', null, '2018-04-13 17:56:28.911000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('9', null, '2018-04-13 17:56:34.101000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/optlog/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('10', null, '2018-04-13 17:57:21.845000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/optlog/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('11', null, '2018-04-14 09:29:07.491000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('12', null, '2018-04-14 09:29:18.758000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/loginlog/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('13', null, '2018-04-14 09:29:33.224000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/loginlog/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('14', null, '2018-04-14 09:29:34.899000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('15', null, '2018-04-14 09:29:51.627000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('16', null, '2018-04-14 09:30:13.605000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('17', null, '2018-04-14 09:30:50.909000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('18', null, '2018-04-14 09:30:54.202000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('19', null, '2018-04-14 09:30:54.740000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('20', null, '2018-04-14 09:33:19.418000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('21', null, '2018-04-14 09:33:26.650000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('22', null, '2018-04-14 09:33:36.645000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('23', null, '2018-04-14 09:33:39.304000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('24', null, '2018-04-14 09:33:46.932000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('25', null, '2018-04-14 09:33:41.284000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('26', null, '2018-04-14 09:33:58.816000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('27', null, '2018-04-14 09:35:51.959000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '1');
INSERT INTO `t_opt_log` VALUES ('28', null, '2018-04-14 09:36:14.819000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('29', null, '2018-04-14 09:37:33.966000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('30', null, '2018-04-14 09:37:36.408000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '1');
INSERT INTO `t_opt_log` VALUES ('31', null, '2018-04-14 09:37:39.192000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('32', null, '2018-04-14 09:38:20.449000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/3.htm', '1');
INSERT INTO `t_opt_log` VALUES ('33', null, '2018-04-14 09:38:40.484000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('34', null, '2018-04-14 09:38:43.243000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/3.htm', '1');
INSERT INTO `t_opt_log` VALUES ('35', null, '2018-04-14 09:38:46.705000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('36', null, '2018-04-14 09:38:48.911000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/3.htm', '1');
INSERT INTO `t_opt_log` VALUES ('37', null, '2018-04-14 09:38:52.960000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('38', null, '2018-04-14 09:38:10.333000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('39', null, '2018-04-14 09:38:13.833000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('40', null, '2018-04-14 09:39:16.843000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/3.htm', '1');
INSERT INTO `t_opt_log` VALUES ('41', null, '2018-04-14 09:39:21.653000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('42', null, '2018-04-14 09:39:23.829000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/3.htm', '1');
INSERT INTO `t_opt_log` VALUES ('43', null, '2018-04-14 09:39:25.915000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('44', null, '2018-04-14 09:38:40.496000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('45', null, '2018-04-14 09:38:43.130000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('46', null, '2018-04-14 09:39:52.651000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('47', null, '2018-04-14 09:41:10.914000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/3.htm', '1');
INSERT INTO `t_opt_log` VALUES ('48', null, '2018-04-14 09:41:57.990000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('49', null, '2018-04-14 09:42:08.325000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/3.htm', '1');
INSERT INTO `t_opt_log` VALUES ('50', null, '2018-04-14 09:48:52.745000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('51', null, '2018-04-14 09:51:42.603000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/3.htm', '1');
INSERT INTO `t_opt_log` VALUES ('52', null, '2018-04-14 09:51:45.904000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('53', null, '2018-04-14 09:51:00.678000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('54', null, '2018-04-14 09:52:07.822000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/3.htm', '1');
INSERT INTO `t_opt_log` VALUES ('55', null, '2018-04-14 09:52:12.312000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('56', null, '2018-04-14 09:52:14.729000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/3.htm', '1');
INSERT INTO `t_opt_log` VALUES ('57', null, '2018-04-14 09:52:17.632000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('58', null, '2018-04-14 09:52:36.507000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/3.htm', '1');
INSERT INTO `t_opt_log` VALUES ('59', null, '2018-04-14 09:52:38.835000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('60', null, '2018-04-14 09:52:41.057000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/3.htm', '1');
INSERT INTO `t_opt_log` VALUES ('61', null, '2018-04-14 09:52:45.077000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('62', null, '2018-04-14 09:52:33.364000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('63', null, '2018-04-14 09:52:43.087000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('64', null, '2018-04-14 09:52:53.177000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('65', null, '2018-04-14 09:52:58.990000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('66', null, '2018-04-14 09:53:02.043000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('67', null, '2018-04-14 09:53:07.433000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('68', null, '2018-04-14 09:54:28.365000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/3.htm', '1');
INSERT INTO `t_opt_log` VALUES ('69', null, '2018-04-14 09:54:32.742000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('70', null, '2018-04-14 09:54:34.944000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/3.htm', '1');
INSERT INTO `t_opt_log` VALUES ('71', null, '2018-04-14 09:54:52.398000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('72', null, '2018-04-14 09:54:27.582000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('73', null, '2018-04-14 09:54:29.672000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('74', null, '2018-04-14 09:54:32.853000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('75', null, '2018-04-14 09:54:51.074000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('76', null, '2018-04-14 09:54:55.573000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('77', null, '2018-04-14 09:55:04.676000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('78', null, '2018-04-14 09:55:06.816000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('79', null, '2018-04-14 09:55:23.628000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('80', null, '2018-04-14 09:55:25.693000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('81', null, '2018-04-14 09:55:31.987000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('82', null, '2018-04-14 09:55:34.131000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('83', null, '2018-04-14 09:55:35.829000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('84', null, '2018-04-14 09:57:11.200000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('85', null, '2018-04-14 09:57:48.279000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('86', null, '2018-04-14 09:57:57.763000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('87', null, '2018-04-14 09:57:59.856000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('88', null, '2018-04-14 09:58:01.170000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('89', null, '2018-04-14 09:58:31.074000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('90', null, '2018-04-14 09:58:33.171000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('91', null, '2018-04-14 09:58:33.896000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('92', null, '2018-04-14 09:58:37.096000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('93', null, '2018-04-14 09:58:41.118000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('94', null, '2018-04-14 10:00:20.189000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('95', null, '2018-04-14 10:00:24.902000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('96', null, '2018-04-14 10:00:31.103000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('97', null, '2018-04-14 10:00:39.355000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('98', null, '2018-04-14 10:00:44.443000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('99', null, '2018-04-14 10:01:10.768000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('100', null, '2018-04-14 10:01:37.259000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('101', null, '2018-04-14 10:06:13.549000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('102', null, '2018-04-14 10:07:28.845000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('103', null, '2018-04-14 10:07:32.042000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('104', null, '2018-04-14 10:07:40.265000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('105', null, '2018-04-14 10:07:42.571000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('106', null, '2018-04-14 10:07:44.799000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('107', null, '2018-04-14 10:09:06.511000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('108', null, '2018-04-14 10:14:56.592000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('109', null, '2018-04-14 10:14:59.294000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/3.htm', '1');
INSERT INTO `t_opt_log` VALUES ('110', null, '2018-04-14 10:15:02.888000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('111', null, '2018-04-14 10:15:05.055000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/3.htm', '1');
INSERT INTO `t_opt_log` VALUES ('112', null, '2018-04-14 10:15:07.209000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('113', null, '2018-04-14 10:16:30.807000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('114', null, '2018-04-14 10:16:38.689000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('115', null, '2018-04-14 10:16:40.059000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('116', null, '2018-04-14 10:16:43.180000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/updatePVById/enable/1/3.json', '1');
INSERT INTO `t_opt_log` VALUES ('117', null, '2018-04-14 10:17:44.107000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('118', null, '2018-04-14 10:17:53.440000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('119', null, '2018-04-14 10:17:54.828000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('120', null, '2018-04-14 10:18:57.928000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('121', null, '2018-04-14 10:19:00.414000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('122', null, '2018-04-14 10:19:02.609000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('123', null, '2018-04-14 10:19:18.097000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('124', null, '2018-04-14 10:19:19.893000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('125', null, '2018-04-14 10:19:29.360000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('126', null, '2018-04-14 10:19:31.520000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('127', null, '2018-04-14 10:23:15.307000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('128', null, '2018-04-14 10:23:19.420000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/3.htm', '1');
INSERT INTO `t_opt_log` VALUES ('129', null, '2018-04-14 10:23:28.593000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('130', null, '2018-04-14 10:23:31.094000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '1');
INSERT INTO `t_opt_log` VALUES ('131', null, '2018-04-14 10:23:45.397000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('132', null, '2018-04-14 10:23:48.777000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('133', null, '2018-04-14 10:23:52.817000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('134', null, '2018-04-14 10:23:55.232000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('135', null, '2018-04-14 10:24:10.943000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('136', null, '2018-04-14 10:24:13.163000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('137', null, '2018-04-14 10:24:14.982000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('138', null, '2018-04-14 10:24:18.591000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('139', null, '2018-04-14 10:27:12.434000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('140', null, '2018-04-14 10:27:14.048000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('141', null, '2018-04-14 10:27:19.118000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('142', null, '2018-04-14 10:28:10.220000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('143', null, '2018-04-14 10:28:18.852000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('144', null, '2018-04-14 10:28:20.927000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('145', null, '2018-04-14 10:28:23.984000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('146', null, '2018-04-14 10:28:58.951000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('147', null, '2018-04-14 10:29:02.938000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('148', null, '2018-04-14 10:29:05.105000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('149', null, '2018-04-14 10:29:06.866000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('150', null, '2018-04-14 10:29:08.007000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('151', null, '2018-04-14 10:29:10.165000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('152', null, '2018-04-14 10:29:18.573000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('153', null, '2018-04-14 10:29:20.741000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('154', null, '2018-04-14 10:29:22.208000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('155', null, '2018-04-14 10:28:48.067000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('156', null, '2018-04-14 10:52:36.888000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('157', null, '2018-04-14 10:52:39.529000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('158', null, '2018-04-14 10:53:00.105000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('159', null, '2018-04-14 10:57:17.777000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityappraise/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('160', null, '2018-04-14 11:05:42.267000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityappraise/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('161', null, '2018-04-14 11:06:04.277000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityappraise/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('162', null, '2018-04-14 11:09:50.067000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityappraise/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('163', null, '2018-04-14 11:11:13.014000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityappraise/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('164', null, '2018-04-14 11:11:26.836000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityappraise/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('165', null, '2018-04-14 11:34:29.301000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('166', null, '2018-04-14 11:34:35.842000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('167', null, '2018-04-14 11:34:40.221000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('168', null, '2018-04-14 11:39:09.639000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('169', null, '2018-04-14 11:39:14.279000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('170', null, '2018-04-14 11:39:19.057000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('171', null, '2018-04-14 11:42:29.508000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('172', null, '2018-04-14 11:42:32.652000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('173', null, '2018-04-14 11:42:41.429000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('174', null, '2018-04-14 11:42:45.532000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('175', null, '2018-04-14 11:42:59.384000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('176', null, '2018-04-14 11:43:53.921000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('177', null, '2018-04-14 11:43:57.546000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('178', null, '2018-04-14 11:44:11.280000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('179', null, '2018-04-14 11:44:16.359000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('180', null, '2018-04-14 11:44:48.048000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('181', null, '2018-04-14 11:44:51.215000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('182', null, '2018-04-14 11:44:59.738000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('183', null, '2018-04-14 11:45:03.880000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('184', null, '2018-04-14 11:45:31.986000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('185', null, '2018-04-14 11:45:34.873000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('186', null, '2018-04-14 11:45:49.801000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('187', null, '2018-04-14 11:45:53.785000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('188', null, '2018-04-14 11:45:56.649000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('189', null, '2018-04-14 11:45:59.066000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('190', null, '2018-04-14 11:46:02.810000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('191', null, '2018-04-14 11:47:00.824000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('192', null, '2018-04-14 11:47:02.650000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('193', null, '2018-04-14 11:47:44.810000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('194', null, '2018-04-14 11:47:48.968000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('195', null, '2018-04-14 11:48:06.933000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('196', null, '2018-04-14 11:48:23.637000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('197', null, '2018-04-14 11:48:25.936000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('198', null, '2018-04-14 11:48:37.861000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('199', null, '2018-04-14 11:50:58.806000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('200', null, '2018-04-14 11:51:31.860000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('201', null, '2018-04-14 11:53:24.838000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('202', null, '2018-04-14 11:53:35.215000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('203', null, '2018-04-14 11:53:37.838000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('204', null, '2018-04-14 11:53:40.387000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('205', null, '2018-04-14 11:54:28.280000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('206', null, '2018-04-14 11:54:46.031000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('207', null, '2018-04-14 11:55:20.221000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('208', null, '2018-04-14 11:55:26.247000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('209', null, '2018-04-14 11:55:43.813000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('210', null, '2018-04-14 11:55:46.762000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('211', null, '2018-04-14 11:55:55.628000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('212', null, '2018-04-14 11:56:02.113000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('213', null, '2018-04-14 11:56:32.320000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('214', null, '2018-04-14 11:56:37.836000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('215', null, '2018-04-14 11:56:46.236000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('216', null, '2018-04-14 11:56:50.990000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('217', null, '2018-04-14 11:59:10.541000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('218', null, '2018-04-14 12:01:40.776000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('219', null, '2018-04-14 12:01:41.718000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('220', null, '2018-04-14 12:02:48.229000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('221', null, '2018-04-14 12:02:47.244000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('222', null, '2018-04-14 12:02:53.810000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('223', null, '2018-04-14 12:02:58.307000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('224', null, '2018-04-14 12:03:24.261000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('225', null, '2018-04-14 12:04:56.551000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('226', null, '2018-04-14 12:04:57.585000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('227', null, '2018-04-14 12:05:14.845000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('228', null, '2018-04-14 12:06:02.507000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('229', null, '2018-04-14 12:07:22.102000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('230', null, '2018-04-14 12:07:25.276000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('231', null, '2018-04-14 12:07:56.513000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('232', null, '2018-04-14 13:50:03.010000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('233', null, '2018-04-14 13:50:06.764000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('234', null, '2018-04-14 13:50:41.269000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('235', null, '2018-04-14 13:53:09.326000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('236', null, '2018-04-14 13:53:35.772000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('237', null, '2018-04-14 13:54:19.686000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('238', null, '2018-04-14 13:55:06.681000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('239', null, '2018-04-14 13:55:07.511000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('240', null, '2018-04-14 14:01:39.616000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('241', null, '2018-04-14 14:04:51.455000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('242', null, '2018-04-14 14:05:02.183000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('243', null, '2018-04-14 14:07:05.920000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('244', null, '2018-04-14 14:07:08.189000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('245', null, '2018-04-14 14:08:03.329000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('246', null, '2018-04-14 14:08:05.897000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('247', null, '2018-04-14 14:08:24.450000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('248', null, '2018-04-14 14:08:27.901000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('249', null, '2018-04-14 14:08:38.206000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('250', null, '2018-04-14 14:12:42.844000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('251', null, '2018-04-14 14:12:54.727000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('252', null, '2018-04-14 14:12:58.938000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('253', null, '2018-04-14 14:15:02.552000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('254', null, '2018-04-14 14:15:23.536000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htmq=%E6%94%B6%E8%B4%A7&search=', '4');
INSERT INTO `t_opt_log` VALUES ('255', null, '2018-04-14 14:26:50.985000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('256', null, '2018-04-14 14:27:01.949000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/2.htm', '4');
INSERT INTO `t_opt_log` VALUES ('257', null, '2018-04-14 14:27:09.756000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('258', null, '2018-04-14 14:27:11.881000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/2.htm', '4');
INSERT INTO `t_opt_log` VALUES ('259', null, '2018-04-14 14:27:21.784000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/updatePVById/enable/1/1.json', '4');
INSERT INTO `t_opt_log` VALUES ('260', null, '2018-04-14 14:32:20.856000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('261', null, '2018-04-14 14:32:27.944000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('262', null, '2018-04-14 14:32:47.733000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('263', null, '2018-04-14 14:32:51.380000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('264', null, '2018-04-14 14:33:01.255000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('265', null, '2018-04-14 14:33:04.841000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('266', null, '2018-04-14 14:33:06.400000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('267', null, '2018-04-14 14:33:23.342000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('268', null, '2018-04-14 14:34:16.165000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('269', null, '2018-04-14 14:34:18.476000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('270', null, '2018-04-14 14:34:29.449000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('271', null, '2018-04-14 14:34:34.222000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('272', null, '2018-04-14 14:35:41.794000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('273', null, '2018-04-14 14:35:43.035000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('274', null, '2018-04-14 14:35:50.166000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('275', null, '2018-04-14 14:35:53.404000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('276', null, '2018-04-14 14:35:56.642000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('277', null, '2018-04-14 14:36:15.817000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('278', null, '2018-04-14 14:36:36.707000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('279', null, '2018-04-14 14:36:42.302000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('280', null, '2018-04-14 14:39:11.112000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('281', null, '2018-04-14 14:39:29.204000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('282', null, '2018-04-14 14:39:34.190000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('283', null, '2018-04-14 14:40:08.197000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('284', null, '2018-04-14 14:40:11.597000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '1');
INSERT INTO `t_opt_log` VALUES ('285', null, '2018-04-14 14:40:15.861000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('286', null, '2018-04-14 14:40:22.837000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('287', null, '2018-04-14 14:42:27.633000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('288', null, '2018-04-14 14:42:30.273000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('289', null, '2018-04-14 14:43:54.494000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('290', null, '2018-04-14 14:43:56.569000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('291', null, '2018-04-14 14:43:58.748000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('292', null, '2018-04-14 14:44:02.651000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('293', null, '2018-04-14 14:48:14.070000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('294', null, '2018-04-14 14:48:17.000000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/2.htm', '4');
INSERT INTO `t_opt_log` VALUES ('295', null, '2018-04-14 14:51:35.822000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('296', null, '2018-04-14 14:51:44.293000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('297', null, '2018-04-14 14:51:46.412000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('298', null, '2018-04-14 14:52:21.346000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('299', null, '2018-04-14 14:52:33.077000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('300', null, '2018-04-14 14:52:35.130000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('301', null, '2018-04-14 14:53:06.516000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/2.htm', '4');
INSERT INTO `t_opt_log` VALUES ('302', null, '2018-04-14 14:53:13.626000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('303', null, '2018-04-14 14:53:15.690000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/2.htm', '4');
INSERT INTO `t_opt_log` VALUES ('304', null, '2018-04-14 14:54:58.165000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('305', null, '2018-04-14 14:55:00.171000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('306', null, '2018-04-14 15:00:41.942000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('307', null, '2018-04-14 15:00:48.179000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('308', null, '2018-04-14 15:00:59.029000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('309', null, '2018-04-14 15:14:44.543000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('310', null, '2018-04-14 15:15:00.046000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('311', null, '2018-04-14 15:15:23.569000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('312', null, '2018-04-14 15:15:57.167000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('313', null, '2018-04-14 15:15:59.354000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('314', null, '2018-04-14 15:16:01.730000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('315', null, '2018-04-14 15:16:25.945000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/list/4/15.htmk=', '2');
INSERT INTO `t_opt_log` VALUES ('316', null, '2018-04-14 15:16:36.412000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/update/58.htm', '2');
INSERT INTO `t_opt_log` VALUES ('317', null, '2018-04-14 15:18:06.018000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('318', null, '2018-04-14 15:18:10.247000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('319', null, '2018-04-14 15:18:20.407000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('320', null, '2018-04-14 15:18:30.308000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('321', null, '2018-04-14 15:18:31.817000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('322', null, '2018-04-14 15:18:52.493000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/list/4/15.htmk=', '2');
INSERT INTO `t_opt_log` VALUES ('323', null, '2018-04-14 15:18:55.662000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/update/58.htm', '2');
INSERT INTO `t_opt_log` VALUES ('324', null, '2018-04-14 15:19:05.838000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('325', null, '2018-04-14 15:19:07.971000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('326', null, '2018-04-14 15:19:12.034000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('327', null, '2018-04-14 15:19:13.953000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('328', null, '2018-04-14 15:19:17.292000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/update/58.htm', '2');
INSERT INTO `t_opt_log` VALUES ('329', null, '2018-04-14 15:19:32.445000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('330', null, '2018-04-14 15:19:34.653000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/update/58.htm', '2');
INSERT INTO `t_opt_log` VALUES ('331', null, '2018-04-14 15:19:36.272000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/list/4/15.htmk=', '2');
INSERT INTO `t_opt_log` VALUES ('332', null, '2018-04-14 15:20:57.042000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('333', null, '2018-04-14 15:21:47.681000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('334', null, '2018-04-14 15:21:49.811000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('335', null, '2018-04-14 15:21:57.310000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('336', null, '2018-04-14 15:21:59.472000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('337', null, '2018-04-14 15:22:08.820000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('338', null, '2018-04-14 15:22:11.237000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('339', null, '2018-04-14 15:22:12.981000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/list/4/15.htmk=', '2');
INSERT INTO `t_opt_log` VALUES ('340', null, '2018-04-14 15:22:33.628000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/update/59.htm', '2');
INSERT INTO `t_opt_log` VALUES ('341', null, '2018-04-14 15:22:39.870000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('342', null, '2018-04-14 15:22:41.951000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/update/59.htm', '2');
INSERT INTO `t_opt_log` VALUES ('343', null, '2018-04-14 15:22:44.822000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/list/4/15.htmk=', '2');
INSERT INTO `t_opt_log` VALUES ('344', null, '2018-04-14 15:22:48.310000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('345', null, '2018-04-14 15:22:54.457000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/update/60.htm', '2');
INSERT INTO `t_opt_log` VALUES ('346', null, '2018-04-14 15:22:58.608000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('347', null, '2018-04-14 15:22:58.961000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/list/4/15.htmk=', '2');
INSERT INTO `t_opt_log` VALUES ('348', null, '2018-04-14 15:23:08.793000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('349', null, '2018-04-14 15:23:11.689000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/update/60.htm', '2');
INSERT INTO `t_opt_log` VALUES ('350', null, '2018-04-14 15:23:20.028000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('351', null, '2018-04-14 15:23:22.450000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/update/60.htm', '2');
INSERT INTO `t_opt_log` VALUES ('352', null, '2018-04-14 15:23:24.819000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/list/4/15.htmk=', '2');
INSERT INTO `t_opt_log` VALUES ('353', null, '2018-04-14 15:23:36.563000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/list/5/15.htmk=', '2');
INSERT INTO `t_opt_log` VALUES ('354', null, '2018-04-14 15:23:39.611000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/update/61.htm', '2');
INSERT INTO `t_opt_log` VALUES ('355', null, '2018-04-14 15:23:48.777000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('356', null, '2018-04-14 15:23:50.856000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/update/61.htm', '2');
INSERT INTO `t_opt_log` VALUES ('357', null, '2018-04-14 15:23:54.229000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/list/5/15.htmk=', '2');
INSERT INTO `t_opt_log` VALUES ('358', null, '2018-04-14 15:24:07.629000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/res/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('359', null, '2018-04-14 15:24:11.890000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('360', null, '2018-04-14 15:24:16.514000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('361', null, '2018-04-14 15:24:47.432000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('362', null, '2018-04-14 15:24:52.296000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('363', null, '2018-04-14 15:24:55.504000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('364', null, '2018-04-14 15:25:01.341000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('365', null, '2018-04-14 15:25:21.291000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('366', null, '2018-04-14 15:26:46.568000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('367', null, '2018-04-14 15:30:09.506000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('368', null, '2018-04-14 15:30:13.674000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('369', null, '2018-04-14 15:30:43.145000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('370', null, '2018-04-14 15:32:15.069000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('371', null, '2018-04-14 15:34:56.749000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('372', null, '2018-04-14 15:34:57.887000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('373', null, '2018-04-14 15:34:59.896000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('374', null, '2018-04-14 15:35:10.109000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('375', null, '2018-04-14 15:35:13.001000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('376', null, '2018-04-14 15:35:15.104000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('377', null, '2018-04-14 15:35:16.524000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('378', null, '2018-04-14 15:38:11.357000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('379', null, '2018-04-14 15:38:21.158000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('380', null, '2018-04-14 15:38:50.166000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('381', null, '2018-04-14 15:39:54.784000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('382', null, '2018-04-14 15:40:14.002000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('383', null, '2018-04-14 15:42:08.442000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('384', null, '2018-04-14 15:42:24.706000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('385', null, '2018-04-14 15:43:08.429000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('386', null, '2018-04-14 15:43:12.131000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('387', null, '2018-04-14 15:43:26.692000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('388', null, '2018-04-14 15:43:30.307000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('389', null, '2018-04-14 15:43:43.284000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('390', null, '2018-04-14 15:43:52.209000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('391', null, '2018-04-14 15:43:54.030000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('392', null, '2018-04-14 15:44:04.484000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('393', null, '2018-04-14 15:44:24.342000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('394', null, '2018-04-14 15:44:26.411000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('395', null, '2018-04-14 15:44:28.807000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('396', null, '2018-04-14 15:44:53.381000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/update/3.htm', '4');
INSERT INTO `t_opt_log` VALUES ('397', null, '2018-04-14 15:44:57.960000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('398', null, '2018-04-14 15:45:00.031000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/update/3.htm', '4');
INSERT INTO `t_opt_log` VALUES ('399', null, '2018-04-14 15:45:01.267000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('400', null, '2018-04-14 15:45:02.863000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('401', null, '2018-04-14 15:46:52.544000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('402', null, '2018-04-14 15:47:00.684000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('403', null, '2018-04-14 15:47:07.425000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('404', null, '2018-04-14 15:47:10.644000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('405', null, '2018-04-14 15:48:30.854000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('406', null, '2018-04-14 15:48:34.120000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('407', null, '2018-04-14 15:48:36.902000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('408', null, '2018-04-14 15:48:39.523000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('409', null, '2018-04-14 15:48:40.981000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('410', null, '2018-04-14 15:48:43.156000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('411', null, '2018-04-14 15:48:45.064000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('412', null, '2018-04-14 15:48:52.142000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('413', null, '2018-04-14 15:48:53.798000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('414', null, '2018-04-14 15:49:03.125000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('415', null, '2018-04-14 15:49:07.152000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('416', null, '2018-04-14 15:49:23.586000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('417', null, '2018-04-14 15:49:24.659000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('418', null, '2018-04-14 15:49:26.837000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('419', null, '2018-04-14 15:49:29.651000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('420', null, '2018-04-14 15:49:31.803000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('421', null, '2018-04-14 15:49:33.627000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('422', null, '2018-04-14 15:49:35.172000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('423', null, '2018-04-14 15:49:36.726000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('424', null, '2018-04-14 15:49:37.644000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('425', null, '2018-04-14 15:49:38.801000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('426', null, '2018-04-14 15:49:42.103000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('427', null, '2018-04-14 15:49:45.072000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('428', null, '2018-04-14 15:50:01.369000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('429', null, '2018-04-14 15:50:02.900000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('430', null, '2018-04-14 15:50:05.954000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('431', null, '2018-04-14 15:50:24.683000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('432', null, '2018-04-14 15:50:26.526000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('433', null, '2018-04-14 15:50:28.519000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('434', null, '2018-04-14 15:50:30.202000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('435', null, '2018-04-14 15:50:31.083000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('436', null, '2018-04-14 15:50:35.670000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('437', null, '2018-04-14 15:50:47.517000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('438', null, '2018-04-14 15:50:49.699000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('439', null, '2018-04-14 15:50:51.973000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('440', null, '2018-04-14 15:50:56.165000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('441', null, '2018-04-14 15:50:57.769000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('442', null, '2018-04-14 15:51:24.438000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('443', null, '2018-04-14 15:52:07.715000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('444', null, '2018-04-14 15:52:13.234000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('445', null, '2018-04-14 15:52:32.084000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('446', null, '2018-04-14 15:52:43.183000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('447', null, '2018-04-14 15:52:45.611000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('448', null, '2018-04-14 15:52:57.299000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('449', null, '2018-04-14 15:53:03.428000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('450', null, '2018-04-14 15:53:16.133000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('451', null, '2018-04-14 15:53:46.001000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('452', null, '2018-04-14 15:55:03.083000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('453', null, '2018-04-14 15:55:09.277000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('454', null, '2018-04-14 15:55:23.934000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('455', null, '2018-04-14 15:55:27.261000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('456', null, '2018-04-14 15:55:29.638000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('457', null, '2018-04-14 15:55:31.699000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('458', null, '2018-04-14 15:55:54.937000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/updatePVById/enable/2/1.json', '4');
INSERT INTO `t_opt_log` VALUES ('459', null, '2018-04-14 15:55:59.954000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('460', null, '2018-04-14 15:56:04.569000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('461', null, '2018-04-14 15:56:23.123000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('462', null, '2018-04-14 15:56:38.531000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('463', null, '2018-04-14 15:57:10.639000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/updatePVById/enable/1/1.json', '4');
INSERT INTO `t_opt_log` VALUES ('464', null, '2018-04-14 15:57:14.189000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('465', null, '2018-04-14 15:57:14.666000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('466', null, '2018-04-14 15:57:23.205000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('467', null, '2018-04-14 15:58:36.602000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('468', null, '2018-04-14 15:58:43.011000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('469', null, '2018-04-14 16:00:21.713000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('470', null, '2018-04-14 16:00:25.321000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('471', null, '2018-04-14 16:00:27.136000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('472', null, '2018-04-14 16:00:27.984000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('473', null, '2018-04-14 16:00:48.562000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('474', null, '2018-04-14 16:00:52.446000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('475', null, '2018-04-14 16:00:54.670000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('476', null, '2018-04-14 16:00:55.188000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('477', null, '2018-04-14 16:00:56.982000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('478', null, '2018-04-14 16:01:14.987000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('479', null, '2018-04-14 16:01:22.316000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('480', null, '2018-04-14 16:01:28.273000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('481', null, '2018-04-14 16:02:01.431000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('482', null, '2018-04-14 16:03:18.483000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('483', null, '2018-04-14 16:03:22.542000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('484', null, '2018-04-14 16:03:28.412000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('485', null, '2018-04-14 16:03:48.058000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('486', null, '2018-04-14 16:03:53.514000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('487', null, '2018-04-14 16:03:55.921000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('488', null, '2018-04-14 16:04:04.180000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('489', null, '2018-04-14 16:04:22.177000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('490', null, '2018-04-14 16:06:23.203000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('491', null, '2018-04-14 16:07:53.136000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('492', null, '2018-04-14 16:07:55.489000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('493', null, '2018-04-14 16:08:05.436000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('494', null, '2018-04-14 16:08:09.014000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('495', null, '2018-04-14 16:09:14.903000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('496', null, '2018-04-14 16:11:14.291000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('497', null, '2018-04-14 16:11:24.100000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('498', null, '2018-04-14 16:12:23.305000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('499', null, '2018-04-14 16:13:33.025000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('500', null, '2018-04-14 16:13:50.376000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('501', null, '2018-04-14 16:15:39.172000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('502', null, '2018-04-14 16:15:49.875000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('503', null, '2018-04-14 16:15:51.787000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/update/2.htm', '4');
INSERT INTO `t_opt_log` VALUES ('504', null, '2018-04-14 16:15:55.441000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('505', null, '2018-04-14 16:17:05.388000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('506', null, '2018-04-14 16:17:07.735000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('507', null, '2018-04-14 16:17:13.973000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('508', null, '2018-04-14 16:17:17.390000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('509', null, '2018-04-14 16:17:17.517000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('510', null, '2018-04-14 16:19:56.877000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('511', null, '2018-04-14 16:20:03.191000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('512', null, '2018-04-14 16:20:06.796000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('513', null, '2018-04-14 16:20:09.114000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('514', null, '2018-04-14 16:20:15.113000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('515', null, '2018-04-14 16:21:42.366000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('516', null, '2018-04-14 16:21:44.678000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('517', null, '2018-04-14 16:21:51.795000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('518', null, '2018-04-14 16:21:56.500000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('519', null, '2018-04-14 16:21:58.641000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('520', null, '2018-04-14 16:22:00.550000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('521', null, '2018-04-14 16:22:01.384000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('522', null, '2018-04-14 16:22:48.806000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('523', null, '2018-04-14 16:22:50.662000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('524', null, '2018-04-14 16:22:57.446000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('525', null, '2018-04-14 16:23:01.194000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('526', null, '2018-04-14 16:23:13.158000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('527', null, '2018-04-14 16:23:14.498000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('528', null, '2018-04-14 16:23:19.002000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('529', null, '2018-04-14 16:23:21.671000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('530', null, '2018-04-14 16:23:23.735000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('531', null, '2018-04-14 16:25:58.511000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('532', null, '2018-04-14 16:26:03.788000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('533', null, '2018-04-14 16:26:08.730000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('534', null, '2018-04-14 16:26:48.754000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('535', null, '2018-04-14 16:28:05.160000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('536', null, '2018-04-14 16:28:49.062000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('537', null, '2018-04-14 16:30:53.795000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('538', null, '2018-04-14 17:21:10.866000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('539', null, '2018-04-14 17:21:13.317000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('540', null, '2018-04-14 17:21:40.412000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('541', null, '2018-04-14 17:21:45.153000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('542', null, '2018-04-14 17:22:04.566000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('543', null, '2018-04-14 17:22:06.734000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('544', null, '2018-04-14 17:22:07.647000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('545', null, '2018-04-14 17:22:11.700000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('546', null, '2018-04-14 17:22:25.043000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('547', null, '2018-04-14 17:22:27.113000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('548', null, '2018-04-14 17:22:27.892000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('549', null, '2018-04-14 17:22:29.123000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('550', null, '2018-04-14 17:22:44.403000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('551', null, '2018-04-14 17:22:46.663000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('552', null, '2018-04-14 17:22:48.146000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('553', null, '2018-04-14 17:23:00.335000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('554', null, '2018-04-14 17:23:03.813000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('555', null, '2018-04-14 17:24:11.783000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('556', null, '2018-04-14 17:24:14.009000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('557', null, '2018-04-14 17:24:15.884000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('558', null, '2018-04-14 17:25:53.110000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityappraise/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('559', null, '2018-04-14 17:37:47.657000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('560', null, '2018-04-14 17:37:49.649000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('561', null, '2018-04-14 17:37:57.493000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('562', null, '2018-04-14 17:37:59.027000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('563', null, '2018-04-14 17:38:01.109000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('564', null, '2018-04-14 17:38:02.340000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('565', null, '2018-04-14 17:38:05.287000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('566', null, '2018-04-14 17:38:08.115000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('567', null, '2018-04-14 17:38:27.219000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('568', null, '2018-04-14 17:38:29.367000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('569', null, '2018-04-14 17:38:35.740000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('570', null, '2018-04-14 17:38:37.163000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('571', null, '2018-04-14 17:38:39.274000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('572', null, '2018-04-14 17:38:40.793000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('573', null, '2018-04-14 17:38:55.123000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('574', null, '2018-04-14 17:38:57.514000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('575', null, '2018-04-14 17:38:59.527000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('576', null, '2018-04-14 17:39:05.445000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('577', null, '2018-04-14 17:39:52.555000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('578', null, '2018-04-14 17:39:54.661000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('579', null, '2018-04-14 17:39:56.115000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('580', null, '2018-04-14 17:39:57.516000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('581', null, '2018-04-14 17:40:39.753000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('582', null, '2018-04-14 17:41:30.273000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('583', null, '2018-04-14 17:42:44.823000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('584', null, '2018-04-14 17:42:47.490000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('585', null, '2018-04-14 17:42:58.744000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('586', null, '2018-04-14 17:43:08.866000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('587', null, '2018-04-14 17:43:26.601000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('588', null, '2018-04-14 17:43:49.549000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('589', null, '2018-04-14 17:43:55.039000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('590', null, '2018-04-14 17:44:22.114000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('591', null, '2018-04-14 17:44:31.069000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('592', null, '2018-04-14 17:44:46.435000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('593', null, '2018-04-14 17:44:50.257000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/updatePVById/enable/2/1.json', '2');
INSERT INTO `t_opt_log` VALUES ('594', null, '2018-04-14 17:44:53.689000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/updatePVById/enable/1/1.json', '2');
INSERT INTO `t_opt_log` VALUES ('595', null, '2018-04-14 17:45:18.291000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('596', null, '2018-04-14 17:45:26.773000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('597', null, '2018-04-14 17:50:50.862000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('598', null, '2018-04-14 17:50:53.887000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('599', null, '2018-04-14 17:51:38.221000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('600', null, '2018-04-14 17:57:24.573000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('601', null, '2018-04-14 17:57:26.397000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('602', null, '2018-04-14 17:59:04.548000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('603', null, '2018-04-14 17:59:08.739000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('604', null, '2018-04-14 17:59:56.298000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('605', null, '2018-04-14 18:00:01.017000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('606', null, '2018-04-14 18:00:04.081000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('607', null, '2018-04-14 18:05:52.541000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('608', null, '2018-04-14 18:06:33.938000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('609', null, '2018-04-14 18:06:25.848000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('610', null, '2018-04-14 18:06:36.497000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/3.htm', '4');
INSERT INTO `t_opt_log` VALUES ('611', null, '2018-04-14 18:06:38.607000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('612', null, '2018-04-14 18:06:42.543000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('613', null, '2018-04-14 18:06:44.151000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('614', null, '2018-04-14 18:06:53.718000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('615', null, '2018-04-14 18:06:58.804000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('616', null, '2018-04-14 18:07:04.532000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('617', null, '2018-04-14 18:07:05.864000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('618', null, '2018-04-14 18:07:33.208000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('619', null, '2018-04-14 18:08:30.231000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('620', null, '2018-04-14 18:09:27.393000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('621', null, '2018-04-14 18:09:28.485000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('622', null, '2018-04-14 18:09:38.882000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('623', null, '2018-04-14 18:09:45.413000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('624', null, '2018-04-14 18:09:47.091000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('625', null, '2018-04-14 18:10:44.432000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('626', null, '2018-04-14 18:10:47.765000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('627', null, '2018-04-14 18:10:47.941000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('628', null, '2018-04-14 18:10:51.265000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('629', null, '2018-04-16 09:33:12.308000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('630', null, '2018-04-16 09:33:13.980000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('631', null, '2018-04-16 09:53:37.000000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('632', null, '2018-04-16 09:53:40.659000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '1');
INSERT INTO `t_opt_log` VALUES ('633', null, '2018-04-16 09:53:53.869000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('634', null, '2018-04-16 09:57:33.927000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('635', null, '2018-04-16 09:57:45.316000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('636', null, '2018-04-16 09:57:56.039000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('637', null, '2018-04-16 10:00:19.444000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('638', null, '2018-04-16 10:00:22.714000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('639', null, '2018-04-16 10:01:33.795000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('640', null, '2018-04-16 10:01:35.436000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('641', null, '2018-04-16 10:01:47.403000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('642', null, '2018-04-16 10:11:57.663000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('643', null, '2018-04-16 10:12:20.896000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('644', null, '2018-04-16 10:13:05.936000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.json', '1');
INSERT INTO `t_opt_log` VALUES ('645', null, '2018-04-16 10:13:08.007000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('646', null, '2018-04-16 10:15:07.663000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.json', '1');
INSERT INTO `t_opt_log` VALUES ('647', null, '2018-04-16 10:15:09.700000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('648', null, '2018-04-16 10:14:24.310000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('649', null, '2018-04-16 10:14:29.641000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('650', null, '2018-04-16 10:14:47.263000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('651', null, '2018-04-16 10:14:50.105000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('652', null, '2018-04-16 10:15:18.949000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('653', null, '2018-04-16 10:15:25.534000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('654', null, '2018-04-16 10:15:29.937000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('655', null, '2018-04-16 10:16:28.759000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('656', null, '2018-04-16 10:17:05.550000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('657', null, '2018-04-16 10:23:27.708000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('658', null, '2018-04-16 10:24:38.253000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('659', null, '2018-04-16 10:24:45.669000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('660', null, '2018-04-16 10:25:46.267000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('661', null, '2018-04-16 10:26:11.207000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('662', null, '2018-04-16 10:26:12.359000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('663', null, '2018-04-16 10:26:13.406000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('664', null, '2018-04-16 10:27:50.330000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('665', null, '2018-04-16 10:27:52.703000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('666', null, '2018-04-16 10:28:08.950000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('667', null, '2018-04-16 10:28:11.174000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('668', null, '2018-04-16 10:28:26.033000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/update/1.htm', '1');
INSERT INTO `t_opt_log` VALUES ('669', null, '2018-04-16 10:29:03.777000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('670', null, '2018-04-16 10:29:05.989000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/update/1.htm', '1');
INSERT INTO `t_opt_log` VALUES ('671', null, '2018-04-16 10:30:00.890000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('672', null, '2018-04-16 10:30:02.947000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/update/1.htm', '1');
INSERT INTO `t_opt_log` VALUES ('673', null, '2018-04-16 10:30:04.515000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('674', null, '2018-04-16 10:30:06.767000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/update/2.htm', '1');
INSERT INTO `t_opt_log` VALUES ('675', null, '2018-04-16 10:30:42.943000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('676', null, '2018-04-16 10:30:44.350000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('677', null, '2018-04-16 10:44:42.464000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('678', null, '2018-04-16 10:47:45.326000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('679', null, '2018-04-16 10:47:47.633000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('680', null, '2018-04-16 10:47:50.624000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('681', null, '2018-04-16 10:48:17.071000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('682', null, '2018-04-16 10:48:23.843000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('683', null, '2018-04-16 10:50:36.657000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('684', null, '2018-04-16 10:50:48.599000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('685', null, '2018-04-16 10:50:51.233000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('686', null, '2018-04-16 10:52:10.999000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/add.json', '1');
INSERT INTO `t_opt_log` VALUES ('687', null, '2018-04-16 10:52:13.052000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('688', null, '2018-04-16 10:52:17.848000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('689', null, '2018-04-16 10:52:19.208000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/update/1.htm', '1');
INSERT INTO `t_opt_log` VALUES ('690', null, '2018-04-16 10:51:33.022000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('691', null, '2018-04-16 10:52:24.038000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('692', null, '2018-04-16 10:52:26.065000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/update/1.htm', '1');
INSERT INTO `t_opt_log` VALUES ('693', null, '2018-04-16 10:52:29.533000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('694', null, '2018-04-16 10:52:31.558000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/update/1.htm', '1');
INSERT INTO `t_opt_log` VALUES ('695', null, '2018-04-16 10:52:35.117000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('696', null, '2018-04-16 10:52:37.139000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/update/1.htm', '1');
INSERT INTO `t_opt_log` VALUES ('697', null, '2018-04-16 10:51:54.992000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('698', null, '2018-04-16 10:51:59.412000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('699', null, '2018-04-16 10:52:01.795000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('700', null, '2018-04-16 10:52:50.928000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('701', null, '2018-04-16 10:52:52.961000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/update/1.htm', '1');
INSERT INTO `t_opt_log` VALUES ('702', null, '2018-04-16 10:52:53.966000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('703', null, '2018-04-16 10:52:13.785000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('704', null, '2018-04-16 10:53:00.967000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('705', null, '2018-04-16 10:53:05.963000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/add.json', '1');
INSERT INTO `t_opt_log` VALUES ('706', null, '2018-04-16 10:53:08.000000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('707', null, '2018-04-16 10:53:13.423000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/add.json', '1');
INSERT INTO `t_opt_log` VALUES ('708', null, '2018-04-16 10:53:15.456000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('709', null, '2018-04-16 10:53:18.897000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/add.json', '1');
INSERT INTO `t_opt_log` VALUES ('710', null, '2018-04-16 10:53:20.918000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('711', null, '2018-04-16 10:53:21.730000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('712', null, '2018-04-16 10:53:28.137000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/update/1.htm', '1');
INSERT INTO `t_opt_log` VALUES ('713', null, '2018-04-16 10:53:34.362000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('714', null, '2018-04-16 10:53:50.721000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('715', null, '2018-04-16 10:53:21.338000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('716', null, '2018-04-16 10:53:24.899000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('717', null, '2018-04-16 10:54:11.840000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('718', null, '2018-04-16 10:54:13.776000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('719', null, '2018-04-16 10:54:16.112000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('720', null, '2018-04-16 10:54:19.205000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('721', null, '2018-04-16 10:53:35.225000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('722', null, '2018-04-16 10:53:39.717000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('723', null, '2018-04-16 10:54:12.378000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('724', null, '2018-04-16 10:54:17.395000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('725', null, '2018-04-16 10:54:23.487000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('726', null, '2018-04-16 10:54:26.018000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('727', null, '2018-04-16 10:54:30.462000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('728', null, '2018-04-16 10:54:35.517000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('729', null, '2018-04-16 10:54:38.009000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('730', null, '2018-04-16 10:54:41.360000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('731', null, '2018-04-16 10:54:44.701000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('732', null, '2018-04-16 10:54:51.973000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('733', null, '2018-04-16 10:54:56.062000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('734', null, '2018-04-16 10:55:32.104000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('735', null, '2018-04-16 10:55:37.100000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('736', null, '2018-04-16 10:55:44.750000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('737', null, '2018-04-16 10:55:46.526000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('738', null, '2018-04-16 10:56:28.054000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('739', null, '2018-04-16 10:56:35.238000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('740', null, '2018-04-16 10:58:33.121000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('741', null, '2018-04-16 11:00:29.702000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('742', null, '2018-04-16 11:00:32.705000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('743', null, '2018-04-16 11:01:30.908000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('744', null, '2018-04-16 11:01:41.997000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('745', null, '2018-04-16 11:02:27.083000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('746', null, '2018-04-16 11:02:53.946000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('747', null, '2018-04-16 11:04:32.916000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('748', null, '2018-04-16 11:04:36.011000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('749', null, '2018-04-16 11:06:08.414000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('750', null, '2018-04-16 11:06:12.878000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('751', null, '2018-04-16 11:05:27.978000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('752', null, '2018-04-16 11:05:42.523000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('753', null, '2018-04-16 11:06:00.773000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('754', null, '2018-04-16 11:06:06.782000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('755', null, '2018-04-16 11:07:07.924000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('756', null, '2018-04-16 11:07:08.986000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('757', null, '2018-04-16 11:07:10.953000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('758', null, '2018-04-16 11:07:13.444000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/update/1.htm', '1');
INSERT INTO `t_opt_log` VALUES ('759', null, '2018-04-16 11:07:18.620000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('760', null, '2018-04-16 11:07:19.613000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('761', null, '2018-04-16 11:07:21.831000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/update/2.htm', '1');
INSERT INTO `t_opt_log` VALUES ('762', null, '2018-04-16 11:07:27.732000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('763', null, '2018-04-16 11:07:28.593000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('764', null, '2018-04-16 11:07:01.285000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('765', null, '2018-04-16 11:07:03.893000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('766', null, '2018-04-16 11:07:50.153000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('767', null, '2018-04-16 11:08:42.386000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('768', null, '2018-04-16 11:11:30.966000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.json', '1');
INSERT INTO `t_opt_log` VALUES ('769', null, '2018-04-16 11:11:32.681000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('770', null, '2018-04-16 11:11:12.930000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('771', null, '2018-04-16 11:11:15.557000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('772', null, '2018-04-16 11:12:08.170000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('773', null, '2018-04-16 11:12:13.751000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('774', null, '2018-04-16 11:14:00.554000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('775', null, '2018-04-16 11:14:11.005000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('776', null, '2018-04-16 11:20:41.421000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('777', null, '2018-04-16 11:20:46.357000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('778', null, '2018-04-16 11:20:48.959000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('779', null, '2018-04-16 11:21:32.463000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('780', null, '2018-04-16 11:21:43.877000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('781', null, '2018-04-16 11:22:53.229000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('782', null, '2018-04-16 11:22:18.480000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('783', null, '2018-04-16 11:23:00.042000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('784', null, '2018-04-16 11:23:09.514000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('785', null, '2018-04-16 11:23:11.944000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('786', null, '2018-04-16 11:23:20.027000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('787', null, '2018-04-16 11:24:45.831000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('788', null, '2018-04-16 11:24:48.459000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/1/15.htmk=', '1');
INSERT INTO `t_opt_log` VALUES ('789', null, '2018-04-16 11:24:50.106000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/2/1/15.htmk=', '1');
INSERT INTO `t_opt_log` VALUES ('790', null, '2018-04-16 11:24:51.833000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/3/1/15.htmk=', '1');
INSERT INTO `t_opt_log` VALUES ('791', null, '2018-04-16 11:24:55.101000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/4/1/15.htmk=', '1');
INSERT INTO `t_opt_log` VALUES ('792', null, '2018-04-16 11:24:57.031000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htmk=', '1');
INSERT INTO `t_opt_log` VALUES ('793', null, '2018-04-16 11:25:18.084000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htmk=', '1');
INSERT INTO `t_opt_log` VALUES ('794', null, '2018-04-16 11:26:12.616000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('795', null, '2018-04-16 11:26:14.983000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('796', null, '2018-04-16 11:26:58.779000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('797', null, '2018-04-16 11:27:47.327000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('798', null, '2018-04-16 11:28:33.515000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('799', null, '2018-04-16 11:28:46.690000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('800', null, '2018-04-16 11:28:50.734000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('801', null, '2018-04-16 11:29:20.380000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('802', null, '2018-04-16 11:31:04.273000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('803', null, '2018-04-16 11:31:06.376000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('804', null, '2018-04-16 11:32:00.295000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('805', null, '2018-04-16 11:32:56.018000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('806', null, '2018-04-16 11:33:11.453000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('807', null, '2018-04-16 11:34:16.550000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('808', null, '2018-04-16 11:34:45.293000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('809', null, '2018-04-16 11:43:19.233000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('810', null, '2018-04-16 11:46:10.500000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/3/1/15.htmk=', '1');
INSERT INTO `t_opt_log` VALUES ('811', null, '2018-04-16 11:46:12.148000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/4/1/15.htmk=', '1');
INSERT INTO `t_opt_log` VALUES ('812', null, '2018-04-16 11:46:13.931000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htmk=', '1');
INSERT INTO `t_opt_log` VALUES ('813', null, '2018-04-16 11:46:15.244000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/1/15.htmk=', '1');
INSERT INTO `t_opt_log` VALUES ('814', null, '2018-04-16 11:46:16.849000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/2/1/15.htmk=', '1');
INSERT INTO `t_opt_log` VALUES ('815', null, '2018-04-16 11:45:31.334000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('816', null, '2018-04-16 11:46:19.149000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/3/1/15.htmk=', '1');
INSERT INTO `t_opt_log` VALUES ('817', null, '2018-04-16 11:47:11.293000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('818', null, '2018-04-16 11:51:07.313000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('819', null, '2018-04-16 11:52:43.094000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('820', null, '2018-04-16 11:53:01.175000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('821', null, '2018-04-16 11:54:28.037000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('822', null, '2018-04-16 11:55:26.343000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('823', null, '2018-04-16 11:58:10.925000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('824', null, '2018-04-16 11:58:13.507000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('825', null, '2018-04-16 11:58:57.306000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('826', null, '2018-04-16 12:00:09.947000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('827', null, '2018-04-16 12:00:33.519000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('828', null, '2018-04-16 12:01:50.442000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('829', null, '2018-04-16 12:06:56.152000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('830', null, '2018-04-16 12:07:42.699000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('831', null, '2018-04-16 12:08:32.841000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('832', null, '2018-04-16 12:08:34.624000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/3/1/15.htmk=', '1');
INSERT INTO `t_opt_log` VALUES ('833', null, '2018-04-16 12:08:37.373000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/1/1/15.htmk=', '1');
INSERT INTO `t_opt_log` VALUES ('834', null, '2018-04-16 12:07:56.070000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('835', null, '2018-04-16 12:08:03.208000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('836', null, '2018-04-16 12:08:04.632000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('837', null, '2018-04-16 12:08:07.440000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('838', null, '2018-04-16 12:09:44.975000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('839', null, '2018-04-16 12:12:18.937000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('840', null, '2018-04-16 13:42:11.056000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('841', null, '2018-04-16 13:42:17.858000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('842', null, '2018-04-16 13:42:20.385000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('843', null, '2018-04-16 13:42:22.679000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('844', null, '2018-04-16 13:42:28.453000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('845', null, '2018-04-16 13:42:32.878000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('846', null, '2018-04-16 13:42:33.542000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('847', null, '2018-04-16 13:42:36.480000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('848', null, '2018-04-16 13:42:40.299000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('849', null, '2018-04-16 13:42:50.905000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('850', null, '2018-04-16 13:42:52.681000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('851', null, '2018-04-16 13:43:44.031000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('852', null, '2018-04-16 13:44:28.034000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('853', null, '2018-04-16 13:44:30.227000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('854', null, '2018-04-16 13:52:28.153000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('855', null, '2018-04-16 13:52:30.239000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('856', null, '2018-04-16 13:52:37.280000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('857', null, '2018-04-16 13:52:43.967000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('858', null, '2018-04-16 13:53:09.940000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('859', null, '2018-04-16 13:53:15.491000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('860', null, '2018-04-16 14:00:38.983000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('861', null, '2018-04-16 14:00:41.857000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('862', null, '2018-04-16 14:02:21.106000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('863', null, '2018-04-16 14:02:26.812000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('864', null, '2018-04-16 14:03:23.862000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('865', null, '2018-04-16 14:06:21.514000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('866', null, '2018-04-16 14:06:34.228000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('867', null, '2018-04-16 14:29:40.941000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('868', null, '2018-04-16 14:29:58.906000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('869', null, '2018-04-16 14:30:05.538000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('870', null, '2018-04-16 14:30:07.893000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('871', null, '2018-04-16 14:30:27.417000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('872', null, '2018-04-16 14:43:28.511000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('873', null, '2018-04-16 14:43:34.665000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('874', null, '2018-04-16 14:43:42.426000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('875', null, '2018-04-16 14:43:44.528000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('876', null, '2018-04-16 14:44:57.058000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('877', null, '2018-04-16 14:45:04.012000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('878', null, '2018-04-16 14:45:09.173000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('879', null, '2018-04-16 14:45:13.188000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('880', null, '2018-04-16 14:45:58.394000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('881', null, '2018-04-16 14:46:00.367000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('882', null, '2018-04-16 14:46:08.716000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('883', null, '2018-04-16 14:49:29.698000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('884', null, '2018-04-16 14:49:40.963000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('885', null, '2018-04-16 14:49:43.518000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('886', null, '2018-04-16 14:49:45.573000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('887', null, '2018-04-16 14:49:48.086000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('888', null, '2018-04-16 14:55:03.021000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('889', null, '2018-04-16 14:55:08.150000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('890', null, '2018-04-16 14:55:11.836000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('891', null, '2018-04-16 14:55:19.620000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('892', null, '2018-04-16 14:55:22.215000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('893', null, '2018-04-16 14:55:26.854000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('894', null, '2018-04-16 14:55:29.305000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('895', null, '2018-04-16 14:55:32.753000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('896', null, '2018-04-16 14:55:45.177000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('897', null, '2018-04-16 14:55:47.713000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('898', null, '2018-04-16 14:55:51.515000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('899', null, '2018-04-16 14:55:54.767000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('900', null, '2018-04-16 14:55:57.081000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('901', null, '2018-04-16 14:56:02.939000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('902', null, '2018-04-16 14:56:05.294000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('903', null, '2018-04-16 14:56:11.232000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('904', null, '2018-04-16 14:56:13.619000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('905', null, '2018-04-16 14:56:18.881000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('906', null, '2018-04-16 14:56:22.796000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('907', null, '2018-04-16 14:57:02.404000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('908', null, '2018-04-16 14:57:04.977000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('909', null, '2018-04-16 14:57:41.205000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('910', null, '2018-04-16 14:57:43.924000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('911', null, '2018-04-16 14:57:46.009000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('912', null, '2018-04-16 14:58:07.417000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('913', null, '2018-04-16 14:58:42.063000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('914', null, '2018-04-16 14:58:44.446000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('915', null, '2018-04-16 14:58:47.301000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('916', null, '2018-04-16 14:58:47.735000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('917', null, '2018-04-16 14:59:17.466000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('918', null, '2018-04-16 14:59:22.581000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('919', null, '2018-04-16 14:59:27.145000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('920', null, '2018-04-16 14:59:37.062000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('921', null, '2018-04-16 15:00:24.205000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('922', null, '2018-04-16 15:00:32.716000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('923', null, '2018-04-16 15:00:57.449000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('924', null, '2018-04-16 15:01:48.729000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('925', null, '2018-04-16 15:02:18.830000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('926', null, '2018-04-16 15:02:21.029000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('927', null, '2018-04-16 15:02:23.785000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('928', null, '2018-04-16 15:02:27.589000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/4.htm', '2');
INSERT INTO `t_opt_log` VALUES ('929', null, '2018-04-16 15:02:30.089000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('930', null, '2018-04-16 15:05:27.029000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('931', null, '2018-04-16 15:06:40.110000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('932', null, '2018-04-16 15:06:42.960000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/2.htm', '4');
INSERT INTO `t_opt_log` VALUES ('933', null, '2018-04-16 15:06:45.400000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('934', null, '2018-04-16 15:06:48.262000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('935', null, '2018-04-16 15:06:50.194000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('936', null, '2018-04-16 15:06:51.077000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('937', null, '2018-04-16 15:06:52.823000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/3.htm', '4');
INSERT INTO `t_opt_log` VALUES ('938', null, '2018-04-16 15:06:54.863000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('939', null, '2018-04-16 15:06:56.896000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/3.htm', '4');
INSERT INTO `t_opt_log` VALUES ('940', null, '2018-04-16 15:06:59.832000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('941', null, '2018-04-16 15:07:07.391000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('942', null, '2018-04-16 15:07:22.024000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('943', null, '2018-04-16 15:07:24.175000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('944', null, '2018-04-16 15:07:24.771000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('945', null, '2018-04-16 15:07:27.859000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('946', null, '2018-04-16 15:07:29.921000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('947', null, '2018-04-16 15:07:31.686000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('948', null, '2018-04-16 15:07:36.683000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('949', null, '2018-04-16 15:07:38.978000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/deleteById/4.json', '4');
INSERT INTO `t_opt_log` VALUES ('950', null, '2018-04-16 15:07:40.103000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('951', null, '2018-04-16 15:08:03.868000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/3.htm', '4');
INSERT INTO `t_opt_log` VALUES ('952', null, '2018-04-16 15:08:39.490000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('953', null, '2018-04-16 15:08:53.916000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/2.htm', '4');
INSERT INTO `t_opt_log` VALUES ('954', null, '2018-04-16 15:09:00.388000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/3.htm', '4');
INSERT INTO `t_opt_log` VALUES ('955', null, '2018-04-16 15:09:04.710000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('956', null, '2018-04-16 15:09:10.279000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/5.htm', '4');
INSERT INTO `t_opt_log` VALUES ('957', null, '2018-04-16 15:11:18.762000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('958', null, '2018-04-16 15:12:15.976000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('959', null, '2018-04-16 15:12:51.311000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('960', null, '2018-04-16 15:13:33.321000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('961', null, '2018-04-16 15:13:39.643000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('962', null, '2018-04-16 15:14:01.981000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('963', null, '2018-04-16 15:16:45.773000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('964', null, '2018-04-16 15:16:49.765000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('965', null, '2018-04-16 15:17:13.925000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('966', null, '2018-04-16 15:18:31.245000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('967', null, '2018-04-16 15:18:35.359000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('968', null, '2018-04-16 15:18:37.001000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('969', null, '2018-04-16 15:18:39.245000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('970', null, '2018-04-16 15:18:41.120000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('971', null, '2018-04-16 15:18:43.010000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('972', null, '2018-04-16 15:18:43.555000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('973', null, '2018-04-16 15:18:45.859000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('974', null, '2018-04-16 15:18:48.808000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('975', null, '2018-04-16 15:18:51.813000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('976', null, '2018-04-16 15:18:57.925000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('977', null, '2018-04-16 15:19:02.460000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('978', null, '2018-04-16 15:19:08.806000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('979', null, '2018-04-16 15:19:10.747000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('980', null, '2018-04-16 15:19:13.728000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('981', null, '2018-04-16 15:19:16.256000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityappraise/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('982', null, '2018-04-16 15:19:29.578000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityappraise/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('983', null, '2018-04-16 15:19:30.911000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('984', null, '2018-04-16 15:25:45.891000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('985', null, '2018-04-16 15:25:50.995000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('986', null, '2018-04-16 15:25:52.654000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('987', null, '2018-04-16 15:25:53.511000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('988', null, '2018-04-16 15:25:55.470000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('989', null, '2018-04-16 15:25:57.313000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('990', null, '2018-04-16 15:25:58.187000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('991', null, '2018-04-16 15:26:00.562000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('992', null, '2018-04-16 15:27:03.264000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('993', null, '2018-04-16 15:27:05.618000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('994', null, '2018-04-16 15:31:00.170000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('995', null, '2018-04-16 15:31:02.017000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('996', null, '2018-04-16 15:31:03.987000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('997', null, '2018-04-16 15:31:58.498000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('998', null, '2018-04-16 15:32:32.204000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('999', null, '2018-04-16 15:32:34.208000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1000', null, '2018-04-16 15:32:45.077000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1001', null, '2018-04-16 15:35:17.517000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1002', null, '2018-04-16 15:35:20.587000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1003', null, '2018-04-16 15:37:34.904000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1004', null, '2018-04-16 15:37:37.519000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1005', null, '2018-04-16 15:37:42.177000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1006', null, '2018-04-16 15:37:44.073000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1007', null, '2018-04-16 15:37:57.162000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1008', null, '2018-04-16 15:38:02.159000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1009', null, '2018-04-16 15:38:09.415000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1010', null, '2018-04-16 15:38:10.581000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1011', null, '2018-04-16 15:38:12.546000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1012', null, '2018-04-16 15:38:19.826000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1013', null, '2018-04-16 15:38:20.887000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1014', null, '2018-04-16 15:38:31.238000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1015', null, '2018-04-16 15:38:36.123000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1016', null, '2018-04-16 15:39:02.206000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1017', null, '2018-04-16 15:39:18.959000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1018', null, '2018-04-16 15:39:23.657000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1019', null, '2018-04-16 15:39:26.009000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1020', null, '2018-04-16 15:39:27.689000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1021', null, '2018-04-16 15:39:32.010000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1022', null, '2018-04-16 15:39:35.571000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1023', null, '2018-04-16 15:39:40.205000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1024', null, '2018-04-16 15:39:41.330000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1025', null, '2018-04-16 15:39:46.077000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1026', null, '2018-04-16 15:39:55.104000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1027', null, '2018-04-16 15:39:57.588000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1028', null, '2018-04-16 15:40:16.817000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1029', null, '2018-04-16 15:40:19.296000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1030', null, '2018-04-16 15:40:22.516000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1031', null, '2018-04-16 15:56:25.237000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1032', null, '2018-04-16 15:56:39.213000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1033', null, '2018-04-16 15:57:01.752000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1034', null, '2018-04-16 15:59:30.657000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1035', null, '2018-04-16 15:59:32.115000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1036', null, '2018-04-16 15:59:34.544000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1037', null, '2018-04-16 16:00:08.828000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1038', null, '2018-04-16 16:07:03.912000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1039', null, '2018-04-16 16:07:07.422000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1040', null, '2018-04-16 16:07:23.535000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1041', null, '2018-04-16 16:07:54.080000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1042', null, '2018-04-16 16:08:15.907000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1043', null, '2018-04-16 16:14:50.568000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1044', null, '2018-04-16 16:16:11.626000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityappraise/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1045', null, '2018-04-16 16:16:14.417000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1046', null, '2018-04-16 16:16:16.837000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1047', null, '2018-04-16 16:16:22.838000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1048', null, '2018-04-16 16:16:26.512000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1049', null, '2018-04-16 16:16:30.559000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1050', null, '2018-04-16 16:16:35.914000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1051', null, '2018-04-16 16:16:43.620000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1052', null, '2018-04-16 16:21:15.508000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1053', null, '2018-04-16 16:22:34.085000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1054', null, '2018-04-16 16:22:38.834000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1055', null, '2018-04-16 16:22:54.817000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1056', null, '2018-04-16 16:23:52.618000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1057', null, '2018-04-16 16:27:29.344000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1058', null, '2018-04-16 16:27:31.399000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1059', null, '2018-04-16 16:28:08.918000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1060', null, '2018-04-16 16:31:04.899000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1061', null, '2018-04-16 16:33:23.878000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1062', null, '2018-04-16 16:39:11.320000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1063', null, '2018-04-16 16:54:25.991000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1064', null, '2018-04-16 16:56:47.394000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1065', null, '2018-04-16 17:04:11.236000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1066', null, '2018-04-16 17:04:50.987000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1067', null, '2018-04-16 17:05:14.268000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1068', null, '2018-04-16 17:05:50.219000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1069', null, '2018-04-16 17:06:11.579000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1070', null, '2018-04-16 17:06:54.803000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1071', null, '2018-04-16 17:08:44.887000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1072', null, '2018-04-16 17:10:21.013000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1073', null, '2018-04-16 17:18:53.417000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1074', null, '2018-04-16 17:19:21.397000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1075', null, '2018-04-16 17:19:50.138000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1076', null, '2018-04-16 17:27:16.850000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1077', null, '2018-04-16 17:27:36.859000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1078', null, '2018-04-16 17:33:56.482000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1079', null, '2018-04-16 17:35:43.127000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1080', null, '2018-04-16 17:35:46.331000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1081', null, '2018-04-16 17:35:48.252000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1082', null, '2018-04-16 17:35:50.553000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1083', null, '2018-04-16 17:35:51.985000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1084', null, '2018-04-16 17:36:16.564000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1085', null, '2018-04-16 17:41:47.349000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1086', null, '2018-04-16 17:41:54.208000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1087', null, '2018-04-16 17:42:00.177000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1088', null, '2018-04-16 17:42:28.687000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/updatePVById/enable/1/2.json', '2');
INSERT INTO `t_opt_log` VALUES ('1089', null, '2018-04-16 17:44:22.009000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1090', null, '2018-04-16 17:44:25.277000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1091', null, '2018-04-16 17:44:27.794000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1092', null, '2018-04-16 17:44:28.770000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1093', null, '2018-04-16 17:44:30.822000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1094', null, '2018-04-16 17:44:33.492000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1095', null, '2018-04-16 17:44:35.221000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityappraise/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1096', null, '2018-04-16 17:44:40.747000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1097', null, '2018-04-16 18:09:20.810000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1098', null, '2018-04-16 18:09:28.820000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1099', null, '2018-04-16 18:09:31.362000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1100', null, '2018-04-16 18:09:36.387000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1101', null, '2018-04-16 18:09:40.836000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1102', null, '2018-04-16 18:09:41.995000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1103', null, '2018-04-16 18:09:59.730000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1104', null, '2018-04-16 18:10:03.404000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1105', null, '2018-04-16 18:10:08.159000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1106', null, '2018-04-16 18:10:12.564000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1107', null, '2018-04-16 18:10:55.810000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1108', null, '2018-04-17 09:04:00.438000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1109', null, '2018-04-17 09:04:02.737000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1110', null, '2018-04-17 09:04:22.503000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1111', null, '2018-04-17 09:04:28.388000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1112', null, '2018-04-17 09:07:32.064000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1113', null, '2018-04-17 09:11:00.243000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1114', null, '2018-04-17 09:14:04.605000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1115', null, '2018-04-17 09:15:06.849000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1116', null, '2018-04-17 09:15:09.383000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1117', null, '2018-04-17 09:15:31.476000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1118', null, '2018-04-17 09:19:30.322000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1119', null, '2018-04-17 09:19:34.519000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1120', null, '2018-04-17 09:19:42.198000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1121', null, '2018-04-17 09:20:36.544000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1122', null, '2018-04-17 09:20:39.543000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1123', null, '2018-04-17 09:21:06.984000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1124', null, '2018-04-17 09:21:44.626000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1125', null, '2018-04-17 09:23:18.841000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1126', null, '2018-04-17 09:29:13.139000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1127', null, '2018-04-17 09:29:17.295000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1128', null, '2018-04-17 09:30:20.324000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('1129', null, '2018-04-17 09:30:26.497000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1130', null, '2018-04-17 09:30:34.538000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1131', null, '2018-04-17 09:30:39.656000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1132', null, '2018-04-17 09:30:59.122000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1133', null, '2018-04-17 09:32:46.378000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1134', null, '2018-04-17 09:32:52.900000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1135', null, '2018-04-17 09:35:47.251000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.json', '1');
INSERT INTO `t_opt_log` VALUES ('1136', null, '2018-04-17 09:35:49.298000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1137', null, '2018-04-17 09:35:50.542000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1138', null, '2018-04-17 09:35:52.181000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1139', null, '2018-04-17 09:36:09.943000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1140', null, '2018-04-17 09:36:24.427000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1141', null, '2018-04-17 09:36:58.612000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1142', null, '2018-04-17 09:37:01.671000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1143', null, '2018-04-17 09:37:12.310000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1144', null, '2018-04-17 09:37:34.720000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1145', null, '2018-04-17 09:37:42.429000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1146', null, '2018-04-17 09:37:43.410000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1147', null, '2018-04-17 09:37:46.344000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1148', null, '2018-04-17 09:38:20.030000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1149', null, '2018-04-17 09:38:28.817000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1150', null, '2018-04-17 09:38:49.898000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1151', null, '2018-04-17 09:38:53.478000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1152', null, '2018-04-17 09:38:56.848000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1153', null, '2018-04-17 09:39:07.210000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1154', null, '2018-04-17 09:39:09.407000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1155', null, '2018-04-17 09:39:14.211000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1156', null, '2018-04-17 09:39:19.691000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1157', null, '2018-04-17 09:42:22.610000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1158', null, '2018-04-17 09:42:25.203000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1159', null, '2018-04-17 09:42:27.807000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1160', null, '2018-04-17 09:42:36.822000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1161', null, '2018-04-17 09:42:37.844000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1162', null, '2018-04-17 09:42:42.750000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1163', null, '2018-04-17 09:43:05.997000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1164', null, '2018-04-17 09:43:07.995000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1165', null, '2018-04-17 09:43:12.590000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1166', null, '2018-04-17 09:43:13.630000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1167', null, '2018-04-17 09:43:28.264000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1168', null, '2018-04-17 09:43:29.540000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1169', null, '2018-04-17 09:43:34.300000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1170', null, '2018-04-17 09:44:00.236000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1171', null, '2018-04-17 09:44:01.771000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1172', null, '2018-04-17 09:44:03.365000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1173', null, '2018-04-17 09:44:07.504000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1174', null, '2018-04-17 09:44:08.982000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1175', null, '2018-04-17 09:44:10.207000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1176', null, '2018-04-17 09:44:12.789000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1177', null, '2018-04-17 09:44:19.740000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1178', null, '2018-04-17 09:44:25.444000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1179', null, '2018-04-17 09:44:31.040000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1180', null, '2018-04-17 09:44:33.979000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1181', null, '2018-04-17 09:44:34.555000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1182', null, '2018-04-17 09:44:36.371000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1183', null, '2018-04-17 09:46:29.014000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1184', null, '2018-04-17 09:47:07.976000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityappraise/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1185', null, '2018-04-17 09:47:17.138000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityappraise/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1186', null, '2018-04-17 09:47:40.048000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/loginlog/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1187', null, '2018-04-17 09:47:56.636000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/loginlog/list/7/15.htmk=', '2');
INSERT INTO `t_opt_log` VALUES ('1188', null, '2018-04-17 09:48:00.390000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1189', null, '2018-04-17 09:48:24.310000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1190', null, '2018-04-17 09:52:01.200000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1191', null, '2018-04-17 09:52:49.982000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1192', null, '2018-04-17 09:53:25.708000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1193', null, '2018-04-17 09:53:31.880000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1194', null, '2018-04-17 09:53:39.519000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1195', null, '2018-04-17 10:02:11.659000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1196', null, '2018-04-17 10:12:58.793000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1197', null, '2018-04-17 10:13:04.733000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1198', null, '2018-04-17 10:13:46.326000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1199', null, '2018-04-17 10:17:05.030000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1200', null, '2018-04-17 10:17:07.789000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1201', null, '2018-04-17 10:18:24.687000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('1202', null, '2018-04-17 10:18:51.511000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1203', null, '2018-04-17 10:19:05.491000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('1204', null, '2018-04-17 10:19:29.391000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1205', null, '2018-04-17 10:19:37.403000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1206', null, '2018-04-17 10:19:41.086000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1207', null, '2018-04-17 10:20:31.075000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1208', null, '2018-04-17 10:25:14.236000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1209', null, '2018-04-17 10:27:31.102000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1210', null, '2018-04-17 10:28:01.316000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1211', null, '2018-04-17 10:33:42.259000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1212', null, '2018-04-17 10:33:50.752000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1213', null, '2018-04-17 10:34:20.568000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('1214', null, '2018-04-17 10:34:46.826000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1215', null, '2018-04-17 10:34:56.682000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1216', null, '2018-04-17 10:35:01.574000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1217', null, '2018-04-17 10:35:09.569000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('1218', null, '2018-04-17 10:35:14.720000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1219', null, '2018-04-17 10:35:20.678000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1220', null, '2018-04-17 10:35:23.578000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/2.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1221', null, '2018-04-17 10:35:26.669000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/3.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1222', null, '2018-04-17 10:35:34.582000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('1223', null, '2018-04-17 10:35:36.678000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/3.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1224', null, '2018-04-17 10:37:19.839000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1225', null, '2018-04-17 10:38:14.414000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1226', null, '2018-04-17 10:38:15.254000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1227', null, '2018-04-17 10:37:41.954000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1228', null, '2018-04-17 10:37:47.681000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1229', null, '2018-04-17 10:37:52.906000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1230', null, '2018-04-17 10:38:30.916000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1231', null, '2018-04-17 10:39:36.749000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1232', null, '2018-04-17 10:41:03.977000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1233', null, '2018-04-17 10:44:30.850000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1234', null, '2018-04-17 10:44:33.718000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1235', null, '2018-04-17 10:44:51.930000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('1236', null, '2018-04-17 10:44:56.520000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1237', null, '2018-04-17 10:44:58.364000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1238', null, '2018-04-17 10:45:12.784000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1239', null, '2018-04-17 10:45:15.019000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1240', null, '2018-04-17 10:45:50.723000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1241', null, '2018-04-17 10:45:53.779000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1242', null, '2018-04-17 10:45:59.552000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1243', null, '2018-04-17 10:46:01.750000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1244', null, '2018-04-17 10:46:03.360000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1245', null, '2018-04-17 10:46:05.810000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1246', null, '2018-04-17 10:46:07.370000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1247', null, '2018-04-17 10:46:15.312000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('1248', null, '2018-04-17 10:46:17.403000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1249', null, '2018-04-17 10:46:17.649000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1250', null, '2018-04-17 10:47:00.781000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1251', null, '2018-04-17 10:47:04.655000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1252', null, '2018-04-17 10:47:09.995000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1253', null, '2018-04-17 10:47:11.046000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1254', null, '2018-04-17 10:47:13.712000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1255', null, '2018-04-17 10:48:17.589000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1256', null, '2018-04-17 10:48:22.715000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1257', null, '2018-04-17 10:48:27.235000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1258', null, '2018-04-17 10:48:32.400000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1259', null, '2018-04-17 10:48:36.989000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1260', null, '2018-04-17 10:48:40.043000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1261', null, '2018-04-17 10:48:41.966000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1262', null, '2018-04-17 10:48:43.662000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1263', null, '2018-04-17 10:49:29.101000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1264', null, '2018-04-17 10:49:31.495000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1265', null, '2018-04-17 10:49:33.127000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1266', null, '2018-04-17 10:49:50.993000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1267', null, '2018-04-17 10:50:05.914000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1268', null, '2018-04-17 10:50:13.663000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1269', null, '2018-04-17 10:50:43.135000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1270', null, '2018-04-17 10:50:56.501000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1271', null, '2018-04-17 10:51:51.978000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1272', null, '2018-04-17 10:52:37.454000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1273', null, '2018-04-17 10:53:12.382000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1274', null, '2018-04-17 10:54:15.977000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1275', null, '2018-04-17 10:55:24.657000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1276', null, '2018-04-17 10:56:58.556000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1277', null, '2018-04-17 10:57:54.708000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1278', null, '2018-04-17 10:58:00.092000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1279', null, '2018-04-17 10:58:05.335000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1280', null, '2018-04-17 10:58:32.279000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('1281', null, '2018-04-17 10:58:34.555000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1282', null, '2018-04-17 10:58:52.735000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('1283', null, '2018-04-17 10:58:54.788000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1284', null, '2018-04-17 10:59:12.362000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('1285', null, '2018-04-17 10:59:14.423000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1286', null, '2018-04-17 10:59:15.480000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1287', null, '2018-04-17 10:59:27.500000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1288', null, '2018-04-17 11:00:29.846000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1289', null, '2018-04-17 11:00:54.015000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1290', null, '2018-04-17 11:04:44.399000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1291', null, '2018-04-17 11:08:11.276000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1292', null, '2018-04-17 11:08:17.320000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1293', null, '2018-04-17 11:10:04.663000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1294', null, '2018-04-17 11:11:37.691000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1295', null, '2018-04-17 11:10:38.377000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1296', null, '2018-04-17 11:11:00.197000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1297', null, '2018-04-17 11:11:02.689000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1298', null, '2018-04-17 11:11:07.018000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1299', null, '2018-04-17 11:11:32.677000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1300', null, '2018-04-17 11:13:56.997000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1301', null, '2018-04-17 11:14:55.152000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1302', null, '2018-04-17 11:17:13.694000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1303', null, '2018-04-17 11:17:54.819000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1304', null, '2018-04-17 11:18:17.368000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1305', null, '2018-04-17 11:19:08.751000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1306', null, '2018-04-17 11:19:40.005000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1307', null, '2018-04-17 11:21:09.477000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1308', null, '2018-04-17 11:22:52.998000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1309', null, '2018-04-17 11:24:04.899000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1310', null, '2018-04-17 11:30:27.480000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1311', null, '2018-04-17 11:31:10.300000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1312', null, '2018-04-17 11:31:29.305000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1313', null, '2018-04-17 11:33:45.920000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1314', null, '2018-04-17 11:34:03.908000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1315', null, '2018-04-17 11:34:09.253000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1316', null, '2018-04-17 11:34:53.117000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1317', null, '2018-04-17 11:36:38.336000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1318', null, '2018-04-17 11:36:43.561000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1319', null, '2018-04-17 11:36:47.791000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1320', null, '2018-04-17 11:36:48.940000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1321', null, '2018-04-17 11:38:23.039000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1322', null, '2018-04-17 11:38:25.855000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1323', null, '2018-04-17 11:38:27.633000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1324', null, '2018-04-17 11:38:28.693000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1325', null, '2018-04-17 11:38:48.981000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1326', null, '2018-04-17 11:39:02.939000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1327', null, '2018-04-17 11:39:07.849000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1328', null, '2018-04-17 11:39:15.495000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1329', null, '2018-04-17 11:41:20.628000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1330', null, '2018-04-17 11:41:26.630000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1331', null, '2018-04-17 11:42:11.868000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1332', null, '2018-04-17 11:42:16.010000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1333', null, '2018-04-17 11:44:31.959000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1334', null, '2018-04-17 11:44:38.786000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1335', null, '2018-04-17 11:45:01.451000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1336', null, '2018-04-17 11:45:06.712000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1337', null, '2018-04-17 11:47:33.851000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1338', null, '2018-04-17 11:50:15.445000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1339', null, '2018-04-17 11:50:20.403000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1340', null, '2018-04-17 11:52:54.934000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1341', null, '2018-04-17 11:52:57.552000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1342', null, '2018-04-17 11:53:20.023000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1343', null, '2018-04-17 11:53:22.829000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1344', null, '2018-04-17 11:54:50.102000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1345', null, '2018-04-17 11:54:52.736000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1346', null, '2018-04-17 11:55:16.761000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1347', null, '2018-04-17 11:55:20.462000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1348', null, '2018-04-17 11:55:32.280000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1349', null, '2018-04-17 11:55:48.512000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1350', null, '2018-04-17 11:56:28.023000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1351', null, '2018-04-17 11:56:30.476000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1352', null, '2018-04-17 11:56:44.342000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1353', null, '2018-04-17 11:56:53.408000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/3.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1354', null, '2018-04-17 11:56:51.759000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1355', null, '2018-04-17 12:00:47.100000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1356', null, '2018-04-17 12:00:50.380000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1357', null, '2018-04-17 12:01:19.666000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1358', null, '2018-04-17 12:01:22.538000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1359', null, '2018-04-17 12:01:24.779000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1360', null, '2018-04-17 12:02:20.124000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1361', null, '2018-04-17 12:02:21.978000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1362', null, '2018-04-17 12:03:36.316000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1363', null, '2018-04-17 12:03:56.170000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1364', null, '2018-04-17 12:05:12.917000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1365', null, '2018-04-17 12:05:15.016000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1366', null, '2018-04-17 12:06:22.308000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1367', null, '2018-04-17 12:06:24.111000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1368', null, '2018-04-17 12:06:54.445000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1369', null, '2018-04-17 12:06:56.465000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1370', null, '2018-04-17 12:08:25.465000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1371', null, '2018-04-17 12:08:27.933000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1372', null, '2018-04-17 12:09:03.523000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1373', null, '2018-04-17 12:09:40.795000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1374', null, '2018-04-17 12:09:43.714000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1375', null, '2018-04-17 12:10:20.908000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1376', null, '2018-04-17 12:10:22.743000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1377', null, '2018-04-17 12:12:16.359000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1378', null, '2018-04-17 13:59:11.063000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1379', null, '2018-04-17 13:59:13.003000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1380', null, '2018-04-17 13:59:46.234000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1381', null, '2018-04-17 13:59:50.487000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1382', null, '2018-04-17 14:00:37.374000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1383', null, '2018-04-17 14:00:40.145000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1384', null, '2018-04-17 14:02:23.112000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1385', null, '2018-04-17 14:02:25.286000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1386', null, '2018-04-17 14:05:19.187000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1387', null, '2018-04-17 14:05:21.292000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1388', null, '2018-04-17 14:05:25.205000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1389', null, '2018-04-17 14:05:29.851000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1390', null, '2018-04-17 14:05:38.821000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1391', null, '2018-04-17 14:06:08.819000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1392', null, '2018-04-17 14:06:10.002000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1393', null, '2018-04-17 14:06:11.551000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1394', null, '2018-04-17 14:06:11.221000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1395', null, '2018-04-17 14:08:58.024000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1396', null, '2018-04-17 14:09:00.163000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1397', null, '2018-04-17 14:09:23.985000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1398', null, '2018-04-17 14:09:55.973000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1399', null, '2018-04-17 14:09:59.061000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1400', null, '2018-04-17 14:10:00.488000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1401', null, '2018-04-17 14:11:17.881000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1402', null, '2018-04-17 14:14:49.694000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/1.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1403', null, '2018-04-17 14:14:53.606000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/2.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1404', null, '2018-04-17 14:14:30.470000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1405', null, '2018-04-17 14:14:37.752000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1406', null, '2018-04-17 14:15:00.963000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1407', null, '2018-04-17 14:15:22.305000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1408', null, '2018-04-17 14:16:40.832000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1409', null, '2018-04-17 14:16:42.561000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1410', null, '2018-04-17 14:17:43.867000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1411', null, '2018-04-17 14:17:47.283000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1412', null, '2018-04-17 14:17:49.034000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1413', null, '2018-04-17 14:17:51.764000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1414', null, '2018-04-17 14:17:54.293000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1415', null, '2018-04-17 14:17:55.960000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1416', null, '2018-04-17 14:18:07.115000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1417', null, '2018-04-17 14:18:09.923000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1418', null, '2018-04-17 14:18:14.797000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1419', null, '2018-04-17 14:18:33.953000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1420', null, '2018-04-17 14:18:36.261000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1421', null, '2018-04-17 14:22:02.330000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1422', null, '2018-04-17 14:22:42.605000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1423', null, '2018-04-17 14:22:44.090000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1424', null, '2018-04-17 14:24:12.181000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1425', null, '2018-04-17 14:24:13.308000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1426', null, '2018-04-17 14:25:50.288000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1427', null, '2018-04-17 14:25:53.207000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1428', null, '2018-04-17 14:27:51.637000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1429', null, '2018-04-17 14:27:53.339000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1430', null, '2018-04-17 14:28:38.999000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1431', null, '2018-04-17 14:28:40.037000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1432', null, '2018-04-17 14:29:06.540000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1433', null, '2018-04-17 14:34:25.904000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1434', null, '2018-04-17 14:34:28.823000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1435', null, '2018-04-17 14:34:32.609000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1436', null, '2018-04-17 14:34:55.770000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1437', null, '2018-04-17 14:35:06.172000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1438', null, '2018-04-17 14:35:09.220000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1439', null, '2018-04-17 14:35:10.773000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1440', null, '2018-04-17 14:35:16.807000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1441', null, '2018-04-17 14:35:21.498000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1442', null, '2018-04-17 14:35:27.708000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1443', null, '2018-04-17 14:35:29.400000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1444', null, '2018-04-17 14:35:34.879000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1445', null, '2018-04-17 14:36:26.686000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1446', null, '2018-04-17 14:36:28.007000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1447', null, '2018-04-17 14:36:42.480000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1448', null, '2018-04-17 14:39:08.161000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1449', null, '2018-04-17 14:40:11.407000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1450', null, '2018-04-17 14:40:14.261000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1451', null, '2018-04-17 14:40:17.415000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1452', null, '2018-04-17 14:40:19.188000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1453', null, '2018-04-17 14:40:35.381000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1454', null, '2018-04-17 14:40:36.566000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1455', null, '2018-04-17 14:41:16.363000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1456', null, '2018-04-17 14:41:19.136000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1457', null, '2018-04-17 14:44:04.982000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1458', null, '2018-04-17 14:44:08.552000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1459', null, '2018-04-17 14:49:49.582000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1460', null, '2018-04-17 14:49:50.412000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1461', null, '2018-04-17 14:50:34.154000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1462', null, '2018-04-17 14:50:36.013000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1463', null, '2018-04-17 14:50:49.014000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1464', null, '2018-04-17 14:50:50.433000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1465', null, '2018-04-17 14:51:03.238000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1466', null, '2018-04-17 14:51:06.309000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1467', null, '2018-04-17 14:52:06.652000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1468', null, '2018-04-17 14:52:08.427000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1469', null, '2018-04-17 14:52:52.518000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1470', null, '2018-04-17 14:52:52.010000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1471', null, '2018-04-17 14:52:58.164000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1472', null, '2018-04-17 14:53:02.214000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1473', null, '2018-04-17 14:53:36.967000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1474', null, '2018-04-17 14:53:38.466000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1475', null, '2018-04-17 14:54:53.848000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1476', null, '2018-04-17 14:55:24.844000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1477', null, '2018-04-17 14:57:24.471000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1478', null, '2018-04-17 14:57:25.800000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1479', null, '2018-04-17 14:57:45.335000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1480', null, '2018-04-17 14:58:03.182000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1481', null, '2018-04-17 14:59:00.863000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1482', null, '2018-04-17 14:59:02.041000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1483', null, '2018-04-17 14:59:25.758000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1484', null, '2018-04-17 14:59:50.431000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1485', null, '2018-04-17 15:00:53.135000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1486', null, '2018-04-17 15:00:54.352000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1487', null, '2018-04-17 15:01:17.031000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1488', null, '2018-04-17 15:01:58.916000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1489', null, '2018-04-17 15:01:59.733000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1490', null, '2018-04-17 15:02:05.293000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1491', null, '2018-04-17 15:02:11.768000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1492', null, '2018-04-17 15:02:14.896000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1493', null, '2018-04-17 15:03:13.961000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1494', null, '2018-04-17 15:03:15.756000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1495', null, '2018-04-17 15:04:00.556000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1496', null, '2018-04-17 15:04:02.505000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1497', null, '2018-04-17 15:04:27.316000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1498', null, '2018-04-17 15:04:39.955000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1499', null, '2018-04-17 15:05:30.013000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1500', null, '2018-04-17 15:05:31.706000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1501', null, '2018-04-17 15:06:41.643000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1502', null, '2018-04-17 15:06:46.071000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1503', null, '2018-04-17 15:06:58.799000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1504', null, '2018-04-17 15:06:59.900000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1505', null, '2018-04-17 15:07:53.207000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1506', null, '2018-04-17 15:08:01.424000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1507', null, '2018-04-17 15:08:38.064000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1508', null, '2018-04-17 15:08:39.543000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1509', null, '2018-04-17 15:12:02.069000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1510', null, '2018-04-17 15:12:03.309000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1511', null, '2018-04-17 15:14:16.317000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1512', null, '2018-04-17 15:14:39.826000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1513', null, '2018-04-17 15:15:31.150000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1514', null, '2018-04-17 15:15:50.507000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1515', null, '2018-04-17 15:16:21.710000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1516', null, '2018-04-17 15:16:36.003000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1517', null, '2018-04-17 15:16:49.706000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1518', null, '2018-04-17 15:17:06.592000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1519', null, '2018-04-17 15:17:08.017000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1520', null, '2018-04-17 15:17:12.831000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1521', null, '2018-04-17 15:17:53.072000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1522', null, '2018-04-17 15:19:16.826000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1523', null, '2018-04-17 15:19:18.015000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1524', null, '2018-04-17 15:23:14.607000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1525', null, '2018-04-17 15:23:16.036000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1526', null, '2018-04-17 15:23:43.256000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1527', null, '2018-04-17 15:23:45.026000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1528', null, '2018-04-17 15:24:43.035000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1529', null, '2018-04-17 15:24:44.279000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1530', null, '2018-04-17 15:27:49.697000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1531', null, '2018-04-17 15:27:50.883000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1532', null, '2018-04-17 15:28:01.359000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1533', null, '2018-04-17 15:28:05.622000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1534', null, '2018-04-17 15:28:35.574000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1535', null, '2018-04-17 15:29:03.253000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1536', null, '2018-04-17 15:29:04.344000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1537', null, '2018-04-17 15:29:46.772000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1538', null, '2018-04-17 15:29:48.175000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1539', null, '2018-04-17 15:30:45.392000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1540', null, '2018-04-17 15:30:46.825000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1541', null, '2018-04-17 15:31:19.443000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1542', null, '2018-04-17 15:31:21.058000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1543', null, '2018-04-17 15:32:28.343000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1544', null, '2018-04-17 15:32:48.213000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1545', null, '2018-04-17 15:33:40.134000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1546', null, '2018-04-17 15:33:41.750000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1547', null, '2018-04-17 15:33:44.580000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1548', null, '2018-04-17 15:34:09.031000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1549', null, '2018-04-17 15:35:04.710000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1550', null, '2018-04-17 15:35:04.952000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1551', null, '2018-04-17 15:35:05.844000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1552', null, '2018-04-17 15:35:07.083000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1553', null, '2018-04-17 15:35:52.664000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1554', null, '2018-04-17 15:35:53.522000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1555', null, '2018-04-17 15:37:17.182000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1556', null, '2018-04-17 15:37:16.606000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1557', null, '2018-04-17 15:37:22.631000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1558', null, '2018-04-17 15:37:34.858000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1559', null, '2018-04-17 15:37:36.236000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1560', null, '2018-04-17 15:37:51.821000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1561', null, '2018-04-17 15:37:52.813000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1562', null, '2018-04-17 15:38:06.689000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1563', null, '2018-04-17 15:38:07.298000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1564', null, '2018-04-17 15:38:33.645000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1565', null, '2018-04-17 15:38:34.355000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1566', null, '2018-04-17 15:38:35.786000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1567', null, '2018-04-17 15:38:36.900000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1568', null, '2018-04-17 15:39:24.296000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1569', null, '2018-04-17 15:39:24.704000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1570', null, '2018-04-17 15:39:25.462000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1571', null, '2018-04-17 15:39:25.339000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1572', null, '2018-04-17 15:39:58.250000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1573', null, '2018-04-17 15:40:00.151000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1574', null, '2018-04-17 15:40:12.419000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1575', null, '2018-04-17 15:40:44.753000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1576', null, '2018-04-17 15:40:45.966000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1577', null, '2018-04-17 15:41:02.489000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1578', null, '2018-04-17 15:41:03.440000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1579', null, '2018-04-17 15:41:23.431000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1580', null, '2018-04-17 15:41:43.186000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1581', null, '2018-04-17 15:42:23.808000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1582', null, '2018-04-17 15:42:27.831000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1583', null, '2018-04-17 15:42:53.373000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1584', null, '2018-04-17 15:43:01.648000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1585', null, '2018-04-17 15:46:54.200000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1586', null, '2018-04-17 15:46:55.681000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1587', null, '2018-04-17 15:47:51.496000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1588', null, '2018-04-17 15:47:52.733000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1589', null, '2018-04-17 15:48:17.963000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1590', null, '2018-04-17 15:48:19.075000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1591', null, '2018-04-17 15:48:53.071000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1592', null, '2018-04-17 15:49:23.269000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1593', null, '2018-04-17 15:49:40.263000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1594', null, '2018-04-17 15:50:10.630000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1595', null, '2018-04-17 15:50:12.402000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1596', null, '2018-04-17 15:50:16.229000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1597', null, '2018-04-17 15:50:44.534000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1598', null, '2018-04-17 15:50:45.920000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1599', null, '2018-04-17 15:51:12.034000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1600', null, '2018-04-17 15:51:17.058000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1601', null, '2018-04-17 15:51:37.811000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1602', null, '2018-04-17 15:51:39.304000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1603', null, '2018-04-17 15:51:51.175000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('1604', null, '2018-04-17 15:51:58.140000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1605', null, '2018-04-17 15:52:06.661000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1606', null, '2018-04-17 15:52:45.942000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1607', null, '2018-04-17 15:53:16.507000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1608', null, '2018-04-17 15:53:35.416000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1609', null, '2018-04-17 15:53:50.926000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1610', null, '2018-04-17 15:53:54.983000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('1611', null, '2018-04-17 15:53:58.712000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1612', null, '2018-04-17 15:54:05.639000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/5.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1613', null, '2018-04-17 15:54:07.645000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1614', null, '2018-04-17 15:54:09.520000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/deleteById/5.json', '4');
INSERT INTO `t_opt_log` VALUES ('1615', null, '2018-04-17 15:54:10.590000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1616', null, '2018-04-17 15:54:12.211000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1617', null, '2018-04-17 15:54:44.444000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('1618', null, '2018-04-17 15:54:51.796000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1619', null, '2018-04-17 15:55:52.716000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1620', null, '2018-04-17 15:58:10.526000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('1621', null, '2018-04-17 15:58:18.447000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1622', null, '2018-04-17 15:58:19.989000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1623', null, '2018-04-17 15:58:29.063000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/deleteById/6.json', '4');
INSERT INTO `t_opt_log` VALUES ('1624', null, '2018-04-17 15:58:30.134000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1625', null, '2018-04-17 15:58:36.813000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/deleteById/7.json', '4');
INSERT INTO `t_opt_log` VALUES ('1626', null, '2018-04-17 15:58:37.849000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1627', null, '2018-04-17 15:59:19.380000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1628', null, '2018-04-17 15:59:21.254000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1629', null, '2018-04-17 15:59:47.635000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1630', null, '2018-04-17 15:59:49.467000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1631', null, '2018-04-17 15:59:52.890000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1632', null, '2018-04-17 16:00:17.523000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1633', null, '2018-04-17 16:01:05.751000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1634', null, '2018-04-17 16:01:06.408000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1635', null, '2018-04-17 16:01:11.851000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1636', null, '2018-04-17 16:01:44.238000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1637', null, '2018-04-17 16:02:05.796000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1638', null, '2018-04-17 16:02:07.474000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1639', null, '2018-04-17 16:02:21.420000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1640', null, '2018-04-17 16:02:22.771000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1641', null, '2018-04-17 16:02:43.631000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1642', null, '2018-04-17 16:02:44.950000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1643', null, '2018-04-17 16:05:33.602000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1644', null, '2018-04-17 16:05:35.194000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1645', null, '2018-04-17 16:05:42.104000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1646', null, '2018-04-17 16:07:48.119000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1647', null, '2018-04-17 16:07:49.987000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1648', null, '2018-04-17 16:08:34.453000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1649', null, '2018-04-17 16:08:35.683000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1650', null, '2018-04-17 16:09:05.759000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1651', null, '2018-04-17 16:09:07.523000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1652', null, '2018-04-17 16:10:21.783000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1653', null, '2018-04-17 16:10:28.011000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1654', null, '2018-04-17 16:10:53.258000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1655', null, '2018-04-17 16:10:53.582000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1656', null, '2018-04-17 16:10:54.472000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1657', null, '2018-04-17 16:11:08.709000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1658', null, '2018-04-17 16:11:09.864000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1659', null, '2018-04-17 16:11:39.196000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1660', null, '2018-04-17 16:11:41.615000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1661', null, '2018-04-17 16:11:49.193000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('1662', null, '2018-04-17 16:12:44.940000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('1663', null, '2018-04-17 16:12:55.449000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1664', null, '2018-04-17 16:13:00.098000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1665', null, '2018-04-17 16:13:35.417000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1666', null, '2018-04-17 16:14:24.400000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1667', null, '2018-04-17 16:14:25.722000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1668', null, '2018-04-17 16:14:29.702000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1669', null, '2018-04-17 16:15:02.153000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1670', null, '2018-04-17 16:15:31.315000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1671', null, '2018-04-17 16:15:31.951000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1672', null, '2018-04-17 16:16:22.257000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1673', null, '2018-04-17 16:16:23.544000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1674', null, '2018-04-17 16:16:39.058000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1675', null, '2018-04-17 16:16:38.455000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1676', null, '2018-04-17 16:16:44.928000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1677', null, '2018-04-17 16:16:46.288000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('1678', null, '2018-04-17 16:16:55.479000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1679', null, '2018-04-17 16:16:56.765000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1680', null, '2018-04-17 16:17:12.789000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1681', null, '2018-04-17 16:17:13.752000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1682', null, '2018-04-17 16:19:05.090000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1683', null, '2018-04-17 16:19:12.885000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1684', null, '2018-04-17 16:19:05.643000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1685', null, '2018-04-17 16:19:14.458000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1686', null, '2018-04-17 16:19:14.957000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1687', null, '2018-04-17 16:19:35.698000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('1688', null, '2018-04-17 16:19:43.731000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1689', null, '2018-04-17 16:20:05.520000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1690', null, '2018-04-17 16:20:23.878000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1691', null, '2018-04-17 16:21:12.487000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1692', null, '2018-04-17 16:21:27.748000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/deleteById/9.json', '4');
INSERT INTO `t_opt_log` VALUES ('1693', null, '2018-04-17 16:21:28.838000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1694', null, '2018-04-17 16:21:31.435000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/deleteById/8.json', '4');
INSERT INTO `t_opt_log` VALUES ('1695', null, '2018-04-17 16:21:32.487000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1696', null, '2018-04-17 16:21:37.797000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1697', null, '2018-04-17 16:22:03.132000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('1698', null, '2018-04-17 16:22:14.171000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1699', null, '2018-04-17 16:22:59.002000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1700', null, '2018-04-17 16:24:22.628000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1701', null, '2018-04-17 16:24:24.482000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1702', null, '2018-04-17 16:24:37.485000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1703', null, '2018-04-17 16:25:08.287000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1704', null, '2018-04-17 16:25:17.579000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1705', null, '2018-04-17 16:25:58.821000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1706', null, '2018-04-17 16:27:21.001000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1707', null, '2018-04-17 16:27:22.399000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1708', null, '2018-04-17 16:27:28.530000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1709', null, '2018-04-17 16:27:47.408000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1710', null, '2018-04-17 16:28:14.949000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1711', null, '2018-04-17 16:28:16.515000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1712', null, '2018-04-17 16:28:20.849000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1713', null, '2018-04-17 16:28:47.824000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1714', null, '2018-04-17 16:30:01.222000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1715', null, '2018-04-17 16:30:29.801000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1716', null, '2018-04-17 16:30:38.637000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1717', null, '2018-04-17 16:31:06.944000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1718', null, '2018-04-17 16:31:49.633000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1719', null, '2018-04-17 16:31:51.176000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1720', null, '2018-04-17 16:32:00.200000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1721', null, '2018-04-17 16:32:21.675000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1722', null, '2018-04-17 16:32:29.129000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1723', null, '2018-04-17 16:35:23.947000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1724', null, '2018-04-17 16:35:25.704000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1725', null, '2018-04-17 16:40:18.697000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1726', null, '2018-04-17 16:40:52.404000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1727', null, '2018-04-17 16:40:53.940000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1728', null, '2018-04-17 16:51:08.899000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1729', null, '2018-04-17 16:51:10.535000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1730', null, '2018-04-17 16:52:17.106000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1731', null, '2018-04-17 16:52:18.206000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1732', null, '2018-04-17 16:52:57.501000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1733', null, '2018-04-17 16:52:58.838000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1734', null, '2018-04-17 16:53:50.783000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1735', null, '2018-04-17 16:53:51.899000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1736', null, '2018-04-17 16:54:14.949000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1737', null, '2018-04-17 16:54:16.224000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1738', null, '2018-04-17 16:56:40.656000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1739', null, '2018-04-17 16:56:42.440000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1740', null, '2018-04-17 16:57:21.969000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1741', null, '2018-04-17 16:57:23.623000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1742', null, '2018-04-17 16:58:16.824000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1743', null, '2018-04-17 16:58:18.237000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1744', null, '2018-04-17 16:59:09.774000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1745', null, '2018-04-17 16:59:11.069000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1746', null, '2018-04-17 17:00:17.332000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1747', null, '2018-04-17 17:00:18.690000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1748', null, '2018-04-17 17:01:25.308000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1749', null, '2018-04-17 17:01:24.445000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1750', null, '2018-04-17 17:01:30.423000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1751', null, '2018-04-17 17:01:36.150000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1752', null, '2018-04-17 17:02:06.263000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1753', null, '2018-04-17 17:02:46.586000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1754', null, '2018-04-17 17:02:48.194000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1755', null, '2018-04-17 17:03:04.025000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1756', null, '2018-04-17 17:06:26.706000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1757', null, '2018-04-17 17:06:28.371000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1758', null, '2018-04-17 17:09:38.723000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1759', null, '2018-04-17 17:09:45.928000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1760', null, '2018-04-17 17:09:55.259000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1761', null, '2018-04-17 17:09:59.458000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1762', null, '2018-04-17 17:10:05.947000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1763', null, '2018-04-17 17:10:11.281000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1764', null, '2018-04-17 17:10:18.362000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1765', null, '2018-04-17 17:10:20.426000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1766', null, '2018-04-17 17:10:22.224000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1767', null, '2018-04-17 17:10:56.578000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('1768', null, '2018-04-17 17:10:58.711000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1769', null, '2018-04-17 17:11:01.078000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1770', null, '2018-04-17 17:12:13.242000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1771', null, '2018-04-17 17:12:21.119000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1772', null, '2018-04-17 17:16:48.018000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1773', null, '2018-04-17 17:16:50.636000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1774', null, '2018-04-17 17:17:27.073000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1775', null, '2018-04-17 17:17:28.345000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1776', null, '2018-04-17 17:19:09.389000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1777', null, '2018-04-17 17:19:08.612000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1778', null, '2018-04-17 17:19:16.647000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1779', null, '2018-04-17 17:19:54.769000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1780', null, '2018-04-17 17:19:55.973000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1781', null, '2018-04-17 17:20:17.185000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1782', null, '2018-04-17 17:20:18.284000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1783', null, '2018-04-17 17:21:05.686000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1784', null, '2018-04-17 17:21:06.768000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1785', null, '2018-04-17 17:21:21.801000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1786', null, '2018-04-17 17:21:22.750000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1787', null, '2018-04-17 17:22:54.684000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1788', null, '2018-04-17 17:22:55.935000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1789', null, '2018-04-17 17:23:05.157000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1790', null, '2018-04-17 17:23:06.319000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1791', null, '2018-04-17 17:23:27.188000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1792', null, '2018-04-17 17:23:28.188000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1793', null, '2018-04-17 17:23:41.057000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1794', null, '2018-04-17 17:23:42.618000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1795', null, '2018-04-17 17:23:44.394000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1796', null, '2018-04-17 17:25:12.092000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1797', null, '2018-04-17 17:26:58.809000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1798', null, '2018-04-17 17:26:58.108000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1799', null, '2018-04-17 17:27:01.064000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1800', null, '2018-04-17 17:27:14.826000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1801', null, '2018-04-17 17:27:34.121000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1802', null, '2018-04-17 17:27:35.988000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1803', null, '2018-04-17 17:27:40.438000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1804', null, '2018-04-17 17:28:17.663000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1805', null, '2018-04-17 17:28:18.562000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1806', null, '2018-04-17 17:28:37.603000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1807', null, '2018-04-17 17:28:45.016000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1808', null, '2018-04-17 17:30:00.041000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1809', null, '2018-04-17 17:31:32.269000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1810', null, '2018-04-17 17:31:48.944000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1811', null, '2018-04-17 17:32:13.647000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1812', null, '2018-04-17 17:33:10.081000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1813', null, '2018-04-17 17:33:13.358000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1814', null, '2018-04-17 17:33:16.507000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1815', null, '2018-04-17 17:33:21.067000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1816', null, '2018-04-17 17:34:54.993000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1817', null, '2018-04-17 17:34:56.282000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1818', null, '2018-04-17 17:34:59.066000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1819', null, '2018-04-17 17:34:59.356000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1820', null, '2018-04-17 17:35:00.924000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1821', null, '2018-04-17 17:35:39.908000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1822', null, '2018-04-17 17:36:19.231000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1823', null, '2018-04-17 17:36:37.852000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1824', null, '2018-04-17 17:36:49.616000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1825', null, '2018-04-17 17:37:01.488000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1826', null, '2018-04-17 17:37:26.147000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1827', null, '2018-04-17 17:37:31.888000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1828', null, '2018-04-17 17:37:33.099000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1829', null, '2018-04-17 17:37:33.087000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1830', null, '2018-04-17 17:37:48.473000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1831', null, '2018-04-17 17:38:16.092000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1832', null, '2018-04-17 17:38:17.098000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1833', null, '2018-04-17 17:38:30.336000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1834', null, '2018-04-17 17:38:31.549000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1835', null, '2018-04-17 17:39:52.317000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1836', null, '2018-04-17 17:39:53.442000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1837', null, '2018-04-17 17:40:47.246000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1838', null, '2018-04-17 17:40:48.269000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1839', null, '2018-04-17 17:41:04.886000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1840', null, '2018-04-17 17:41:06.044000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1841', null, '2018-04-17 17:41:15.710000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1842', null, '2018-04-17 17:41:16.609000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1843', null, '2018-04-17 17:41:27.330000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1844', null, '2018-04-17 17:41:28.284000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1845', null, '2018-04-17 17:41:58.124000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1846', null, '2018-04-17 17:41:59.241000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1847', null, '2018-04-17 17:42:39.409000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1848', null, '2018-04-17 17:42:40.471000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1849', null, '2018-04-17 17:43:19.266000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1850', null, '2018-04-17 17:43:21.619000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1851', null, '2018-04-17 17:43:37.996000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1852', null, '2018-04-17 17:43:39.584000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1853', null, '2018-04-17 17:44:05.166000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1854', null, '2018-04-17 17:44:23.222000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1855', null, '2018-04-17 17:45:48.771000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1856', null, '2018-04-17 17:45:49.425000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1857', null, '2018-04-17 17:45:51.939000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1858', null, '2018-04-17 17:46:37.896000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1859', null, '2018-04-17 17:46:39.128000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1860', null, '2018-04-17 17:46:46.940000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1861', null, '2018-04-17 17:46:48.874000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1862', null, '2018-04-17 17:46:53.108000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1863', null, '2018-04-17 17:46:54.465000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1864', null, '2018-04-17 17:46:56.678000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1865', null, '2018-04-17 17:47:19.514000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1866', null, '2018-04-17 17:47:45.335000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1867', null, '2018-04-17 17:47:47.680000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1868', null, '2018-04-17 17:47:51.390000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1869', null, '2018-04-17 17:48:16.379000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1870', null, '2018-04-17 17:48:23.285000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1871', null, '2018-04-17 17:48:24.833000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1872', null, '2018-04-17 17:48:27.782000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1873', null, '2018-04-17 17:48:31.018000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1874', null, '2018-04-17 17:48:32.447000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1875', null, '2018-04-17 17:48:40.248000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1876', null, '2018-04-17 17:49:56.043000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1877', null, '2018-04-17 17:49:57.919000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1878', null, '2018-04-17 17:50:44.257000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1879', null, '2018-04-17 17:50:45.651000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1880', null, '2018-04-17 17:53:43.207000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1881', null, '2018-04-17 17:53:44.538000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1882', null, '2018-04-17 17:58:15.844000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1883', null, '2018-04-17 17:58:17.228000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1884', null, '2018-04-17 18:02:51.708000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1885', null, '2018-04-17 18:02:54.025000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1886', null, '2018-04-17 18:03:53.943000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1887', null, '2018-04-17 18:03:54.830000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1888', null, '2018-04-17 18:03:57.824000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1889', null, '2018-04-17 18:04:15.136000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1890', null, '2018-04-17 18:04:17.126000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1891', null, '2018-04-17 18:04:21.033000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1892', null, '2018-04-17 18:04:48.527000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1893', null, '2018-04-17 18:04:50.316000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1894', null, '2018-04-17 18:05:28.354000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1895', null, '2018-04-17 18:05:29.883000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1896', null, '2018-04-17 18:13:51.841000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1897', null, '2018-04-17 18:13:53.522000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1898', null, '2018-04-17 18:14:55.569000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1899', null, '2018-04-17 18:14:58.032000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1900', null, '2018-04-17 18:15:56.540000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1901', null, '2018-04-17 18:15:58.054000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1902', null, '2018-04-17 18:16:17.676000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1903', null, '2018-04-17 18:16:18.767000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1904', null, '2018-04-17 18:16:37.586000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1905', null, '2018-04-17 18:16:38.704000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1906', null, '2018-04-17 18:17:21.759000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1907', null, '2018-04-17 18:17:22.827000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1908', null, '2018-04-17 18:18:48.499000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1909', null, '2018-04-17 18:18:49.814000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1910', null, '2018-04-17 18:19:54.292000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1911', null, '2018-04-17 18:20:00.541000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1912', null, '2018-04-17 18:21:45.542000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1913', null, '2018-04-17 18:21:57.853000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/2.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1914', null, '2018-04-17 18:22:16.697000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1915', null, '2018-04-17 18:22:18.072000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/3.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1916', null, '2018-04-17 18:22:29.909000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1917', null, '2018-04-17 18:22:31.907000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/11.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1918', null, '2018-04-17 18:24:38.658000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/loginlog/list/1/15.htmk=aaa', '1');
INSERT INTO `t_opt_log` VALUES ('1919', null, '2018-04-17 18:24:50.637000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1920', null, '2018-04-17 18:24:52.097000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1921', null, '2018-04-17 18:25:17.441000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.json', '1');
INSERT INTO `t_opt_log` VALUES ('1922', null, '2018-04-17 18:25:19.489000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1923', null, '2018-04-17 18:25:20.497000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1924', null, '2018-04-17 18:25:21.973000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1925', null, '2018-04-17 18:24:44.905000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1926', null, '2018-04-17 18:24:47.904000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1927', null, '2018-04-17 18:24:59.159000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1928', null, '2018-04-17 18:26:15.125000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.json', '1');
INSERT INTO `t_opt_log` VALUES ('1929', null, '2018-04-17 18:26:16.336000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1930', null, '2018-04-17 18:25:44.603000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1931', null, '2018-04-17 18:25:47.440000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1932', null, '2018-04-17 18:25:49.392000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/2.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1933', null, '2018-04-17 18:25:52.341000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1934', null, '2018-04-17 18:26:25.258000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1935', null, '2018-04-17 18:26:27.635000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1936', null, '2018-04-17 18:26:29.479000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1937', null, '2018-04-17 18:26:31.863000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1938', null, '2018-04-17 18:26:40.507000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1939', null, '2018-04-17 18:26:42.709000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1940', null, '2018-04-17 18:27:33.701000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1941', null, '2018-04-17 18:28:10.327000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1942', null, '2018-04-17 18:28:29.793000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1943', null, '2018-04-17 18:28:32.067000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1944', null, '2018-04-17 18:28:36.188000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1945', null, '2018-04-17 18:28:38.189000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1946', null, '2018-04-17 18:28:46.562000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1947', null, '2018-04-17 18:28:51.199000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1948', null, '2018-04-17 18:28:57.876000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityappraise/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1949', null, '2018-04-17 18:29:09.165000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1950', null, '2018-04-17 18:29:12.659000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1951', null, '2018-04-17 18:30:01.086000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1952', null, '2018-04-17 18:32:22.657000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list1/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1953', null, '2018-04-17 18:33:12.751000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('1954', null, '2018-04-17 18:39:48.328000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1955', null, '2018-04-17 18:39:54.632000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1956', null, '2018-04-17 18:40:01.513000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('1957', null, '2018-04-17 18:40:03.659000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1958', null, '2018-04-17 18:41:01.833000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1959', null, '2018-04-17 18:41:12.463000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details1/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('1960', null, '2018-04-17 18:41:12.782000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1961', null, '2018-04-17 18:41:21.267000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('1962', null, '2018-04-17 18:41:23.321000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1963', null, '2018-04-17 18:42:29.169000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1964', null, '2018-04-17 18:42:31.260000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1965', null, '2018-04-17 18:42:37.177000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('1966', null, '2018-04-17 18:42:39.298000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1967', null, '2018-04-17 18:42:45.287000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1968', null, '2018-04-17 18:43:46.130000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1969', null, '2018-04-17 18:44:04.898000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1970', null, '2018-04-17 18:44:39.372000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1971', null, '2018-04-17 18:44:41.337000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1972', null, '2018-04-17 18:45:03.526000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('1973', null, '2018-04-17 18:45:07.084000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1974', null, '2018-04-17 18:46:00.455000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1975', null, '2018-04-17 18:46:23.739000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('1976', null, '2018-04-17 18:46:26.110000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1977', null, '2018-04-23 09:01:51.213000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityappraise/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1978', null, '2018-04-23 09:02:00.287000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1979', null, '2018-04-23 09:02:16.982000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1980', null, '2018-04-23 09:02:22.146000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1981', null, '2018-04-23 09:02:24.607000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1982', null, '2018-04-23 09:02:25.567000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1983', null, '2018-04-23 09:02:27.902000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1984', null, '2018-04-23 09:02:43.197000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1985', null, '2018-04-23 09:04:45.125000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1986', null, '2018-04-23 09:09:30.989000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1987', null, '2018-04-23 09:09:35.717000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1988', null, '2018-04-23 09:11:03.808000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1989', null, '2018-04-23 09:11:16.965000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1990', null, '2018-04-23 09:11:24.446000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1991', null, '2018-04-23 09:11:28.641000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1992', null, '2018-04-23 09:11:19.674000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1993', null, '2018-04-23 09:11:40.939000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1994', null, '2018-04-23 09:11:44.609000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1995', null, '2018-04-23 09:11:52.168000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1996', null, '2018-04-23 09:37:53.447000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1997', null, '2018-04-23 09:37:59.191000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1998', null, '2018-04-23 09:38:00.841000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('1999', null, '2018-04-23 09:38:01.799000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2000', null, '2018-04-23 09:38:03.375000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2001', null, '2018-04-23 09:38:08.890000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2002', null, '2018-04-23 09:47:42.510000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2003', null, '2018-04-23 09:47:50.199000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2004', null, '2018-04-23 09:47:53.212000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2005', null, '2018-04-23 09:47:59.505000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2006', null, '2018-04-23 09:48:02.151000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2007', null, '2018-04-23 09:48:07.886000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2008', null, '2018-04-23 09:48:21.118000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2009', null, '2018-04-23 09:48:40.530000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2010', null, '2018-04-23 09:48:43.565000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2011', null, '2018-04-23 09:48:46.616000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2012', null, '2018-04-23 09:48:56.244000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2013', null, '2018-04-23 09:49:04.254000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2014', null, '2018-04-23 09:49:05.863000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2015', null, '2018-04-23 09:49:41.585000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2016', null, '2018-04-23 10:07:24.782000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2017', null, '2018-04-23 10:07:27.288000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2018', null, '2018-04-23 10:13:19.486000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2019', null, '2018-04-23 10:13:21.787000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2020', null, '2018-04-23 10:14:07.733000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2021', null, '2018-04-23 10:14:09.203000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2022', null, '2018-04-23 10:21:09.826000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2023', null, '2018-04-23 10:21:11.732000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2024', null, '2018-04-23 10:22:05.459000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2025', null, '2018-04-23 10:22:13.718000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2026', null, '2018-04-23 10:22:33.364000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2027', null, '2018-04-23 10:22:41.287000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2028', null, '2018-04-23 10:23:28.109000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2029', null, '2018-04-23 10:23:31.140000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2030', null, '2018-04-23 10:23:39.990000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('2031', null, '2018-04-23 10:23:48.080000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2032', null, '2018-04-23 10:23:51.117000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2033', null, '2018-04-23 10:23:54.644000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2034', null, '2018-04-23 10:23:58.277000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2035', null, '2018-04-23 10:24:15.960000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2036', null, '2018-04-23 10:24:22.550000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2037', null, '2018-04-23 10:28:24.836000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2038', null, '2018-04-23 10:28:24.276000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2039', null, '2018-04-23 10:28:38.277000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2040', null, '2018-04-23 10:29:25.341000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2041', null, '2018-04-23 10:29:29.092000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2042', null, '2018-04-23 10:30:31.963000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2043', null, '2018-04-23 10:30:37.103000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2044', null, '2018-04-23 10:30:41.829000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2045', null, '2018-04-23 10:30:45.633000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2046', null, '2018-04-23 10:31:28.347000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2047', null, '2018-04-23 10:38:08.155000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2048', null, '2018-04-23 10:38:10.797000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2049', null, '2018-04-23 10:50:58.032000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2050', null, '2018-04-23 10:51:01.982000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2051', null, '2018-04-23 10:51:02.972000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2052', null, '2018-04-23 10:51:17.569000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2053', null, '2018-04-23 11:13:27.798000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2054', null, '2018-04-23 11:13:29.208000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2055', null, '2018-04-23 11:13:33.117000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2056', null, '2018-04-23 11:16:31.443000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2057', null, '2018-04-23 11:16:35.203000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2058', null, '2018-04-23 11:19:32.432000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2059', null, '2018-04-23 11:19:35.273000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2060', null, '2018-04-23 11:22:39.423000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2061', null, '2018-04-23 11:24:49.942000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2062', null, '2018-04-23 11:25:09.376000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2063', null, '2018-04-23 11:25:11.010000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2064', null, '2018-04-23 11:25:36.695000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2065', null, '2018-04-23 11:26:11.575000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2066', null, '2018-04-23 11:46:47.208000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2067', null, '2018-04-23 11:53:06.724000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2068', null, '2018-04-23 11:55:28.538000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/12.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2069', null, '2018-04-23 11:55:40.585000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('2070', null, '2018-04-23 14:00:05.385000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2071', null, '2018-04-23 14:00:07.385000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2072', null, '2018-04-23 14:01:39.896000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2073', null, '2018-04-23 14:05:00.891000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2074', null, '2018-04-23 14:05:09.251000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2075', null, '2018-04-23 14:05:11.466000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2076', null, '2018-04-23 14:06:22.027000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2077', null, '2018-04-23 14:06:23.587000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2078', null, '2018-04-23 14:06:42.994000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2079', null, '2018-04-23 14:06:44.297000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2080', null, '2018-04-23 14:06:48.624000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2081', null, '2018-04-23 14:06:50.467000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2082', null, '2018-04-23 14:06:54.255000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2083', null, '2018-04-23 14:07:22.252000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2084', null, '2018-04-23 14:07:23.752000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2085', null, '2018-04-23 14:07:27.803000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2086', null, '2018-04-23 14:08:19.274000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2087', null, '2018-04-23 14:08:37.408000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2088', null, '2018-04-23 14:08:38.584000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2089', null, '2018-04-23 14:08:42.370000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2090', null, '2018-04-23 14:08:43.566000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/update/10.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2091', null, '2018-04-23 14:09:15.517000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2092', null, '2018-04-23 14:09:35.365000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/optlog/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2093', null, '2018-04-23 14:09:41.795000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/optlog/list/140/15.htmk=', '4');
INSERT INTO `t_opt_log` VALUES ('2094', null, '2018-04-23 14:09:50.919000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/loginlog/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2095', null, '2018-04-23 14:10:08.690000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2096', null, '2018-04-23 14:10:16.347000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list2/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2097', null, '2018-04-23 14:10:30.955000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityappraise/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2098', null, '2018-04-23 14:10:46.210000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2099', null, '2018-04-23 14:11:29.349000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2100', null, '2018-04-23 14:11:27.619000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2101', null, '2018-04-23 14:11:34.581000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2102', null, '2018-04-23 14:12:42.791000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2103', null, '2018-04-23 14:12:49.502000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2104', null, '2018-04-23 15:38:39.285000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2105', null, '2018-04-23 15:38:47.357000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2106', null, '2018-04-23 15:38:58.546000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2107', null, '2018-04-23 15:45:45.249000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2108', null, '2018-04-23 15:45:46.856000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2109', null, '2018-04-23 15:46:12.429000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2110', null, '2018-04-23 15:46:15.504000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2111', null, '2018-04-23 15:46:28.669000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2112', null, '2018-04-23 15:46:32.055000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2113', null, '2018-04-23 15:47:27.616000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2114', null, '2018-04-23 15:48:09.608000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2115', null, '2018-04-23 15:49:06.933000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2116', null, '2018-04-23 15:49:13.650000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2117', null, '2018-04-23 15:49:41.305000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2118', null, '2018-04-23 15:49:44.152000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2119', null, '2018-04-23 15:50:00.873000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2120', null, '2018-04-23 15:50:19.729000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2121', null, '2018-04-23 15:50:21.616000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2122', null, '2018-04-23 15:50:24.158000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2123', null, '2018-04-23 15:51:11.485000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2124', null, '2018-04-23 15:51:13.167000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2125', null, '2018-04-23 15:51:14.149000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2126', null, '2018-04-23 15:52:33.920000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2127', null, '2018-04-23 15:55:01.119000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2128', null, '2018-04-23 16:00:26.925000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2129', null, '2018-04-23 16:00:46.590000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2130', null, '2018-04-23 16:01:15.236000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2131', null, '2018-04-23 16:01:24.754000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2132', null, '2018-04-23 16:05:30.608000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2133', null, '2018-04-23 16:05:40.442000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2134', null, '2018-04-23 16:06:02.891000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2135', null, '2018-04-23 16:06:21.837000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('2136', null, '2018-04-23 16:06:24.014000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2137', null, '2018-04-23 16:06:26.934000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2138', null, '2018-04-23 16:06:28.844000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2139', null, '2018-04-23 16:06:33.995000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2140', null, '2018-04-23 16:07:18.257000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2141', null, '2018-04-23 16:07:36.961000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('2142', null, '2018-04-23 16:07:39.055000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/2.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2143', null, '2018-04-23 16:07:42.063000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2144', null, '2018-04-23 16:07:51.046000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2145', null, '2018-04-23 16:08:09.587000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('2146', null, '2018-04-23 16:08:11.701000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/update/3.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2147', null, '2018-04-23 16:08:14.899000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2148', null, '2018-04-24 12:03:10.569000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('2149', null, '2018-04-24 12:04:23.669000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('2150', null, '2018-04-24 12:06:13.896000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/add.json', '2');
INSERT INTO `t_opt_log` VALUES ('2151', null, '2018-04-24 12:48:52.607000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/4.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2152', null, '2018-04-24 12:48:59.363000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('2153', null, '2018-04-24 12:49:01.471000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/4.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2154', null, '2018-04-24 12:49:04.327000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/5.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2155', null, '2018-04-24 12:49:08.679000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('2156', null, '2018-04-24 12:49:10.758000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/5.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2157', null, '2018-04-24 12:49:14.038000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/6.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2158', null, '2018-04-24 12:49:21.972000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('2159', null, '2018-04-24 12:49:24.045000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/6.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2160', null, '2018-04-24 15:31:28.069000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2161', null, '2018-04-24 15:31:31.422000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2162', null, '2018-04-24 15:53:25.535000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2163', null, '2018-04-24 16:26:13.430000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/6.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2164', null, '2018-04-24 16:26:18.765000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('2165', null, '2018-04-24 16:26:21.331000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/6.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2166', null, '2018-04-24 16:26:27.924000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/5.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2167', null, '2018-04-24 16:26:33.892000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('2168', null, '2018-04-24 16:26:36.375000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/5.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2169', null, '2018-04-24 16:26:42.209000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/4.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2170', null, '2018-04-24 16:26:47.931000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('2171', null, '2018-04-24 16:26:50.088000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/4.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2172', null, '2018-04-24 16:27:04.224000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/5.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2173', null, '2018-04-24 16:27:09.955000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('2174', null, '2018-04-24 16:27:12.038000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/5.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2175', null, '2018-04-25 09:03:41.983000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2176', null, '2018-04-25 09:42:27.667000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityappraise/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2177', null, '2018-04-25 09:42:32.724000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2178', null, '2018-04-25 09:53:54.583000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2179', null, '2018-04-25 09:55:09.386000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2180', null, '2018-04-25 10:15:40.624000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2181', null, '2018-04-25 10:19:05.554000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2182', null, '2018-04-25 10:20:40.400000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2183', null, '2018-04-25 10:20:46.120000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2184', null, '2018-04-25 10:20:52.942000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2185', null, '2018-04-25 10:31:43.882000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2186', null, '2018-04-25 10:31:46.844000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2187', null, '2018-04-25 10:32:39.959000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2188', null, '2018-04-25 10:31:53.582000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2189', null, '2018-04-25 10:32:44.623000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2190', null, '2018-04-25 10:33:02.894000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2191', null, '2018-04-25 10:33:10.430000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2192', null, '2018-04-25 10:32:26.655000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update.json', '2');
INSERT INTO `t_opt_log` VALUES ('2193', null, '2018-04-25 10:32:32.963000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2194', null, '2018-04-25 10:36:00.502000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2195', null, '2018-04-25 10:45:10.032000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2196', null, '2018-04-25 10:45:26.164000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2197', null, '2018-04-25 10:45:29.756000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('2198', null, '2018-04-25 10:45:31.890000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2199', null, '2018-04-25 10:45:41.043000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2200', null, '2018-04-25 10:46:03.253000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2201', null, '2018-04-25 10:46:06.416000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/3.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2202', null, '2018-04-25 10:46:09.026000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('2203', null, '2018-04-25 10:46:11.093000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/3.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2204', null, '2018-04-25 10:46:11.809000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2205', null, '2018-04-25 10:46:14.397000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2206', null, '2018-04-25 10:46:27.836000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/3.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2207', null, '2018-04-25 10:46:30.832000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2208', null, '2018-04-25 10:46:31.881000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2209', null, '2018-04-25 10:46:52.239000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/add.json', '4');
INSERT INTO `t_opt_log` VALUES ('2210', null, '2018-04-25 10:46:54.319000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2211', null, '2018-04-25 10:46:56.568000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2212', null, '2018-04-25 10:49:04.184000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2213', null, '2018-04-25 10:49:09.801000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('2214', null, '2018-04-25 10:49:11.708000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2215', null, '2018-04-25 10:51:44.558000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2216', null, '2018-04-25 10:51:46.435000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/4.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2217', null, '2018-04-25 10:51:48.601000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('2218', null, '2018-04-25 10:51:50.280000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2219', null, '2018-04-25 11:04:58.226000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2220', null, '2018-04-25 11:05:13.319000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2221', null, '2018-04-25 11:05:19.521000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2222', null, '2018-04-25 11:05:30.794000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2223', null, '2018-04-25 11:05:58.911000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2224', null, '2018-04-25 11:06:04.493000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2225', null, '2018-04-25 11:31:55.449000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2226', null, '2018-04-25 11:35:39.959000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2227', null, '2018-04-25 11:35:43.628000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2228', null, '2018-04-25 11:43:14.124000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2229', null, '2018-04-25 11:43:16.114000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2230', null, '2018-04-25 11:43:19.327000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2231', null, '2018-04-25 11:43:25.042000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2232', null, '2018-04-25 11:43:50.992000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2233', null, '2018-04-25 11:43:52.653000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2234', null, '2018-04-25 11:43:58.949000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2235', null, '2018-04-25 11:44:03.065000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2236', null, '2018-04-25 11:44:19.336000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update.json', '4');
INSERT INTO `t_opt_log` VALUES ('2237', null, '2018-04-25 11:44:22.058000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2238', null, '2018-04-25 11:45:11.535000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2239', null, '2018-04-25 11:45:16.199000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2240', null, '2018-04-25 11:45:20.711000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2241', null, '2018-04-25 11:52:35.646000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2242', null, '2018-04-25 11:53:42.557000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2243', null, '2018-04-25 11:55:14.249000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2244', null, '2018-04-25 11:56:58.323000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2245', null, '2018-04-25 11:57:03.250000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2246', null, '2018-04-25 11:57:08.612000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '2');
INSERT INTO `t_opt_log` VALUES ('2247', null, '2018-04-25 11:57:17.779000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2248', null, '2018-04-25 11:57:56.225000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2249', null, '2018-04-25 12:05:23.041000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2250', null, '2018-04-25 12:09:11.744000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2251', null, '2018-04-25 12:09:13.620000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2252', null, '2018-04-25 12:09:17.568000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2253', null, '2018-04-25 13:59:01.777000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2254', null, '2018-04-25 13:59:40.216000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2255', null, '2018-04-25 14:03:26.294000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2256', null, '2018-04-25 14:03:28.421000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2257', null, '2018-04-25 14:03:45.426000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2258', null, '2018-04-25 14:08:02.676000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2259', null, '2018-04-25 14:08:10.553000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2260', null, '2018-04-25 14:08:42.186000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2261', null, '2018-04-27 09:15:16.331000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2262', null, '2018-04-27 09:17:07.908000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2263', null, '2018-04-27 11:15:35.408000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2264', null, '2018-04-27 11:21:42.322000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/7.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2265', null, '2018-04-27 11:22:19.798000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/deleteById/9.json', '4');
INSERT INTO `t_opt_log` VALUES ('2266', null, '2018-04-27 16:53:10.069000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2267', null, '2018-04-27 17:18:11.339000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/14.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2268', null, '2018-04-27 17:19:11.015000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('2269', null, '2018-04-27 17:19:13.138000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/14.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2270', null, '2018-04-27 17:20:58.005000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/add.json', '1');
INSERT INTO `t_opt_log` VALUES ('2271', null, '2018-04-27 17:21:14.342000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2272', null, '2018-04-27 17:21:27.456000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update.json', '1');
INSERT INTO `t_opt_log` VALUES ('2273', null, '2018-04-27 17:22:55.825000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2274', null, '2018-04-28 09:18:21.119000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2275', null, '2018-04-28 09:22:29.724000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2276', null, '2018-04-28 09:22:32.806000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2277', null, '2018-04-28 09:22:37.162000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2278', null, '2018-04-28 09:22:47.161000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2279', null, '2018-04-28 09:23:30.085000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2280', null, '2018-04-28 09:52:43.543000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/draw/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2281', null, '2018-04-28 09:53:11.749000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/draw/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2282', null, '2018-05-04 09:10:02.420000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2283', null, '2018-05-04 09:11:13.289000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/details/1.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2284', null, '2018-05-04 09:11:18.559000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/order/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2285', null, '2018-05-04 15:24:58.557000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/14.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2286', null, '2018-05-04 15:25:18.326000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2287', null, '2018-05-04 15:25:19.786000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityevaluation/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2288', null, '2018-05-04 15:25:24.144000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2289', null, '2018-05-04 15:25:27.039000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/details/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2290', null, '2018-05-04 15:26:04.851000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2291', null, '2018-05-04 15:26:06.447000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2292', null, '2018-05-04 15:27:21.922000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2293', null, '2018-05-04 15:27:31.559000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2294', null, '2018-05-04 15:27:34.559000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/add.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2295', null, '2018-05-04 15:27:37.805000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityclass/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2296', null, '2018-05-04 15:29:12.045000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2297', null, '2018-05-04 15:29:13.272000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2298', null, '2018-05-04 15:29:14.998000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2299', null, '2018-05-04 15:28:13.003000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberbill/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2300', null, '2018-05-04 15:29:27.488000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2301', null, '2018-05-04 15:29:28.736000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2302', null, '2018-05-04 15:29:30.612000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2303', null, '2018-05-04 15:29:36.338000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2304', null, '2018-05-04 15:29:38.921000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2305', null, '2018-05-04 15:29:40.433000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsgtype/list/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2306', null, '2018-05-04 15:29:43.706000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2307', null, '2018-05-04 15:29:45.046000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/add.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2308', null, '2018-05-04 15:29:52.494000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');
INSERT INTO `t_opt_log` VALUES ('2309', null, '2018-05-04 15:29:38.665000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2310', null, '2018-05-04 15:29:43.823000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/update/35.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2311', null, '2018-05-04 15:29:48.302000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2312', null, '2018-05-04 15:30:53.787000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2313', null, '2018-05-04 15:30:57.782000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2314', null, '2018-05-04 15:31:01.666000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodityspecification/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2315', null, '2018-05-04 15:56:10.692000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/14.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2316', null, '2018-05-04 15:56:21.894000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/member/update/23.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2317', null, '2018-05-04 15:56:37.735000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2318', null, '2018-05-04 15:56:40.343000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/update/5.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2319', null, '2018-05-04 15:56:54.807000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2320', null, '2018-05-04 15:58:13.192000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2321', null, '2018-05-04 15:58:24.213000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/1.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2322', null, '2018-05-04 15:58:29.355000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2323', null, '2018-05-04 15:58:34.021000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/update/2.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2324', null, '2018-05-04 15:58:39.829000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/sys/user/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2325', null, '2018-05-04 16:00:45.286000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/commodity/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2326', null, '2018-05-04 16:00:53.786000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/memberaddress/list/1/15.htm', '4');
INSERT INTO `t_opt_log` VALUES ('2327', null, '2018-05-04 16:12:21.956000', '1', '1', null, '0:0:0:0:0:0:0:1', null, '/admin/automsg/list/0/1/15.htm', '1');

-- ----------------------------
-- Table structure for `t_order`
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `alipay_number` varchar(255) DEFAULT NULL,
  `apply_for_time` datetime(6) DEFAULT NULL,
  `appraise` int(11) DEFAULT NULL,
  `appraise_time` datetime(6) DEFAULT NULL,
  `business_remarks` varchar(255) DEFAULT NULL,
  `buyer_dshipments_time` datetime(6) DEFAULT NULL,
  `check_time` datetime(6) DEFAULT NULL,
  `express_name` varchar(255) DEFAULT NULL,
  `express_no` varchar(255) DEFAULT NULL,
  `finish_time` datetime(6) DEFAULT NULL,
  `first_level_brokerage` decimal(19,2) DEFAULT NULL,
  `image_url` text,
  `order_refund_time` decimal(19,2) DEFAULT NULL,
  `order_remarks` varchar(255) DEFAULT NULL,
  `pay_pathway` int(11) DEFAULT NULL,
  `payment_time` datetime(6) DEFAULT NULL,
  `postage_money` decimal(19,2) DEFAULT NULL,
  `receiving_time` datetime(6) DEFAULT NULL,
  `refund_express_name` varchar(255) DEFAULT NULL,
  `refund_express_no` varchar(255) DEFAULT NULL,
  `refund_reason` varchar(255) DEFAULT NULL,
  `refund_remarks` varchar(255) DEFAULT NULL,
  `refund_time` datetime(6) DEFAULT NULL,
  `reject_reason` varchar(255) DEFAULT NULL,
  `second_level_brokerage` decimal(19,2) DEFAULT NULL,
  `shipments_time` datetime(6) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `total_money` decimal(19,2) DEFAULT NULL,
  `wx_number` varchar(255) DEFAULT NULL,
  `commodity_id` int(11) DEFAULT NULL,
  `commodity_specification_id` int(11) DEFAULT NULL,
  `member_id` int(11) DEFAULT NULL,
  `member_address_id` int(11) DEFAULT NULL,
  `cart_id` int(11) DEFAULT NULL,
  `order_no` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKlgv0bxhgqakk5b4cnk0ncqlyj` (`commodity_id`),
  KEY `FK2w597vfp4dk3rpbu9km88p8d2` (`commodity_specification_id`),
  KEY `FK41xpqu33kp5hoandl0hhwd14c` (`member_id`),
  KEY `FKjmqx6k9frj1v17j723ncf7jg9` (`member_address_id`),
  KEY `FK1ctc9h23uyfrwsdp0lohdlj40` (`cart_id`),
  CONSTRAINT `FK1ctc9h23uyfrwsdp0lohdlj40` FOREIGN KEY (`cart_id`) REFERENCES `t_cart` (`id`),
  CONSTRAINT `FK2w597vfp4dk3rpbu9km88p8d2` FOREIGN KEY (`commodity_specification_id`) REFERENCES `t_commodity_specification` (`id`),
  CONSTRAINT `FK41xpqu33kp5hoandl0hhwd14c` FOREIGN KEY (`member_id`) REFERENCES `t_member` (`id`),
  CONSTRAINT `FKjmqx6k9frj1v17j723ncf7jg9` FOREIGN KEY (`member_address_id`) REFERENCES `t_member_address` (`id`),
  CONSTRAINT `FKlgv0bxhgqakk5b4cnk0ncqlyj` FOREIGN KEY (`commodity_id`) REFERENCES `t_commodity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES ('1', null, '2018-05-03 09:59:04.107000', '1', '1', null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '1098.99', null, null, null, '14', '36', null, '2018050309590410770736');
INSERT INTO `t_order` VALUES ('2', null, '2018-05-03 09:59:19.392000', '1', '1', null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2', '299.97', null, null, null, '14', '36', null, '2018050309591939230159');
INSERT INTO `t_order` VALUES ('3', null, '2018-05-03 09:59:38.523000', '1', '1', null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2', '297.00', null, null, null, '14', '36', null, '2018050309593852362565');
INSERT INTO `t_order` VALUES ('4', null, '2018-05-03 10:00:45.458000', '1', '1', null, null, '2018-05-03 18:15:09.190000', '0', null, null, null, null, null, null, null, null, '/static/order/4OnbpvbNlksBjZYsZY4h_6lemRy6Zb_gPlkve8XBfNps5_SGaSJVKZtWdoFdtngd.jpg|/static/order/466CMpNpGvDL_pIGLHQTewIJP18SfwomE8rw3wZMiD8RgqK__Ud4zH6UQ74-kCPH.jpg|/static/order/crSWrLm0DtZ8joAOSkNU1vLz9ZZE9FMj68NRYWpQ6XZNH3i8TmsRd5Wz8mhH-vCO.jpg', null, null, null, null, null, null, null, null, '七天无条件包退', '一个人所得了得……一个人所得了', null, null, null, null, '5', '2997.00', null, null, null, '14', '36', null, '2018050310004545855473');
INSERT INTO `t_order` VALUES ('5', null, '2018-05-03 11:08:11.000000', '1', '1', null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '4', '4995.00', null, null, null, '14', '36', null, '2018050311081100007912');
INSERT INTO `t_order` VALUES ('6', null, '2018-05-03 11:08:28.389000', '1', '1', null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '299.97', null, null, null, '14', '36', null, '2018050311082839031313');
INSERT INTO `t_order` VALUES ('7', null, '2018-05-03 11:08:57.036000', '1', '1', null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '3996.00', null, null, null, '14', '36', null, '2018050311085703676796');
INSERT INTO `t_order` VALUES ('8', null, '2018-05-03 14:14:50.985000', '1', '1', null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '99.99', null, null, null, '22', '36', null, '2018050314145098596802');
INSERT INTO `t_order` VALUES ('9', null, '2018-05-04 15:20:42.906000', '1', '1', null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '99.99', null, null, null, '14', '36', null, '2018050415204290683451');
INSERT INTO `t_order` VALUES ('10', null, '2018-05-04 17:49:44.325000', '1', '1', null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '99.99', null, null, null, '22', '36', null, '2018050417494432541780');
INSERT INTO `t_order` VALUES ('11', null, '2018-05-04 17:52:28.107000', '1', '1', null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '99.00', null, null, null, '22', '36', null, '2018050417522810772287');
INSERT INTO `t_order` VALUES ('12', null, '2018-05-07 15:12:35.621000', '1', '1', null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '0.01', null, null, null, '14', '36', null, '2018050715123562145517');
INSERT INTO `t_order` VALUES ('13', null, '2018-05-08 09:26:58.462000', '1', '1', null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '99.00', null, null, null, '22', '36', null, '2018050809265846292919');
INSERT INTO `t_order` VALUES ('14', null, '2018-05-08 15:55:25.884000', '1', '1', null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '99.99', null, null, null, '22', '36', null, '2018050815552588446099');
INSERT INTO `t_order` VALUES ('15', null, '2018-05-08 16:12:18.994000', '1', '1', null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '0.01', null, null, null, '22', '36', null, '2018050816121899445678');
INSERT INTO `t_order` VALUES ('16', null, '2018-05-08 16:18:57.156000', '1', '1', null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '0.01', null, null, null, '22', '36', null, '2018050816185715675026');
INSERT INTO `t_order` VALUES ('17', null, '2018-05-08 16:25:06.686000', '1', '1', null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '0.01', null, null, null, '22', '36', null, '2018050816250668604371');
INSERT INTO `t_order` VALUES ('18', null, '2018-05-09 11:27:26.082000', '1', '1', null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '0.01', null, null, null, '22', '36', null, '2018050911272608259727');
INSERT INTO `t_order` VALUES ('19', null, '2018-05-09 17:18:17.698000', '1', '1', null, null, null, '0', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '1', '0.01', null, null, null, '22', '36', null, '2018050917181769840910');

-- ----------------------------
-- Table structure for `t_order_item`
-- ----------------------------
DROP TABLE IF EXISTS `t_order_item`;
CREATE TABLE `t_order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `activity` varchar(255) DEFAULT NULL,
  `appraise_count` int(11) DEFAULT NULL,
  `buy_count` int(11) DEFAULT NULL,
  `commodity_id` int(11) DEFAULT NULL,
  `cost` decimal(19,2) DEFAULT NULL,
  `default_bulk` double DEFAULT NULL,
  `default_weight` double DEFAULT NULL,
  `free_postage` int(11) DEFAULT NULL,
  `freight` decimal(19,2) DEFAULT NULL,
  `imge_list_show` varchar(255) DEFAULT NULL,
  `imger_path` varchar(255) DEFAULT NULL,
  `original_price` decimal(19,2) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `sales_volume` int(11) DEFAULT NULL,
  `show_discount` decimal(19,2) DEFAULT NULL,
  `show_price` decimal(19,2) DEFAULT NULL,
  `show_remarks` varchar(255) DEFAULT NULL,
  `sort` int(11) DEFAULT NULL,
  `specifications` varchar(255) DEFAULT NULL,
  `total_stock` int(11) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2y83rerik30vumt2a1mff6606` (`order_id`),
  KEY `FK9dkq3y5tlptes6hajnjixncqx` (`commodity_id`),
  CONSTRAINT `FK2y83rerik30vumt2a1mff6606` FOREIGN KEY (`order_id`) REFERENCES `t_order` (`id`),
  CONSTRAINT `FK9dkq3y5tlptes6hajnjixncqx` FOREIGN KEY (`commodity_id`) REFERENCES `t_commodity` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order_item
-- ----------------------------
INSERT INTO `t_order_item` VALUES ('1', null, '2018-05-03 09:59:04.117000', '1', '1', '威士忌', '1', '99', '1', '3', '99.00', '99', '99', '99', '999.00', '/static/upload/image/20180414/1523698777501008904.jpg|/static/upload/image/20180414/1523698784179055257.jpg|/static/upload/image/20180414/1523698788259049000.jpg|/static/upload/image/20180414/1523698791008036100.png', '/static/upload/image/20180414/1523698770688097391.jpg', '999.00', '999', '999', '999.00', '999.00', '999', null, '2瓶/一箱', '976', '1');
INSERT INTO `t_order_item` VALUES ('2', null, '2018-05-03 09:59:04.143000', '1', '1', '红酒', '1', '1211', '1', '1', '22.00', '77', '77', '12', '10.50', '/static/upload/image/20180414/1523698701783090640.jpg|/static/upload/image/20180414/1523698704945011965.jpg', '/static/upload/image/20180414/1523698695572079772.jpg', '99.00', '你好啊', '99', '9.80', '99.99', '你哈哦', null, '10瓶/一箱', '64', '1');
INSERT INTO `t_order_item` VALUES ('3', null, '2018-05-03 09:59:19.392000', '1', '1', '红酒', '1', '1211', '3', '1', '22.00', '77', '77', '12', '10.50', '/static/upload/image/20180414/1523698701783090640.jpg|/static/upload/image/20180414/1523698704945011965.jpg', '/static/upload/image/20180414/1523698695572079772.jpg', '99.00', '你好啊', '99', '9.80', '99.99', '你哈哦', null, '10瓶/一箱', '63', '2');
INSERT INTO `t_order_item` VALUES ('4', null, '2018-05-03 09:59:38.529000', '1', '1', '白酒', null, '97', '3', '2', '97.00', '97', '97', '97', '97.00', '/static/upload/image/20180414/1523698730246017472.jpg|/static/upload/image/20180414/1523698733458007875.jpg', '/static/upload/image/20180414/1523698727048027243.jpg', '99.00', '好酒', '99', '99.00', '99.00', '好酒', null, '9瓶/一箱', '71', '3');
INSERT INTO `t_order_item` VALUES ('5', null, '2018-05-03 10:00:45.458000', '1', '1', '威士忌', '1', '99', '3', '3', '99.00', '99', '99', '99', '999.00', '/static/upload/image/20180414/1523698777501008904.jpg|/static/upload/image/20180414/1523698784179055257.jpg|/static/upload/image/20180414/1523698788259049000.jpg|/static/upload/image/20180414/1523698791008036100.png', '/static/upload/image/20180414/1523698770688097391.jpg', '999.00', '999', '999', '999.00', '999.00', '999', null, '2瓶/一箱', '975', '4');
INSERT INTO `t_order_item` VALUES ('6', null, '2018-05-03 11:08:11.017000', '1', '1', '威士忌', '1', '99', '5', '3', '99.00', '99', '99', '99', '999.00', '/static/upload/image/20180414/1523698777501008904.jpg|/static/upload/image/20180414/1523698784179055257.jpg|/static/upload/image/20180414/1523698788259049000.jpg|/static/upload/image/20180414/1523698791008036100.png', '/static/upload/image/20180414/1523698770688097391.jpg', '999.00', '999', '999', '999.00', '999.00', '999', null, '2瓶/一箱', '972', '5');
INSERT INTO `t_order_item` VALUES ('7', null, '2018-05-03 11:08:28.395000', '1', '1', '红酒', '1', '1211', '3', '1', '22.00', '77', '77', '12', '10.50', '/static/upload/image/20180414/1523698701783090640.jpg|/static/upload/image/20180414/1523698704945011965.jpg', '/static/upload/image/20180414/1523698695572079772.jpg', '99.00', '你好啊', '99', '9.80', '99.99', '你哈哦', null, '10瓶/一箱', '60', '6');
INSERT INTO `t_order_item` VALUES ('8', null, '2018-05-03 11:08:57.040000', '1', '1', '威士忌', '1', '99', '4', '3', '99.00', '99', '99', '99', '999.00', '/static/upload/image/20180414/1523698777501008904.jpg|/static/upload/image/20180414/1523698784179055257.jpg|/static/upload/image/20180414/1523698788259049000.jpg|/static/upload/image/20180414/1523698791008036100.png', '/static/upload/image/20180414/1523698770688097391.jpg', '999.00', '999', '999', '999.00', '999.00', '999', null, '2瓶/一箱', '967', '7');
INSERT INTO `t_order_item` VALUES ('9', null, '2018-05-03 14:14:50.996000', '1', '1', '红酒', '1', '1211', '1', '1', '22.00', '77', '77', '12', '10.50', '/static/upload/image/20180414/1523698701783090640.jpg|/static/upload/image/20180414/1523698704945011965.jpg', '/static/upload/image/20180414/1523698695572079772.jpg', '99.00', '你好啊', '99', '9.80', '99.99', '你哈哦', null, '10瓶/一箱', '57', '8');
INSERT INTO `t_order_item` VALUES ('10', null, '2018-05-04 15:20:42.934000', '1', '1', '红酒', '1', '1211', '1', '1', '22.00', '77', '77', '12', '10.50', '/static/upload/image/20180414/1523698701783090640.jpg|/static/upload/image/20180414/1523698704945011965.jpg', '/static/upload/image/20180414/1523698695572079772.jpg', '99.00', '你好啊', '99', '9.80', '99.99', '你哈哦', null, '10瓶/一箱', '56', '9');
INSERT INTO `t_order_item` VALUES ('11', null, '2018-05-04 17:49:44.335000', '1', '1', '红酒', '1', '1211', '1', '1', '22.00', '77', '77', '12', '10.50', '/static/upload/image/20180414/1523698701783090640.jpg|/static/upload/image/20180414/1523698704945011965.jpg', '/static/upload/image/20180414/1523698695572079772.jpg', '99.00', '你好啊', '99', '9.80', '99.99', '你哈哦', null, '10瓶/一箱', '55', '10');
INSERT INTO `t_order_item` VALUES ('12', null, '2018-05-04 17:52:28.108000', '1', '1', '白酒', null, '97', '1', '2', '97.00', '97', '97', '97', '97.00', '/static/upload/image/20180414/1523698730246017472.jpg|/static/upload/image/20180414/1523698733458007875.jpg', '/static/upload/image/20180414/1523698727048027243.jpg', '99.00', '好酒', '99', '99.00', '99.00', '好酒', null, '9瓶/一箱', '68', '11');
INSERT INTO `t_order_item` VALUES ('13', null, '2018-05-07 15:12:35.638000', '1', '1', '红酒', '1', '1211', '1', '1', '22.00', '77', '77', '12', '10.50', '/static/upload/image/20180414/1523698701783090640.jpg|/static/upload/image/20180414/1523698704945011965.jpg', '/static/upload/image/20180414/1523698695572079772.jpg', '99.00', '你好啊', '99', '9.80', '99.99', '你哈哦', null, '10瓶/一箱', '54', '12');
INSERT INTO `t_order_item` VALUES ('14', null, '2018-05-08 09:26:58.482000', '1', '1', '白酒', null, '97', '1', '2', '97.00', '97', '97', '97', '97.00', '/static/upload/image/20180414/1523698730246017472.jpg|/static/upload/image/20180414/1523698733458007875.jpg', '/static/upload/image/20180414/1523698727048027243.jpg', '99.00', '好酒', '99', '99.00', '99.00', '好酒', null, '9瓶/一箱', '67', '13');
INSERT INTO `t_order_item` VALUES ('15', null, '2018-05-08 15:55:25.902000', '1', '1', '红酒', '1', '1211', '1', '1', '22.00', '77', '77', '12', '10.50', '/static/upload/image/20180414/1523698701783090640.jpg|/static/upload/image/20180414/1523698704945011965.jpg', '/static/upload/image/20180414/1523698695572079772.jpg', '99.00', '你好啊', '99', '9.80', '99.99', '你哈哦', null, '10瓶/一箱', '53', '14');
INSERT INTO `t_order_item` VALUES ('16', null, '2018-05-08 16:12:19.002000', '1', '1', '红酒', '1', '1211', '1', '1', '22.00', '77', '77', '12', '10.50', '/static/upload/image/20180414/1523698701783090640.jpg|/static/upload/image/20180414/1523698704945011965.jpg', '/static/upload/image/20180414/1523698695572079772.jpg', '99.00', '你好啊', '99', '9.80', '0.01', '你哈哦', null, '10瓶/一箱', '52', '15');
INSERT INTO `t_order_item` VALUES ('17', null, '2018-05-08 16:18:57.178000', '1', '1', '红酒', '1', '1211', '1', '1', '22.00', '77', '77', '12', '10.50', '/static/upload/image/20180414/1523698701783090640.jpg|/static/upload/image/20180414/1523698704945011965.jpg', '/static/upload/image/20180414/1523698695572079772.jpg', '99.00', '你好啊', '99', '9.80', '0.01', '你哈哦', null, '10瓶/一箱', '51', '16');
INSERT INTO `t_order_item` VALUES ('18', null, '2018-05-08 16:25:06.694000', '1', '1', '白酒', null, '97', '1', '2', '97.00', '97', '97', '97', '97.00', '/static/upload/image/20180414/1523698730246017472.jpg|/static/upload/image/20180414/1523698733458007875.jpg', '/static/upload/image/20180414/1523698727048027243.jpg', '99.00', '好酒', '99', '99.00', '0.01', '好酒', null, '9瓶/一箱', '66', '17');
INSERT INTO `t_order_item` VALUES ('19', null, '2018-05-09 11:27:26.124000', '1', '1', '红酒', '1', '1211', '1', '1', '22.00', '77', '77', '12', '10.50', '/static/upload/image/20180414/1523698701783090640.jpg|/static/upload/image/20180414/1523698704945011965.jpg', '/static/upload/image/20180414/1523698695572079772.jpg', '99.00', '你好啊', '99', '9.80', '0.01', '你哈哦', null, '10瓶/一箱', '50', '18');
INSERT INTO `t_order_item` VALUES ('20', null, '2018-05-09 17:18:17.709000', '1', '1', '红酒', '1', '1211', '1', '1', '22.00', '77', '77', '12', '10.50', '/static/upload/image/20180414/1523698701783090640.jpg|/static/upload/image/20180414/1523698704945011965.jpg', '/static/upload/image/20180414/1523698695572079772.jpg', '99.00', '你好啊', '99', '9.80', '0.01', '你哈哦', null, '10瓶/一箱', '49', '19');

-- ----------------------------
-- Table structure for `t_res`
-- ----------------------------
DROP TABLE IF EXISTS `t_res`;
CREATE TABLE `t_res` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9mxmyqk77m4ta5xfwfurf0tkh` (`parent_id`),
  CONSTRAINT `FK9mxmyqk77m4ta5xfwfurf0tkh` FOREIGN KEY (`parent_id`) REFERENCES `t_res` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_res
-- ----------------------------
INSERT INTO `t_res` VALUES ('1', null, null, '1', '1', '顶级资源', null, '0', '0', null, null);
INSERT INTO `t_res` VALUES ('2', null, '2018-04-13 13:57:40.075000', '1', '1', '会员中心', '', '0', '1', '', '1');
INSERT INTO `t_res` VALUES ('3', null, '2018-04-14 17:52:22.665000', '1', '1', '会员管理', 'admin:member:show', '0', '1', '/admin/member/list/1/115.htm', '2');
INSERT INTO `t_res` VALUES ('4', null, '2018-04-14 17:52:00.471000', '1', '1', '添加会员', 'admin:member:add', '0', '2', '', '3');
INSERT INTO `t_res` VALUES ('5', null, '2018-04-14 17:52:42.920000', '1', '1', '修改会员', 'admin:member:update', '0', '2', '', '3');
INSERT INTO `t_res` VALUES ('6', null, '2018-04-14 17:52:55.655000', '1', '1', '删除会员', 'admin:member:delete', '0', '2', '', '3');
INSERT INTO `t_res` VALUES ('7', null, '2018-04-13 14:07:18.915000', '1', '1', '数据统计', 'admin:member:statistics', '0', '1', '/admin/member/statistics.htm', '2');
INSERT INTO `t_res` VALUES ('8', null, '2018-04-13 14:08:38.504000', '1', '1', '商品分类', '', '0', '1', '', '1');
INSERT INTO `t_res` VALUES ('9', null, '2018-04-14 09:40:13.869000', '1', '1', '分类列表', 'admin:commodityclass:show', '0', '1', '/admin/commodityclass/list/1/15.htm', '8');
INSERT INTO `t_res` VALUES ('10', null, '2018-04-14 09:40:26.416000', '1', '1', '添加分类', 'admin:commodityclass:add', '0', '2', '', '8');
INSERT INTO `t_res` VALUES ('11', null, '2018-04-14 09:40:48.621000', '1', '1', '修改分类', 'admin:commodityclass:update', '0', '2', '', '8');
INSERT INTO `t_res` VALUES ('12', null, '2018-04-14 09:40:58.829000', '1', '1', '删除分类', 'admin:commodityclass:delete', '0', '2', '', '8');
INSERT INTO `t_res` VALUES ('13', null, '2018-04-13 14:17:22.254000', '1', '1', '商品管理', '', '0', '1', '', '1');
INSERT INTO `t_res` VALUES ('14', null, '2018-04-13 14:18:10.502000', '1', '1', '商品列表', 'admin:commodity:show', '0', '1', '/admin/commodity/list/1/15.htm', '13');
INSERT INTO `t_res` VALUES ('15', null, '2018-04-13 14:18:31.255000', '1', '1', '添加商品', 'admin:commodity:add', '0', '2', '', '13');
INSERT INTO `t_res` VALUES ('16', null, '2018-04-13 14:18:47.323000', '1', '1', '修改商品', 'admin:commodity:update', '0', '2', '', '13');
INSERT INTO `t_res` VALUES ('17', null, '2018-04-13 14:19:01.642000', '1', '1', '删除商品', 'admin:commodity:delete', '0', '2', '', '13');
INSERT INTO `t_res` VALUES ('18', null, '2018-04-13 14:27:52.177000', '1', '1', '订单管理', '', '0', '1', '', '1');
INSERT INTO `t_res` VALUES ('19', null, '2018-04-13 14:28:38.124000', '1', '1', '订单列表', 'admin:order:show', '0', '1', '/admin/order/list/1/15.htm', '18');
INSERT INTO `t_res` VALUES ('20', null, '2018-04-13 14:29:12.072000', '1', '1', '修改订单', 'admin:order:update', '0', '2', '', '18');
INSERT INTO `t_res` VALUES ('21', null, '2018-04-13 15:45:14.554000', '1', '1', '删除订单', 'admin:order:delete', '0', '2', '', '18');
INSERT INTO `t_res` VALUES ('22', null, '2018-04-13 14:30:59.790000', '1', '1', '评价管理', '', '0', '1', '', '1');
INSERT INTO `t_res` VALUES ('23', null, '2018-04-14 10:55:56.450000', '1', '1', '评价列表', 'admin:commodityappraise:show', '0', '1', '/admin/commodityappraise/list/1/15.htm', '22');
INSERT INTO `t_res` VALUES ('24', null, '2018-04-14 10:56:11.023000', '1', '1', '修改评价', 'admin:commodityappraise:update', '0', '2', '', '22');
INSERT INTO `t_res` VALUES ('25', null, '2018-04-14 10:56:21.683000', '1', '1', '删除评价', 'admin:commodityappraise:delete', '0', '2', '', '22');
INSERT INTO `t_res` VALUES ('26', null, '2018-04-13 16:15:01.986000', '1', '1', '售后订单', 'admin:customerservice:show', '0', '1', '/admin/customerservice/list/1/15.htm', '44');
INSERT INTO `t_res` VALUES ('27', null, '2018-04-13 16:15:18.529000', '1', '1', '处理售后', 'admin:customerservice:update', '0', '2', '', '44');
INSERT INTO `t_res` VALUES ('28', null, '2018-04-13 14:53:43.424000', '1', '1', '分销中心', '', '0', '1', '', '1');
INSERT INTO `t_res` VALUES ('29', null, '2018-04-13 15:44:37.343000', '1', '1', '分销管理', 'admin:distribution:distributionCenter', '0', '1', '/admin/distribution/distributionCenter.htm', '28');
INSERT INTO `t_res` VALUES ('30', null, '2018-04-13 15:06:23.109000', '1', '1', '分销比例设置', 'admin:distribution:setRat', '0', '1', '/admin/distribution/setRat.htm', '28');
INSERT INTO `t_res` VALUES ('31', null, '2018-04-13 15:07:58.412000', '1', '1', '分销下属', 'admin:distribution:distributionMember', '0', '1', '/admin/distribution/distributionMember.htm', '28');
INSERT INTO `t_res` VALUES ('32', null, '2018-04-13 15:08:40.162000', '1', '1', '财务管理', '', '0', '1', '', '1');
INSERT INTO `t_res` VALUES ('33', null, '2018-04-13 15:09:55.692000', '1', '1', '提现记录', 'admin:draw:show', '0', '1', '/admin/draw/list/1/15.htm', '32');
INSERT INTO `t_res` VALUES ('34', null, '2018-04-13 15:10:46.443000', '1', '1', '管理员中心', '', '0', '1', '', '1');
INSERT INTO `t_res` VALUES ('35', null, '2018-04-13 15:11:43.358000', '1', '1', '管理员管理', 'admin:sys:user:show', '0', '1', '/admin/sys/user/list/1/15.htm', '34');
INSERT INTO `t_res` VALUES ('36', null, '2018-04-13 15:12:12.382000', '1', '1', '添加管理员', 'admin:sys:user:add', '0', '2', '', '35');
INSERT INTO `t_res` VALUES ('37', null, '2018-04-13 15:12:51.566000', '1', '1', '修改管理员信息', 'admin:sys:user:update', '0', '2', '', '35');
INSERT INTO `t_res` VALUES ('38', null, '2018-04-13 15:13:07.038000', '1', '1', '删除管理员', 'admin:sys:user:delete', '0', '2', '', '35');
INSERT INTO `t_res` VALUES ('39', null, '2018-04-13 15:14:26.077000', '1', '1', '资源管理', 'admin:sys:res:show', '0', '1', '/admin/sys/res/list/1/15.htm', '34');
INSERT INTO `t_res` VALUES ('40', null, '2018-04-13 15:15:09.940000', '1', '1', '添加资源', 'admin:sys:res:add', '0', '2', '', '39');
INSERT INTO `t_res` VALUES ('41', null, '2018-04-13 15:15:26.382000', '1', '1', '修改资源', 'admin:sys:res:update', '0', '2', '', '39');
INSERT INTO `t_res` VALUES ('42', null, '2018-04-13 15:16:08.348000', '1', '1', '删除资源', 'admin:sys:res:delete', '0', '2', '', '39');
INSERT INTO `t_res` VALUES ('43', null, '2018-04-13 15:17:23.051000', '1', '1', '备份数据库', 'admin:sys:bakupData', '0', '1', '/admin/sys/bakupData.htm', '34');
INSERT INTO `t_res` VALUES ('44', null, '2018-04-16 09:25:20.904000', '1', '1', '会员服务', '', '0', '1', '', '1');
INSERT INTO `t_res` VALUES ('45', null, '2018-04-13 16:27:16.431000', '1', '1', '设置管理员权限', 'admin:user:setRes', '0', '2', '', '35');
INSERT INTO `t_res` VALUES ('46', null, '2018-04-13 17:12:21.693000', '1', '1', '查看登录日志', 'admin:sys:loginlog:show', '0', '1', '/admin/sys/loginlog/list/1/15.htm', '34');
INSERT INTO `t_res` VALUES ('47', null, '2018-04-13 17:12:06.969000', '1', '1', '查看操作日志', 'admin:sys:optlog:show', '0', '1', '/admin/sys/optlog/list/1/15.htm', '34');
INSERT INTO `t_res` VALUES ('48', null, '2018-04-14 09:29:26.158000', '1', '1', '收货地址', 'admin:memberaddress:show', '0', '1', '/admin/memberaddress/list/1/15.htm', '2');
INSERT INTO `t_res` VALUES ('49', null, '2018-04-14 09:22:31.685000', '1', '1', '添加收货地址', 'admin:memberaddress:add', '0', '2', '', '2');
INSERT INTO `t_res` VALUES ('50', null, '2018-04-14 09:23:03.277000', '1', '1', '删除收货地址', 'admin:memberaddress:delete', '0', '2', '', '2');
INSERT INTO `t_res` VALUES ('51', null, '2018-04-14 09:23:28.564000', '1', '1', '修改收货地址', 'admin:memberaddress:update', '0', '2', '', '2');
INSERT INTO `t_res` VALUES ('52', null, '2018-04-14 11:44:38.093000', '1', '1', '商品详情', 'admin:commodity:details', '0', '2', '', '13');
INSERT INTO `t_res` VALUES ('53', null, '2018-04-14 12:06:40.009000', '1', '1', '会员详情', 'admin:member:datails', '0', '2', '', '2');
INSERT INTO `t_res` VALUES ('54', null, '2018-04-17 09:26:37.065000', '1', '1', '商品评价', 'admin:commodityevaluation:show', '0', '1', '/admin/commodityevaluation/list/1/15.htm', '13');
INSERT INTO `t_res` VALUES ('55', null, '2018-04-14 14:37:57.391000', '2', '1', '添加评价', 'admin:memberevaluation:add', '0', '2', '', '2');
INSERT INTO `t_res` VALUES ('56', null, '2018-04-17 09:27:32.969000', '1', '1', '修改评价', 'admin:commodityevaluation:update', '0', '2', '', '13');
INSERT INTO `t_res` VALUES ('57', null, '2018-04-17 09:28:13.143000', '1', '1', '删除评价', 'admin:commodityevaluation:delete', '0', '2', '', '13');
INSERT INTO `t_res` VALUES ('58', null, '2018-04-14 15:19:32.485000', '1', '1', '商品规格', 'admin:commodityspecification:show', '0', '1', '/admin/commodityspecification/list/1/15.htm', '13');
INSERT INTO `t_res` VALUES ('59', null, '2018-04-14 15:22:39.900000', '1', '1', '添加规格', 'admin:commodityspecification:add', '0', '2', '', '13');
INSERT INTO `t_res` VALUES ('60', null, '2018-04-14 15:23:20.392000', '1', '1', '修改规格', 'admin:commodityspecification:update', '0', '2', '', '13');
INSERT INTO `t_res` VALUES ('61', null, '2018-04-14 15:23:48.798000', '1', '1', '删除规格', 'admin:commodityspecification:delete', '0', '2', '', '13');
INSERT INTO `t_res` VALUES ('62', null, '2018-04-14 17:55:05.181000', '1', '1', '会员账单', 'admin:memberbill:show', '0', '1', '/admin/memberbill/list/1/15.htm', '3');
INSERT INTO `t_res` VALUES ('63', null, '2018-04-14 17:46:35.073000', '2', '1', '会员佣金', 'admin:memberbrokerage:show', '0', '1', '/admin/memberbrokerage/list/1/15.htm', '2');
INSERT INTO `t_res` VALUES ('64', null, '2018-04-14 17:54:55.930000', '1', '1', '添加账单', 'admin:memberbill:add', '0', '2', '', '3');
INSERT INTO `t_res` VALUES ('65', null, '2018-04-14 17:55:19.629000', '1', '1', '修改账单', 'admin:memberbill:update', '0', '2', '', '3');
INSERT INTO `t_res` VALUES ('66', null, '2018-04-14 17:54:44.599000', '1', '1', '删除账单', 'admin:memberbill:delete', '0', '2', '', '3');
INSERT INTO `t_res` VALUES ('67', null, '2018-04-14 17:54:07.509000', '2', '1', '添加佣金', 'admin:memberbrokerage:add', '0', '2', '', '3');
INSERT INTO `t_res` VALUES ('68', null, '2018-04-14 17:53:33.945000', '2', '1', '修改佣金', 'admin:memberbrokerage:update', '0', '2', '', '3');
INSERT INTO `t_res` VALUES ('69', null, '2018-04-14 17:53:23.820000', '2', '1', '删除佣金', 'admin:memberbrokerage:delete', '0', '2', '', '3');
INSERT INTO `t_res` VALUES ('70', null, '2018-04-16 11:19:38.527000', '1', '1', '自动回复管理', 'admin:automsg:show', '0', '1', '/admin/automsg/list/0/1/15.htm', '44');
INSERT INTO `t_res` VALUES ('71', null, '2018-04-16 09:59:09.559000', '1', '1', '添加自动回复', 'admin:automsg:add', '0', '2', '', '70');
INSERT INTO `t_res` VALUES ('72', null, '2018-04-16 09:59:28.553000', '1', '1', '修改自动回复', 'admin:automsg:update', '0', '2', '', '70');
INSERT INTO `t_res` VALUES ('73', null, '2018-04-16 09:59:45.938000', '1', '1', '删除自动回复', 'admin:automsg:delete', '0', '2', '', '70');
INSERT INTO `t_res` VALUES ('74', null, '2018-04-16 10:47:29.566000', '1', '1', '回复类型管理', 'admin:automsgtype:show', '0', '1', '/admin/automsgtype/list/1/15.htm', '44');
INSERT INTO `t_res` VALUES ('75', null, '2018-04-16 10:46:03.922000', '1', '1', '添加类型', 'admin:automsgtype:add', '0', '2', '', '74');
INSERT INTO `t_res` VALUES ('76', null, '2018-04-16 10:46:28.335000', '1', '1', '修改类型', 'admin:automsgtype:update', '0', '2', '', '74');
INSERT INTO `t_res` VALUES ('77', null, '2018-04-16 10:46:44.252000', '1', '1', '删除类型', 'admin:automsgtype:delete', '0', '2', '', '74');
INSERT INTO `t_res` VALUES ('78', null, '2018-04-16 10:55:25.230000', '2', '1', '添加订单', 'admin:order:add', '0', '2', '', '18');
INSERT INTO `t_res` VALUES ('79', null, '2018-04-16 12:11:58.353000', '1', '1', '订单详情', 'admin:order:details', '0', '2', '', '18');
INSERT INTO `t_res` VALUES ('80', null, '2018-04-17 10:10:11.541000', '1', '1', '发货管理', '', '0', '1', '/admin/order/list1/1/15.htm', '18');
INSERT INTO `t_res` VALUES ('81', null, '2018-04-17 10:04:35.659000', '2', '1', '退货管理', '', '0', '1', '', '18');
INSERT INTO `t_res` VALUES ('82', null, '2018-04-17 10:14:18.177000', '1', '1', '查看', '', '0', '2', '', '80');
INSERT INTO `t_res` VALUES ('83', null, '2018-04-17 10:14:49.727000', '1', '1', '确认发货', '', '0', '2', '', '80');
INSERT INTO `t_res` VALUES ('84', null, '2018-04-17 10:15:08.150000', '1', '1', '备注', '', '0', '2', '', '80');
INSERT INTO `t_res` VALUES ('85', null, '2018-04-17 10:10:37.621000', '1', '1', '退货管理', '', '0', '1', '/admin/order/list2/1/15.htm', '18');
INSERT INTO `t_res` VALUES ('86', null, '2018-04-17 10:15:31.054000', '1', '1', '查看', '', '0', '2', '', '85');
INSERT INTO `t_res` VALUES ('87', null, '2018-04-17 10:15:54.505000', '1', '1', '拒绝', '', '0', '2', '', '85');
INSERT INTO `t_res` VALUES ('88', null, '2018-04-17 10:16:14.084000', '1', '1', '同意', '', '0', '2', '', '85');
INSERT INTO `t_res` VALUES ('89', null, '2018-04-17 10:31:42.792000', '1', '1', '账单列表', 'admin:memberbill:show', '0', '1', '/admin/memberbill/list/1/15.htm', '32');
INSERT INTO `t_res` VALUES ('90', null, '2018-04-17 10:40:09.446000', '1', '1', '删除账单', 'admin:memberbill:delete', '0', '2', '', '32');
INSERT INTO `t_res` VALUES ('91', null, '2018-04-17 10:40:45.697000', '1', '1', '修改账单', 'admin:memberbill:update', '0', '2', '', '32');
INSERT INTO `t_res` VALUES ('92', null, '2018-04-17 10:43:44.323000', '1', '1', '添加账单', 'admin:memberbill:add', '0', '2', '', '32');

-- ----------------------------
-- Table structure for `t_service`
-- ----------------------------
DROP TABLE IF EXISTS `t_service`;
CREATE TABLE `t_service` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `after_sales_problem` varchar(255) DEFAULT NULL,
  `commodity_issues` varchar(255) DEFAULT NULL,
  `how_to_buy` varchar(255) DEFAULT NULL,
  `logistics_problem` varchar(255) DEFAULT NULL,
  `order_problem` varchar(255) DEFAULT NULL,
  `promotion_of_problem` varchar(255) DEFAULT NULL,
  `the_invoice_issue` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_service
-- ----------------------------

-- ----------------------------
-- Table structure for `t_user`
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `last_login_date` datetime(6) DEFAULT NULL,
  `last_login_ip` varchar(255) DEFAULT NULL,
  `login_count` int(11) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `pass_error_times` int(11) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `sign` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', null, '2018-04-13 16:41:42.228000', '1', '1', '超级管理员', '/static/admin/img/user8-128x128.jpg', null, null, '0', '18174734499', '0', 'a', null, '0', null, 'admin');
INSERT INTO `t_user` VALUES ('2', null, '2018-04-23 10:23:40.030000', '1', '1', '梁', '/static/upload/image/20180417/1523932507202085046.jpg', null, null, '0', '13555555554', '0', '', null, '0', null, '123');
INSERT INTO `t_user` VALUES ('3', null, '2018-04-14 10:15:02.894000', '1', '1', '灰灰', '/static/admin/img/user8-128x128.jpg', null, null, '0', '18894717688', '0', 'asdfasdf,,,', null, '0', null, 'hh');
INSERT INTO `t_user` VALUES ('4', null, '2018-04-17 10:44:51.954000', '1', '1', '余毅', '/static/upload/image/20180417/1523928568424017433.jpg', null, null, '0', '18894717644', '0', 'yy', null, '0', null, 'yy');

-- ----------------------------
-- Table structure for `t_user_res`
-- ----------------------------
DROP TABLE IF EXISTS `t_user_res`;
CREATE TABLE `t_user_res` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` longtext,
  `create_time` datetime(6) DEFAULT NULL,
  `deleted` int(11) DEFAULT NULL,
  `enable` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `res_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9jnp8x22r714llhds35oe91pe` (`res_id`),
  KEY `FKqfnq1bbob94mdme33ftbqen9j` (`user_id`),
  CONSTRAINT `FK9jnp8x22r714llhds35oe91pe` FOREIGN KEY (`res_id`) REFERENCES `t_res` (`id`),
  CONSTRAINT `FKqfnq1bbob94mdme33ftbqen9j` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2435 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_res
-- ----------------------------
INSERT INTO `t_user_res` VALUES ('395', null, '2018-04-14 10:15:02.933000', '1', '1', null, '2', '3');
INSERT INTO `t_user_res` VALUES ('396', null, '2018-04-14 10:15:02.935000', '1', '1', null, '3', '3');
INSERT INTO `t_user_res` VALUES ('397', null, '2018-04-14 10:15:02.938000', '1', '1', null, '4', '3');
INSERT INTO `t_user_res` VALUES ('398', null, '2018-04-14 10:15:02.940000', '1', '1', null, '5', '3');
INSERT INTO `t_user_res` VALUES ('399', null, '2018-04-14 10:15:02.952000', '1', '1', null, '6', '3');
INSERT INTO `t_user_res` VALUES ('400', null, '2018-04-14 10:15:02.955000', '1', '1', null, '7', '3');
INSERT INTO `t_user_res` VALUES ('401', null, '2018-04-14 10:15:02.958000', '1', '1', null, '8', '3');
INSERT INTO `t_user_res` VALUES ('402', null, '2018-04-14 10:15:02.960000', '1', '1', null, '9', '3');
INSERT INTO `t_user_res` VALUES ('403', null, '2018-04-14 10:15:02.962000', '1', '1', null, '10', '3');
INSERT INTO `t_user_res` VALUES ('404', null, '2018-04-14 10:15:02.965000', '1', '1', null, '11', '3');
INSERT INTO `t_user_res` VALUES ('405', null, '2018-04-14 10:15:02.967000', '1', '1', null, '12', '3');
INSERT INTO `t_user_res` VALUES ('406', null, '2018-04-14 10:15:02.970000', '1', '1', null, '13', '3');
INSERT INTO `t_user_res` VALUES ('407', null, '2018-04-14 10:15:02.972000', '1', '1', null, '14', '3');
INSERT INTO `t_user_res` VALUES ('408', null, '2018-04-14 10:15:02.974000', '1', '1', null, '15', '3');
INSERT INTO `t_user_res` VALUES ('409', null, '2018-04-14 10:15:02.977000', '1', '1', null, '16', '3');
INSERT INTO `t_user_res` VALUES ('410', null, '2018-04-14 10:15:02.979000', '1', '1', null, '17', '3');
INSERT INTO `t_user_res` VALUES ('411', null, '2018-04-14 10:15:02.981000', '1', '1', null, '18', '3');
INSERT INTO `t_user_res` VALUES ('412', null, '2018-04-14 10:15:02.984000', '1', '1', null, '19', '3');
INSERT INTO `t_user_res` VALUES ('413', null, '2018-04-14 10:15:02.986000', '1', '1', null, '20', '3');
INSERT INTO `t_user_res` VALUES ('414', null, '2018-04-14 10:15:02.989000', '1', '1', null, '21', '3');
INSERT INTO `t_user_res` VALUES ('415', null, '2018-04-14 10:15:02.992000', '1', '1', null, '22', '3');
INSERT INTO `t_user_res` VALUES ('416', null, '2018-04-14 10:15:02.994000', '1', '1', null, '23', '3');
INSERT INTO `t_user_res` VALUES ('417', null, '2018-04-14 10:15:02.997000', '1', '1', null, '24', '3');
INSERT INTO `t_user_res` VALUES ('418', null, '2018-04-14 10:15:02.999000', '1', '1', null, '25', '3');
INSERT INTO `t_user_res` VALUES ('419', null, '2018-04-14 10:15:03.002000', '1', '1', null, '28', '3');
INSERT INTO `t_user_res` VALUES ('420', null, '2018-04-14 10:15:03.004000', '1', '1', null, '29', '3');
INSERT INTO `t_user_res` VALUES ('421', null, '2018-04-14 10:15:03.007000', '1', '1', null, '30', '3');
INSERT INTO `t_user_res` VALUES ('422', null, '2018-04-14 10:15:03.009000', '1', '1', null, '31', '3');
INSERT INTO `t_user_res` VALUES ('423', null, '2018-04-14 10:15:03.012000', '1', '1', null, '32', '3');
INSERT INTO `t_user_res` VALUES ('424', null, '2018-04-14 10:15:03.015000', '1', '1', null, '33', '3');
INSERT INTO `t_user_res` VALUES ('425', null, '2018-04-14 10:15:03.017000', '1', '1', null, '34', '3');
INSERT INTO `t_user_res` VALUES ('426', null, '2018-04-14 10:15:03.019000', '1', '1', null, '35', '3');
INSERT INTO `t_user_res` VALUES ('427', null, '2018-04-14 10:15:03.022000', '1', '1', null, '36', '3');
INSERT INTO `t_user_res` VALUES ('428', null, '2018-04-14 10:15:03.024000', '1', '1', null, '37', '3');
INSERT INTO `t_user_res` VALUES ('429', null, '2018-04-14 10:15:03.027000', '1', '1', null, '38', '3');
INSERT INTO `t_user_res` VALUES ('430', null, '2018-04-14 10:15:03.029000', '1', '1', null, '39', '3');
INSERT INTO `t_user_res` VALUES ('431', null, '2018-04-14 10:15:03.032000', '1', '1', null, '40', '3');
INSERT INTO `t_user_res` VALUES ('432', null, '2018-04-14 10:15:03.035000', '1', '1', null, '41', '3');
INSERT INTO `t_user_res` VALUES ('433', null, '2018-04-14 10:15:03.037000', '1', '1', null, '42', '3');
INSERT INTO `t_user_res` VALUES ('434', null, '2018-04-14 10:15:03.040000', '1', '1', null, '43', '3');
INSERT INTO `t_user_res` VALUES ('435', null, '2018-04-14 10:15:03.043000', '1', '1', null, '26', '3');
INSERT INTO `t_user_res` VALUES ('436', null, '2018-04-14 10:15:03.045000', '1', '1', null, '27', '3');
INSERT INTO `t_user_res` VALUES ('2268', null, '2018-04-17 10:44:52.224000', '1', '1', null, '2', '4');
INSERT INTO `t_user_res` VALUES ('2269', null, '2018-04-17 10:44:52.247000', '1', '1', null, '3', '4');
INSERT INTO `t_user_res` VALUES ('2270', null, '2018-04-17 10:44:52.269000', '1', '1', null, '4', '4');
INSERT INTO `t_user_res` VALUES ('2271', null, '2018-04-17 10:44:52.286000', '1', '1', null, '5', '4');
INSERT INTO `t_user_res` VALUES ('2272', null, '2018-04-17 10:44:52.306000', '1', '1', null, '6', '4');
INSERT INTO `t_user_res` VALUES ('2273', null, '2018-04-17 10:44:52.340000', '1', '1', null, '62', '4');
INSERT INTO `t_user_res` VALUES ('2274', null, '2018-04-17 10:44:52.360000', '1', '1', null, '64', '4');
INSERT INTO `t_user_res` VALUES ('2275', null, '2018-04-17 10:44:52.379000', '1', '1', null, '65', '4');
INSERT INTO `t_user_res` VALUES ('2276', null, '2018-04-17 10:44:52.404000', '1', '1', null, '66', '4');
INSERT INTO `t_user_res` VALUES ('2277', null, '2018-04-17 10:44:52.440000', '1', '1', null, '48', '4');
INSERT INTO `t_user_res` VALUES ('2278', null, '2018-04-17 10:44:52.507000', '1', '1', null, '49', '4');
INSERT INTO `t_user_res` VALUES ('2279', null, '2018-04-17 10:44:52.564000', '1', '1', null, '50', '4');
INSERT INTO `t_user_res` VALUES ('2280', null, '2018-04-17 10:44:52.608000', '1', '1', null, '51', '4');
INSERT INTO `t_user_res` VALUES ('2281', null, '2018-04-17 10:44:52.662000', '1', '1', null, '53', '4');
INSERT INTO `t_user_res` VALUES ('2282', null, '2018-04-17 10:44:52.692000', '1', '1', null, '8', '4');
INSERT INTO `t_user_res` VALUES ('2283', null, '2018-04-17 10:44:52.723000', '1', '1', null, '9', '4');
INSERT INTO `t_user_res` VALUES ('2284', null, '2018-04-17 10:44:52.751000', '1', '1', null, '10', '4');
INSERT INTO `t_user_res` VALUES ('2285', null, '2018-04-17 10:44:52.772000', '1', '1', null, '11', '4');
INSERT INTO `t_user_res` VALUES ('2286', null, '2018-04-17 10:44:52.794000', '1', '1', null, '12', '4');
INSERT INTO `t_user_res` VALUES ('2287', null, '2018-04-17 10:44:52.853000', '1', '1', null, '13', '4');
INSERT INTO `t_user_res` VALUES ('2288', null, '2018-04-17 10:44:52.875000', '1', '1', null, '14', '4');
INSERT INTO `t_user_res` VALUES ('2289', null, '2018-04-17 10:44:52.896000', '1', '1', null, '15', '4');
INSERT INTO `t_user_res` VALUES ('2290', null, '2018-04-17 10:44:52.914000', '1', '1', null, '16', '4');
INSERT INTO `t_user_res` VALUES ('2291', null, '2018-04-17 10:44:52.939000', '1', '1', null, '17', '4');
INSERT INTO `t_user_res` VALUES ('2292', null, '2018-04-17 10:44:52.967000', '1', '1', null, '52', '4');
INSERT INTO `t_user_res` VALUES ('2293', null, '2018-04-17 10:44:52.991000', '1', '1', null, '54', '4');
INSERT INTO `t_user_res` VALUES ('2294', null, '2018-04-17 10:44:53.014000', '1', '1', null, '56', '4');
INSERT INTO `t_user_res` VALUES ('2295', null, '2018-04-17 10:44:53.045000', '1', '1', null, '57', '4');
INSERT INTO `t_user_res` VALUES ('2296', null, '2018-04-17 10:44:53.083000', '1', '1', null, '58', '4');
INSERT INTO `t_user_res` VALUES ('2297', null, '2018-04-17 10:44:53.106000', '1', '1', null, '59', '4');
INSERT INTO `t_user_res` VALUES ('2298', null, '2018-04-17 10:44:53.125000', '1', '1', null, '60', '4');
INSERT INTO `t_user_res` VALUES ('2299', null, '2018-04-17 10:44:53.160000', '1', '1', null, '61', '4');
INSERT INTO `t_user_res` VALUES ('2300', null, '2018-04-17 10:44:53.179000', '1', '1', null, '18', '4');
INSERT INTO `t_user_res` VALUES ('2301', null, '2018-04-17 10:44:53.225000', '1', '1', null, '19', '4');
INSERT INTO `t_user_res` VALUES ('2302', null, '2018-04-17 10:44:53.276000', '1', '1', null, '20', '4');
INSERT INTO `t_user_res` VALUES ('2303', null, '2018-04-17 10:44:53.294000', '1', '1', null, '21', '4');
INSERT INTO `t_user_res` VALUES ('2304', null, '2018-04-17 10:44:53.319000', '1', '1', null, '79', '4');
INSERT INTO `t_user_res` VALUES ('2305', null, '2018-04-17 10:44:53.375000', '1', '1', null, '80', '4');
INSERT INTO `t_user_res` VALUES ('2306', null, '2018-04-17 10:44:53.395000', '1', '1', null, '82', '4');
INSERT INTO `t_user_res` VALUES ('2307', null, '2018-04-17 10:44:53.416000', '1', '1', null, '83', '4');
INSERT INTO `t_user_res` VALUES ('2308', null, '2018-04-17 10:44:53.447000', '1', '1', null, '84', '4');
INSERT INTO `t_user_res` VALUES ('2309', null, '2018-04-17 10:44:53.485000', '1', '1', null, '85', '4');
INSERT INTO `t_user_res` VALUES ('2310', null, '2018-04-17 10:44:53.510000', '1', '1', null, '86', '4');
INSERT INTO `t_user_res` VALUES ('2311', null, '2018-04-17 10:44:53.528000', '1', '1', null, '87', '4');
INSERT INTO `t_user_res` VALUES ('2312', null, '2018-04-17 10:44:53.555000', '1', '1', null, '88', '4');
INSERT INTO `t_user_res` VALUES ('2313', null, '2018-04-17 10:44:53.580000', '1', '1', null, '22', '4');
INSERT INTO `t_user_res` VALUES ('2314', null, '2018-04-17 10:44:53.598000', '1', '1', null, '23', '4');
INSERT INTO `t_user_res` VALUES ('2315', null, '2018-04-17 10:44:53.623000', '1', '1', null, '24', '4');
INSERT INTO `t_user_res` VALUES ('2316', null, '2018-04-17 10:44:53.639000', '1', '1', null, '25', '4');
INSERT INTO `t_user_res` VALUES ('2317', null, '2018-04-17 10:44:53.705000', '1', '1', null, '28', '4');
INSERT INTO `t_user_res` VALUES ('2318', null, '2018-04-17 10:44:53.726000', '1', '1', null, '29', '4');
INSERT INTO `t_user_res` VALUES ('2319', null, '2018-04-17 10:44:53.757000', '1', '1', null, '30', '4');
INSERT INTO `t_user_res` VALUES ('2320', null, '2018-04-17 10:44:53.795000', '1', '1', null, '31', '4');
INSERT INTO `t_user_res` VALUES ('2321', null, '2018-04-17 10:44:53.810000', '1', '1', null, '32', '4');
INSERT INTO `t_user_res` VALUES ('2322', null, '2018-04-17 10:44:53.838000', '1', '1', null, '33', '4');
INSERT INTO `t_user_res` VALUES ('2323', null, '2018-04-17 10:44:53.855000', '1', '1', null, '89', '4');
INSERT INTO `t_user_res` VALUES ('2324', null, '2018-04-17 10:44:53.883000', '1', '1', null, '90', '4');
INSERT INTO `t_user_res` VALUES ('2325', null, '2018-04-17 10:44:53.896000', '1', '1', null, '91', '4');
INSERT INTO `t_user_res` VALUES ('2326', null, '2018-04-17 10:44:53.910000', '1', '1', null, '92', '4');
INSERT INTO `t_user_res` VALUES ('2327', null, '2018-04-17 10:44:53.923000', '1', '1', null, '34', '4');
INSERT INTO `t_user_res` VALUES ('2328', null, '2018-04-17 10:44:53.938000', '1', '1', null, '35', '4');
INSERT INTO `t_user_res` VALUES ('2329', null, '2018-04-17 10:44:53.949000', '1', '1', null, '36', '4');
INSERT INTO `t_user_res` VALUES ('2330', null, '2018-04-17 10:44:53.992000', '1', '1', null, '37', '4');
INSERT INTO `t_user_res` VALUES ('2331', null, '2018-04-17 10:44:54.009000', '1', '1', null, '38', '4');
INSERT INTO `t_user_res` VALUES ('2332', null, '2018-04-17 10:44:54.025000', '1', '1', null, '45', '4');
INSERT INTO `t_user_res` VALUES ('2333', null, '2018-04-17 10:44:54.041000', '1', '1', null, '39', '4');
INSERT INTO `t_user_res` VALUES ('2334', null, '2018-04-17 10:44:54.082000', '1', '1', null, '40', '4');
INSERT INTO `t_user_res` VALUES ('2335', null, '2018-04-17 10:44:54.100000', '1', '1', null, '41', '4');
INSERT INTO `t_user_res` VALUES ('2336', null, '2018-04-17 10:44:54.150000', '1', '1', null, '42', '4');
INSERT INTO `t_user_res` VALUES ('2337', null, '2018-04-17 10:44:54.181000', '1', '1', null, '43', '4');
INSERT INTO `t_user_res` VALUES ('2338', null, '2018-04-17 10:44:54.199000', '1', '1', null, '46', '4');
INSERT INTO `t_user_res` VALUES ('2339', null, '2018-04-17 10:44:54.214000', '1', '1', null, '47', '4');
INSERT INTO `t_user_res` VALUES ('2340', null, '2018-04-17 10:44:54.233000', '1', '1', null, '44', '4');
INSERT INTO `t_user_res` VALUES ('2341', null, '2018-04-17 10:44:54.248000', '1', '1', null, '26', '4');
INSERT INTO `t_user_res` VALUES ('2342', null, '2018-04-17 10:44:54.296000', '1', '1', null, '27', '4');
INSERT INTO `t_user_res` VALUES ('2343', null, '2018-04-17 10:44:54.308000', '1', '1', null, '70', '4');
INSERT INTO `t_user_res` VALUES ('2344', null, '2018-04-17 10:44:54.321000', '1', '1', null, '71', '4');
INSERT INTO `t_user_res` VALUES ('2345', null, '2018-04-17 10:44:54.345000', '1', '1', null, '72', '4');
INSERT INTO `t_user_res` VALUES ('2346', null, '2018-04-17 10:44:54.385000', '1', '1', null, '73', '4');
INSERT INTO `t_user_res` VALUES ('2347', null, '2018-04-17 10:44:54.407000', '1', '1', null, '74', '4');
INSERT INTO `t_user_res` VALUES ('2348', null, '2018-04-17 10:44:54.433000', '1', '1', null, '75', '4');
INSERT INTO `t_user_res` VALUES ('2349', null, '2018-04-17 10:44:54.450000', '1', '1', null, '76', '4');
INSERT INTO `t_user_res` VALUES ('2350', null, '2018-04-17 10:44:54.477000', '1', '1', null, '77', '4');
INSERT INTO `t_user_res` VALUES ('2351', null, '2018-04-23 10:23:40.420000', '1', '1', null, '2', '2');
INSERT INTO `t_user_res` VALUES ('2352', null, '2018-04-23 10:23:40.470000', '1', '1', null, '3', '2');
INSERT INTO `t_user_res` VALUES ('2353', null, '2018-04-23 10:23:40.500000', '1', '1', null, '4', '2');
INSERT INTO `t_user_res` VALUES ('2354', null, '2018-04-23 10:23:40.560000', '1', '1', null, '5', '2');
INSERT INTO `t_user_res` VALUES ('2355', null, '2018-04-23 10:23:40.640000', '1', '1', null, '6', '2');
INSERT INTO `t_user_res` VALUES ('2356', null, '2018-04-23 10:23:40.690000', '1', '1', null, '62', '2');
INSERT INTO `t_user_res` VALUES ('2357', null, '2018-04-23 10:23:40.710000', '1', '1', null, '64', '2');
INSERT INTO `t_user_res` VALUES ('2358', null, '2018-04-23 10:23:40.740000', '1', '1', null, '65', '2');
INSERT INTO `t_user_res` VALUES ('2359', null, '2018-04-23 10:23:40.780000', '1', '1', null, '66', '2');
INSERT INTO `t_user_res` VALUES ('2360', null, '2018-04-23 10:23:40.810000', '1', '1', null, '7', '2');
INSERT INTO `t_user_res` VALUES ('2361', null, '2018-04-23 10:23:40.850000', '1', '1', null, '48', '2');
INSERT INTO `t_user_res` VALUES ('2362', null, '2018-04-23 10:23:40.890000', '1', '1', null, '49', '2');
INSERT INTO `t_user_res` VALUES ('2363', null, '2018-04-23 10:23:40.970000', '1', '1', null, '50', '2');
INSERT INTO `t_user_res` VALUES ('2364', null, '2018-04-23 10:23:41.110000', '1', '1', null, '51', '2');
INSERT INTO `t_user_res` VALUES ('2365', null, '2018-04-23 10:23:41.130000', '1', '1', null, '53', '2');
INSERT INTO `t_user_res` VALUES ('2366', null, '2018-04-23 10:23:41.170000', '1', '1', null, '8', '2');
INSERT INTO `t_user_res` VALUES ('2367', null, '2018-04-23 10:23:41.210000', '1', '1', null, '9', '2');
INSERT INTO `t_user_res` VALUES ('2368', null, '2018-04-23 10:23:41.230000', '1', '1', null, '10', '2');
INSERT INTO `t_user_res` VALUES ('2369', null, '2018-04-23 10:23:41.260000', '1', '1', null, '11', '2');
INSERT INTO `t_user_res` VALUES ('2370', null, '2018-04-23 10:23:41.320000', '1', '1', null, '12', '2');
INSERT INTO `t_user_res` VALUES ('2371', null, '2018-04-23 10:23:41.360000', '1', '1', null, '13', '2');
INSERT INTO `t_user_res` VALUES ('2372', null, '2018-04-23 10:23:41.400000', '1', '1', null, '14', '2');
INSERT INTO `t_user_res` VALUES ('2373', null, '2018-04-23 10:23:41.430000', '1', '1', null, '15', '2');
INSERT INTO `t_user_res` VALUES ('2374', null, '2018-04-23 10:23:41.460000', '1', '1', null, '16', '2');
INSERT INTO `t_user_res` VALUES ('2375', null, '2018-04-23 10:23:41.510000', '1', '1', null, '17', '2');
INSERT INTO `t_user_res` VALUES ('2376', null, '2018-04-23 10:23:41.550000', '1', '1', null, '52', '2');
INSERT INTO `t_user_res` VALUES ('2377', null, '2018-04-23 10:23:41.570000', '1', '1', null, '54', '2');
INSERT INTO `t_user_res` VALUES ('2378', null, '2018-04-23 10:23:41.610000', '1', '1', null, '56', '2');
INSERT INTO `t_user_res` VALUES ('2379', null, '2018-04-23 10:23:41.640000', '1', '1', null, '57', '2');
INSERT INTO `t_user_res` VALUES ('2380', null, '2018-04-23 10:23:41.720000', '1', '1', null, '58', '2');
INSERT INTO `t_user_res` VALUES ('2381', null, '2018-04-23 10:23:41.750000', '1', '1', null, '59', '2');
INSERT INTO `t_user_res` VALUES ('2382', null, '2018-04-23 10:23:41.810000', '1', '1', null, '60', '2');
INSERT INTO `t_user_res` VALUES ('2383', null, '2018-04-23 10:23:41.840000', '1', '1', null, '61', '2');
INSERT INTO `t_user_res` VALUES ('2384', null, '2018-04-23 10:23:41.870000', '1', '1', null, '18', '2');
INSERT INTO `t_user_res` VALUES ('2385', null, '2018-04-23 10:23:41.940000', '1', '1', null, '19', '2');
INSERT INTO `t_user_res` VALUES ('2386', null, '2018-04-23 10:23:41.970000', '1', '1', null, '20', '2');
INSERT INTO `t_user_res` VALUES ('2387', null, '2018-04-23 10:23:42.040000', '1', '1', null, '21', '2');
INSERT INTO `t_user_res` VALUES ('2388', null, '2018-04-23 10:23:42.070000', '1', '1', null, '79', '2');
INSERT INTO `t_user_res` VALUES ('2389', null, '2018-04-23 10:23:42.120000', '1', '1', null, '80', '2');
INSERT INTO `t_user_res` VALUES ('2390', null, '2018-04-23 10:23:42.140000', '1', '1', null, '82', '2');
INSERT INTO `t_user_res` VALUES ('2391', null, '2018-04-23 10:23:42.170000', '1', '1', null, '83', '2');
INSERT INTO `t_user_res` VALUES ('2392', null, '2018-04-23 10:23:42.210000', '1', '1', null, '84', '2');
INSERT INTO `t_user_res` VALUES ('2393', null, '2018-04-23 10:23:42.240000', '1', '1', null, '85', '2');
INSERT INTO `t_user_res` VALUES ('2394', null, '2018-04-23 10:23:42.290000', '1', '1', null, '86', '2');
INSERT INTO `t_user_res` VALUES ('2395', null, '2018-04-23 10:23:42.350000', '1', '1', null, '87', '2');
INSERT INTO `t_user_res` VALUES ('2396', null, '2018-04-23 10:23:42.370000', '1', '1', null, '88', '2');
INSERT INTO `t_user_res` VALUES ('2397', null, '2018-04-23 10:23:42.410000', '1', '1', null, '22', '2');
INSERT INTO `t_user_res` VALUES ('2398', null, '2018-04-23 10:23:42.450000', '1', '1', null, '23', '2');
INSERT INTO `t_user_res` VALUES ('2399', null, '2018-04-23 10:23:42.490000', '1', '1', null, '24', '2');
INSERT INTO `t_user_res` VALUES ('2400', null, '2018-04-23 10:23:42.520000', '1', '1', null, '25', '2');
INSERT INTO `t_user_res` VALUES ('2401', null, '2018-04-23 10:23:42.550000', '1', '1', null, '28', '2');
INSERT INTO `t_user_res` VALUES ('2402', null, '2018-04-23 10:23:42.570000', '1', '1', null, '29', '2');
INSERT INTO `t_user_res` VALUES ('2403', null, '2018-04-23 10:23:42.590000', '1', '1', null, '30', '2');
INSERT INTO `t_user_res` VALUES ('2404', null, '2018-04-23 10:23:42.620000', '1', '1', null, '31', '2');
INSERT INTO `t_user_res` VALUES ('2405', null, '2018-04-23 10:23:42.650000', '1', '1', null, '32', '2');
INSERT INTO `t_user_res` VALUES ('2406', null, '2018-04-23 10:23:42.670000', '1', '1', null, '33', '2');
INSERT INTO `t_user_res` VALUES ('2407', null, '2018-04-23 10:23:42.710000', '1', '1', null, '89', '2');
INSERT INTO `t_user_res` VALUES ('2408', null, '2018-04-23 10:23:42.740000', '1', '1', null, '90', '2');
INSERT INTO `t_user_res` VALUES ('2409', null, '2018-04-23 10:23:42.770000', '1', '1', null, '91', '2');
INSERT INTO `t_user_res` VALUES ('2410', null, '2018-04-23 10:23:42.790000', '1', '1', null, '92', '2');
INSERT INTO `t_user_res` VALUES ('2411', null, '2018-04-23 10:23:42.830000', '1', '1', null, '34', '2');
INSERT INTO `t_user_res` VALUES ('2412', null, '2018-04-23 10:23:42.860000', '1', '1', null, '35', '2');
INSERT INTO `t_user_res` VALUES ('2413', null, '2018-04-23 10:23:42.900000', '1', '1', null, '36', '2');
INSERT INTO `t_user_res` VALUES ('2414', null, '2018-04-23 10:23:43.350000', '1', '1', null, '37', '2');
INSERT INTO `t_user_res` VALUES ('2415', null, '2018-04-23 10:23:45.270000', '1', '1', null, '38', '2');
INSERT INTO `t_user_res` VALUES ('2416', null, '2018-04-23 10:23:45.310000', '1', '1', null, '45', '2');
INSERT INTO `t_user_res` VALUES ('2417', null, '2018-04-23 10:23:45.330000', '1', '1', null, '39', '2');
INSERT INTO `t_user_res` VALUES ('2418', null, '2018-04-23 10:23:45.370000', '1', '1', null, '40', '2');
INSERT INTO `t_user_res` VALUES ('2419', null, '2018-04-23 10:23:45.410000', '1', '1', null, '41', '2');
INSERT INTO `t_user_res` VALUES ('2420', null, '2018-04-23 10:23:45.460000', '1', '1', null, '42', '2');
INSERT INTO `t_user_res` VALUES ('2421', null, '2018-04-23 10:23:45.500000', '1', '1', null, '43', '2');
INSERT INTO `t_user_res` VALUES ('2422', null, '2018-04-23 10:23:45.530000', '1', '1', null, '46', '2');
INSERT INTO `t_user_res` VALUES ('2423', null, '2018-04-23 10:23:45.580000', '1', '1', null, '47', '2');
INSERT INTO `t_user_res` VALUES ('2424', null, '2018-04-23 10:23:45.620000', '1', '1', null, '44', '2');
INSERT INTO `t_user_res` VALUES ('2425', null, '2018-04-23 10:23:45.650000', '1', '1', null, '26', '2');
INSERT INTO `t_user_res` VALUES ('2426', null, '2018-04-23 10:23:45.730000', '1', '1', null, '27', '2');
INSERT INTO `t_user_res` VALUES ('2427', null, '2018-04-23 10:23:45.760000', '1', '1', null, '70', '2');
INSERT INTO `t_user_res` VALUES ('2428', null, '2018-04-23 10:23:45.790000', '1', '1', null, '71', '2');
INSERT INTO `t_user_res` VALUES ('2429', null, '2018-04-23 10:23:45.820000', '1', '1', null, '72', '2');
INSERT INTO `t_user_res` VALUES ('2430', null, '2018-04-23 10:23:45.850000', '1', '1', null, '73', '2');
INSERT INTO `t_user_res` VALUES ('2431', null, '2018-04-23 10:23:45.880000', '1', '1', null, '74', '2');
INSERT INTO `t_user_res` VALUES ('2432', null, '2018-04-23 10:23:45.910000', '1', '1', null, '75', '2');
INSERT INTO `t_user_res` VALUES ('2433', null, '2018-04-23 10:23:45.960000', '1', '1', null, '76', '2');
INSERT INTO `t_user_res` VALUES ('2434', null, '2018-04-23 10:23:46.020000', '1', '1', null, '77', '2');
