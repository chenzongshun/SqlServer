create database pxscj
on primary
( name='pxscj_data',
  filename='G:\SQLserver\2017 04 25\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='G:\SQLserver\2017 04 25\pxscj.ldf',
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


--1、在学生管理系统数据库中创建一个“日期天数差”函数，用于计算两个日期数据之间相差的天数。

create function 日期天数差(@a datetime,@b datetime) returns int
as
begin
  return datediff(dd,@a,@b)		--dd天	 mm月	yy年
end
go

declare @a int, @b datetime ='2017-08-20',@c datetime = '2007-08-20'
set @a = dbo.日期天数差(@b,@c)
print '年份'+convert(varchar(20),year(@b))+'和年份'+convert(varchar(20),@c)+'之间相差'+convert(varchar(20),@a)+'天'
go

--2创建一个“日期年份差”函数，用于计算两个日期数据之间相差的年数。

create function 日期年数差(@a datetime,@b datetime) returns int
as
begin
  return datediff(yy,@a,@b)
end
go

declare @a int, @b datetime ='2017-08-20',@c datetime = '2007-08-20'
set @a = dbo.日期年数差(@b,@c)
print '年份'+convert(varchar(20),@b)+'和年份'+convert(varchar(20),@c)+'之间相差'+convert(varchar(20),@a)+'年'
go

--3、在学生管理系统数据库中创建一个统计某门课程考试的人数的函数“某门课程参考人数”
  
create function 某门课程参考人数(@kcm varchar(20)) returns int as		--注意是'returns'  并且别忘了varcahr后面有个值大小
begin
  declare @rs int
  select @rs=COUNT(*) from KCB where 课程名=@kcm
  return @rs
end

declare @a varchar(20)='计算机基础'
print '选修了'+convert(varchar(20),@a)+'的人数有：'
+convert(varchar(20),dbo.某门课程参考人数(@a))+'个人'
 

--4、应用创建的函数查询档案表中学生的姓名、性别、出生日期、年龄。

select 姓名,性别,出生时间,dbo.日期年数差(出生时间,GETDATE()) as 年龄 from xsb


