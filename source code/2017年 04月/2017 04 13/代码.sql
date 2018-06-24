create database pxscj
on primary
( name='pxscj_data',
  filename='G:\SQLserver\2017 04 13\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='G:\SQLserver\2017 04 13\pxscj.ldf',
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




--1、创建一个加密视图，可以检索各门课程的期中考试参考人数，平均分，最高分，最低分。

create view 成绩加密
with encryption as				--加了这个说明这个视图是加密了的
select COUNT(成绩) 人数,AVG(成绩) 平均分,MAX(成绩) 最高分,MIN(成绩) 最低分 from CJB

create view  成绩没有加密1 as
select COUNT(成绩) 人数,AVG(成绩) 平均分,MAX(成绩) 最高分,MIN(成绩) 最低分 from CJB

exec sp_helptext 成绩加密		--sp_helptext调用存储过程，来查看视图的代码


exec sp_helptext 成绩没有加密	--这里用来查看视图代码的加密性

--2、创建一个视图，可以检索学号、课程号、期末成绩，并且通过该视图修改、插入数据时期末成绩必须成绩>70 and 成绩<80

drop view 成绩修改视图 

create view 成绩修改视图 as
select * from CJB
where 成绩>70 and 成绩<80
with check option					--check:检查  option:选项	加了这句的意思是说只能够按照上面的条件去修改数据库

--3、创建视图cs_xs,可以检索计算机专业学生的基本信息；向CS_XS视图中插入以下记录：

create view cs_xs as
select * from xsb where 专业='计算机'
insert into cs_xs
values('081115', '刘明仪', 1,'1998-3-2', '计算机',50,null)

--4、将CS_XS视图中所有学生的总学分增加8。

update cs_xs set 总学分=总学分+ 8

--5、将CS_KC视图中学号为081101的学生的101号课程成绩改为90。

update cs_kc set 成绩=90
where 学号='081101'  and 课程号='101'

--6、删除CS_XS中女同学的记录。

delete from cs_xs where 性别 = 0		--删除中记得有个“from”
 
--7创建一个“课程成绩视图”。要求通过该视图插入一门 新课程：
--课程号为‘306’、课程名为‘高等数学’；参加考学生的学号为‘081301’ 、php的期中成绩为89分。


create view 课程成绩视图(学号,课程号1,成绩,课程号2,课程名)as  
select 学号,a.课程号,成绩,b.课程号,课程名
from cjb a join kcb b
on a.课程号=b.课程号
 
Insert into 课程成绩视图(课程号2,课程名)
Values ('108','高等数学')	--涉及多表只能够用这种方式
Insert into 课程成绩视图(学号,课程号1,成绩)
Values('020101','108',89 )

Insert into 课程成绩视图
Values('020101','108',89,'108','生物' ) 
--错误视图或函数 '课程成绩视图' 不可更新，因为修改会影响多个基表。


 