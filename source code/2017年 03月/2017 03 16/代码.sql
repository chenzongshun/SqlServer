use master
drop database pxscj
create database pxscj
on primary
( name='pxscj_data',
  filename='D:\顺的文件\紧急备份\数据库基础\源代码\2017年 03月\2017 03 16\pxscj.mdf',
  size=3mb, 
  filegrowth=1
)
log on
( name='pxscj_log',
  filename='D:\顺的文件\紧急备份\数据库基础\源代码\2017年 03月\2017 03 16\pxscj.ldf',
  size=1mb, 
  filegrowth=1
)

go
use pxscj
go
create table xsb
(
 	
	学号 	char(6)	NOT NULL PRIMARY KEY,
  	姓名 	char(8) 	NOT NULL,
  	性别 	bit 		NULL DEFAULT 1,
  	出生时间 	date 		NULL,
  	专业 	char(12) 	NULL,
  	总学分 	int 			NULL,	
  	备注		varchar(500) NULL
)
go
CREATE TABLE KCB
( 	
	课程号 	char(3)	NOT NULL PRIMARY KEY,
  	课程名 	char(16) 	NOT NULL,
  	开课学期 	tinyint 		NULL DEFAULT 1,
  	学时 	tinyint 		NULL DEFAULT 0,
  	学分 	tinyint 	NOT	NULL DEFAULT 0

)
go
create table CJB
(
学号 char(6) not null,
课程号 char(3) not null,
成绩 int null default 0,
primary key(学号,课程号)
)
go
use pxscj
go
INSERT INTO XSB 
VALUES('081101','王林',1,'1990-02-10','计算机',50,NULL),
('081102', '程明' , 1, '1991-02-1', '计算机',50, NULL),
('081103', '王燕' , 0, '1989-12-12', '计算机',50, NULL),
('081104', '韦严平' , 1, '1990-12-20', '计算机',50, NULL),
('081106', '李方方' , 1, '1991-09-30', '计算机',54, '提前修完《数据结构》，并获学分'),
('081107', '韦明' , 1, '1989-2-12', '计算机',52, '已提前修完一门课程'),
('081108', '李红' , 0, '1990-11-26', '计算机',50, '三好学生'),
('081109', '赵琳' , 0, '1991-12-27', '计算机',48, '有一门课不及格，待补考'),
('081201', '王敏' , 1, '1989-05-11', '网络',42, NULL),
('081202', '林王' , 1, '1989-03-25', '网络',40, '有一门课不及格，待补考'),
('081203', '孙强' , 1, '1989-05-11', '网络',42, NULL),
('081204', '李研' , 0, '1991-12-11', '网络',42, NULL),
('081211', '胡琴' , 0, '1990-11-11', '网络',42, NULL)

go
INSERT INTO KCB 
VALUES('101','计算机基础',1,80,5),
('102','C#',1,80,5),
('103','HTML',1,80,5),
('202','SQL',1,80,5),
('205','JAVA',1,80,5),
('301','JAVA WEB',1,80,5),
('305','PHP',1,80,5),
('311','C#.NET',1,80,5)

go
insert into cjb
values('081101','101',89),
('081101','102',79),
('081101','103',80),
('081102','101',83),
('081102','102',73),
('081102','103',83),
('081103','101',89),
('081103','102',79),
('081103','103',80),
('081104','101',49),
('081104','102',79),
('081104','103',80),
('081106','101',89),
('081106','102',59),
('081106','103',80),
('081201','101',89),
('081201','102',79),
('081201','103',80),
('081203','101',89),
('081203','102',79),
('081203','103',80)


--0、求选修101课程的学生的平均成绩、总成绩。

select 平均成绩 = AVG(成绩),SUM(成绩) as 总成绩 from CJB where 课程号='101'

--1、求选修101课程的学生的最高分和最低分。

select 最高分 = max(成绩),min(成绩) as 最低分 from CJB where 课程号='101'

--2、求学生的总数

select COUNT(*) as 总人数 from xsb

--3、统计备注不为空的学生数。

select COUNT(*) from xsb where 备注 is null
select COUNT(*) from xsb where 备注 is not null
select * from xsb where 备注 is not null

--4、统计总学分在50分以上的人数。

select * from xsb where 总学分>50

--5、求选修了课程的学生总数。网络作为选修

select * from xsb
select COUNT(专业) as 选了网络选修课的 from xsb where 专业='网络'

--6、复制新表xsb1,其结构与xsb一样。

select * into xsb1 from xsb
select * from xsb1

--7、查询XSB表中计算机专业总学分大于等于42的同学的情况。

select * from xsb where 专业='计算机' and 总学分>42

--8、查询XSB表中姓“王”且单名的学生情况。（刘姓和李姓）

select * from xsb
select * from xsb where 姓名 like ('王%')						--姓王的
select * from xsb where 姓名 like ('%王%')						--字符串中只要有王的
select * from xsb where 姓名 like '王%' and 姓名 like '李%'		--又姓王又姓李的不存在
select * from xsb where 姓名 like '王%' or 姓名 like '李%'		--注意不是and而是or

--9、查询XSB表中学号倒数第3个数字为1，且倒数第1个数在1～5之间的学生学号、姓名及专业。

select * from xsb where 学号 like '%1_[1-5]'					--通配符‘ % ’代表任意多个或单个字符
select 学号,姓名,专业 from xsb where 学号 like '%1_[12345]'		--‘ _ ’通配符下划线，代表任意单个字符

--10、查询XSB表中不在1989年出生的学生情况。

select * from xsb where 出生时间 between '1989-01-01' and '1989-12-31'		--between:在…之间

--11、查询XSB表中专业为“计算机”、“通信工程”或“无线电”的学生情况。

select * from xsb where 专业 = '计算机' or 专业 = '通信工程' or 专业 = '无线电'
select * from xsb where 专业 in ('计算机','通信工程','无线电')				--in:在…之内

--12、查询备注尚不定的学生情况。
select * from xsb
select * from xsb where 备注 is null
select * from xsb where 备注 is not null

