create database pxscj
on primary
( name='pxscj_data',
  filename='E:\SQLserver\2017 05 12\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\SQLserver\2017 05 12\pxscj.ldf',
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



--1、在学生管理系统中创建一个可以返回数据集的存储过程“考试查询”。
--可以查询某专业某姓名学生的学号、姓名、课程名、成绩。

create proc 考试查询 @zy varchar(20),@xm varchar(20) as
select xsb.学号,姓名,专业,课程名,成绩 
from xsb join CJB 
on xsb.学号=CJB.学号 join KCB 
on CJB.课程号=KCB.课程号
where 专业=@zy and 姓名=@xm

exec 考试查询 计算机 , 王林

--2、在学生管理数据库中创建一个“统计考试科目数” 的存储过程。
--其中输入参数是某学生的姓名，输出参数是这个学生的考试科目数。
--执行该存储过程，查看输出参数的结果。

create proc 统计考试科目数 
@name varchar(10),@num int output as
select @num=COUNT(*) from xsb join CJB 
on xsb.学号=CJB.学号 where 姓名=@name

declare @mz varchar(10),@n int
set @mz = '王燕'
exec 统计考试科目数 @mz,@n output
print @n

--3、在学生管理系统中创建一个“查找学生” 的存储过程。
--如果找到有该学生存储过程就返回1，否则返回0。

drop proc 查找学生
create proc 查找学生 @name varchar(20) as		--这里的varchar(20)忘记写后面的范围了
if exists(select * from xsb where 姓名 = @name)	--exists:存在
	return 1	--return返回		begin   end  {}
else 
	return 0

declare @s int
exec @s=查找学生 '李方方'
print @s		--print:打印

exec 查找学生 '李方方'

--4、在学生管理系统中创建一个“考试查询”的存储过程，
--如果查找到该学生的姓名并且参加了一门以上的考试，存储过程就返回1，
--如果找到了该学生但没有参加任何考试存储过程就返回2，否则就返回0。
drop proc 考试查询2

create proc 考试查询2 @name varchar(10) as
if exists(select 姓名 from xsb,CJB where 姓名=@name and xsb.学号 = CJB.学号)
	return 1
else if exists(select * from xsb where 姓名=@name)
	return 2
else
	return 0

--下面插入学生表一个字段，作为没有成绩的
insert into xsb values('040203','顺',1,'1998-07-13','软件','100',null)


declare @s int
exec @s = 考试查询2 顺
if @s=1
	print cast(@s as varchar(20))+'参加了考试并且有成绩'
if @s=2
	print convert(varchar(20),@s)+'有这个学生,但是没有成绩'
if @s=0
	print cast(@s as varchar(20))+'请确保名字是否输入正确'

--cast(@s as varchar(20)) === convert(varchar(20),@s) 都是转换的意思,注意区分



