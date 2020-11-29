/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.7.26 : Database - think_admin
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`think_admin` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `think_admin`;

/*Table structure for table `company_user` */

DROP TABLE IF EXISTS `company_user`;

CREATE TABLE `company_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nickname` varchar(50) DEFAULT '' COMMENT '员工姓名',
  `svn_username` varchar(50) DEFAULT '' COMMENT '员工账号',
  `svn_password` varchar(32) DEFAULT '' COMMENT '员工密码',
  `svn_authorize` varchar(255) DEFAULT '' COMMENT '权限授权',
  `user_type` varchar(20) DEFAULT '' COMMENT '员工身份',
  `entry_date` varchar(30) DEFAULT '' COMMENT '入职日期',
  `leave_date` varchar(30) DEFAULT '' COMMENT '离职日期',
  `become_date` varchar(30) DEFAULT '' COMMENT '转正日期',
  `contact_qq` varchar(16) DEFAULT '' COMMENT '联系QQ',
  `contact_mail` varchar(32) DEFAULT '' COMMENT '联系邮箱',
  `contact_phone` varchar(16) DEFAULT '' COMMENT '联系手机',
  `mobile_macs` text COMMENT '打卡手机',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(0禁用,1正常,2离职)',
  `sort` bigint(20) unsigned DEFAULT '0' COMMENT '排序权重',
  `is_deleted` tinyint(1) unsigned DEFAULT '0' COMMENT '删除(1删除,0未删)',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_company_user_nickname` (`nickname`) USING BTREE,
  KEY `idx_company_user_svn_username` (`svn_username`) USING BTREE,
  KEY `idx_company_user_deleted` (`is_deleted`) USING BTREE,
  KEY `idx_company_user_status` (`status`) USING BTREE,
  KEY `idx_company_user_type` (`user_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='企业-员工信息';

/*Data for the table `company_user` */

insert  into `company_user`(`id`,`nickname`,`svn_username`,`svn_password`,`svn_authorize`,`user_type`,`entry_date`,`leave_date`,`become_date`,`contact_qq`,`contact_mail`,`contact_phone`,`mobile_macs`,`status`,`sort`,`is_deleted`,`create_at`) values (1,'肖世成','123123','123213','0','php','2020-10-09','','2020-10-28','21312312312','123@qq.com','15279831247','',1,0,1,'2020-10-31 12:04:54');

/*Table structure for table `company_user_auth` */

DROP TABLE IF EXISTS `company_user_auth`;

CREATE TABLE `company_user_auth` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT '' COMMENT '权限名称',
  `path` varchar(500) DEFAULT '' COMMENT '权限路径',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(0禁用,1正常)',
  `desc` varchar(500) DEFAULT '' COMMENT '权限描述',
  `sort` bigint(20) unsigned DEFAULT '0' COMMENT '排序权重',
  `is_deleted` tinyint(1) unsigned DEFAULT '0' COMMENT '删除(1删除,0未删)',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_company_user_auth_status` (`status`) USING BTREE,
  KEY `idx_company_user_auth_deleted` (`is_deleted`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='企业-仓库权限';

/*Data for the table `company_user_auth` */

/*Table structure for table `company_user_clock` */

DROP TABLE IF EXISTS `company_user_clock`;

CREATE TABLE `company_user_clock` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) unsigned DEFAULT NULL COMMENT '用户ID',
  `name` varchar(20) DEFAULT NULL COMMENT '用户姓名',
  `ip` varchar(15) NOT NULL COMMENT '权限名称',
  `mac` char(17) DEFAULT '1' COMMENT '状态(1:禁用,2:启用)',
  `desc` varchar(255) DEFAULT NULL COMMENT '备注说明',
  `date` date DEFAULT NULL,
  `start_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `end_at` datetime DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_company_user_clock_date` (`date`) USING BTREE,
  KEY `idx_company_user_clock_uid` (`uid`) USING BTREE,
  KEY `idx_company_user_clock_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='企业-打卡记录';

/*Data for the table `company_user_clock` */

/*Table structure for table `s_class` */

DROP TABLE IF EXISTS `s_class`;

