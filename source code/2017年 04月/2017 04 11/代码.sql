create database pxscj
on primary
( name='pxscj_data',
  filename='E:\SQLserver\2017 04 11\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\SQLserver\2017 04 11\pxscj.ldf',
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


--1、创建CS_KC视图，包括计算机专业各学生的学号、
--其选修的课程号及成绩。要保证对该视图的修改都符合“专业为计算机”这一条件。

create view CS_KC
as						--as:作为	这个给忘了
select a.学号,成绩,b.课程号,c.课程名,专业 from xsb a inner 
join CJB b on a.学号=b.学号
join KCB c on b.课程号=c.课程号
where 专业='计算机'

--2、创建计算机专业学生的平均成绩视图CS_KC_AVG，
--包括学号（在视图中列名为num）和平均成绩（在视图中列名为score_avg）。

create view CS_KC_AVG(num,score_avg,课程号,课程名,专业)		--如果要取名字的话记得要和下面查询的列数配对上
as						--as:作为	这个给忘了
select a.学号,成绩,b.课程号,c.课程名,专业 from xsb a inner 
join CJB b on a.学号=b.学号
join KCB c on b.课程号=c.课程号
where 专业='计算机'

--3、使用视图CS_KC查找计算机专业的学生学号和选修的课程号。

select * from CS_KC			--虽然提示对象名无效,但是不知为何能够出来预想的结果

--4、查找平均成绩在80分以上的学生的学号和平均成绩。

select * from CS_KC where 成绩>80


--自己的附加题目	加密

create view CS_KC1
with encryption				--加密
as						--as:作为	这个给忘了
select a.学号,成绩,b.课程号,c.课程名,专业 from xsb a inner 
join CJB b on a.学号=b.学号
join KCB c on b.课程号=c.课程号
where 专业='计算机'
