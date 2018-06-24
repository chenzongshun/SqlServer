create database pxscj
on primary
( name='pxscj_data',
  filename='E:\SQLserver\2017 04 28\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\SQLserver\2017 04 28\pxscj.ldf',
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




--1、创建一个内嵌表函数能够查看某个专业、某门课程的考试情况。能显示学号、姓名、专业、课程名称、考试成绩；应用创建的函数进行查询。

drop function ckzymmkc		--删除函数
create function ckzymmkc(@zy varchar(10) = '计算机') 
returns table as
	return		--仅仅只有一个语句块不写begin否则出错
	select xsb.学号,姓名,专业,课程名,成绩 from xsb join CJB 
	on xsb.学号=CJB.学号 join KCB
	on KCB.课程号=CJB.课程号	where 专业=@zy
	
select * from dbo.ckzymmkc(default) where				--采用默认参数
select * from dbo.ckzymmkc('网络')	where 课程名 = 'C#'	--再次筛选

--2、在PXSCJ数据库中创建返回表的函数score_table()，通过以学号作为实参调用该函数，可显示该学生各门功课的成绩和学分。

create function score_table(@xh int) 
returns @ta table			--这里是返回一个表的变量，然后跟着表的结构
(
	学号 char(7),
	姓名 varchar(10),
	课程名 varchar(10),
	成绩 int,
	xf int
)
as							--还是 不要忘了as
begin
	insert @ta				--插入到表变量中去
	select xsb.学号,姓名,课程名,成绩,学分 from xsb,KCB,CJB
	where xsb.学号=CJB.学号 and KCB.课程号=CJB.课程号 and xsb.学号 = @xh
return						--返回一个空的
end

	--要点：开头返回的必须为一个表值变量 后面加table后紧跟表结构，字段名会在调用此函数时体现
	--函数体必须包含在begin end内，begin后面必须为inset+表变量，end上面必须为return，后面不跟任何东西

select * from score_table('081101')

--3、在PXSCJ数据库中创建一个多语句表值函数，可以返回某门课程或所有课程的学号、姓名、课程名、成绩。

create function kcmde(@kcm varchar(10)) 
returns table as				--再次验证仅仅只有一个语句块不写begin否则出错
	return select x.学号,姓名,课程名,成绩 
	from xsb x inner join CJB c 
	on x.学号=c.学号 join KCB k 
	on k.课程号=c.课程号 where 课程名=@kcm		--课程名等于形参
 
select * from kcmde('计算机基础')

