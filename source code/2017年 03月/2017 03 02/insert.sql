--1.创建数据库
create database pxscj
	on
	(
		name= 'pxscj_data',
		filename='f:\data\pxscj.mdf',
		size=3 mb,
		maxsize=50 mb,
		filegrowth=1mb		
	)
	log on			--开始日志文件
	(
		name='pxscj_log',		--日志文件在数据库软件中的名字
		filename='f:\data\pxscj.ldf',		--日志文件磁盘中的物理文件名字
		size=1 mb,
		maxsize=5 mb,
		filegrowth=10%
	);
--2，创建学生表
create table xsb
( 	
	学号 	char(6)	not null primary key,
  	姓名 	char(8) 	not null,
  	性别 	bit 		null default 1,
  	出生时间 	datetime 		null,
  	专业 	char(12) 	null,
  	总学分 	int 			null,	
  	备注		varchar(500) null
)
--3，创建课程表
create table kcb
( 	
	课程号 	char(3)	not null primary key,
  	课程名 	char(16) 	not null,
  	开课学期 	tinyint 		null default 1,
  	学时 	tinyint 		null default 0,
  	学分 	tinyint 	not	null default 0

)
--4，创建成绩表
create table cjb
(
学号 char(6) not null,
课程号 char(3) not null,
成绩 int null default 0,
primary key(学号,课程号)
)
--5、向pxscj数据库的表xsb中插入如下一行数据：
insert into xsb 
  	values('081101', '王林' , 1, '1990-02-10', '计算机',50, null)

select  *	from xsb

insert into xsb 
  	values('081111', '赵琳' , 0, '1990-03-18', '计算机',50, '三好学生')

insert into xsb (学号, 姓名, 性别, 出生时间, 总学分)
  	values('081102', '李林', 1, '1990-02-10', 50)

insert into xsb 
  	values('081103', '胡林', 1, '1990-02-10', default,50, null);
--一次向xsb表中插入两行数据
insert into xsb values
	('091101', '王海', 1, '1991-05-10', '软件工程', 50, null),values('091102', '李娜', 0, '1991-04-12', '软件工程', 52, null)

insert into kcb values('101','计算机基础',1,80,5)
insert into cjb values('081101',101,80)

--用create语句建立表xsb1：
use pxscj
go
create table xsb1
( 	num  char(6) not null primary key,
	name  char(8) not null,
	speiality char(10) null
)
--用insert语句向xsb1表中插入数据：
insert top(5) into xsb1
	select 学号, 姓名, 专业	from xsb   where 专业= '计算机'








