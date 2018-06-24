use master
drop database pxscj
create database pxscj
on primary
( name='pxscj_data',
  filename='g:\数据库基础\2017 03 09\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='g:\数据库基础\2017 03 09\pxscj.ldf',
  size=1mb,
  maxsize=10mb,
  filegrowth=10%
)
go
use pxscj
go
create table xsb
(
 	
	学号 	char(6)	not null primary key,
  	姓名 	char(8) 	not null,
  	性别 	bit 		null default 1,
  	出生时间 	date 		null,
  	专业 	char(12) 	null,
  	总学分 	int 			null,	
  	备注		varchar(500) null
)
go
create table kcb
( 	
	课程号 	char(3)	not null primary key,
  	课程名 	char(16) 	not null,
  	开课学期 	tinyint 		null default 1,
  	学时 	tinyint 		null default 0,
  	学分 	tinyint 	not	null default 0

)
go
create table cjb
(
学号 char(6) not null,
课程号 char(3) not null,
成绩 int null default 0,
primary key(学号,课程号)
)

--表格创建完毕

use pxscj

--开始插入表格内容
delete xsb  where 学号='201611'		--删除学生表中学号为201611的行

use pxscj
go
insert into xsb 
values('081101','王林',1,'1990-02-10','计算机',50,null),
('081102', '程明' , 1, '1991-02-1', '计算机',50, null),
('081103', '王燕' , 0, '1989-12-12', '计算机',50, null),
('081104', '韦严平' , 1, '1990-12-20', '计算机',50, null),
('081106', '李方方' , 1, '1991-09-30', '计算机',54, '提前修完《数据结构》，并获学分'),
('081107', '韦明' , 1, '1989-2-12', '计算机',52, '已提前修完一门课程'),
('081108', '李红' , 0, '1990-11-26', '计算机',50, '三好学生'),
('081109', '赵琳' , 0, '1991-12-27', '计算机',48, '有一门课不及格，待补考'),
('081201', '王敏' , 1, '1989-05-11', '网络',42, null),
('081202', '王林' , 1, '1989-03-25', '网络',40, '有一门课不及格，待补考'),
('081203', '孙强' , 1, '1989-05-11', '网络',42, null),
('081204', '李研' , 0, '1991-12-11', '网络',42, null),
('081211', '胡琴' , 0, '1990-11-11', '网络',42, null)

go
insert into kcb 
values('101','计算机基础',1,80,5),
('102','c#',1,80,5),
('103','html',1,80,5),
('202','sql',1,80,5),
('205','java',1,80,5),
('301','java web',1,80,5),
('305','php',1,80,5),
('311','c#.net',1,80,5)

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
select * from kcb
select * from cjb


--0、设置cjb中的学号和课程号为外键。

use pxscj		--当前表为外键
alter table cjb
add constraint fk_cjb_xsb foreign key(学号)references xsb(学号)
--当前表的学号字段为'xsb'表中'学号'字段的外键，'xsb'中的'学号'为主键

use pxscj
alter table cjb
add constraint fk_cjb_kcb foreign key(课程号)references kcb(课程号)			
--foreign:外键	constraint:约束	references:选择的主键
	
--1、创建xsb1表（假设xsb1表未创建），并对“学号”
--字段创建primary key约束，对“姓名”字段定义
--unique约束。
use pxscj
create table xsb1	--创建代码时就设置
(学号 char(6),
姓名 char(6),
constraint pk primary key(学号),
constraint px unique(姓名))	--设置唯一键

drop table xsb1
use pxscj
create table xsb1	--独立创建表
(学号 char(6) not null,
姓名 char(6))
 
 
alter table xsb1
add constraint pk primary key(学号)	--添加主键
 
 
alter table xsb1
add constraint px unique (姓名)	--设置唯一键

--2、创建一个course_name表来记录每门课程的学
--生学号、姓名、课程号、学分和毕业日期。其中
--，学号、课程号和毕业日期构成复合主键，学分
--为唯一键。

--constraint pk primary key(学号,姓名)	--添加主键

--3、修改xsb1表，向其中添加一个“身份证号码
--”字段，对该字段定义unique约束。对“出生时
--间”字段定义unique约束。
use pxscj
alter table xsb1 
add 出身时间 datetime
add 身份证 char(20)

alter table xsb1 
add constraint up unique(身份证)
alter table xsb1 
add constraint ux unique(出身时间)

--4、删除上例中创建的primary key约束和
--unique约束。
insert into xsb values(123456,'陈宗顺',1,'1998-07-13','软件',100,null)
delete cjb where 学号='123456'
insert into cjb values(123456,101,88)

select * from xsb where 姓名='陈宗顺'
select * from kcb
select * from cjb

