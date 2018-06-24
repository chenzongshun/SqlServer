create database pxscj
on primary
( name='pxscj_data',
  filename='E:\SQLserver\2017 05 11\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\SQLserver\2017 05 11\pxscj.ldf',
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

--做题之前认识新内容

select * from sys.procedures			--查看数据库内所有的存储过程
select * from sys.procedures where name = '存储过程名'

--巧用exists重复创建存储过程
if exists(select * from sys.procedures where name = '查看xsb')--存在就true
drop proc 查看xsb		--存在就删除它
go
create proc 查看xsb as
select * from xsb

exec 查看xsb

--1、输入学号，查看该学生的开课门数。（用输入参数）

select * from xsb 
select * from CJB	--先插入改变的与众不同
insert cjb values('081101','010','55')
insert cjb values('081101','110','55')

drop proc 开课门数
create proc 开课门数 @xh int=081101 as
select COUNT(*) from CJB where 学号=@xh

--2、输入学号，查看该学生的开课门数。（用输出参数）

drop proc 开课门数_用输出参数
create proc 开课门数_用输出参数 
@xh int=081101, @num int output as
select @num=COUNT(*) from CJB where 学号=@xh

--3、分别调用前两个函数查看‘081101’的开课情况。

exec 开课门数 081102

declare @n int
exec 开课门数_用输出参数 081101 , @n output		--多个参数记得逗号
select @n 门数

--4、创建一个存储过程do_insert，作用是向XSB表中插入一行数据
--('091201', '陶伟', 1, '1990-03-05', '软件工程',50, NULL);

create proc do_insert as
insert xsb values('091201', '陶伟', 1, '1990-03-05', '软件工程',50, NULL)
 
select * from xsb

--创建另外一个存储过程do_action
--在其中调用第一个存储过程，并根据条件处理该行数据，处理后输出相应的信息
--（输入0修改数据，如姓名变量刘英，性别为0；输入1则删除该记录）。
drop proc do_action
create proc do_action @n int as
begin
    exec do_insert        
  if(@n=0)    
    begin
      update xsb set 姓名='刘英',性别=0 where 学号='091201'
      print '修改成功'
    end
   else if(@n=1)
    begin
      delete xsb where 学号='091201'
      print '该记录已删除'
    end
  else
    print '请输入正确的数字'   
end

exec do_action 0
exec do_action 1
select * from xsb