/*
Navicat MySQL Data Transfer

Source Server         : db
Source Server Version : 50718
Source Host           : 127.0.0.1:3306
Source Database       : intero

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2017-12-05 23:07:41
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for field
-- ----------------------------
DROP TABLE IF EXISTS `field`;
CREATE TABLE `field` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of field
-- ----------------------------

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `from_id` int(11) DEFAULT NULL,
  `to_id` int(11) DEFAULT NULL,
  `created_at` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `message_from_id` (`from_id`),
  KEY `message_to_id` (`to_id`),
  CONSTRAINT `message_from_id` FOREIGN KEY (`from_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `message_to_id` FOREIGN KEY (`to_id`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('1', 'asdasd', '25', '25', null, null);

-- ----------------------------
-- Table structure for notification
-- ----------------------------
DROP TABLE IF EXISTS `notification`;
CREATE TABLE `notification` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `created_at` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notification
-- ----------------------------

-- ----------------------------
-- Table structure for notification_user_mid
-- ----------------------------
DROP TABLE IF EXISTS `notification_user_mid`;
CREATE TABLE `notification_user_mid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `notification_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mid__User_id` (`user_id`),
  KEY `mid_notification_id` (`notification_id`),
  CONSTRAINT `mid__User_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `mid_notification_id` FOREIGN KEY (`notification_id`) REFERENCES `notification` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of notification_user_mid
-- ----------------------------

-- ----------------------------
-- Table structure for post
-- ----------------------------
DROP TABLE IF EXISTS `post`;
CREATE TABLE `post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `content` varchar(4005) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `img` varchar(415) DEFAULT NULL,
  `view_count` int(11) DEFAULT NULL,
  `agree` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `disagree` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `post_user` (`user_id`),
  CONSTRAINT `post_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post
-- ----------------------------
INSERT INTO `post` VALUES ('28', '哈哈哈哈哈', '2017-12-03 17:16:45', 'HHHHHHHHHHHHHHHHHHHHHHHHHH', null, null, '0', '0', '2017-12-03 17:16:45', '0', '25');
INSERT INTO `post` VALUES ('29', '哈哈哈哈哈', '2017-12-04 22:13:29', 'HHHHHHHHHHHHHHHHHHHHHHHHHH', null, null, '0', '0', '2017-12-04 22:13:29', '0', '25');
INSERT INTO `post` VALUES ('30', '哈哈哈哈哈', '2017-12-04 22:13:29', 'HHHHHHHHHHHHHHHHHHHHHHHHHH', null, null, '0', '0', '2017-12-04 22:13:29', '0', '25');
INSERT INTO `post` VALUES ('31', '哈哈哈哈哈', '2017-12-04 22:13:29', 'HHHHHHHHHHHHHHHHHHHHHHHHHH', null, null, '0', '0', '2017-12-04 22:13:29', '0', '25');
INSERT INTO `post` VALUES ('32', '哈哈哈哈哈', '2017-12-04 22:13:29', 'HHHHHHHHHHHHHHHHHHHHHHHHHH', null, null, '0', '0', '2017-12-04 22:13:29', '0', '25');
INSERT INTO `post` VALUES ('33', '哈哈哈哈哈', '2017-12-04 22:13:29', 'HHHHHHHHHHHHHHHHHHHHHHHHHH', null, null, '0', '0', '2017-12-04 22:13:29', '0', '25');
INSERT INTO `post` VALUES ('34', '哈哈哈哈哈', '2017-12-04 22:13:29', 'HHHHHHHHHHHHHHHHHHHHHHHHHH', null, null, '0', '0', '2017-12-04 22:13:29', '0', '25');
INSERT INTO `post` VALUES ('35', '哈哈哈哈哈', '2017-12-04 22:13:29', 'HHHHHHHHHHHHHHHHHHHHHHHHHH', null, null, '0', '0', '2017-12-04 22:13:29', '0', '25');
INSERT INTO `post` VALUES ('36', '哈哈哈哈哈', '2017-12-04 22:13:29', 'HHHHHHHHHHHHHHHHHHHHHHHHHH', null, null, '0', '0', '2017-12-04 22:13:29', '0', '25');
INSERT INTO `post` VALUES ('37', '哈哈哈哈哈', '2017-12-04 22:13:29', 'HHHHHHHHHHHHHHHHHHHHHHHHHH', null, null, '0', '0', '2017-12-04 22:13:29', '0', '25');
INSERT INTO `post` VALUES ('38', '哈哈哈哈哈', '2017-12-04 22:13:29', 'HHHHHHHHHHHHHHHHHHHHHHHHHH', null, null, '0', '0', '2017-12-04 22:13:29', '0', '25');
INSERT INTO `post` VALUES ('39', '哈哈哈哈哈', '2017-12-04 22:13:29', 'HHHHHHHHHHHHHHHHHHHHHHHHHH', null, null, '0', '0', '2017-12-04 22:13:29', '0', '25');
INSERT INTO `post` VALUES ('40', '哈哈哈哈哈', '2017-12-04 22:13:29', 'HHHHHHHHHHHHHHHHHHHHHHHHHH', null, null, '0', '0', '2017-12-04 22:13:29', '0', '25');
INSERT INTO `post` VALUES ('41', '哈哈哈哈哈', '2017-12-04 22:13:29', 'HHHHHHHHHHHHHHHHHHHHHHHHHH', null, null, '0', '0', '2017-12-04 22:13:29', '0', '25');
INSERT INTO `post` VALUES ('42', '哈哈哈哈哈', '2017-12-04 22:13:29', 'HHHHHHHHHHHHHHHHHHHHHHHHHH', null, null, '0', '0', '2017-12-04 22:13:29', '0', '25');

-- ----------------------------
-- Table structure for post_comment
-- ----------------------------
DROP TABLE IF EXISTS `post_comment`;
CREATE TABLE `post_comment` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `content` varchar(4000) DEFAULT NULL,
  `agree` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `disagree` int(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `form` varchar(255) DEFAULT NULL,
  `post_id` int(11) DEFAULT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id_post_comment` (`post_id`),
  KEY `post_comment_user` (`user_id`),
  CONSTRAINT `post_comment_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `post_id_post_comment` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post_comment
-- ----------------------------

-- ----------------------------
-- Table structure for post_field_mid
-- ----------------------------
DROP TABLE IF EXISTS `post_field_mid`;
CREATE TABLE `post_field_mid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) DEFAULT NULL,
  `field_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id_post_field_mid` (`post_id`),
  KEY `field_id_post_field_mid` (`field_id`),
  CONSTRAINT `field_id_post_field_mid` FOREIGN KEY (`field_id`) REFERENCES `field` (`id`) ON DELETE SET NULL,
  CONSTRAINT `post_id_post_field_mid` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post_field_mid
-- ----------------------------

-- ----------------------------
-- Table structure for post_tag
-- ----------------------------
DROP TABLE IF EXISTS `post_tag`;
CREATE TABLE `post_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post_tag
-- ----------------------------

-- ----------------------------
-- Table structure for post_tag_mid
-- ----------------------------
DROP TABLE IF EXISTS `post_tag_mid`;
CREATE TABLE `post_tag_mid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `post_id` int(11) DEFAULT NULL,
  `tag_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `post_id_post_tag_mid` (`post_id`),
  KEY `tag_id_tag_post_tag_mid` (`tag_id`),
  CONSTRAINT `post_id_post_tag_mid` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tag_id_tag_post_tag_mid` FOREIGN KEY (`tag_id`) REFERENCES `post_tag` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of post_tag_mid
-- ----------------------------

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `star` int(11) DEFAULT NULL,
  `agree` int(11) DEFAULT NULL,
  `disagree` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) DEFAULT NULL,
  `img` varchar(415) DEFAULT NULL,
  `view_count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_user` (`user_id`),
  CONSTRAINT `project_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project
-- ----------------------------

-- ----------------------------
-- Table structure for project_comment
-- ----------------------------
DROP TABLE IF EXISTS `project_comment`;
CREATE TABLE `project_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `agree` int(11) DEFAULT NULL,
  `disagree` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `form` varchar(255) DEFAULT NULL,
  `project_id` int(11) DEFAULT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id_project_comment` (`project_id`),
  KEY `project_comment_user` (`user_id`),
  CONSTRAINT `project_comment_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `project_id_project_comment` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project_comment
-- ----------------------------

-- ----------------------------
-- Table structure for project_field_mid
-- ----------------------------
DROP TABLE IF EXISTS `project_field_mid`;
CREATE TABLE `project_field_mid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) DEFAULT NULL,
  `filed_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id_project_field_mid` (`project_id`),
  KEY `field_id_project_field_mid` (`filed_id`),
  CONSTRAINT `field_id_project_field_mid` FOREIGN KEY (`filed_id`) REFERENCES `field` (`id`) ON DELETE SET NULL,
  CONSTRAINT `project_id_project_field_mid` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project_field_mid
-- ----------------------------

-- ----------------------------
-- Table structure for project_tag
-- ----------------------------
DROP TABLE IF EXISTS `project_tag`;
CREATE TABLE `project_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project_tag
-- ----------------------------

-- ----------------------------
-- Table structure for project_tag_mid
-- ----------------------------
DROP TABLE IF EXISTS `project_tag_mid`;
CREATE TABLE `project_tag_mid` (
  `project_id` int(11) DEFAULT NULL,
  `tag_id` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `tag_id_tag_project_tag_mid` (`project_id`),
  KEY `tag_id_project_tag_mid` (`tag_id`),
  CONSTRAINT `project_id_project_tag_mid` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tag_id_project_tag_mid` FOREIGN KEY (`tag_id`) REFERENCES `project_tag` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project_tag_mid
-- ----------------------------

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `content` varchar(4005) DEFAULT NULL,
  `status` varchar(45) DEFAULT NULL,
  `img` varchar(415) DEFAULT NULL,
  `view_count` int(11) DEFAULT NULL,
  `agree` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `user_id` int(11) DEFAULT NULL,
  `disagree` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_user` (`user_id`),
  CONSTRAINT `question_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question
-- ----------------------------

-- ----------------------------
-- Table structure for question_comment
-- ----------------------------
DROP TABLE IF EXISTS `question_comment`;
CREATE TABLE `question_comment` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `content` varchar(4000) DEFAULT NULL,
  `agree` int(11) DEFAULT NULL,
  `created_at` varchar(255) DEFAULT NULL,
  `updated_at` varchar(255) DEFAULT NULL,
  `disagree` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `form` varchar(255) DEFAULT NULL,
  `question_id` int(11) DEFAULT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_id_question_comment` (`question_id`),
  KEY `question_comment_user` (`user_id`),
  CONSTRAINT `question_comment_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  CONSTRAINT `question_id_question_comment` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question_comment
-- ----------------------------

-- ----------------------------
-- Table structure for question_field_mid
-- ----------------------------
DROP TABLE IF EXISTS `question_field_mid`;
CREATE TABLE `question_field_mid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) DEFAULT NULL,
  `filed_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id_question_field_mid` (`filed_id`),
  KEY `question_id_question_field_mid` (`question_id`),
  CONSTRAINT `field_id_question_field_mid` FOREIGN KEY (`filed_id`) REFERENCES `field` (`id`) ON DELETE SET NULL,
  CONSTRAINT `question_id_question_field_mid` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question_field_mid
-- ----------------------------

-- ----------------------------
-- Table structure for question_tag
-- ----------------------------
DROP TABLE IF EXISTS `question_tag`;
CREATE TABLE `question_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question_tag
-- ----------------------------

-- ----------------------------
-- Table structure for question_tag_mid
-- ----------------------------
DROP TABLE IF EXISTS `question_tag_mid`;
CREATE TABLE `question_tag_mid` (
  `question_id` int(11) DEFAULT NULL,
  `tag_id` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `question_id_question_tag_mid` (`question_id`),
  KEY `tag_id_question_tag_mid` (`tag_id`),
  CONSTRAINT `question_id_question_tag_mid` FOREIGN KEY (`question_id`) REFERENCES `question` (`id`) ON DELETE SET NULL,
  CONSTRAINT `tag_id_question_tag_mid` FOREIGN KEY (`tag_id`) REFERENCES `question_tag` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question_tag_mid
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT '',
  `auth` int(11) DEFAULT '1',
  `password` varchar(255) DEFAULT NULL,
  `mobile` varchar(45) DEFAULT '',
  `work_id` varchar(45) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `avartar` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `level_id` int(11) DEFAULT '1',
  `prestige_id` int(11) DEFAULT '1',
  `v_id` int(11) DEFAULT '1',
  `email` varchar(255) DEFAULT '',
  `major_id` int(11) DEFAULT NULL,
  `degree_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `email` (`mobile`) USING BTREE,
  UNIQUE KEY `mobie` (`mobile`),
  KEY `level_id` (`level_id`),
  KEY `prestige_id` (`prestige_id`),
  KEY `v_id` (`v_id`),
  KEY `major_id` (`major_id`),
  KEY `degree_id` (`degree_id`),
  CONSTRAINT `degree_id` FOREIGN KEY (`degree_id`) REFERENCES `user_degree` (`id`) ON DELETE SET NULL,
  CONSTRAINT `level_id` FOREIGN KEY (`level_id`) REFERENCES `user_level` (`id`) ON DELETE SET NULL,
  CONSTRAINT `major_id` FOREIGN KEY (`major_id`) REFERENCES `user_major` (`id`) ON DELETE SET NULL,
  CONSTRAINT `prestige_id` FOREIGN KEY (`prestige_id`) REFERENCES `user_prestige` (`id`) ON DELETE SET NULL,
  CONSTRAINT `v_id` FOREIGN KEY (`v_id`) REFERENCES `user_v` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('25', 'test', '0', '$5$rounds=535000$kRmKRJvJFoyPs/fZ$HiJB1CtHexAzz8zMLRb2XcO5VEjrukZpUmaUtkHgIn0', null, null, null, null, '2017-12-03 18:22:22', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for user_degree
-- ----------------------------
DROP TABLE IF EXISTS `user_degree`;
CREATE TABLE `user_degree` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_degree
-- ----------------------------
INSERT INTO `user_degree` VALUES ('1', '本科');
INSERT INTO `user_degree` VALUES ('2', '硕士研究生');
INSERT INTO `user_degree` VALUES ('3', '博士研究生');

-- ----------------------------
-- Table structure for user_field_mid
-- ----------------------------
DROP TABLE IF EXISTS `user_field_mid`;
CREATE TABLE `user_field_mid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `filed_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `field_id_user_field_mid` (`filed_id`),
  KEY `user_id_user_field_mid` (`user_id`),
  CONSTRAINT `field_id_user_field_mid` FOREIGN KEY (`filed_id`) REFERENCES `field` (`id`) ON DELETE SET NULL,
  CONSTRAINT `user_id_user_field_mid` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_field_mid
-- ----------------------------

-- ----------------------------
-- Table structure for user_level
-- ----------------------------
DROP TABLE IF EXISTS `user_level`;
CREATE TABLE `user_level` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_level
-- ----------------------------
INSERT INTO `user_level` VALUES ('1', '正常', '');
INSERT INTO `user_level` VALUES ('2', '禁言', null);

-- ----------------------------
-- Table structure for user_major
-- ----------------------------
DROP TABLE IF EXISTS `user_major`;
CREATE TABLE `user_major` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_major
-- ----------------------------
INSERT INTO `user_major` VALUES ('1', '化工');

-- ----------------------------
-- Table structure for user_prestige
-- ----------------------------
DROP TABLE IF EXISTS `user_prestige`;
CREATE TABLE `user_prestige` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `avartar` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_prestige
-- ----------------------------
INSERT INTO `user_prestige` VALUES ('1', '菜鸟', null);
INSERT INTO `user_prestige` VALUES ('2', '混世魔王', null);

-- ----------------------------
-- Table structure for user_v
-- ----------------------------
DROP TABLE IF EXISTS `user_v`;
CREATE TABLE `user_v` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `avartar` varchar(255) DEFAULT NULL,
  `star` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_v
-- ----------------------------
INSERT INTO `user_v` VALUES ('1', '普通', null, '1');
INSERT INTO `user_v` VALUES ('2', '大牛', null, '3');
INSERT INTO `user_v` VALUES ('3', '老师', null, '10');
SET FOREIGN_KEY_CHECKS=1;
