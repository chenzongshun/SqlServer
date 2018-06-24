create database pxscj
on primary
( name='pxscj_data',
  filename='E:\数据库基础\2017 03 21\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\数据库基础\2017 03 21\pxscj.ldf',
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
  	性别 	varchar(2) 		NULL DEFAULT 1,
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

select * from CJB
select * from KCB
select * from xsb

update xsb set 性别 = '男' where 性别=1
update xsb set 性别 = '女' where 性别='0'


-----------创建修改表格完毕------------

--数据的分组查询

--0、统计成绩表中所考课程科目的总数。

select 课程总数=COUNT(distinct 课程号) from CJB		--distinct:差异，排除掉相同的

--1、统计各专业学生的总人数。

select COUNT(*)总人数 from xsb
select 专业,人数=COUNT(*) from xsb
group by 专业

--2、在cjb中统计参考各门课程的总人数。

delete CJB where 学号='081101' and 课程号='101'
delete CJB where 学号='081104' and 课程号='103'
delete CJB where 学号='081106' and 课程号='103'
select * from CJB
select 课程号,COUNT(学号) as 人数 from CJB
group by 课程号							--按课程号来进行分组

--3、统计各门课程期末考试的总分、平均分、最高分、最低分与参加考试的人数。

select 课程号, sum(成绩) 总分 ,AVG(成绩) 平均分 ,MAX(成绩) 最高分 ,MIN(成绩) 最低分,COUNT(*)总人数 from CJB
group by 课程号

--4、分专业分别统计男女生的人数。

select count(专业)人数,专业,性别 from xsb
group by 专业,性别
order by 性别 desc

--5、分别查询101、103号课程的考试成绩的总分、参考人数、平均分。

select  * from CJB
select 课程号,sum(成绩) 总分 ,AVG(成绩) 平均分 ,MAX(成绩) 最高分 ,MIN(成绩) 最低分,COUNT(*)人数 from CJB
where 课程号='101' or 课程号='103'
group by 课程号

--6、将总人数大于5的专业显示出来。					--从这行开始下面的没有学

Select   专业, 人数=count(*) 
From  xsb
Group  by   专业
Having   count(专业)>5

--7、统计考了两门以上的课程的学生的学号和课程门数。

Select   学号,count(*)
From  cjb
Group  by   学号
Having  count(课程号)>2
