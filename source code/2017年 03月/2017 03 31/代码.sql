create database pxscj
on primary
( name='pxscj_data',
  filename='E:\数据库基础\2017 03 31\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\数据库基础\2017 03 31\pxscj.ldf',
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

--子查询:

--1、查询102号课程期中成绩是80分以上的学生姓名。

select * from xsb join CJB on xsb.学号=CJB.学号 where CJB.成绩>80	 --显示7条

select distinct xsb.学号,姓名 from xsb join CJB on xsb.学号=CJB.学号 where CJB.成绩>80 

select * from xsb			--好像会自带distinct消除学号的差异性	显示6条
where 学号 in (
select 学号 from CJB where 成绩 >80
)

--2、列出网络专业的所有学生的成绩情况。

select xsb.*,CJB.成绩 from xsb join CJB on xsb.学号=CJB.学号 where 专业='网络'

select * from xsb
where 学号 in (
select 学号 from CJB where 专业='网络'
)

select * from CJB
where 学号 in (
select 学号 from xsb where 专业='网络'
)

--3、从XSB表中查找所有女学生的姓名、学号及其与081101号学生的年龄差距。

select 姓名,学号,YEAR(出生时间)-YEAR
(( 							--注意year函数和子查询的函数括号都要写，这里 不需要写in
   select 出生时间 from xsb where 学号='081101'
)) as 年龄差异 
from xsb
where 性别 = '0'

--4、查询课程号为103且期中成绩高于课程号为102的所有期中成绩的学生的学号和期中成绩。

select * from CJB where 课程号='103' and 成绩 > all(
select 成绩 from CJB where 课程号='102'
)

--5、从成绩表中列出102号课程的期中成绩
--高于此课程期中成绩平均值
--的记录的学号、姓名、课程号和期中成绩。

select * from CJB where 课程号='102' and 成绩 > all(
(select AVG(成绩) from CJB where 课程号='102')
)



