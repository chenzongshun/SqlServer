create database pxscj
on primary
( name='pxscj_data',
  filename='E:\数据库基础\2017 03 28\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\数据库基础\2017 03 28\pxscj.ldf',
  size=1mb,
  maxsize=10mb,
  filegrowth=10%
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
('081202', '王林' , 1, '1989-03-25', '网络',40, '有一门课不及格，待补考'),
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

select * from xsb
select * from KCB
select * from CJB

--使用compute 子句汇总数据

--1、列出103号课程的明细数据和汇总期中考试的平均分，最高分和最低分。

select * from  CJB
where 课程号='103'
compute avg(cjb.成绩),max(cjb.成绩),min(cjb.成绩)

--2、查询《计算机基础》课程期中考试的明细数据和汇总该课程的考试的总分，参考人数和平均分。

select * from KCB join CJB
on CJB.课程号=KCB.课程号
where 课程名='计算机基础'
order by 学号
compute sum(成绩),count(成绩),avg(成绩)--计算 

--3、按学号分组汇总每个学生的期中成绩的总分，平均分及考试科目数和每个学生考试的明细数据。

select * from  CJB   
order by 学号--排序，默认顺
compute sum(成绩),avg(成绩),count(成绩)		--重复一行在表的最后计算全部的字段
by 学号
compute sum(成绩),avg(成绩),count(成绩)

--4、查询成绩表中每门课程的明细数据和汇总每门课程期末成绩的总分，
--参考人数和平均分。以及所有科目期末成绩的总分，参考人数和平均分。

select KCB.课程名,xsb.专业,CJB.成绩,xsb.姓名 from 
KCB join CJB join  xsb
on xsb.学号=CJB.学号
on KCB.课程号=CJB.课程号
order by CJB.课程号
compute sum(成绩),count(成绩),avg(成绩)

