create database pxscj
on primary
( name='pxscj_data',
  filename='E:\数据库基础\2017 03 24\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\数据库基础\2017 03 24\pxscj.ldf',
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
('081103','102',89),
('081103','103',80),
('081104','101',49),
('081104','102',79),
('081104','103',80),
('081106','101',89),
('081106','102',59),
('081106','103',59),
('081201','101',89),
('081201','102',79),
('081201','103',80),
('081203','101',89),
('081203','102',79),
('081203','103',79)
 
select * from CJB
select * from KCB
select * from xsb

--以JOIN关键字指定的连接：

--1、内连接：查找PXSCJ数据库每个学生的情况以及选修的课程情况。

select xsb.*,CJB.课程号,CJB.成绩 
from xsb inner join CJB
on xsb.学号=CJB.学号

--2、用FROM子句的JOIN关键字表达下列查询：查找选修了103号课程且成绩大于等于80分的学生姓名及成绩。

select xsb.姓名,CJB.成绩 
from xsb inner join CJB
on xsb.学号=CJB.学号 and 课程号='103'		--故意把本来写到where的语句写到了on后面，用and链接起来
where 成绩>=80

--3、用FROM子句的JOIN关键字表达下列查询：查找选修了“计算机基础”课程且成绩大于等于80分的学生学号、姓名、课程名及成绩。

select xsb.学号,姓名,课程名,成绩		--注明xsb.学号的原因是因为成绩表里面也有一个学号
from xsb join KCB inner join CJB
on KCB.课程号=CJB.课程号				--千万注意这里,因为是内链接,所以顾名思义,是要从外到内,所以说on关键字也是有先后之分的
on xsb.学号=CJB.学号 and 课程名='计算机基础' and 成绩>=80 

--4、成绩、学号相同,但是课程号不同

select b.学号,a.课程号,a.成绩 from
CJB a ,CJB b
where a.成绩=b.成绩 and a.学号=a.学号 and a.课程号!=b.课程号

select b.学号,a.课程号,a.成绩 from
CJB a join CJB b
on a.成绩=b.成绩 and a.学号=b.学号 and a.课程号!=b.课程号			--千万注意是a表和b表的对比不是像上面那样的a对a

select * from CJB

--5、外连接：查找所有学生情况，以及他们选修的课程号，若学生未选修任何课，也要包括其情况。

select xsb.*,CJB.课程号 
from xsb left outer join CJB
on xsb.学号=CJB.学号

--6、查找被选修了的课程的选修情况和所有开设的课程名。

select xsb.姓名,KCB.课程名 
from xsb  inner join CJB right join KCB
on kcb.课程号=CJB.课程号
on CJB.学号=xsb.学号

--7、交叉连接：列出学生所有可能的选课情况。

