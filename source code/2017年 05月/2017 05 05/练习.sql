create database pxscj_2
on primary
( name='pxscj_2_data',
  filename='g:\SQLserver\2017 05 05\pxscj_2.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_2_log',
  filename='g:\SQLserver\2017 05 05\pxscj_2.ldf',
  size=1mb,
  maxsize=10mb,
  filegrowth=10%
)

go
use pxscj_2
go

use pxscj_2
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
cno varchar(5)not null,			--课程号
cname varchar(10) not null,		--课程名字
tno varchar(10)not null			--教室号
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
select * from TEACHER		--教师表




--1、查询“张旭“教师任课的学生成绩。

select * from score where cno=		--成绩表的课程号 = 
(select cno from course where tno=	--获得课程号，条件为教师号为
(select tno from teacher where tname='张旭'))

--2、查询选修某课程的同学人数多于5人的教师姓名。

select a.tname from teacher a where a.tno in(		---tno教师号
	select x.tno from course x,score y where x.cno=y.cno	--con课程号
	group by x.tno			--tno教师号
	having count(x.tno)>5)

--3、查询存在有85分以上成绩的课程cno.

select cno from score group by cno having max(degree)>85

--4、查询出“计算机系“教师所教课程的成绩表。

select s.* from score s join course c 
on s.cno=c.cno join teacher t
on t.tno=c.tno where t.depart='计算机系'

--5*、查询所有教师和同学的name、sex和birthday.（union））

select t.tname,t.tsex,t.tbirthday from teacher t
union		--新内容,如果两个表的字段一样的话就可以进行连接
select s.sname,s.ssex,s.sbirthday from student s

--6*、查询成绩比该课程平均成绩低的同学的成绩表。

select a.* from score a		--score成绩表
where degree<				--成绩小于
(select avg(degree) from score b where a.cno=b.cno)--a.cno=b.cno确保课程号对上再对比

--7、查询所有有课教师的tname和depart	名字和系部

select tname,depart 
from teacher join course on teacher.tno=course.tno

--8、查询至少有2名男生的班号。

select class from student  where ssex='男' group by class having count(ssex)>1

--9、查询student表中不姓“王”的同学记录。

select * from student where sname not like '王%' --重在not

--10、查询student表中每个学生的姓名和年龄。

select s.sname,年龄 = year(getdate())-year(s.sbirthday) from student s 

--11、查询student表中最大和最小的sbirthday日期值。

select year(max(sbirthday)),year(min(sbirthday)) from student

--12、以班号和年龄从大到小的顺序查询student表中的全部记录。

select * from student order by sbirthday desc

--13、查询“男”教师及其所上的课程。

select * from course c join teacher t on c.tno=t.tno where t.tsex='男'

--14、查询最高分同学的sno、cno和degree列。

select top 1 * from score order by degree desc

--15、查询所有选修“计算机导论”课程的“男”同学的成绩表
 
select student.*,score.* from score join student 
on student.sno=score.sno where cno=
(select cno from course where cname='计算机导论')  and student.ssex='男'

 




/*							参考答案						*/

1、
select a.sno,a.degree 
from score a join teacher b join course c
 on b.tno=c.tno
on a.cno=c.cno
where b.tname='张旭'
或：
select cno,sno,degree from score 
where cno=(
           select x.cno 
           from course x,teacher y 
           where x.tno=y.tno and y.tname='张旭'
           )
2、
select a.tname from teacher a ,course b,score c
where  b.cno=c.cno  and  a.tno=b.tno
group by a.tname 
having count(a.tname)>5
或：
select tname from teacher where tno in(
         select x.tno from course x,score y 
         where x.cno=y.cno 
         group by x.tno 
         having count(x.tno)>5
         )
3、
select cno from score group by cno having max(degree)>85
或：
select distinct cno from score where degree in (select degree from score where 
degree>85)
4、
select a.* from score a join teacher b join course c
on b.tno=c.tno 
on a.cno=c.cno 
where b.depart='计算机系'
5、
select sname as name, ssex as sex, sbirthday as birthday from student
union
select tname as name, tsex as sex, tbirthday as birthday from teacher;
6、
select a.* from score a 
where degree<(select avg(degree) from score b where a.cno=b.cno)
7、
select a.tname,a.depart from teacher a join course b on a.tno=b.tno
或：
select tname,depart from teacher a where exists
(select * from course b where a.tno=b.tno)
或：
select tname,depart from teacher where tno in (select tno from course)
8、
select class from student  where ssex='男' group by class having count(ssex)>1;
9、
select * from student a where sname not like '王%'
10、
select sname,(year(getdate())-year(sbirthday)) as age from student;
11、
select sname,sbirthday as themax from student where sbirthday =(select min(sbirthday)
from student)
union
select sname,sbirthday as themin from student where sbirthday =(select max(sbirthday) from 
student);
12、
select class,(year(getdate())-year(sbirthday)) as age from student order by class desc,age 
desc;
13、
select a.tname,b.cname from teacher a join course b on a.tno=b.tno where a.tsex='男';
14、
select a.* from score a where degree=(select max(degree) from score b )
15、
select * from score where sno in(select sno from student where
ssex='男') and cno=(select cno from course
where cname='计算机导论')

