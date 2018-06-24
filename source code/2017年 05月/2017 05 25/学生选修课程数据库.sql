--设有学生选修课程数据库， 

create database xueshenbiao on(
name=xueshenbiao,
filename='D:\SQLserver\2017 05 25\xueshenbiao.mdf',
filegrowth=1,
size=3)
log on(
name=xueshenbiao_ldf,
filename='D:\SQLserver\2017 05 25\xueshenbiao.ldf',
filegrowth=1,
size=3)
go
use xueshenbiao

--学生表（学号，姓名，年龄，性别，所在系，地址，出生日期） 

drop table xsb
create table xsb(
id int primary key identity(1001,1),
name varchar(10),
nianling int,
sex varchar(2),
xibu varchar(16),
dizhi varchar(30),
birthday datetime)

--课程表（课程号，课程名称，教师姓名） 

drop table kcb
create table kcb(
kch int primary key,
kcm varchar(20),
tcname varchar(20))

--选课表（学号，课程号，成绩） 

drop table xkb
create table xkb(
id int primary key,
kch int,
scour int
constraint xkb_xsb foreign key(id) references xsb(id),
constraint xkb_kcb foreign key(kch) references kcb(kch))

--开始插入记录

select * from xsb
insert into xsb values('李方式',23,'男','电信系','湖南郴州','1991-02-05'),
					  ('就浪费',78,'女','足球系','北京大同','1956-05-30'),
				      ('陈发送',45,'男','电信系','湖南邵阳','1987-04-10'),
					  ('猪合格',26,'女','财贸系','湖南湘潭','1971-07-12'),
					  ('李部分',32,'男','农林系','东北范德','1987-02-09')

select * from xkb
insert into xkb values(1001,54,48),(1002,74,58),(1003,68,78),(1004,45,65),(1005,35,45)

select * from kcb
insert into kcb values(54,'计算机与生活','陈倒是'),
					  (74,'C#程序设计','李是的'),
					  (68,'大学语文','刘骄傲'),
					  (45,'java程序设计','李没'),
					  (35,'高职实用英语','李也')

--用SQL语言查询下列问题： 

--1）李老师所教的课程号、课程名称。

select * from kcb where tcname like '李%'
select * from kcb where tcname like '李_'

--2）年龄大于23岁的女学生的学号和姓名。 

select * from xsb

select * from xsb where sex = '女' and YEAR(GETDATE()) - YEAR(birthday) > 23

--3）“李是的”所选修的全部课程名称。 

select kcm from kcb where tcname = '李是的'

--4）所有成绩都在60分以上的学生姓名及所在系。 

select xsb.name,xsb.xibu,xkb.scour 
from xkb join xsb 
on xkb.id = xsb.id
where scour > 60

--5）没有选修“C#程序设计”课的学生姓名。 

select * from kcb join xkb 
on xkb.kch=kcb.kch join xsb
on xsb.id=xkb.id where kcm != 'C#程序设计'

--6）至少选修两门以上课程的学生姓名、性别。 

select name,sex from xsb where id in
(select id from xkb
group by id having count(id)>1)		--分组后再次统计是否超过1

--7）选修了李老师所讲课程的学生人数。

select count(id) from xkb, kcb		--计算id的数就是人数 从xkb、kcb中查
where xkb.kch=kcb.kch and tcname='李是的'

--8）没有选修李老师所讲课程的学生。

select * from xsb where xsb.id in 
(select id from xkb where xkb.kch in 
(select kch from kcb where tcname != '李是的'))
--如果用上面的id用=的话那么将会报错
--子查询返回的值不止一个。当子查询跟随在 =、!=、<、<=、>、>= 
--之后，或子查询用作表达式时，这种情况是不允许的
select distinct xsb.id, xsb.name 
from xsb, xkb, kcb 
where (xkb.id=xsb.id) and (xkb.kch=kcb.kch)
 and (tcname<>'李是的')

--9）“操作系统”课程得最高分的学生姓名、性别、所在系。
 
select top 1* from xsb,xkb,kcb 
where kcb.kch=xkb.kch and xsb.id=xkb.id and kcm like '计%'
order by xkb.scour		--asc 顺序_默认   desc倒叙

 
select top 1 xsb.id,xsb.name,xsb.xibu 
from xsb,xkb,kcb 
where xsb.id=xkb.id and kcb.kch=xkb.kch
and  kcm like '计%'
order by scour desc

 