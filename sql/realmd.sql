/*
Navicat MySQL Data Transfer

Source Server         : LocalCore
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : realmd

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2018-12-31 12:47:37
*/

SET FOREIGN_KEY_CHECKS=0;
-- ----------------------------
-- Table structure for `account`
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Account identifier',
  `username` varchar(32) NOT NULL DEFAULT '' COMMENT 'User name',
  `sha_pass_hash` varchar(40) NOT NULL DEFAULT '' COMMENT 'SHA1 password Hash',
  `gmlevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `sessionkey` longtext,
  `v` longtext,
  `s` longtext COMMENT 'password salt',
  `email` text COMMENT 'Email address',
  `joindate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Account Created Date',
  `last_ip` varchar(30) NOT NULL DEFAULT '0.0.0.0',
  `failed_logins` int(11) unsigned NOT NULL DEFAULT '0',
  `locked` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `last_login` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `active_realm_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'last realm id',
  `expansion` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'max game expansion',
  `mutetime` bigint(40) unsigned NOT NULL DEFAULT '0',
  `locale` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `os` varchar(3) DEFAULT '' COMMENT 'Client OS Version',
  `playerBot` bit(1) NOT NULL DEFAULT b'0' COMMENT 'Whether the account is a playerbot account',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_username` (`username`),
  KEY `idx_gmlevel` (`gmlevel`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Account System';

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('5', 'ADMIN', '8301316D0D8448A34FA6D0C6BF1CBFA2B4A1A93A', '3', 'B8028B87446886938D3D42DABD89A3FD616689772E0F0C00009E32DA0F691ECD5730378E21F88BF5', '442E22FE561EE84D263C7B0006EB1F5232B7694B16DED41E3A032A7383B57CA0', 'E7A2C5B5017754544472291C6BE9E47DB48B6DE65BB34AB5BDCAFB6110ACA4E7', null, '2018-12-30 07:38:22', '127.0.0.1', '0', '0', '2018-12-31 12:46:30', '0', '0', '0', '0', 'Win', '\0');

-- ----------------------------
-- Table structure for `account_banned`
-- ----------------------------
DROP TABLE IF EXISTS `account_banned`;
CREATE TABLE `account_banned` (
  `id` int(11) unsigned NOT NULL COMMENT 'Account identifier',
  `bandate` bigint(40) NOT NULL DEFAULT '0',
  `unbandate` bigint(40) NOT NULL DEFAULT '0',
  `bannedby` varchar(50) NOT NULL,
  `banreason` varchar(255) NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`,`bandate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Ban List';

-- ----------------------------
-- Records of account_banned
-- ----------------------------

-- ----------------------------
-- Table structure for `db_version`
-- ----------------------------
DROP TABLE IF EXISTS `db_version`;
CREATE TABLE `db_version` (
  `version` int(3) NOT NULL,
  `structure` int(3) NOT NULL,
  `content` int(3) NOT NULL,
  `description` varchar(30) NOT NULL DEFAULT '',
  `comment` varchar(150) DEFAULT '',
  PRIMARY KEY (`version`,`structure`,`content`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT COMMENT='Used DB version notes';

-- ----------------------------
-- Records of db_version
-- ----------------------------
INSERT INTO `db_version` VALUES ('21', '1', '4', 'Remove dbDocs', 'Base Database from 20150409 to Rel21_1_4');

-- ----------------------------
-- Table structure for `ip_banned`
-- ----------------------------
DROP TABLE IF EXISTS `ip_banned`;
CREATE TABLE `ip_banned` (
  `ip` varchar(32) NOT NULL DEFAULT '0.0.0.0',
  `bandate` bigint(40) NOT NULL,
  `unbandate` bigint(40) NOT NULL,
  `bannedby` varchar(50) NOT NULL DEFAULT '[Console]',
  `banreason` varchar(255) NOT NULL DEFAULT 'no reason',
  PRIMARY KEY (`ip`,`bandate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Banned IPs';

-- ----------------------------
-- Records of ip_banned
-- ----------------------------

-- ----------------------------
-- Table structure for `realmcharacters`
-- ----------------------------
DROP TABLE IF EXISTS `realmcharacters`;
CREATE TABLE `realmcharacters` (
  `realmid` int(11) unsigned NOT NULL COMMENT 'Realm identifier',
  `acctid` int(11) unsigned NOT NULL COMMENT 'Account identifier',
  `numchars` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`realmid`,`acctid`),
  KEY `acctid` (`acctid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Realm Character Tracker';

-- ----------------------------
-- Records of realmcharacters
-- ----------------------------
INSERT INTO `realmcharacters` VALUES ('1', '1', '0');
INSERT INTO `realmcharacters` VALUES ('1', '2', '0');
INSERT INTO `realmcharacters` VALUES ('1', '3', '0');
INSERT INTO `realmcharacters` VALUES ('1', '4', '0');
INSERT INTO `realmcharacters` VALUES ('1', '5', '0');

-- ----------------------------
-- Table structure for `realmlist`
-- ----------------------------
DROP TABLE IF EXISTS `realmlist`;
CREATE TABLE `realmlist` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Realm identifier',
  `name` varchar(32) NOT NULL DEFAULT '',
  `address` varchar(32) NOT NULL DEFAULT '127.0.0.1',
  `localAddress` varchar(255) NOT NULL DEFAULT '127.0.0.1',
  `localSubnetMask` varchar(255) NOT NULL DEFAULT '255.255.255.0',
  `port` int(11) NOT NULL DEFAULT '8085',
  `icon` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `realmflags` tinyint(3) unsigned NOT NULL DEFAULT '2' COMMENT 'Supported masks: 0x1 (invalid, not show in realm list), 0x2 (offline, set by mangosd), 0x4 (show version and build), 0x20 (new players), 0x40 (recommended)',
  `timezone` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `allowedSecurityLevel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `population` float unsigned NOT NULL DEFAULT '0',
  `realmbuilds` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Realm System';

-- ----------------------------
-- Records of realmlist
-- ----------------------------
INSERT INTO `realmlist` VALUES ('1', 'ClassicCore', '127.0.0.1', '127.0.0.1', '255.255.255.0', '8085', '1', '2', '1', '0', '0', '5875 6005 6141 ');

-- ----------------------------
-- Table structure for `uptime`
-- ----------------------------
DROP TABLE IF EXISTS `uptime`;
CREATE TABLE `uptime` (
  `realmid` int(11) unsigned NOT NULL COMMENT 'Realm identifier',
  `starttime` bigint(20) unsigned NOT NULL DEFAULT '0',
  `startstring` varchar(64) NOT NULL DEFAULT '',
  `uptime` bigint(20) unsigned NOT NULL DEFAULT '0',
  `maxplayers` smallint(5) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`realmid`,`starttime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Uptime system';

-- ----------------------------
-- Records of uptime
-- ----------------------------
INSERT INTO `uptime` VALUES ('1', '1546115850', '2018-12-30 07:37:30', '0', '0');
INSERT INTO `uptime` VALUES ('1', '1546220734', '2018-12-31 12:45:34', '0', '0');

-- ----------------------------
-- Table structure for `warden_log`
-- ----------------------------
DROP TABLE IF EXISTS `warden_log`;
CREATE TABLE `warden_log` (
  `entry` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Log entry ID',
  `check` smallint(5) unsigned NOT NULL COMMENT 'Failed Warden check ID',
  `action` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Action taken (enum WardenActions)',
  `account` int(11) unsigned NOT NULL COMMENT 'Account ID',
  `guid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'Player GUID',
  `map` int(11) unsigned DEFAULT NULL COMMENT 'Map ID',
  `position_x` float DEFAULT NULL COMMENT 'Player position X',
  `position_y` float DEFAULT NULL COMMENT 'Player position Y',
  `position_z` float DEFAULT NULL COMMENT 'Player position Z',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date of the log entry',
  PRIMARY KEY (`entry`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Warden log of failed checks';

-- ----------------------------
-- Records of warden_log
-- ----------------------------
