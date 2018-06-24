create database pxscj
on primary
( name='pxscj_data',
  filename='E:\数据库基础\2017 03 17\pxscj.mdf',
  size=3mb, 
  filegrowth=1
)
log on
( name='pxscj_log',
  filename='E:\数据库基础\2017 03 17\pxscj.ldf',
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


--1、在xsb中查找年龄在26~27岁的所有男性记录的学号、姓名、年龄、性别。并按年龄进行降序排列。

select 学号,姓名,YEAR(GETDATE()) - YEAR(出生时间) 年龄 ,性别 = case	--是函数就必须要打括号
when 性别='1' then '男'  
else '女'  
end
from xsb
where year(getdate()) - YEAR(出生时间) between 26 and 27				--between配对and配合使用
order by YEAR(GETDATE()) - YEAR(出生时间) desc							--order by 排序    desc 降序	默认asc顺序

--2、查询所有女性记录的学号、姓名、专业、出生日期，并按专业升序，出生日期降序排列记录。

select 姓名,专业,出生时间,专业,性别 = case
when 性别='0' then '女'
else '男' end
from xsb
where 性别='0'
order by 出生时间 desc

--3、在学生表中以专业升序排列查询前三个学生的姓名以及与第三个学生同专业的学生的姓名。

select  top 3 with ties * from xsb				--with ties配合top使用，显示出与四个与第三个专业相同的人
order by 专业

--4、查询期末成绩最高的4条记录的学生学号和期末成绩以及与第四个学生期末成绩相同的哪些记录。

select top 3 with ties * from CJB order by 成绩 desc

--5、统计学生表中记录的总数。

select COUNT(*) 总学生数 from xsb

--6、统计成绩表中所考课程科目的总数。

insert into KCB values (221,'C#',1,100,10)
select * from KCB
select COUNT(distinct 课程名) from KCB		--distinct差异

--7、统计成绩表中101号课程期中成绩的总分和期中成绩的平均分。

select avg(成绩) 平均分 from CJB where 课程号='101'
select sum(成绩) 总分 from CJB where 课程号='101'

--8、查出档案表中年龄最大和最小的学生的出生日期。

select MAX(YEAR(出生时间)) 最小年龄,MIN(YEAR(出生时间)) 最大年龄 from xsb
--select MiN(YEAR(出生时间)) 最小年龄 from xsb


select * from xsb
