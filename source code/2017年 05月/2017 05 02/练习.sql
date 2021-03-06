create database pxscj
on primary
( name='pxscj_data',
  filename='E:\SQLserver\2017 05 02\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\SQLserver\2017 05 02\pxscj.ldf',
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



--1、查询总学分在40到50分之间的学生学号和姓名

select xsb.学号,xsb.姓名,总学分 from xsb 
where 总学分 >= 40 and 总学分 <= 50

select 学号, 姓名, 总学分
from  xsb where 总学分 between 40 and 50

--2、查询总学分在40到50分之外的学生学号和姓名
 
select xsb.学号,xsb.姓名,总学分 from xsb where 总学分 <= 40 or 总学分 >= 50
select 学号, 姓名, 总学分
from  xsb
where 总学分 not between 40 and 50

--3、查询课程名以“计”或C开头的情况

select * from KCB where 课程名 like '[c]%'
select * from KCB where 课程名 like '计%'

--4、查询所有选课学生的姓名

select distinct 姓名 from xsb x inner join CJB c
on x.学号 = c.学号 join KCB k
on c.课程号=k.课程号
where c.课程号 != 'null'

select distinct 姓名 from xsb 
where  exists 
(select * from cjb where  xsb.学号= cjb.学号)

--5、查询成绩高于“王林”最高成绩的学生姓名以及成绩

select a.学号,a.姓名,a.性别,b.成绩 
from xsb a inner join CJB b 
on a.学号=b.学号 where 
成绩>(select max(c.成绩) 
from xsb x join CJB c on x.学号=c.学号
where x.姓名='王林' )

update CJB set 成绩=成绩-10 where CJB.学号=081101
 
select 姓名, 课程名, 成绩
from xsb, cjb, kcb
where 成绩> all
(select top 2 b.成绩 from xsb a,  cjb b where a.学号= b.学号 and  a.姓名= '王林')
	and xsb.学号=cjb.学号
	and kcb.课程号=cjb.课程号
	and 姓名<>'王林'

