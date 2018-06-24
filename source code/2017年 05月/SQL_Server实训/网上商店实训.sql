if exists(select * from sys.databases where name='wssd')
begin						--检查是否已经存在数据库，如果存在就删除
	use master
	drop database wssd
end
go 

--下面开始创建wssd数据库
create database wssd		--缩写网上商店
on (name=wssd,
filename='F:\SQL_Server实训\wssd.mdf',
filegrowth=1,
size=3)
log on (name=wssd_ldf,
filename='F:\SQL_Server实训\wssd.ldf',
filegrowth=1,
size=3)
go
use wssd
go 

/*			SQL中PK，FK意思：
--主键			constraint PK_字段 primary key(字段),
--唯一约束		constraint UK_字段 unique key(字段),
--默认约束		constrint DF_字段 default('默认值') for 字段,
--检查约束		constraint CK_字段 check(约束。如：len(字段)>1),
--主外键关系	constraint FK_主表_从表 foreign(外键字段) references 主表(主表主键字段)
*/



--下面开始创建commodity表		commodity:商品

if exists(select * from sys.tables where name = 'commodity')
	drop table commodity
create table commodity(			--商品表
/*商品编号*/	id bigint primary key,			--尽管int依然是SQL Server最主要的整数数据类型，但还是新增加了整数数据类型bigint，它应用于整数超过int数据范围的场合。
/*商品名称*/	name varchar(50),
/*商品价格*/	jiage decimal(10,2),
/*供应商编号*/	gysid varchar(20),
/*生产地*/		scd varchar(50))

--下面开始创建indent表			indent:订单

if exists(select * from sys.tables where name = 'indent')
	drop table indent
create table indent(			--订单表
/*订单编号*/	ddid bigint primary key,
/*商品编号*/	cmid bigint,
/*订购数量*/	dgcount int,
/*总价*/		zongjia money)

--下面开始创建供distributor表	distributor:供应商

if exists(select * from sys.tables where name = 'distributor')
	drop table distributor 
create table distributor(		--供应商表
/*供应商编号*/	gysid varchar(20) primary key,
/*供应商名称*/	gysname varchar(50))

--下面设置订单表和商品表的关系，有了商品表中的商品id，订单表中才能有商品的id号
alter table indent add constraint commodity_indent_id 
foreign key(cmid) references commodity(id)
go
--下面设置商品表和供应商表的关系，有了供应商的id，商品表里面才有商品的供应商id号
alter table commodity add constraint commodity_distributor_id 
foreign key(gysid) references distributor(gysid)
go

--			分别在三个表中插入2.13  2.15中的样本数据

--开始向商品表插入数据
insert into commodity values(1000,'盛唐笔记本',5600,430102,'广东'),
							(1001,'博士笔记本',6700,540199,'上海'),
							(1002,'360手机',2300,100001,'深圳'),
							(1003,'电子手表',4500,100002,'广东'),
							(1004,'河南面粉',7800,100003,'河南'),
							(1005,'爽口水产品',8900,100004,'湖北'),
							(1006,'惠普笔记本',7400,100005,'浙江'),
							(1007,'华硕笔记本',1800,100006,'北京')
							
----开始向订单表插入数据
insert into indent values(11070232,1000,3,16800),
						 (11060343,1002,21,125600),
						 (11050345,1003,2,3400),
						 (11050346,1004,5,13400),
						 (11050347,1005,9,28400),
						 (11050325,1006,6,13400),
						 (11050378,1007,15,53400)
						 
--开始向供应商表插入数据
insert into distributor values(100001,'至尊科技'),
							  (100002,'浙江三禾'),
							  (540199,'爱尚小小'),
							  (430102,'盛唐科技'),
							  (100003,'景宁中信'),
							  (100004,'清华同方'),
							  (100005,'合肥金伟'),
							  (100006,'博士科技'),
							  (440708,'惠普科技')
 
select * from commodity				--商品表
select * from indent				--订单表
select * from distributor			--供应商表
go

--				将商品为‘惠普笔记本’的商品价格下调10%
update commodity set jiage=jiage*90/100 where name='惠普笔记本'

--				查出商品编号为‘1002’的总订购数量
select dgcount 总订购数量 from indent where cmid = 1002

--查询出商品名称为‘惠普笔记本’的商品订购数量和价格

select 订购数量 = cmid , zongjia as 价格 from indent 
where cmid = (select id from commodity where name = '惠普笔记本')

--创建存储过程P_stored_proc,指定供应商代码，查询该供应商的订单信息

create procedure P_stored_proc @gysid int as
select * from distributor d inner 
join commodity c on c.gysid = d.gysid
join indent i on i.cmid=c.id where d.gysid = @gysid
go

--下面开始调用存储过程
exec P_stored_proc 430102
exec P_stored_proc @gysid = 440708
exec P_stored_proc '540199'


--查询所有名称包含‘科技’的供应商编号，供应商名称
update distributor set gysname ='博士电脑' where gysname = '博士科技'

select 应商编号 = d.gysid , d.gysname 供应商名称 
from commodity c,distributor d,indent i
where c.gysid = d.gysid and c.id = i.cmid
and gysname like '%科技%'

use wssd EXEC sp_changedbowner 'sa'		--使用wssd创建数据库关系图