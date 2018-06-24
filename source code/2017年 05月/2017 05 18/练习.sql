--1. 在数据库supplier中，创建有如下4个表：

 create database supplier
 on (
 name='supplier',
 filename='E:\SQLserver\2017 05 18\supplier.mdf',
 size=3mb,
 maxsize=100mb,
 filegrowth=1mb
 )
 
 log on(
 name='supplier_ldf',
 filename='E:\SQLserver\2017 05 18\supplier.ldf',
 size=3mb,
 maxsize=100mb,
 filegrowth=1mb
 )
go

--供应商表S(SNO,SNAME,CITY)

use supplier
create table s
(SNO int,		--SNO、SNAME、CITY分别表示供应商代码、供应商姓名、城市
SNAME varchar(20),
CITY varchar(20))

--零件表J(JNO,JNAME,COLOR,WEIGHT)

create table j     --供应商所在城市，JNO、JNAME、COLOR、WEIGHT分别表示零件代码、零件名、颜色和重量
(JNO int,
JNAME varchar(20),
COLOR varchar(10),
WEIGHTT int)

--工程表P(PNO,PNAME,CITY)

create table p(		--PNO、PNAME、CITY分别表示工程代码、工程名、工程所在城市
PNO int,
PNAME varchar(20),
CITY varchar(20))

--供应情况表SPJ(SNO,PNO,JNO,QTY)

create table spj(		--SNO供应商代码，PNO工程代码，JNO零件代码，QTY表示某供应商供应某工程某种零件的数量
SNO int,
PNO int,
JNO int,
QTY int) 

--然后在每个表中录入或插入若干记录。

select * from j		--零件表	零件代码、零件名、颜色和重量

insert into j values(1,'扳手','sliver',50)
insert into j values(2,'老虎钳','red',20),
					(3,'螺丝刀','yellow',10),
					(4,'钉子','white',1),
					(5,'梯子','green',200)

select * from p		--工程表   工程代码、工程名、工程所在城市

insert into p values(001,'娄底三大桥','娄底'),
					(002,'长沙一大桥','长沙'),
					(003,'湘潭万达广场','湘潭'),
					(004,'株洲汽车工程学院新址','株洲'),
					(005,'长沙广电','长沙')

select * from s		--供应商表	分别表示供应商代码、供应商姓名、城市
insert into s values(1,'即可','湘潭'),
					(2,'饭店','长沙'),
					(3,'早上','株洲'),
					(4,'那么','长沙'),
					(5,'请我','娄底')

select * from spj	--供应情况表	SNO供应商代码，PNO工程代码，JNO零件代码，QTY表示某供应商供应某工程某种零件的数量
insert into spj values(1,1,1,123),
					  (2,2,2,45),
					  (3,3,3,54),
					  (4,4,4,36),
					  (5,5,5,12)

--2、分别写出SQL语句，完成如下功能：
--(1)查询出重量大于30或颜色为"red"的零件名；

select * from j where WEIGHTT>30 or COLOR = 'red'

--(2)查询出每个供应商为每个工程供应零件的数量 

select sum(QTY) from SPJ group by SNO,PNO

--(3)查询出给"北京"的工程供应"齿轮"零件的供应商名；

select s.SNAME from s where s.SNO=(
select SNO from spj where JNO=(
select jno from j where JNO = ))


select SNAME from S where SNO in (
select SNO from SPJ,P,J
where (CITY='长沙') and (SPJ.PNO=P.PNO) 
and (JNAME='老虎钳') and (SPJ.JNO=J.JNO))

select * from j
select * from p
select * from s
select * from spj



--(4)建一个视图，定义为所有"green"颜色的零件。

create view gre as
select * from j where COLOR='green'

select * from gre

--3. 现有关系数据库‘study’如下：
--学生(学号，姓名，性别，专业、奖学金) 课程(课程号，名称，学分) 学习(学号，课程号，分数) 
--用SQL实现：
--(0)创建数据库并录入若干记录；

 create database study
 on (
 name='study',
 filename='E:\SQLserver\2017 05 18\study.mdf',
 size=3mb,
 maxsize=100mb,
 filegrowth=1mb
 )
 
 log on(
 name='study_ldf',
 filename='E:\SQLserver\2017 05 18\study.ldf',
 size=3mb,
 maxsize=100mb,
 filegrowth=1mb
 )
go

create table student(		 --学生(学号，姓名，性别，专业、奖学金
sidd int,
sname varchar(10),
ssex varchar(2),
szy varchar(10),
sjxj int) 

create table cours(    -- 课程(课程号，名称，学分) 
cid int,
cname varchar(10),
cxf int)

create table scour(	--成绩(学号，课程号，分数)
sidd int,
cid int,
sfs int)

--(1)查询没有获得奖学金、同时至少有一门课程成绩在95分以上的学生信息，包括学号、姓名和专业； 

select student.sidd,student.sname,student.szy from student join scour on scour.sidd = student.sidd join cours
on cours.cid = scour.cid where scour.sfs > 95

--(2)查询没有任何一门课程成绩在80分以下的所有学生的信息，包括学号、姓名和专业； 

select student.sidd,student.sname,student.szy from student join scour on scour.sidd = student.sidd join cours
on cours.cid = scour.cid where scour.sfs < 80 

--(3)对成绩得过满分(100分)的学生，如果没有获得奖学金的，将其奖学金设为 1000元； 

update student
set sjxj = 1000 where student.sidd in(
select distinct scour.sidd from student,scour
where (student.sjxj is null) and (student.sidd=scour.cid) and(scour.sfs=100))

--(4)定义学生成绩得过满分(100分)的课程视图AAA，包括课程号、名称和学分；

create view AAA as
select distinct cours.cid,cours.cname,cours.cxf
from cours,scour
where (cours.cid=scour.cid) and(scour.sfs=100)