CREATE TABLE `s_class` (
  `id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `class_name` varchar(10) NOT NULL COMMENT '班级姓名',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `s_class` */

insert  into `s_class`(`id`,`class_name`) values (1,'一班'),(2,'二班'),(3,'三班');

/*Table structure for table `store_express_company` */

DROP TABLE IF EXISTS `store_express_company`;

CREATE TABLE `store_express_company` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `express_title` varchar(50) DEFAULT '' COMMENT '快递公司名称',
  `express_code` varchar(50) DEFAULT '' COMMENT '快递公司代码',
  `express_desc` varchar(512) DEFAULT '' COMMENT '快递公司描述',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(0.无效,1.有效)',
  `sort` bigint(20) unsigned DEFAULT '0' COMMENT '排序权重',
  `is_deleted` tinyint(1) unsigned DEFAULT '0' COMMENT '删除状态(1删除,0未删除)',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 COMMENT='商城-快递-公司';

/*Data for the table `store_express_company` */

insert  into `store_express_company`(`id`,`express_title`,`express_code`,`express_desc`,`status`,`sort`,`is_deleted`,`create_at`) values (5,'AAE全球专递','aae',NULL,0,0,0,'2017-09-12 11:53:40'),(6,'安捷快递','anjie','',0,0,0,'2017-09-13 15:27:26'),(7,'安信达快递','anxindakuaixi',NULL,0,0,0,'2017-09-13 16:05:19'),(8,'彪记快递','biaojikuaidi',NULL,0,0,0,'2017-09-13 16:05:26'),(9,'BHT','bht','',0,0,0,'2017-09-13 16:05:37'),(10,'百福东方国际物流','baifudongfang',NULL,0,0,0,'2017-09-13 16:05:41'),(11,'中国东方（COE）','coe',NULL,0,0,0,'2017-09-13 16:05:48'),(12,'长宇物流','changyuwuliu',NULL,0,0,0,'2017-09-13 16:05:58'),(13,'大田物流','datianwuliu',NULL,0,0,0,'2017-09-13 16:06:06'),(14,'德邦物流','debangwuliu','',0,1,0,'2017-09-13 16:06:14'),(15,'DHL','dhl',NULL,0,0,0,'2017-09-13 16:06:24'),(16,'DPEX','dpex',NULL,0,0,0,'2017-09-13 16:06:29'),(17,'d速快递','dsukuaidi',NULL,0,0,0,'2017-09-13 16:06:34'),(18,'递四方','disifang',NULL,0,0,0,'2017-09-13 16:06:40'),(19,'EMS快递','ems','',1,0,0,'2017-09-13 16:06:47'),(20,'FEDEX（国外）','fedex',NULL,0,0,0,'2017-09-13 16:06:56'),(21,'飞康达物流','feikangda',NULL,0,0,0,'2017-09-13 16:07:03'),(22,'凤凰快递','fenghuangkuaidi',NULL,0,0,0,'2017-09-13 16:07:10'),(23,'飞快达','feikuaida',NULL,0,0,0,'2017-09-13 16:07:16'),(24,'国通快递','guotongkuaidi',NULL,0,0,0,'2017-09-13 16:07:27'),(25,'港中能达物流','ganzhongnengda',NULL,0,0,0,'2017-09-13 16:07:33'),(26,'广东邮政物流','guangdongyouzhengwuliu',NULL,0,0,0,'2017-09-13 16:08:22'),(27,'共速达','gongsuda',NULL,0,0,0,'2017-09-13 16:08:48'),(28,'汇通快运','huitongkuaidi',NULL,0,0,0,'2017-09-13 16:08:56'),(29,'恒路物流','hengluwuliu',NULL,0,0,0,'2017-09-13 16:09:02'),(30,'华夏龙物流','huaxialongwuliu',NULL,0,0,0,'2017-09-13 16:09:12'),(31,'海红','haihongwangsong',NULL,0,0,0,'2017-09-13 16:09:20'),(32,'海外环球','haiwaihuanqiu',NULL,0,0,0,'2017-09-13 16:09:27'),(33,'佳怡物流','jiayiwuliu',NULL,0,0,0,'2017-09-13 16:09:35'),(34,'京广速递','jinguangsudikuaijian',NULL,0,0,0,'2017-09-13 16:09:42'),(35,'急先达','jixianda',NULL,0,0,0,'2017-09-13 16:09:49'),(36,'佳吉物流','jjwl',NULL,0,0,0,'2017-09-13 16:10:01'),(37,'加运美物流','jymwl',NULL,0,0,0,'2017-09-13 16:10:13'),(38,'金大物流','jindawuliu',NULL,0,0,0,'2017-09-13 16:10:22'),(39,'嘉里大通','jialidatong',NULL,0,0,0,'2017-09-13 16:10:33'),(40,'晋越快递','jykd',NULL,0,0,0,'2017-09-13 16:10:40'),(41,'快捷速递','kuaijiesudi',NULL,0,0,0,'2017-09-13 16:10:49'),(42,'联邦快递（国内）','lianb',NULL,0,0,0,'2017-09-13 16:10:58'),(43,'联昊通物流','lianhaowuliu',NULL,0,0,0,'2017-09-13 16:11:07'),(44,'龙邦物流','longbanwuliu',NULL,0,0,0,'2017-09-13 16:11:15'),(45,'立即送','lijisong',NULL,0,0,0,'2017-09-13 16:11:25'),(46,'乐捷递','lejiedi',NULL,0,0,0,'2017-09-13 16:11:36'),(47,'民航快递','minghangkuaidi',NULL,0,0,0,'2017-09-13 16:11:45'),(48,'美国快递','meiguokuaidi',NULL,0,0,0,'2017-09-13 16:11:53'),(49,'门对门','menduimen',NULL,0,0,0,'2017-09-13 16:12:01'),(50,'OCS','ocs',NULL,0,0,0,'2017-09-13 16:12:10'),(51,'配思货运','peisihuoyunkuaidi',NULL,0,0,0,'2017-09-13 16:12:18'),(52,'全晨快递','quanchenkuaidi',NULL,0,0,0,'2017-09-13 16:12:26'),(53,'全峰快递','quanfengkuaidi',NULL,0,0,0,'2017-09-13 16:12:34'),(54,'全际通物流','quanjitong',NULL,0,0,0,'2017-09-13 16:12:41'),(55,'全日通快递','quanritongkuaidi',NULL,0,0,0,'2017-09-13 16:12:49'),(56,'全一快递','quanyikuaidi',NULL,0,0,0,'2017-09-13 16:12:56'),(57,'如风达','rufengda',NULL,0,0,0,'2017-09-13 16:13:03'),(58,'三态速递','santaisudi',NULL,0,0,0,'2017-09-13 16:13:15'),(59,'盛辉物流','shenghuiwuliu',NULL,0,0,0,'2017-09-13 16:13:22'),(60,'申通','shentong',NULL,0,0,0,'2017-09-13 16:13:34'),(61,'顺丰','shunfeng','',0,0,0,'2017-09-13 16:13:41'),(62,'速尔物流','sue',NULL,0,0,0,'2017-09-13 16:13:48'),(63,'盛丰物流','shengfeng',NULL,0,0,0,'2017-09-13 16:13:55'),(64,'赛澳递','saiaodi',NULL,0,0,0,'2017-09-13 16:14:02'),(65,'天地华宇','tiandihuayu',NULL,0,0,0,'2017-09-13 16:14:11'),(66,'天天快递','tiantian',NULL,0,0,0,'2017-09-13 16:14:19'),(67,'TNT','tnt',NULL,0,0,0,'2017-09-13 16:14:26'),(68,'UPS','ups',NULL,0,0,0,'2017-09-13 16:14:29'),(69,'万家物流','wanjiawuliu',NULL,0,0,0,'2017-09-13 16:14:37'),(70,'文捷航空速递','wenjiesudi',NULL,0,0,0,'2017-09-13 16:14:46'),(71,'伍圆','wuyuan',NULL,0,0,0,'2017-09-13 16:14:52'),(72,'万象物流','wxwl',NULL,0,0,0,'2017-09-13 16:15:00'),(73,'新邦物流','xinbangwuliu',NULL,0,0,0,'2017-09-13 16:15:06'),(74,'信丰物流','xinfengwuliu',NULL,0,0,0,'2017-09-13 16:15:15'),(75,'亚风速递','yafengsudi',NULL,0,0,0,'2017-09-13 16:15:23'),(76,'一邦速递','yibangwuliu',NULL,0,0,0,'2017-09-13 16:15:30'),(77,'优速物流','youshuwuliu',NULL,0,0,0,'2017-09-13 16:15:36'),(78,'邮政包裹挂号信','youzhengguonei',NULL,0,3,0,'2017-09-13 16:15:44'),(79,'邮政国际包裹挂号信','youzhengguoji',NULL,0,2,0,'2017-09-13 16:15:51'),(80,'远成物流','yuanchengwuliu',NULL,0,0,0,'2017-09-13 16:15:57'),(81,'圆通速递','yuantong','',1,1,0,'2017-09-13 16:16:03'),(82,'源伟丰快递','yuanweifeng',NULL,0,0,0,'2017-09-13 16:16:10'),(83,'元智捷诚快递','yuanzhijiecheng',NULL,0,0,0,'2017-09-13 16:16:17'),(84,'韵达快运','yunda',NULL,0,0,0,'2017-09-13 16:16:24'),(85,'运通快递','yuntongkuaidi',NULL,0,0,0,'2017-09-13 16:16:33'),(86,'越丰物流','yuefengwuliu',NULL,0,0,0,'2017-09-13 16:16:40'),(87,'源安达','yad',NULL,0,0,0,'2017-09-13 16:16:47'),(88,'银捷速递','yinjiesudi',NULL,0,0,0,'2017-09-13 16:16:56'),(89,'宅急送','zhaijisong',NULL,0,0,0,'2017-09-13 16:17:03'),(90,'中铁快运','zhongtiekuaiyun',NULL,0,0,0,'2017-09-13 16:17:10'),(91,'中通速递','zhongtong','',0,0,0,'2017-09-13 16:17:16'),(92,'中邮物流','zhongyouwuliu',NULL,0,0,0,'2017-09-13 16:17:27'),(93,'忠信达','zhongxinda',NULL,0,0,0,'2017-09-13 16:17:34'),(94,'芝麻开门','zhimakaimen','',1,0,0,'2017-09-13 16:17:41');

/*Table structure for table `store_express_template` */

DROP TABLE IF EXISTS `store_express_template`;

CREATE TABLE `store_express_template` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `rule` longtext COMMENT '省份规则内容',
  `order_reduction_state` tinyint(1) unsigned DEFAULT '0' COMMENT '订单满减状态',
  `order_reduction_price` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '订单满减金额',
  `first_number` bigint(20) unsigned DEFAULT '0' COMMENT '首件数量',
  `first_price` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '首件邮费',
  `next_number` bigint(20) unsigned DEFAULT '0' COMMENT '续件数量',
  `next_price` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '续件邮费',
  `is_default` tinyint(1) unsigned DEFAULT '0' COMMENT '默认规则',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_store_express_template_is_default` (`is_default`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商城-快递-模板';

/*Data for the table `store_express_template` */

/*Table structure for table `store_goods` */

DROP TABLE IF EXISTS `store_goods`;

CREATE TABLE `store_goods` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cate_id` bigint(20) unsigned DEFAULT '0' COMMENT '商品分类',
  `title` text COMMENT '商品标题',
  `logo` text COMMENT '商品图标',
  `specs` text COMMENT '商品规格JSON',
  `lists` text COMMENT '商品列表JSON',
  `image` text COMMENT '商品图片',
  `content` longtext COMMENT '商品内容',
  `number_sales` bigint(20) unsigned DEFAULT '0' COMMENT '销售数量',
  `number_stock` bigint(20) unsigned DEFAULT '0' COMMENT '库库数量',
  `price_rate` decimal(20,4) unsigned DEFAULT '0.0000' COMMENT '返利比例',
  `price_express` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '统一运费',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '销售状态',
  `sort` bigint(20) unsigned DEFAULT '0' COMMENT '排序权重',
  `is_deleted` tinyint(1) unsigned DEFAULT '0' COMMENT '删除状态',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_store_goods_status` (`status`) USING BTREE,
  KEY `idx_store_goods_cate_id` (`cate_id`) USING BTREE,
  KEY `idx_store_goods_is_deleted` (`is_deleted`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品-记录';

/*Data for the table `store_goods` */

/*Table structure for table `store_goods_cate` */

DROP TABLE IF EXISTS `store_goods_cate`;

CREATE TABLE `store_goods_cate` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `logo` varchar(500) DEFAULT '' COMMENT '分类图标',
  `title` varchar(255) DEFAULT '' COMMENT '分类名称',
  `desc` varchar(1024) DEFAULT '' COMMENT '分类描述',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '销售状态',
  `sort` bigint(20) unsigned DEFAULT '0' COMMENT '排序权重',
  `is_deleted` tinyint(1) unsigned DEFAULT '0' COMMENT '删除状态',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_store_goods_cate_is_deleted` (`is_deleted`) USING BTREE,
  KEY `idx_store_goods_cate_status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品-分类';

/*Data for the table `store_goods_cate` */

/*Table structure for table `store_goods_list` */

DROP TABLE IF EXISTS `store_goods_list`;

CREATE TABLE `store_goods_list` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sku` varchar(20) DEFAULT '' COMMENT 'sku',
  `goods_id` bigint(20) unsigned DEFAULT '0' COMMENT '商品ID',
  `goods_spec` varchar(100) DEFAULT '' COMMENT '商品规格',
  `price_market` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '商品标价',
  `price_selling` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '商品售价',
  `number_sales` bigint(20) unsigned DEFAULT '0' COMMENT '销售数量',
  `number_stock` bigint(20) unsigned DEFAULT '0' COMMENT '商品库存',
  `number_virtual` bigint(20) unsigned DEFAULT '0' COMMENT '虚拟销量',
  `number_express` bigint(20) unsigned DEFAULT '1' COMMENT '快递数量',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '商品状态',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_store_goods_list_id` (`goods_id`) USING BTREE,
  KEY `idx_store_goods_list_spec` (`goods_spec`) USING BTREE,
  KEY `idx_store_goods_list_status` (`status`) USING BTREE,
  KEY `idx_store_goods_list_sku` (`sku`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品-详情';

/*Data for the table `store_goods_list` */

/*Table structure for table `store_goods_stock` */

DROP TABLE IF EXISTS `store_goods_stock`;

CREATE TABLE `store_goods_stock` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` bigint(20) unsigned DEFAULT '0' COMMENT '商品ID',
  `goods_spec` varchar(200) DEFAULT '' COMMENT '商品规格',
  `number_stock` bigint(20) unsigned DEFAULT '0' COMMENT '商品库存',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_store_goods_stock_gid` (`goods_id`) USING BTREE,
  KEY `idx_store_goods_stock_spec` (`goods_spec`(191)) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品-入库';

/*Data for the table `store_goods_stock` */

/*Table structure for table `store_member` */

DROP TABLE IF EXISTS `store_member`;

CREATE TABLE `store_member` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `openid` varchar(100) DEFAULT '' COMMENT '微信OPENID',
  `headimg` varchar(512) DEFAULT '' COMMENT '头像地址',
  `nickname` varchar(100) DEFAULT '' COMMENT '微信昵称',
  `phone` varchar(20) DEFAULT '' COMMENT '联系手机',
  `username` varchar(50) DEFAULT '' COMMENT '真实姓名',
  `vip_level` tinyint(1) unsigned DEFAULT '0' COMMENT '会员级别(0游客,1为临时,2为VIP1,3为VIP2)',
  `vip_date` date DEFAULT NULL COMMENT '保级日期',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_store_member_openid` (`openid`) USING BTREE,
  KEY `idx_store_member_phone` (`phone`) USING BTREE,
  KEY `idx_store_member_vip_level` (`vip_level`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员-记录';

/*Data for the table `store_member` */

/*Table structure for table `store_member_address` */

DROP TABLE IF EXISTS `store_member_address`;

CREATE TABLE `store_member_address` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) unsigned DEFAULT '0' COMMENT '会员ID',
  `name` varchar(100) DEFAULT '' COMMENT '收货姓名',
  `phone` varchar(20) DEFAULT '' COMMENT '收货手机',
  `province` varchar(100) DEFAULT '' COMMENT '地址-省份',
  `city` varchar(100) DEFAULT '' COMMENT '地址-城市',
  `area` varchar(100) DEFAULT '' COMMENT '地址-区域',
  `address` varchar(255) DEFAULT '' COMMENT '地址-详情',
  `is_default` tinyint(1) unsigned DEFAULT '0' COMMENT '默认地址',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_store_member_address_mid` (`mid`) USING BTREE,
  KEY `idx_store_member_address_is_default` (`is_default`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员-地址';

/*Data for the table `store_member_address` */

/*Table structure for table `store_member_sms_history` */

DROP TABLE IF EXISTS `store_member_sms_history`;

CREATE TABLE `store_member_sms_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) unsigned DEFAULT '0' COMMENT '会员ID',
  `phone` varchar(20) DEFAULT '' COMMENT '目标手机',
  `content` varchar(512) DEFAULT '' COMMENT '短信内容',
  `region` varchar(100) DEFAULT '' COMMENT '区域编码',
  `result` varchar(100) DEFAULT '' COMMENT '返回结果',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_store_member_sms_history_phone` (`phone`) USING BTREE,
  KEY `idx_store_member_sms_history_mid` (`mid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员-短信';

/*Data for the table `store_member_sms_history` */

/*Table structure for table `store_order` */

DROP TABLE IF EXISTS `store_order`;

CREATE TABLE `store_order` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) unsigned DEFAULT '0' COMMENT '会员ID',
  `order_no` bigint(20) unsigned DEFAULT '0' COMMENT '订单单号',
  `from_mid` bigint(20) unsigned DEFAULT '0' COMMENT '推荐会员ID',
  `price_total` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '待付金额统计',
  `price_goods` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '商品费用统计',
  `price_express` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '快递费用统计',
  `price_rate_amount` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '返利金额统计',
  `pay_state` tinyint(1) unsigned DEFAULT '0' COMMENT '支付状态(0未支付,1已支付)',
  `pay_type` varchar(10) DEFAULT '' COMMENT '支付方式',
  `pay_price` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '支付金额',
  `pay_no` varchar(100) DEFAULT '' COMMENT '支付单号',
  `pay_at` datetime DEFAULT NULL COMMENT '支付时间',
  `cancel_state` tinyint(1) unsigned DEFAULT '0' COMMENT '取消状态',
  `cancel_at` datetime DEFAULT NULL COMMENT '取消时间',
  `cancel_desc` varchar(500) DEFAULT '' COMMENT '取消描述',
  `refund_state` tinyint(1) unsigned DEFAULT '0' COMMENT '退款状态(0未退款,1待退款,2已退款)',
  `refund_at` datetime DEFAULT NULL COMMENT '退款时间',
  `refund_no` varchar(100) DEFAULT '' COMMENT '退款单号',
  `refund_price` decimal(20,2) DEFAULT '0.00' COMMENT '退款金额',
  `refund_desc` varchar(500) DEFAULT '' COMMENT '退款描述',
  `express_state` tinyint(1) unsigned DEFAULT '0' COMMENT '发货状态(0未发货,1已发货,2已签收)',
  `express_company_code` varchar(255) DEFAULT '' COMMENT '发货快递公司编码',
  `express_company_title` varchar(255) DEFAULT '' COMMENT '发货快递公司名称',
  `express_send_no` varchar(50) DEFAULT '' COMMENT '发货单号',
  `express_send_at` datetime DEFAULT NULL COMMENT '发货时间',
  `express_address_id` bigint(20) unsigned DEFAULT '0' COMMENT '收货地址ID',
  `express_name` varchar(255) DEFAULT '' COMMENT '收货人姓名',
  `express_phone` varchar(11) DEFAULT '' COMMENT '收货人手机',
  `express_province` varchar(255) DEFAULT '' COMMENT '收货地址省份',
  `express_city` varchar(255) DEFAULT '' COMMENT '收货地址城市',
  `express_area` varchar(255) DEFAULT '' COMMENT '收货地址区域',
  `express_address` varchar(255) DEFAULT '' COMMENT '收货详细地址',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '订单状态(0已取消,1预订单待补全,2新订单待支付,3已支付待发货,4已发货待签收,5已完成)',
  `is_deleted` tinyint(1) unsigned DEFAULT '0' COMMENT '删除状态',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_store_groups_order_mid` (`mid`) USING BTREE,
  KEY `idx_store_groups_order_order_no` (`order_no`) USING BTREE,
  KEY `idx_store_groups_order_pay_state` (`pay_state`) USING BTREE,
  KEY `idx_store_groups_order_cancel_state` (`cancel_state`) USING BTREE,
  KEY `idx_store_groups_order_refund_state` (`refund_state`) USING BTREE,
  KEY `idx_store_groups_order_status` (`status`) USING BTREE,
  KEY `idx_store_groups_order_pay_no` (`pay_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单-记录';

/*Data for the table `store_order` */

/*Table structure for table `store_order_list` */

DROP TABLE IF EXISTS `store_order_list`;

CREATE TABLE `store_order_list` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `mid` bigint(20) unsigned DEFAULT '0' COMMENT '会员ID',
  `from_id` bigint(20) unsigned DEFAULT '0' COMMENT '推荐会员',
  `order_no` bigint(20) unsigned DEFAULT '0' COMMENT '订单单号',
  `goods_id` bigint(20) unsigned DEFAULT '0' COMMENT '商品标识',
  `goods_title` varchar(255) DEFAULT '' COMMENT '商品标题',
  `goods_logo` varchar(500) DEFAULT '' COMMENT '商品图标',
  `goods_spec` varchar(100) DEFAULT '' COMMENT '商品规格',
  `price_real` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '交易金额',
  `price_selling` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '销售价格',
  `price_market` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '市场价格',
  `price_express` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '快递费用',
  `price_rate` decimal(20,4) unsigned DEFAULT '0.0000' COMMENT '分成比例',
  `price_rate_amount` decimal(20,2) unsigned DEFAULT '0.00' COMMENT '分成金额',
  `number_goods` bigint(20) unsigned DEFAULT '0' COMMENT '商品数量',
  `number_express` bigint(20) unsigned DEFAULT '0' COMMENT '快递数量',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_store_goods_list_id` (`goods_id`) USING BTREE,
  KEY `idx_store_goods_list_spec` (`goods_spec`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单-详情';

/*Data for the table `store_order_list` */

/*Table structure for table `student` */

DROP TABLE IF EXISTS `student`;

CREATE TABLE `student` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  `s_id` int(10) unsigned NOT NULL,
  `c_id` int(10) unsigned NOT NULL COMMENT '班级id',
  `sex` tinyint(1) NOT NULL COMMENT '性别',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `s_id` (`s_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

/*Data for the table `student` */

insert  into `student`(`id`,`name`,`s_id`,`c_id`,`sex`,`create_at`) values (14,'肖',1,1,1,'2020-11-01 09:22:14'),(15,'世',2,2,1,'2020-11-01 09:22:29'),(16,'成',3,3,0,'2020-11-01 09:22:40'),(18,'肖',111,1,0,'2020-11-01 11:22:58'),(19,'王网',12,1,0,'2020-11-01 11:23:39'),(20,'网网',13,2,1,'2020-11-01 11:23:57');

/*Table structure for table `system_auth` */

DROP TABLE IF EXISTS `system_auth`;

CREATE TABLE `system_auth` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(20) DEFAULT NULL COMMENT '权限名称',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '权限状态',
  `sort` bigint(20) unsigned DEFAULT '0' COMMENT '排序权重',
  `desc` varchar(255) DEFAULT '' COMMENT '备注说明',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_system_auth_status` (`status`) USING BTREE,
  KEY `idx_system_auth_title` (`title`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='系统-权限';

/*Data for the table `system_auth` */

insert  into `system_auth`(`id`,`title`,`status`,`sort`,`desc`,`create_at`) values (1,'一级用户',1,0,'次与admin','2020-10-31 11:02:21');

/*Table structure for table `system_auth_node` */

DROP TABLE IF EXISTS `system_auth_node`;

CREATE TABLE `system_auth_node` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `auth` bigint(20) unsigned DEFAULT NULL COMMENT '角色',
  `node` varchar(200) DEFAULT NULL COMMENT '节点',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_system_auth_auth` (`auth`) USING BTREE,
  KEY `idx_system_auth_node` (`node`(191)) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COMMENT='系统-权限-授权';

/*Data for the table `system_auth_node` */

insert  into `system_auth_node`(`id`,`auth`,`node`) values (1,1,'company'),(2,1,'company/auth'),(3,1,'company/auth/index'),(4,1,'company/auth/add'),(5,1,'company/auth/edit'),(6,1,'company/auth/state'),(7,1,'company/auth/remove'),(8,1,'company/clock'),(9,1,'company/clock/index'),(10,1,'company/user'),(11,1,'company/user/index'),(12,1,'company/user/add'),(13,1,'company/user/edit'),(14,1,'company/user/state'),(15,1,'company/user/remove'),(16,1,'service'),(17,1,'service/config'),(18,1,'service/config/index'),(19,1,'service/config/edit'),(20,1,'service/fans'),(21,1,'service/fans/index'),(22,1,'service/fans/setblack'),(23,1,'service/fans/delblack'),(24,1,'service/fans/sync'),(25,1,'service/fans/remove'),(26,1,'service/index'),(27,1,'service/index/index'),(28,1,'service/index/clearquota'),(29,1,'service/index/sync'),(30,1,'service/index/syncall'),(31,1,'service/index/remove'),(32,1,'service/index/forbid'),(33,1,'service/index/resume'),(34,1,'store'),(35,1,'store/config'),(36,1,'store/config/index'),(37,1,'store/config/save'),(38,1,'store/express_company'),(39,1,'store/express_company/index'),(40,1,'store/express_company/add'),(41,1,'store/express_company/edit'),(42,1,'store/express_company/forbid'),(43,1,'store/express_company/resume'),(44,1,'store/express_company/remove'),(45,1,'store/express_template'),(46,1,'store/express_template/index'),(47,1,'store/express_template/save'),(48,1,'store/goods'),(49,1,'store/goods/index'),(50,1,'store/goods/stock'),(51,1,'store/goods/add'),(52,1,'store/goods/edit'),(53,1,'store/goods/forbid'),(54,1,'store/goods/resume'),(55,1,'store/goods/remove'),(56,1,'store/goods_cate'),(57,1,'store/goods_cate/index'),(58,1,'store/goods_cate/add'),(59,1,'store/goods_cate/edit'),(60,1,'store/goods_cate/forbid'),(61,1,'store/goods_cate/resume'),(62,1,'store/goods_cate/remove'),(63,1,'store/member'),(64,1,'store/member/index'),(65,1,'store/message'),(66,1,'store/message/index'),(67,1,'store/message/remove'),(68,1,'store/order'),(69,1,'store/order/index'),(70,1,'store/order/express'),(71,1,'store/order/expressquery'),(72,1,'store/slider'),(73,1,'store/slider/home'),(74,1,'wechat'),(75,1,'wechat/config'),(76,1,'wechat/config/options'),(77,1,'wechat/config/payment'),(78,1,'wechat/fans'),(79,1,'wechat/fans/index'),(80,1,'wechat/fans/setblack'),(81,1,'wechat/fans/delblack'),(82,1,'wechat/fans/sync'),(83,1,'wechat/fans/remove'),(84,1,'wechat/index'),(85,1,'wechat/index/index'),(86,1,'wechat/keys'),(87,1,'wechat/keys/index'),(88,1,'wechat/keys/add'),(89,1,'wechat/keys/edit'),(90,1,'wechat/keys/remove'),(91,1,'wechat/keys/forbid'),(92,1,'wechat/keys/resume'),(93,1,'wechat/keys/subscribe'),(94,1,'wechat/keys/defaults'),(95,1,'wechat/menu'),(96,1,'wechat/menu/index'),(97,1,'wechat/menu/edit'),(98,1,'wechat/menu/cancel'),(99,1,'wechat/news'),(100,1,'wechat/news/index'),(101,1,'wechat/news/select'),(102,1,'wechat/news/add'),(103,1,'wechat/news/edit');

/*Table structure for table `system_config` */

DROP TABLE IF EXISTS `system_config`;

CREATE TABLE `system_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '' COMMENT '配置名',
  `value` varchar(500) DEFAULT '' COMMENT '配置值',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_system_config_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COMMENT='系统-配置';

/*Data for the table `system_config` */

insert  into `system_config`(`id`,`name`,`value`) values (1,'app_name','ThinkAdmin'),(2,'site_name','ThinkAdmin'),(3,'app_version','dev'),(4,'site_copy','©版权所有 2014-2018 楚才科技'),(5,'site_icon','/upload/decb0fe26fa3f486/b3f6521bf29403c8.png'),(7,'miitbeian','粤ICP备16006642号-2'),(8,'storage_type','local'),(9,'storage_local_exts','doc,gif,icon,jpg,mp3,mp4,p12,pem,png,rar'),(10,'storage_qiniu_bucket','https'),(11,'storage_qiniu_domain','用你自己的吧'),(12,'storage_qiniu_access_key','用你自己的吧'),(13,'storage_qiniu_secret_key','用你自己的吧'),(14,'storage_oss_bucket','cuci-mytest'),(15,'storage_oss_endpoint','oss-cn-hangzhou.aliyuncs.com'),(16,'storage_oss_domain','用你自己的吧'),(17,'storage_oss_keyid','用你自己的吧'),(18,'storage_oss_secret','用你自己的吧'),(36,'storage_oss_is_https','http'),(43,'storage_qiniu_region','华东'),(44,'storage_qiniu_is_https','https'),(45,'wechat_mch_id','1332187001'),(46,'wechat_mch_key','A82DC5BD1F3359081049C568D8502BC5'),(47,'wechat_mch_ssl_type','p12'),(48,'wechat_mch_ssl_p12','65b8e4f56718182d/1bc857ee646aa15d.p12'),(49,'wechat_mch_ssl_key','cc2e3e1345123930/c407d033294f283d.pem'),(50,'wechat_mch_ssl_cer','966eaf89299e9c95/7014872cc109b29a.pem'),(51,'wechat_token','mytoken'),(52,'wechat_appid','wx60a43dd8161666d4'),(53,'wechat_appsecret','9978422e0e431643d4b42868d183d60b'),(54,'wechat_encodingaeskey',''),(55,'wechat_push_url','消息推送地址：http://127.0.0.1:8000/wechat/api.push'),(56,'wechat_type','thr'),(57,'wechat_thr_appid','wx60a43dd8161666d4'),(58,'wechat_thr_appkey','5caf4b0727f6e46a7e6ccbe773cc955d'),(60,'wechat_thr_appurl','消息推送地址：http://127.0.0.1:2314/wechat/api.push'),(61,'component_appid','wx28b58798480874f9'),(62,'component_appsecret','8d0e1ec14ea0adc5027dd0ad82c64bc9'),(63,'component_token','P8QHTIxpBEq88IrxatqhgpBm2OAQROkI'),(64,'component_encodingaeskey','L5uFIa0U6KLalPyXckyqoVIJYLhsfrg8k9YzybZIHsx'),(65,'system_message_state','0'),(66,'sms_zt_username','可以找CUCI申请'),(67,'sms_zt_password','可以找CUCI申请'),(68,'sms_reg_template','您的验证码为{code}，请在十分钟内完成操作！'),(69,'sms_secure','可以找CUCI申请'),(70,'store_title','测试商城'),(71,'store_order_wait_time','0.50'),(72,'store_order_clear_time','24.00'),(73,'store_order_confirm_time','60.00'),(74,'sms_zt_username2','可以找CUCI申请2'),(75,'sms_zt_password2','可以找CUCI申请2'),(76,'sms_secure2','可以找CUCI申请2'),(77,'sms_reg_template2','您的验证码为{code}，请在十分钟内完成操作！2'),(78,'michat_appid','2882303761518074614'),(79,'michat_appkey','5861807470614'),(80,'michat_appsecert','CP/WUTUgDuyOxgLQ5ztesg==');

/*Table structure for table `system_data` */

DROP TABLE IF EXISTS `system_data`;

CREATE TABLE `system_data` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '配置名',
  `value` longtext COMMENT '配置值',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_system_data_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='系统-数据';

/*Data for the table `system_data` */

insert  into `system_data`(`id`,`name`,`value`) values (1,'menudata','[{\"name\":\"请输入名称\",\"type\":\"scancode_push\",\"key\":\"scancode_push\"}]');

/*Table structure for table `system_log` */

DROP TABLE IF EXISTS `system_log`;

CREATE TABLE `system_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `node` varchar(200) NOT NULL DEFAULT '' COMMENT '当前操作节点',
  `geoip` varchar(15) NOT NULL DEFAULT '' COMMENT '操作者IP地址',
  `action` varchar(200) NOT NULL DEFAULT '' COMMENT '操作行为名称',
  `content` varchar(1024) NOT NULL DEFAULT '' COMMENT '操作内容描述',
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT '操作人用户名',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='系统-日志';

/*Data for the table `system_log` */

insert  into `system_log`(`id`,`node`,`geoip`,`action`,`content`,`username`,`create_at`) values (1,'admin/login/index','127.0.0.1','系统管理','用户登录系统后台成功','admin','2020-10-31 08:20:19'),(2,'admin/login/index','127.0.0.1','系统管理','用户登录系统后台成功','admin','2020-10-31 10:16:32'),(3,'admin/login/index','127.0.0.1','系统管理','用户登录系统后台成功','xiao','2020-10-31 11:58:34'),(4,'admin/login/index','127.0.0.1','系统管理','用户登录系统后台成功','admin','2020-10-31 12:00:22'),(5,'admin/login/index','127.0.0.1','系统管理','用户登录系统后台成功','admin','2020-11-01 10:58:43'),(6,'admin/login/index','127.0.0.1','系统管理','用户登录系统后台成功','admin','2020-11-01 11:25:27'),(7,'admin/login/index','127.0.0.1','系统管理','用户登录系统后台成功','admin','2020-11-01 21:15:38');

/*Table structure for table `system_menu` */

DROP TABLE IF EXISTS `system_menu`;

CREATE TABLE `system_menu` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) unsigned DEFAULT '0' COMMENT '父ID',
  `title` varchar(100) DEFAULT '' COMMENT '名称',
  `node` varchar(200) DEFAULT '' COMMENT '节点代码',
  `icon` varchar(100) DEFAULT '' COMMENT '菜单图标',
  `url` varchar(400) DEFAULT '' COMMENT '链接',
  `params` varchar(500) DEFAULT '' COMMENT '链接参数',
  `target` varchar(20) DEFAULT '_self' COMMENT '打开方式',
  `sort` int(11) unsigned DEFAULT '0' COMMENT '菜单排序',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_system_menu_node` (`node`(191)) USING BTREE,
  KEY `idx_system_menu_status` (`status`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COMMENT='系统-菜单';

/*Data for the table `system_menu` */

insert  into `system_menu`(`id`,`pid`,`title`,`node`,`icon`,`url`,`params`,`target`,`sort`,`status`,`create_at`) values (1,0,'后台首页','','','admin/index/main','','_self',500,1,'2018-09-05 17:59:38'),(2,0,'系统管理','','','#','','_self',100,1,'2018-09-05 18:04:52'),(3,4,'系统菜单管理','','layui-icon layui-icon-layouts','admin/menu/index','','_self',1,1,'2018-09-05 18:05:26'),(4,2,'系统配置','','','#','','_self',20,1,'2018-09-05 18:07:17'),(5,12,'系统用户管理','','layui-icon layui-icon-username','admin/user/index','','_self',1,1,'2018-09-06 11:10:42'),(7,12,'访问权限管理','','layui-icon layui-icon-vercode','admin/auth/index','','_self',2,1,'2018-09-06 15:17:14'),(11,4,'系统参数配置','','layui-icon layui-icon-set','admin/config/info','','_self',4,1,'2018-09-06 16:43:47'),(12,2,'权限管理','','','#','','_self',10,1,'2018-09-06 18:01:31'),(13,0,'商城管理','','','#','','_self',400,1,'2018-10-12 13:56:29'),(14,48,'商品信息管理','','layui-icon layui-icon-component','store/goods/index','','_self',3,1,'2018-10-12 13:56:48'),(16,0,'微信管理','','','#','','_self',300,1,'2018-10-31 15:15:27'),(17,16,'微信管理','','','#','','_self',20,1,'2018-10-31 15:16:46'),(18,17,'微信授权配置','','layui-icon layui-icon-set','wechat/config/options','','_self',2,1,'2018-10-31 15:17:11'),(19,17,'微信支付配置','','layui-icon layui-icon-rmb','wechat/config/payment','','_self',1,1,'2018-10-31 18:28:09'),(20,16,'微信定制','','','#','','_self',10,1,'2018-11-13 11:46:27'),(21,20,'图文素材管理','','layui-icon layui-icon-template','wechat/news/index','','_self',6,1,'2018-11-13 11:46:55'),(22,20,'粉丝信息管理','','layui-icon layui-icon-user','wechat/fans/index','','_self',5,1,'2018-11-15 09:51:13'),(23,20,'回复规则管理','','layui-icon layui-icon-engine','wechat/keys/index','','_self',4,1,'2018-11-22 11:29:08'),(24,20,'关注回复配置','','layui-icon layui-icon-senior','wechat/keys/subscribe','','_self',3,1,'2018-11-27 11:45:28'),(25,20,'默认回复配置','','layui-icon layui-icon-survey','wechat/keys/defaults','','_self',2,1,'2018-11-27 11:45:58'),(26,20,'微信菜单管理','','layui-icon layui-icon-cellphone','wechat/menu/index','','_self',1,1,'2018-11-27 17:56:56'),(27,4,'系统任务管理','','layui-icon layui-icon-log','admin/queue/index','','_self',3,1,'2018-11-29 11:13:34'),(37,0,'开放平台','','','#','','_self',200,1,'2018-12-28 13:29:25'),(38,40,'开放平台配置','','layui-icon layui-icon-set','service/config/index','','_self',0,1,'2018-12-28 13:29:44'),(39,40,'公众授权管理','','layui-icon layui-icon-template-1','service/index/index','','_self',0,1,'2018-12-28 13:30:07'),(40,37,'平台管理','','','#','','_self',0,1,'2018-12-28 16:05:46'),(42,48,'会员信息管理','','layui-icon layui-icon-user','store/member/index','','_self',1,1,'2019-01-22 14:24:23'),(43,48,'订单记录管理','','layui-icon layui-icon-template-1','store/order/index','','_self',2,1,'2019-01-22 14:46:22'),(44,48,'商品分类管理','','layui-icon layui-icon-app','store/goods_cate/index','','_self',4,1,'2019-01-23 10:41:06'),(45,47,'商城参数配置','','layui-icon layui-icon-set','store/config/index','','_self',5,1,'2019-01-24 16:47:33'),(46,47,'短信发送记录','','layui-icon layui-icon-console','store/message/index','','_self',4,1,'2019-01-24 18:09:58'),(47,13,'商城配置','','','#','','_self',20,1,'2019-01-25 16:47:49'),(48,13,'数据管理','','','#','','_self',10,1,'2019-01-25 16:48:35'),(49,4,'系统日志管理','','layui-icon layui-icon-form','admin/oplog/index','','_self',2,1,'2019-02-18 12:56:56'),(50,47,'快递公司管理','','layui-icon layui-icon-form','store/express_company/index','','_self',3,1,'2019-04-01 17:10:59'),(52,47,'邮费模板管理','','layui-icon layui-icon-fonts-clear','store/express_template/index','','_self',1,1,'2019-04-23 13:17:10'),(55,17,'微信数据统计','','layui-icon layui-icon-chart-screen','wechat/index/index','','_self',3,1,'2019-06-15 15:03:51'),(56,40,'微信粉丝管理','','layui-icon layui-icon-username','service/fans/index','','_self',0,1,'2019-07-23 09:57:24'),(57,0,'企业管理','','','#','','_self',150,1,'2019-08-08 17:20:29'),(58,57,'基础管理','','','#','','_self',0,1,'2019-08-08 17:20:42'),(59,58,'企业员工管理','','layui-icon layui-icon-username','company/user/index','','_self',0,1,'2019-08-08 17:20:59'),(60,58,'仓库权限管理','','layui-icon layui-icon-template-1','company/auth/index','','_self',0,1,'2019-08-08 18:39:37'),(61,58,'网络打卡管理','','layui-icon layui-icon-engine','company/clock/index','','_self',0,1,'2019-08-09 14:44:23'),(62,0,'学生管理','','','#','','_self',145,1,'2020-10-31 08:32:31'),(63,62,'基本管理','','','#','','_self',0,1,'2020-10-31 08:32:51'),(64,63,'学生列表','','layui-icon layui-icon-align-left','student/index/index','','_self',0,1,'2020-10-31 08:34:15');

/*Table structure for table `system_queue` */

DROP TABLE IF EXISTS `system_queue`;

CREATE TABLE `system_queue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '任务名称',
  `data` longtext NOT NULL COMMENT '执行参数',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '任务状态(1新任务,2处理中,3成功,4失败)',
  `preload` varchar(500) DEFAULT '' COMMENT '执行内容',
  `time` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '执行时间',
  `double` tinyint(1) DEFAULT '1' COMMENT '单例模式',
  `desc` varchar(500) DEFAULT '' COMMENT '状态描述',
  `start_at` varchar(20) DEFAULT '' COMMENT '开始时间',
  `end_at` varchar(20) DEFAULT '' COMMENT '结束时间',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_system_queue_double` (`double`) USING BTREE,
  KEY `idx_system_queue_time` (`time`) USING BTREE,
  KEY `idx_system_queue_title` (`title`) USING BTREE,
  KEY `idx_system_queue_create_at` (`create_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统-任务';

/*Data for the table `system_queue` */

/*Table structure for table `system_user` */

DROP TABLE IF EXISTS `system_user`;

CREATE TABLE `system_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT '' COMMENT '用户账号',
  `password` varchar(32) DEFAULT '' COMMENT '用户密码',
  `qq` varchar(16) DEFAULT '' COMMENT '联系QQ',
  `mail` varchar(32) DEFAULT '' COMMENT '联系邮箱',
  `phone` varchar(16) DEFAULT '' COMMENT '联系手机',
  `login_at` datetime DEFAULT NULL COMMENT '登录时间',
  `login_ip` varchar(255) DEFAULT '' COMMENT '登录IP',
  `login_num` bigint(20) unsigned DEFAULT '0' COMMENT '登录次数',
  `authorize` varchar(255) DEFAULT '' COMMENT '权限授权',
  `tags` varchar(255) DEFAULT '' COMMENT '用户标签',
  `desc` varchar(255) DEFAULT '' COMMENT '备注说明',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(0禁用,1启用)',
  `is_deleted` tinyint(1) unsigned DEFAULT '0' COMMENT '删除(1删除,0未删)',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_system_user_username` (`username`) USING BTREE,
  KEY `idx_system_user_status` (`status`) USING BTREE,
  KEY `idx_system_user_deleted` (`is_deleted`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10002 DEFAULT CHARSET=utf8mb4 COMMENT='系统-用户';

/*Data for the table `system_user` */

insert  into `system_user`(`id`,`username`,`password`,`qq`,`mail`,`phone`,`login_at`,`login_ip`,`login_num`,`authorize`,`tags`,`desc`,`status`,`is_deleted`,`create_at`) values (10000,'admin','21232f297a57a5a743894a0e4a801fc3','22222222','','','2020-11-01 21:15:38','127.0.0.1',667,'','','',1,0,'2015-11-13 15:14:22'),(10001,'xiao','3dd2ad103cac78591892de9265a8b7a7','','2532839909@qq.com','15279831247','2020-10-31 11:58:34','127.0.0.1',1,'1','','测试\r\n',1,0,'2020-10-31 11:00:03');

/*Table structure for table `wechat_fans` */

DROP TABLE IF EXISTS `wechat_fans`;

CREATE TABLE `wechat_fans` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `appid` varchar(50) DEFAULT '' COMMENT '公众号APPID',
  `unionid` varchar(100) DEFAULT '' COMMENT '粉丝unionid',
  `openid` varchar(100) DEFAULT '' COMMENT '粉丝openid',
  `tagid_list` varchar(100) DEFAULT '' COMMENT '粉丝标签id',
  `is_black` tinyint(1) unsigned DEFAULT '0' COMMENT '是否为黑名单状态',
  `subscribe` tinyint(1) unsigned DEFAULT '0' COMMENT '关注状态(0未关注,1已关注)',
  `nickname` varchar(200) DEFAULT '' COMMENT '用户昵称',
  `sex` tinyint(1) unsigned DEFAULT NULL COMMENT '用户性别(1男性,2女性,0未知)',
  `country` varchar(50) DEFAULT '' COMMENT '用户所在国家',
  `province` varchar(50) DEFAULT '' COMMENT '用户所在省份',
  `city` varchar(50) DEFAULT '' COMMENT '用户所在城市',
  `language` varchar(50) DEFAULT '' COMMENT '用户的语言(zh_CN)',
  `headimgurl` varchar(500) DEFAULT '' COMMENT '用户头像',
  `subscribe_time` bigint(20) unsigned DEFAULT '0' COMMENT '关注时间',
  `subscribe_at` datetime DEFAULT NULL COMMENT '关注时间',
  `remark` varchar(50) DEFAULT '' COMMENT '备注',
  `subscribe_scene` varchar(200) DEFAULT '' COMMENT '扫码关注场景',
  `qr_scene` varchar(100) DEFAULT '' COMMENT '二维码场景值',
  `qr_scene_str` varchar(200) DEFAULT '' COMMENT '二维码场景内容',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_wechat_fans_openid` (`openid`) USING BTREE,
  KEY `idx_wechat_fans_unionid` (`unionid`) USING BTREE,
  KEY `idx_wechat_fans_is_back` (`is_black`) USING BTREE,
  KEY `idx_wechat_fans_subscribe` (`subscribe`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='微信-粉丝';

/*Data for the table `wechat_fans` */

/*Table structure for table `wechat_fans_tags` */

DROP TABLE IF EXISTS `wechat_fans_tags`;

CREATE TABLE `wechat_fans_tags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `appid` varchar(50) DEFAULT '' COMMENT '公众号APPID',
  `name` varchar(35) DEFAULT NULL COMMENT '标签名称',
  `count` bigint(20) unsigned DEFAULT '0' COMMENT '总数',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  KEY `idx_wechat_fans_tags_id` (`id`) USING BTREE,
  KEY `idx_wechat_fans_tags_appid` (`appid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='微信-粉丝-标签';

/*Data for the table `wechat_fans_tags` */

/*Table structure for table `wechat_keys` */

DROP TABLE IF EXISTS `wechat_keys`;

CREATE TABLE `wechat_keys` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `appid` char(100) DEFAULT '' COMMENT '公众号APPID',
  `type` varchar(20) DEFAULT '' COMMENT '类型(text,image,news)',
  `keys` varchar(100) DEFAULT NULL COMMENT '关键字',
  `content` text COMMENT '文本内容',
  `image_url` varchar(255) DEFAULT '' COMMENT '图片链接',
  `voice_url` varchar(255) DEFAULT '' COMMENT '语音链接',
  `music_title` varchar(100) DEFAULT '' COMMENT '音乐标题',
  `music_url` varchar(255) DEFAULT '' COMMENT '音乐链接',
  `music_image` varchar(255) DEFAULT '' COMMENT '缩略图片',
  `music_desc` varchar(255) DEFAULT '' COMMENT '音乐描述',
  `video_title` varchar(100) DEFAULT '' COMMENT '视频标题',
  `video_url` varchar(255) DEFAULT '' COMMENT '视频URL',
  `video_desc` varchar(255) DEFAULT '' COMMENT '视频描述',
  `news_id` bigint(20) unsigned DEFAULT NULL COMMENT '图文ID',
  `sort` bigint(20) unsigned DEFAULT '0' COMMENT '排序字段',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(0禁用,1启用)',
  `create_by` bigint(20) unsigned DEFAULT '0' COMMENT '创建人',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_wechat_keys_appid` (`appid`) USING BTREE,
  KEY `idx_wechat_keys_type` (`type`) USING BTREE,
  KEY `idx_wechat_keys_keys` (`keys`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='微信-关键字';

/*Data for the table `wechat_keys` */

/*Table structure for table `wechat_media` */

DROP TABLE IF EXISTS `wechat_media`;

CREATE TABLE `wechat_media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `appid` varchar(100) DEFAULT '' COMMENT '公众号ID',
  `md5` varchar(32) DEFAULT '' COMMENT '文件md5',
  `type` varchar(20) DEFAULT '' COMMENT '媒体类型',
  `media_id` varchar(100) DEFAULT '' COMMENT '永久素材MediaID',
  `local_url` varchar(300) DEFAULT '' COMMENT '本地文件链接',
  `media_url` varchar(300) DEFAULT '' COMMENT '远程图片链接',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_wechat_media_appid` (`appid`) USING BTREE,
  KEY `idx_wechat_media_md5` (`md5`) USING BTREE,
  KEY `idx_wechat_media_type` (`type`) USING BTREE,
  KEY `idx_wechat_media_media_id` (`media_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='微信-素材';

/*Data for the table `wechat_media` */

/*Table structure for table `wechat_news` */

DROP TABLE IF EXISTS `wechat_news`;

CREATE TABLE `wechat_news` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `media_id` varchar(100) DEFAULT '' COMMENT '永久素材MediaID',
  `local_url` varchar(300) DEFAULT '' COMMENT '永久素材显示URL',
  `article_id` varchar(60) DEFAULT '' COMMENT '关联图文ID(用英文逗号做分割)',
  `is_deleted` tinyint(1) unsigned DEFAULT '0' COMMENT '是否删除',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_wechat_news_artcle_id` (`article_id`) USING BTREE,
  KEY `idx_wechat_news_media_id` (`media_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='微信-图文';

/*Data for the table `wechat_news` */

/*Table structure for table `wechat_news_article` */

DROP TABLE IF EXISTS `wechat_news_article`;

CREATE TABLE `wechat_news_article` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT '' COMMENT '素材标题',
  `local_url` varchar(300) DEFAULT '' COMMENT '永久素材显示URL',
  `show_cover_pic` tinyint(4) unsigned DEFAULT '0' COMMENT '显示封面(0不显示,1显示)',
  `author` varchar(20) DEFAULT '' COMMENT '文章作者',
  `digest` varchar(300) DEFAULT '' COMMENT '摘要内容',
  `content` longtext COMMENT '图文内容',
  `content_source_url` varchar(200) DEFAULT '' COMMENT '原文地址',
  `read_num` bigint(20) unsigned DEFAULT '0' COMMENT '阅读数量',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='微信-图文-文章';

/*Data for the table `wechat_news_article` */

/*Table structure for table `wechat_service_config` */

DROP TABLE IF EXISTS `wechat_service_config`;

CREATE TABLE `wechat_service_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `authorizer_appid` varchar(100) DEFAULT '' COMMENT '公众号APPID',
  `authorizer_access_token` varchar(200) DEFAULT '' COMMENT '公众号授权Token',
  `authorizer_refresh_token` varchar(200) DEFAULT '' COMMENT '公众号刷新Token',
  `func_info` varchar(100) DEFAULT '' COMMENT '公众号集权',
  `nick_name` varchar(50) DEFAULT '' COMMENT '公众号昵称',
  `head_img` varchar(200) DEFAULT '' COMMENT '公众号头像',
  `expires_in` bigint(20) DEFAULT NULL COMMENT 'Token有效时间',
  `service_type` tinyint(2) DEFAULT NULL COMMENT '微信类型(0代表订阅号,2代表服务号,3代表小程序)',
  `service_type_info` tinyint(2) DEFAULT NULL COMMENT '公众号实际类型',
  `verify_type` tinyint(2) DEFAULT NULL COMMENT '公众号认证类型(-1代表未认证, 0代表微信认证)',
  `verify_type_info` tinyint(2) DEFAULT NULL COMMENT '公众号实际认证类型',
  `user_name` varchar(100) DEFAULT '' COMMENT '众众号原始账号',
  `alias` varchar(100) DEFAULT '' COMMENT '公众号别名',
  `qrcode_url` varchar(200) DEFAULT '' COMMENT '公众号二维码',
  `business_info` varchar(255) DEFAULT '',
  `principal_name` varchar(255) DEFAULT '' COMMENT '公司名称',
  `miniprograminfo` varchar(1024) DEFAULT '' COMMENT '小程序JSON',
  `idc` tinyint(1) unsigned DEFAULT NULL,
  `signature` text COMMENT '小程序的描述',
  `total` bigint(20) unsigned DEFAULT '0' COMMENT '统计调用次数',
  `appkey` varchar(32) DEFAULT '' COMMENT '应用接口KEY',
  `appuri` varchar(255) DEFAULT '' COMMENT '应用接口URI',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态(1正常授权,0取消授权)',
  `is_deleted` tinyint(1) unsigned DEFAULT '0' COMMENT '删除状态(0未删除,1已删除)',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_wechat_service_config_authorizer_appid` (`authorizer_appid`) USING BTREE,
  KEY `idx_wechat_service_config_status` (`status`) USING BTREE,
  KEY `idx_wechat_service_config_is_deleted` (`is_deleted`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='微信-授权';

/*Data for the table `wechat_service_config` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
