use master
drop database 账单管理系统
create database 账单管理系统
on
(
name='账单管理系统',
filename='D:\顺的文件\紧急备份\Cshar程序设计\C#所有源代码\2017\2017 年 03 月\2017 03 15\实战账单任务\账单管理系统.mdf',
size=3,
filegrowth=1)

log on
(
name='账单管理系统_ldf',
filename='D:\顺的文件\紧急备份\Cshar程序设计\C#所有源代码\2017\2017 年 03 月\2017 03 15\实战账单任务\账单管理系统_123.ldf',
size=1,
filegrowth=1)

use 账单管理系统

create table UserPwd
(bianhao int not null,
usernm varchar(8) primary key,
pwd varchar(8) not null)

insert into UserPwd values('4','3')
insert into UserPwd values('3','3')
insert into UserPwd values('1','1')

update UserPwd set pwd='1' where usernm='3'

select * from UserPwd 

use 账单管理系统
select * from UserPwd where usernm= '1' and  pwd= '1'

drop table shozhi
create table shouzhi
(bianhao int identity (1,1) not null,	--标识，从1开始，增量为1
收支 varchar(8) not null,
收支名称 varchar(50),
收支内容 varchar(200) 
+
)

insert into shouzhi values('支出','吃饭','和一家人')
insert into shouzhi values('支出','吃fff饭','和ffff一家人')
insert into shouzhi values('支出','吃fff饭','和ffff一家人')
insert into shouzhi values('支出','吃fff饭','和ffff一家人')
insert into shouzhi values('收入','暑假工','在长沙湘江世纪城有道是餐厅')
insert into shouzhi values('收入','暑假工','在长沙湘江世纪城有道是餐厅')

select * from shouzhi