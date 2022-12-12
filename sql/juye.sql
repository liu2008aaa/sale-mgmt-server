/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50614
Source Host           : 127.0.0.1:53306
Source Database       : juye

Target Server Type    : MYSQL
Target Server Version : 50614
File Encoding         : 65001

Date: 2016-03-24 11:51:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tab_accounts
-- ----------------------------
DROP TABLE IF EXISTS `tab_accounts`;
CREATE TABLE `tab_accounts` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `orderid` int(8) DEFAULT NULL COMMENT '订单号 ',
  `shippername` varchar(50) DEFAULT NULL COMMENT '发货单位名称 3',
  `receivingname` varchar(50) DEFAULT NULL COMMENT '收货单位 名称 4',
  `carhome` varchar(50) DEFAULT NULL COMMENT '车辆所属公司 5',
  `platenumber` varchar(50) DEFAULT NULL COMMENT '车牌号 6',
  `vecturatype` int(8) DEFAULT NULL COMMENT '货运类型 长途、短途',
  `sgw` varchar(50) DEFAULT NULL COMMENT '发货 毛重 8',
  `stw` varchar(50) DEFAULT NULL COMMENT '发货 皮重 10',
  `snw` varchar(50) DEFAULT NULL COMMENT '发货 净重 12',
  `rnw` varchar(50) DEFAULT NULL COMMENT '收货 净重 13',
  `coaltype` varchar(50) DEFAULT NULL COMMENT '煤型 14',
  `losston` varchar(50) DEFAULT NULL COMMENT '亏吨数 15',
  `money` varchar(50) DEFAULT NULL COMMENT '余额 16',
  `coaltypeprice` varchar(50) DEFAULT NULL COMMENT '煤型单价 17',
  `lossratio` varchar(50) DEFAULT NULL COMMENT '正常亏损率 18',
  `normallosston` varchar(50) DEFAULT NULL COMMENT '正常亏吨数 19',
  `beyonds` varchar(50) DEFAULT NULL COMMENT '超亏吨数 20',
  `shipperprice` varchar(50) DEFAULT NULL COMMENT '发货单位运费单价 21',
  `shippercost` varchar(50) DEFAULT NULL COMMENT '发货单位运费 22',
  `chauffeurprice` varchar(50) DEFAULT NULL COMMENT '司机运费单价 23',
  `chauffeurcost` varchar(50) DEFAULT NULL COMMENT '司机运费 24',
  `status` int(8) DEFAULT NULL COMMENT '结算状态 0:全部，1：未结算，2：已结算 25',
  `datetime` datetime DEFAULT NULL COMMENT '发货日期 26',
  `data_index` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tab_losston
-- ----------------------------
DROP TABLE IF EXISTS `tab_losston`;
CREATE TABLE `tab_losston` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `orderid` int(8) DEFAULT NULL COMMENT '订单 编号',
  `price` varchar(50) DEFAULT NULL COMMENT '煤型单价',
  `lossratio` varchar(50) DEFAULT NULL COMMENT '正常亏损率',
  `normallosston` varchar(50) DEFAULT NULL COMMENT '正常亏吨数',
  `beyonds` varchar(50) DEFAULT NULL COMMENT '超亏吨数',
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for tab_orderform
-- ----------------------------
DROP TABLE IF EXISTS `tab_orderform`;
CREATE TABLE `tab_orderform` (
  `id` int(8) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `shipperid` int(8) DEFAULT NULL COMMENT '发货单位id',
  `shippername` varchar(50) DEFAULT NULL COMMENT '发货单位名称',
  `receivingname` varchar(50) DEFAULT NULL COMMENT '收货单位 名称',
  `carhome` varchar(50) DEFAULT NULL COMMENT '车辆所属公司',
  `platenumber` varchar(50) DEFAULT NULL COMMENT '车牌号',
  `vecturatype` int(8) DEFAULT NULL COMMENT '货运类型 长途、短途',
  `sgw` varchar(50) DEFAULT NULL COMMENT '发货 毛重',
  `stw` varchar(50) DEFAULT NULL COMMENT '发货 皮重',
  `snw` varchar(50) DEFAULT NULL COMMENT '发货 净重',
  `rnw` varchar(50) DEFAULT NULL COMMENT '收货 净重',
  `coaltype` varchar(50) DEFAULT NULL COMMENT '煤型',
  `losston` varchar(50) DEFAULT NULL COMMENT '亏吨数',
  `status` int(8) DEFAULT NULL COMMENT '操作状态--0:初始;1:已发货;2:已收货,3:已结算',
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '数据录入 日期',
  `data_index` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conditionIndex` (`id`,`shippername`,`receivingname`,`carhome`,`platenumber`,`vecturatype`,`coaltype`,`status`,`datetime`),
  KEY `conditionIndexForAccounts` (`id`,`shippername`,`receivingname`,`carhome`,`platenumber`,`vecturatype`,`coaltype`,`datetime`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for tab_shipper
-- ----------------------------
DROP TABLE IF EXISTS `tab_shipper`;
CREATE TABLE `tab_shipper` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) DEFAULT NULL COMMENT '发货单位名称',
  `money` varchar(50) DEFAULT NULL COMMENT '余额',
  `restriction` varchar(50) DEFAULT NULL COMMENT '超额限定',
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '日期',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

