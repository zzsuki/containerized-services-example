-- 创建学生表
CREATE TABLE student(
	sno varchar(20) PRIMARY KEY, -- 学号
	sname varchar(20) NOT NULL, -- 学生姓名
	ssex varchar(20) NOT NULL, -- 学生性别
	sbirthday datetime, -- 出生日期
	class varchar(20) -- 所在班级
);

-- 创建教师表
CREATE TABLE teacher(
	tno varchar(20) PRIMARY KEY, -- 教师标号
	tname varchar(20) NOT NULL, -- 教师姓名
	tsex varchar(20) NOT NULL, -- 教师性别
	tbirthday datetime, -- 教师出生日期
	prof varchar(20), -- 职称
	depart varchar(20) -- 教师所在部门
);

-- 课程表

CREATE TABLE course(
	cno varchar(20) PRIMARY key, -- 课程编号
	cname varchar(20) NOT NULL,  -- 课程名称
	tno varchar(20) NOT NULL -- 教师编号
	FOREIGN key(tno) REFERENCES teacher(tno)
);

-- -- 创建成绩表

CREATE TABLE `score`(
	sno varchar(20) NOT NULL,  -- 学生编号
	cno varchar(20) NOT NULL,  -- 课程编号
	degree DECIMAL(4,1),  -- 成绩
    FOREIGN key(sno) REFERENCES student(sno),
    FOREIGN key(cno) REFERENCES course(cno)
);

-- 添加外键约束

-- ALTER TABLE course 
-- ADD CONSTRAINT fk_tno FOREIGN KEY(tno)
-- REFERENCES teacher(tno);

-- ALTER TABLE `score` 
-- ADD CONSTRAINT fk_sno FOREIGN KEY(sno)
-- REFERENCES student(sno);

-- ALTER TABLE `score`
-- ADD CONSTRAINT fk_cno FOREIGN key(cno)
-- REFERENCES course(cno);

-- 插入数据
-- 向学生表添加数据
INSERT INTO student values('108','曾华','男','1977-09-01','95033');
INSERT INTO student values('105','匡明','男','1975-10-02','95031');
INSERT INTO student values('107','王丽','女','1976-01-23','95033');
INSERT INTO student values('101','李军','男','1976-02-20','95033');
INSERT INTO student values('109','王芳','女','1975-02-10','95031');
INSERT INTO student values('103','陆君','男','1974-06-03','95031');

-- 向教师表添加数据

INSERT INTO teacher values
('804','李诚','男','1958-12-02','副教授','计算机系'),
('856','张旭','男','1969-03-12','讲师','电子工程系'),
('825','王萍','女','1972-05-05','助教','计算机系'),
('831','刘冰','女','1977-08-14','助教','电子工程系');

-- INSERT INTO teacher values('856','张旭','男','1969-03-12','讲师','电子工程系');
-- INSERT INTO teacher values('825','王萍','女','1972-05-05','助教','计算机系');
-- INSERT INTO teacher values('831','刘冰','女','1977-08-14','助教','电子工程系');

-- 向课程表中添加数据

INSERT INTO course values('3-105','计算机导论','825');
INSERT INTO course values('3-245','操作系统','804');
INSERT INTO course values('6-166','数字电路','856');
INSERT INTO course values('9-888','高等数学','831');

-- 向成绩表中添加数据

INSERT INTO `score` values('103','3-245',86);
INSERT INTO `score` values('105','3-245',75);
INSERT INTO `score` values('109','3-245',68);
INSERT INTO `score` values('103','3-105',92);
INSERT INTO `score` values('105','3-105',88);
INSERT INTO `score` values('109','3-105',76);
INSERT INTO `score` values('101','3-105',64);
INSERT INTO `score` values('107','3-105',91);
INSERT INTO `score` values('108','3-105',78);
INSERT INTO `score` values('101','6-166',85);
INSERT INTO `score` values('107','6-166',79);
INSERT INTO `score` values('108','6-166',81);