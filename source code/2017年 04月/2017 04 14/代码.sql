create database pxscj
on primary
( name='pxscj_data',
  filename='E:\SQLserver\2017 04 14\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\SQLserver\2017 04 14\pxscj.ldf',
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


--1、创建一个“计算机基础成绩视图”，通过该视图修改王林同学的计算机基础的成绩为95分。

create view 计算机基础成绩视图 as
select a.学号,姓名,b.成绩,c.课程名 from xsb a inner 
join CJB b on a.学号 = b.学号 
join KCB c on b.课程号 = c.课程号

select * from 计算机基础成绩视图

alter view 计算机基础成绩视图 as
select a.学号,姓名,b.成绩,c.课程名 from xsb a inner 
join CJB b on a.学号 = b.学号 
join KCB c on b.课程号 = c.课程号
where 课程名 = '计算机基础'

update 计算机基础成绩视图 set 成绩 = 95 
where 姓名 = '王林'			--你居然忘记了打这句话，后果为把所有的成绩都会修改成为95

--2.1建一个包含有“计算机基础”和“ASP”课程的“成绩视图1”，该视图含有xsb的学号、姓名、专业字段，cjb的学号、课程号、成绩字段，kcb的课程号、课程名、字段；

create view 成绩视图1(a学号,姓名,专业,b学号,b课程号,成绩,c课程号,c课程名) as
select a.学号,姓名,专业,b.学号,b.课程号,成绩,c.课程号,c.课程名 from xsb a
join CJB b on a.学号 = b.学号
join KCB c on b.课程号 = c.课程号
where c.课程名 = '计算机基础' or 课程名 = 'SQL'

--2.2过该视图在xsb中插入一条记录，学号为081601，姓名为刘自信，专业为网络专业；

select * from xsb
insert 成绩视图1(a学号,姓名,专业) values('081601','刘自信','网络')

--2.3在成绩表中插入该同学的107号“VB”这门课程的期末成绩为89分；

insert into 成绩视图1 (b学号,b课程号,成绩)
values('081601','107',89)		select * from 成绩视图1

--2.4修改成绩表中王林这个学生计算机基础的期末成绩为88分。

update 成绩视图1 set 成绩 = 88 where 姓名 = '王林'
