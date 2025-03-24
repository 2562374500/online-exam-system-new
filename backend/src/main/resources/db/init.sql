-- 创建数据库
CREATE DATABASE IF NOT EXISTS online_exam DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE online_exam;

-- 用户表
CREATE TABLE IF NOT EXISTS `user` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `username` varchar(50) NOT NULL COMMENT '用户名',
    `password` varchar(100) NOT NULL COMMENT '密码',
    `real_name` varchar(50) COMMENT '真实姓名',
    `email` varchar(100) COMMENT '邮箱',
    `phone` varchar(20) COMMENT '手机号',
    `role` tinyint(4) NOT NULL DEFAULT 0 COMMENT '角色：0学生，1教师，2管理员',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 题目表
CREATE TABLE IF NOT EXISTS `question` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `title` varchar(200) NOT NULL COMMENT '题目标题',
    `content` text NOT NULL COMMENT '题目内容',
    `answer` text NOT NULL COMMENT '答案',
    `analysis` text COMMENT '解析',
    `type` tinyint(4) NOT NULL COMMENT '题目类型：1单选题，2多选题，3判断题，4填空题，5简答题',
    `difficulty` tinyint(4) NOT NULL COMMENT '难度：1简单，2中等，3困难',
    `score` int(11) NOT NULL COMMENT '分值',
    `create_by` bigint(20) NOT NULL COMMENT '创建人ID',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='题目表';

-- 试卷表
CREATE TABLE IF NOT EXISTS `paper` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `name` varchar(100) NOT NULL COMMENT '试卷名称',
    `description` text COMMENT '试卷描述',
    `total_score` int(11) NOT NULL COMMENT '总分',
    `duration` int(11) NOT NULL COMMENT '考试时长（分钟）',
    `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态：0草稿，1已发布，2已结束',
    `create_by` bigint(20) NOT NULL COMMENT '创建人ID',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='试卷表';

-- 试卷题目关联表
CREATE TABLE IF NOT EXISTS `paper_question` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `paper_id` bigint(20) NOT NULL COMMENT '试卷ID',
    `question_id` bigint(20) NOT NULL COMMENT '题目ID',
    `order_num` int(11) NOT NULL COMMENT '题目顺序',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    PRIMARY KEY (`id`),
    KEY `idx_paper_id` (`paper_id`),
    KEY `idx_question_id` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='试卷题目关联表';

-- 考试表
CREATE TABLE IF NOT EXISTS `exam` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `paper_id` bigint(20) NOT NULL COMMENT '试卷ID',
    `name` varchar(100) NOT NULL COMMENT '考试名称',
    `description` text COMMENT '考试描述',
    `start_time` datetime NOT NULL COMMENT '开始时间',
    `end_time` datetime NOT NULL COMMENT '结束时间',
    `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态：0未开始，1进行中，2已结束',
    `create_by` bigint(20) NOT NULL COMMENT '创建人ID',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
    PRIMARY KEY (`id`),
    KEY `idx_paper_id` (`paper_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='考试表';

-- 考试记录表
CREATE TABLE IF NOT EXISTS `exam_record` (
    `id` bigint(20) NOT NULL AUTO_INCREMENT,
    `exam_id` bigint(20) NOT NULL COMMENT '考试ID',
    `user_id` bigint(20) NOT NULL COMMENT '用户ID',
    `paper_id` bigint(20) NOT NULL COMMENT '试卷ID',
    `answers` text COMMENT '答案',
    `score` int(11) DEFAULT NULL COMMENT '得分',
    `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '状态：0未提交，1已提交，2已批改',
    `submit_time` datetime DEFAULT NULL COMMENT '提交时间',
    `start_time` datetime NOT NULL COMMENT '开始时间',
    `end_time` datetime DEFAULT NULL COMMENT '结束时间',
    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    `deleted` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
    PRIMARY KEY (`id`),
    KEY `idx_exam_id` (`exam_id`),
    KEY `idx_user_id` (`user_id`),
    KEY `idx_paper_id` (`paper_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='考试记录表'; 