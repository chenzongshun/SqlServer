create database pxscj
on primary
( name='pxscj_data',
  filename='E:\SQLserver\2017 04 20\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\SQLserver\2017 04 20\pxscj.ldf',
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


drop database pxscj


--1、用于查询总学分大于42的学生人数。
 
declare @num int
select @num=(select count(学号) from xsb where  总学分>42)
if @num<>0			--<>在数据库中叫'不等于'
select @num as '总学分>42的人数'



--2、如果“计算机基础”课程的平均成绩高于75分，则显示“平均成绩高于75分”。

declare @scoue int = 60
if (select avg(成绩) from CJB inner join KCB on CJB.课程号=KCB.课程号 where 课程名='计算机基础')>=@scoue
	goto a			--跳转到a的语句块
else
	goto b
	
a:begin				--begin：开始，标志着语句块的开始
print '平均成绩大于等于'+convert(char(10),@scoue)+'分'
return		--如果不写这里，如果正好又执行了这一段语句块，那么将会把下面的b语句块也执行掉，因为return只能结束当前语句块
end			--end：结束，标志着语句块的结束

b:begin 
print '平均成绩低于'+convert(char(10),@scoue)+'分'
return
end			--end如果不写的话就会出错，begin一定要配合end来使用
go

--3、使用CASE语句，根据性别值输出“男”或“女”。

select 姓名, 性别 =   --在这里为别名
case
 when  性别 =1 then '男' 
 when  性别 =0 then '女' 
end
from xsb

select 姓名, sex =			--sex在这里为别名
case 性别					--取性别的值
 when  1 then '男' 
 when  0 then '女' 
end
from xsb
