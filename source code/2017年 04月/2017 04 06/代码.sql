------------------------回顾内容------------------------


--创建数据库

create database CPXS		
on
(
  name='cpxs_data',
  filename='E:\SQLserver\2017 04 06\cpxs.mdf',
  size=3,
  filegrowth=1
)

log on
(
  name='cpxs_log',
  filename='E:\SQLserver\2017 04 06\cpxs.ldf',
  size=3,
  filegrowth=1
)
use cpxs

--2，创建产品表

create table 产品表
(
产品编号 char(6) not null primary key,		--设置主键 primary key
产口名称  varchar(20)not null,
价格  numeric(6,1),				--数值类型，相当于double   (6,1)是代表着保留一位小数点
库存量  int null
)

--3.创建销售商表

create table 销售商表
(
客户编号 char(6) not null primary key,
客户名称  varchar(20)not null,
地区  varchar(20),
负责人  varchar(20),
电话   char(12)
)

--4 创建产品销售表

create table 产品销售表
(
销售日期 date,
产品编号 char(6) not null ,
客户编号 char(6) not null ,
客户名称  varchar(20)not null,
数量  int,
销售额  numeric(20,1)
)

--增加字段

alter table 产品表				--在这里混淆了一下，修改表格用的是alter而不是update，update用于修改记录行
add 产品简介 varchar(50)
use CPXS
select * from 产品表

--增加字段

alter table 产品表
drop column 产品简介				--这里注意要加column，否则删除的是constraint约束

--插入记录

insert into 产品表 values('132','面包',42,42)
select * from 产品表
insert into 产品表 values('133222','电脑',5,82),('132132','红酒',100,22)

--修改表格中的价格列,将其打个八折

update 产品表 set 价格=价格*0.8 
select * from 产品表 

--9 将打8折后的商品价格低于50的删除

delete   from 产品表 where 价格 < 50			--这里较为生疏
select * from 产品表 where 库存量 = 22			--与查询作为对比

--10 增加主键

alter table 产品销售表
add constraint PK_产品销售表 primary key(产品编号,客户编号,客户名称)