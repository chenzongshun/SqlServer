--现有关系数据库如下： 
--数据库名：学生成绩数据库

create database xscj on(
name=xscj,
filename='E:\SQLserver\2017 05 26\xscj.mdf',
size=3,
filegrowth=1)
log on(
name=xscj_ldf,
filename='E:\SQLserver\2017 05 26\xscj.ldf',
size=3,
filegrowth=1)
use xscj
go

drop table cjb,xsb,kcb
go
--学生表(班级编号，学号，姓名，性别，民族，身份证号，出生日期)

create table xsb(
classid int identity(2017,1),
xuehao int primary key,
name varchar(20),
sex varchar(2),
minzu varchar(20),
sfzh char(20),
birthday datetime) 

select * from xsb
delete xsb
insert xsb values(1001,'快快快','女','汉族','123456789456123','1998-02-09'),
			     (1002,'哦哦哦','男','汉族','185415645746566','1997-07-14'),
			     (1003,'额为额','女','傣族','156456144894633','1997-02-25'),
			     (1004,'惹我是','男','汉族','489795156745872','1998-03-13'),
			     (1005,'开发发','女','汉族','153456451674511','1998-06-12'),
			     (1006,'吧发在','女','苗族','451561564142313','1997-02-18'),
			     (1007,'人按时','男','侗族','486486789156782','1998-01-17'),
			     (1008,'士是是','女','汉族','455314551484545','1996-02-02'),
			     (1009,'去请按','男','汉族','156561546154564','1999-09-01'),
			     (10010,'核桃仁','女','汉族','123134546544874','1998-12-28')

--课程表(课程号，课程名) 

create table kcb(
kch int primary key,			--作为约束的主键表,它需要成为主键
kcm varchar(16))

select * from kcb
delete kcb
insert kcb values(1005,'C#程序设计'),
				 (1006,'java程序设计'),
				 (1007,'大学语文'),
				 (1008,'高等数学'),
				 (1009,'高效养猪技术'),
				 (10010,'计算机与生活'),
				 (10011,'养鳄鱼'),
				 (10012,'喂猪实战100列'),
				 (10013,'SQL数据库'),
				 (10014,'高职使用英语')

--成绩表(ID,学号，课号，分数) 

create table cjb(
id int identity(1001,1),
xuehao int primary key,
kch int not null,
scour int
constraint cjb_xsb_xuehao foreign key(xuehao) references xsb(xuehao),
constraint cjb_kcb_kch foreign key(kch) references kcb(kch))		--只有外键的后面才有key

select * from cjb
delete cjb
insert cjb values(1001,10012,100),
				 (1002,1005,45),
				 (1003,1006,87),
				 (1004,1007,89),
				 (1005,1008,92),
				 (1006,1009,64),
				 (1007,10010,61),
				 (1008,10011,56),
				 (1009,10013,71),
				 (10010,10014,40)

--用SQL语言实现下列功能的sql语句代码：
--1．在[学生成绩数据库]的[学生表]中查询年龄为20岁或22岁的学生。

select * from xsb where YEAR(GETDATE()) - YEAR(birthday) in (20,22)

--2．在[学生成绩数据库]中查询每个学生的班级编号、学号、姓名、平均分，结果按平均分降序排列，均分相同者按班级排列。

select x.classid,x.xuehao,x.name,AVG(c.scour) avg	--avg为平均分的别名
from xsb x,cjb c,kcb k	
where x.xuehao=c.xuehao and k.kch=c.kch 
group by x.classid,x.xuehao,x.name		--这三个字段必须要在select显示字段的后面也要显示出来
order by AVG(scour) desc,x.classid asc	--结果按平均分降序排列，均分相同者按班级排列

--3．编写一个自定义函数，根据[学生表]中的[出生日期]列，计算年龄。
create function nl (@xuehao int)
returns int as
begin
	declare @nl int
	select @nl = YEAR(GETDATE()) - year(birthday) from xsb where xuehao = @xuehao
	return @nl
end

declare @nl int,@xuehao int = 1001
select @nl = dbo.nl(@xuehao)
print '学号'+convert(varchar(10),@xuehao) + '的年龄是' + convert(varchar(10),@nl) + '岁'


--4．创建一个视图[教学成绩表视图]显示学生的学号、姓名、课程名、分数。

create view jxcjview as
select x.classid,x.xuehao,x.name,k.kcm,c.scour
from xsb x,cjb c,kcb k 
where x.xuehao=c.xuehao and k.kch=c.kch 

select * from jxcjview

--5．编写一个存储过程，输入学号，从[教学成绩表视图]显示该学生的姓名、课程名、分数。

drop proc xmkcfs
create procedure xmkcfs 
@xuehao int as
select name,kcm,scour from jxcjview where xuehao=@xuehao

exec xmkcfs 1001
exec xmkcfs @xuehao = 1006
exec xmkcfs '1002'


select * from xsb
update xsb set minzu='汉族',birthday='1980-12-24' where name = '快快快'
 
