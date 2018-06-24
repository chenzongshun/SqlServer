--现有关系数据库如下： 
--数据库名：教师数据库

create database 教师数据库 
on
(name = 教师数据库,
filename = 'E:\SQLserver\2017 05 19\教师数据库.mdf',
filegrowth=1,
size=3)
log on
(name = 教师数据库_ldf,
filename = 'E:\SQLserver\2017 05 19\教师数据库.ldf',
filegrowth=1,
size=3)

--教师表(编号 char(6)，姓名，性别，民族，职称，身份证号) 

create table 教师表(
编号 char(6) primary key,
姓名 varchar(10),
性别 varchar(2) check(性别='男' or 性别 ='女'),		--仅仅只能输入男和女
民族 varchar(10) not null default '汉族',
职称 varchar(10),
身份证号 int unique,
constraint sfzhaoma unique(身份证号))

--课程表(课号 char(6)，名称) 

create table 课程表(
课程号 char(6)  primary key,
课程名 varchar(10))

alter table 课程表
alter column 课程名 varchar(20)		--修改表字段的数据类型

--任课表(ID，教师编号,课号，课时数) 

create table 任课表(
ID int identity(1,1),     --新知识：标识列identity(1,1)左边是从1开始，增量为1
教师编号 char(6),
课程号 char(6),
课时数  int check(课时数> 1 and 课时数<100))		--仅仅在1---100这个范围内

--用SQL语言实现下列功能的sql语句代码：

--1.	创建上述三表的建库、建表代码；
--   要求使用：主键(教师表.编号，课程表.课号)、
--外键(任课表.教师编号，任课表.课号)、

alter table 任课表
add constraint 教师表_编号_任课表_教师编号 foreign key(教师编号) references 教师表(编号)

alter table 任课表
add constraint 课程表_课号_任课表_课号 foreign key(课程号) references 课程表(课程号)

--   默认(民族)、非空(民族，姓名)、唯一(身份证号)、检查(性别、课时数),自动编号(ID)
--2.	将下列课程信息添加到课程表的代码
--        课号      课程名称
--        100001    SQL Server数据库
--        100002    数据结构
--        100003    VB程序设计

select * from 课程表

insert into 课程表 
values(100001,'SQL Server数据库'),
	  (100002,'数据结构'),
	  (100003,'VB程序设计')

--        修改  课号为100003的课程名称：Visual Basic程序设计

update 课程表 set 课程名='Visual Basic程序设计' where 课程号=100003

--        删除  课号为100003的课程信息        

delete 课程表 where 课程号=100003

--3.	写出创建[任课表视图](教师编号，姓名，课号，课程名称，课时数)的代码；

create view 任课表视图 as
select a.编号,a.姓名,c.课程号,c.课程名,b.课时数 
from 教师表 a join 任课表 b on a.编号 = b.教师编号 join 课程表 c
on b.课程号=c.课程号

select * from 任课表视图

--4.	写出创建[某门课任课教师]内嵌表值函数以及检索的代码；

create function 某门课任课教师 
(@kename varchar(20))				--局部变量记得打括号
returns table as
return (select a.编号,a.姓名,c.课程号,c.课程名,b.课时数 
from 教师表 a 
join 任课表 b on a.编号=b.教师编号
join 课程表 c on b.课程号=c.课程号)

select * from 某门课任课教师 ('数据结构')	--传值记得打括号,就跟C#一样

create function [某门课任课教师](@课程名 varchar(15))
returns table as
return (select 课程名称, 课时数, 教师姓名=姓名 from 任课表视图
where 课程名=@课程名)
go

--	    检索：所有代'SQL Server数据库'这门课程的老师姓名；

select * from 某门课任课教师 ('SQL Server数据库')

--5.	写出创建[统计课时数]：输出最大课时数、最低课时数、平均课时的存储过程以及执行代码；

drop proc 统计课时数
create procedure 统计课时数 as
select 最大课时数 = max(a.课时数),最小课程数 = min(a.课时数),
平均课时数 = avg(a.课时数) from 任课表 as a

exec 统计课时数

--6.	写出创建：计算某教师代课总课时，并将值返回的存储过程以及执行代码。(6分)
--执行：计算“郭老师”的总课时。

drop proc 某教师代课总课时 
create procedure 某教师代课总课时 
@教师名 nchar(16)
as
begin
   declare @总课时 int 
   select @总课时=sum (课时数) from 任课表视图
   where 姓名 = @教师名 
   print '总课时为' + convert(varchar(20), @总课时)
   
   print convert(varchar(20), @教师名)+ '的总课时为'
end
go

execute 某教师代课总课时 '老师名'

--7.	检索有一门或一门以上课程课时数大于90的所有教师的信息，包括编号、姓名。

select * from 教师表 where 教师表.编号 in(
select distinct  教师编号 from 任课表 where 课时数 > 90)		-distinctct差异

--8.	建一个规则，并将其绑定到教师表的职称列上，规定取值为（'教授','副教授','讲师', '助教'）之一。

create rule zhicheng _rule
as @zhicheng  in ('教授','副教授','讲师', '助教')
go
sp_bindrule zhicheng_rule, '教师表.职称'





