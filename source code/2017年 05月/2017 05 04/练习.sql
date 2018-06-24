create database pxscj
on primary
( name='pxscj_data',
  filename='E:\SQLserver\2017 05 04\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\SQLserver\2017 05 04\pxscj.ldf',
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


use pxscj
go
create table student				--创建一个学生表
(
sno varchar(3)not null,		--学生学号
sname varchar(4)not null,	--学生名字
ssex varchar(2) not null,	--学生性别
sbirthday datetime ,		--出生年月
class varchar(5)			--所在班级
) 
go  
create table course					--创建一个课程表
(
cno varchar(5)not null,			--课程编号
cname varchar(10) not null,		--课程名字
tno varchar(10)not null			--可能是课程的教室
) 
go  
create table score   				--创建一个成绩表
(
sno varchar(3)not null,			--学生学号
cno varchar(5)not null,			--课程号
degree numeric(10, 1)not null	--成绩
)
  
go  
create table teacher  				--创建一个教师表
(
tno varchar(3)not null,			--教师号
tname varchar(4) not null,		--教师名字
tsex varchar(2) not null,		--教师性别
tbirthday datetime not null,	--教师出生时间
prof varchar(6),				--教师职位
depart varchar(10)not null		--所属系部
) 
go
insert into student(sno,sname,ssex,sbirthday,class) 
values (108 ,'曾华' ,'男' ,'1977-09-01',95033);  
insert into student(sno,sname,ssex,sbirthday,class) 
values (105 ,'匡明' ,'男' ,'1975-10-02',95031);  
insert into student(sno,sname,ssex,sbirthday,class) 
values (107 ,'王丽' ,'女' ,'1976-01-23',95033);  
insert into student(sno,sname,ssex,sbirthday,class) 
values  (101 ,'李军' ,'男' ,'1976-02-20',95033);  
insert into student(sno,sname,ssex,sbirthday,class) 
values (109 ,'王芳' ,'女' ,'1975-02-10',95031);  
insert  into student(sno,sname,ssex,sbirthday,class)
values (103 ,'陆君' ,'男' ,'1974-06-03',95031); 
go  
insert into course(cno,cname,tno)
values ('3-105','计算机导论',825) 
insert into course(cno,cname,tno)
values ('3-245','操作系统',804); 
insert into course (cno,cname,tno)
values ('6-166','数据电路',856); 
insert into course(cno,cname,tno)
values ('9-888','高等数学',831); 
go  
insert into score(sno,cno,degree)
values (103,'3-245',86);  
insert into score(sno,cno,degree)
values (105,'3-245',75); 
insert into score(sno,cno,degree)
values (109,'3-245',68); 
insert into score(sno,cno,degree)
values (103,'3-105',92); 
insert into score(sno,cno,degree)
values (105,'3-105',88); 
insert into score(sno,cno,degree)
values (109,'3-105',76); 
insert into score(sno,cno,degree)
values (101,'3-105',64); 
insert into score(sno,cno,degree)
values (107,'3-105',91); 
insert  into score (sno,cno,degree)
values (108,'3-105',78); 
insert into score(sno,cno,degree)
values (101,'6-166',85); 
insert into score(sno,cno,degree)
values (107,'6-106',79); 
insert into score(sno,cno,degree)
values (108,'6-166',81); 
go  
insert into teacher(tno,tname,tsex,tbirthday,prof,depart)  
values (804,'李诚','男','1958-12-02','副教授','计算机系'); 
insert into teacher(tno,tname,tsex,tbirthday,prof,depart)  
values (856,'张旭','男','1969-03-12','讲师','电子工程系'); 
insert  into teacher(tno,tname,tsex,tbirthday,prof,depart) 
values (825,'王萍','女','1972-05-05','助教','计算机系');  
insert into teacher(tno,tname,tsex,tbirthday,prof,depart)
values (831,'刘冰','女','1977-08-14','助教','电子工程系');  
go

select * from COURSE		--课程表
select * from SCORE			--成绩表
select * from STUDENT		--学生表
select * from TEACHER		--教室表


--1、查询Student表中的所有记录的Sname、Ssex和Class列。

select Sname,Ssex,Class from STUDENT
  
--2、查询教师所有的单位即不重复的Depart列。

select distinct(DEPART) from TEACHER

--3、查询Student表的所有记录。

select * from STUDENT
  
--4、查询Score表中成绩在60到80之间的所有记录。  

select * from SCORE where DEGREE between 60 and 80

--5、查询Score表中成绩为85，或86及88的记录。in(85,86,88)  

select * from SCORE where DEGREE in (85,86,88)

--6、查询Student表中“95031”班或性别为“女”的同学记录。

select * from STUDENT where CLASS = '95031' or SSEX = '女'

--7、以Class降序查询Student表的所有记录。

select * from STUDENT order by SNO desc		--desc:倒序    asc:顺序
  
--8、以Cno升序、Degree降序查询Score表的所有记录。
  
select * from SCORE order by SNO asc,DEGREE desc	--多个排序用逗号

--9、查询“95031”班的学生人数。

select COUNT(*) '95031班的人数为' from STUDENT where CLASS = '95031'

--10、查询Score表中的最高分的学生学号和课程号。

select top 1 * from SCORE order by DEGREE desc 
select * from SCORE where DEGREE=(select MAX(DEGREE) from SCORE)

--11、查询3-105号课程的平均分。

select AVG(DEGREE) '3-105号课程的平均分为' from SCORE where CNO = '3-105'

--12、查询Score表中至少有3名以上学生选修的并以3开头的课程的平均分数。

select * from SCORE

select CNO 课程号,AVG(DEGREE) 平均分,COUNT(cno) 人数 from SCORE 
where CNO like '3%'
group by cno
having count(*)>3				--having count(*)新内容，分组统计

--13、查询最低分大于70，最高分小于90的Sno列。

select SNO from SCORE where DEGREE>70 and DEGREE < 90

--14、查询所有学生的Sname、Cno和Degree列。  

select Sname,Cno,Degree from STUDENT join SCORE on STUDENT.SNO=SCORE.SNO

--15、查询所有学生的Sno、Cname和Degree列。

select STUDENT.Sno,Cname,Degree 
from STUDENT join SCORE 
on STUDENT.SNO=SCORE.SNO join COURSE
on COURSE.CNO=SCORE.CNO

--16、查询所有学生的Sname、Cname和Degree列。

select Sname,Cname,Degree 
from STUDENT join SCORE 
on STUDENT.SNO=SCORE.SNO join COURSE
on COURSE.CNO=SCORE.CNO

--17、查询“95033”班所选课程的平均分。

select AVG(DEGREE) from SCORE where SNO in (
select sno from STUDENT where CLASS = '95033')
   
--18、查询和学号为'109'的同学同年出生的所有学生的Sno、Sname和Sbirthday列。(用year()函数)

select Sno,Sname,Sbirthday 
from STUDENT 
where YEAR(SBIRTHDAY)=(select year(SBIRTHDAY) from STUDENT where SNO=109)

