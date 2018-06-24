--现有关系数据库如下： 
--数据库名：医院数据库
use master
drop database hospital
go
create database hospital on(
name = hospital,
filename = 'E:\SQLserver\2017 05 24\hospital.mdf',
filegrowth = 1,
size = 3)
log on(
name = hospital_log,
filename = 'E:\SQLserver\2017 05 24\hospital.ldf',
filegrowth = 1,
size = 1)
go
--医生表(编号，姓名，性别，出生日期，职称) 
use hospital
create table yishengbiao(
yid int not null,
name varchar(10),
sex varchar(2),
birthday datetime,
zhicheng varchar(10) not null)

--病人表(编号，姓名，性别，民族，身份证号) 

create table bingrenbiao(
bid int not null identity(1,1),
name varchar(10) not null,
sex varchar(2),
mingzu varchar(10),
idcard int)

--病历表(ID，病人编号,医生编号，病历描述) 

create table binglibiao(
blid int identity(1,1),
brid int,
ysid int,
binglimiaoshu varchar(100))
go

--用SQL语言实现下列功能的sql语句代码：
--1.	创建上述三表的建库、建表代码；
--   要求使用：主键(医生表.编号，病人表.编号)、外键(病历表.医生编号，
--   病历表.病人课号)、非空(职称，姓名)、检查(性别),自动编号(ID) 
--yishengbiao  bingrenbiao  binglibiao

alter table yishengbiao add constraint zj primary key (yid)
alter table bingrenbiao add constraint br primary key (bid)

alter table binglibiao
add constraint ysidbrid foreign key(ysid) references yishengbiao(yid)
alter table binglibiao
add constraint ysidbrid1 foreign key(brid) references bingrenbiao(bid)

alter table yishengbiao add check(sex = '女' or sex = '男') 
alter table bingrenbiao add check(sex = '女' or sex = '男') 
go

--2.	将下列医生信息添加到医生表的代码
-- 编号   姓名 性别 出生日期 职称
--100001 杜医生 男 1963-5-18 副主任医师
--100002 郭医生 女 1950-7-26 副主任医师
--100003 刘医生 男 1973-9-18 医师

select * from yishengbiao
insert yishengbiao values(100001 ,'杜医生' ,'男' ,1963-5-18 ,'副主任医师')
insert yishengbiao values(100002 ,'郭医生' ,'女' ,1950-7-26 ,'副主任医师')
insert yishengbiao values(100003 ,'刘医生' ,'男' ,1973-9-18 ,'医师')

--        修改  编号为100002的医生职称为‘主任医师’

update yishengbiao set zhicheng = '主任医师' where yid = 100002

--        删除  编号为100003的医生信息        

delete yishengbiao where yid = 100003

--3.	写出创建：医疗表视图(医生编号，姓名，病人姓名，病历)的代码；
drop view ylsbt
create view ylsbt as(
select y.yid , y.name, br.name bm, b.binglimiaoshu	--如果去掉br.name后面的 bm就会报在视图或函数 'ylsbt' 中多次指定了列名 'name'。因为两个表中的名字都是叫name,不能够存在相同的name
from yishengbiao y join binglibiao b 
on y.yid = b.ysid join bingrenbiao br 
on br.bid = b.brid)

select * from ylsbt

--4.	写出所有病人编号、姓名、病历、以及病人所对应的医生编号的查询语句；

select br.bid,br.name,b.binglimiaoshu,y.yid 
from yishengbiao y join binglibiao b 
on y.yid = b.ysid join bingrenbiao br 
on br.bid = b.brid

--5.	写出创建：  输出某医生（根据医生编号即可）看病人数存储过程

create procedure kysbh @ysid int as(
select COUNT(*) 人数 from binglibiao where ysid = @ysid)

--	以及执行过程（要求输入医生姓名的参数，输出病人数）。

exec kysbh 100001

--6.	写出查询1970年以前出生的医生。

select * from yishengbiao
update yishengbiao set birthday = '1998-7-26' where yid = 100002

select * from yishengbiao where YEAR(birthday)<1970

--7.	检索有病人的医生信息。

select * from yishengbiao b where b.yid in (select ysid from binglibiao)

--8.	创建一个默认，并将其绑定到医生表的成绩职称列上，默认值为“医师”。
     	
select * from yishengbiao
create  default  zhicheng AS '医师'  

exec sp_bindefault 'zhicheng', 'yishengbiao.zhicheng'

--这个意思就是在添加表记录的时候会自动添加的默认值，前提是没有手动添加这个字段的前提下