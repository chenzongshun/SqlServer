use master
drop database pxscj
create database pxscj
on(
name=pxscj_data,
filename='d:\数据库基础\2017 03 02\pxscj.mdf')

log on(
name=pxscj_log,
filename='d:\数据库基础\2017 03 02\pxscj_log.ldf')

use pxscj
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

--插入数据

use pxscj
insert into xsb values('201606','赵晓',0,'1998-07-23','护理专业',78,'品学兼优')
insert into xsb values('201604','赵巧云',0,'1998-05-13','药品营销',87,'三好学生')
insert into xsb values('201605','陈栋昆',1,'1997-11-28','机械制造',99,'三好学生')
insert into xsb values('201603','陈宗顺',1,'1998-07-03','软件技术',100,'品学兼优')

select * from xsb	--查询数据表

use pxscj
select 姓名 from xsb where 备注='品学兼优'


