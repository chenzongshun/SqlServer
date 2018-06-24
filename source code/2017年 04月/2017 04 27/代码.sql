create database pxscj
on primary
( name='pxscj_data',
  filename='E:\SQLserver\2017 04 27\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\SQLserver\2017 04 27\pxscj.ldf',
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
('081103','101',54),
('081103','102',79),
('081103','103',80),
('081104','101',49),
('081104','102',79),
('081104','103',80),
('081106','101',89),
('081106','102',59),
('081106','103',80),
('081201','101',60),
('081201','102',79),
('081201','103',80),
('081203','101',78),
('081203','102',79),
('081203','103',80)
	
	
	use pxscj
	
	
--1、创建用户定义函数，实现计算全体学生某门功课平均成绩的功能。
 
create function 
某门功课平均成绩 (@kcm varchar(10))
returns int
as
begin
	declare @pjz int
	select @pjz = AVG(成绩) from xsb join CJB 
	on xsb.学号=CJB.学号 join KCB 
	on KCB.课程号=CJB.课程号
	where 课程名=@kcm
	return @pjz
end

print dbo.某门功课平均成绩('计算机基础') 

--2、创建内嵌函数fn_view()，可查询指定专业的学生的学号和姓名。
	内嵌表值函数
create function fn_view(@zy varchar(10)) 
returns table as
return select * from xsb where 专业=@zy

select * from dbo.fn_view('网络')		--注意前面不需要打印print

--3、先创建视图，查询学生的各科成绩（学号、姓名、课程名、成绩）；
create view 各科成绩 as 
select xsb.学号,姓名,课程名,成绩 
from xsb join CJB on xsb.学号=CJB.学号 join KCB 
on CJB.课程号=KCB.课程号
--并利用视图再创建内嵌函数st_score()，调用st_score()查询学号为081101的学生的各科成绩。
create function st_score(@xh int) returns table as
return select * from 各科成绩 where 学号=@xh

select * from dbo.st_score('081101')