create database 学生管理
on primary
( name='学生管理_data',
  filename='E:\数据库基础\2017 03 07\学生管理.mdf',
  size=3mb,
  maxsize=100mb,
  filegrow
)
log on
( name='学生管理_log',
  filename='E:\数据库基础\2017 03 07\学生管理.ldf',
  size=1mb,
  maxsize=10mb,
  filegrowth=10%
)
go
use 学生管理
go
create table 档案表
(
 学号 char(8) not null,
 姓名 varchar(8) null,
 出生日期 datetime,
 入学成绩 decimal(4,1),
 家庭住址 varchar(30) 
)
go
drop table 课程表
create table 课程表
(
 学号 char(8) not null,
 课程号  char(3)  not null,
 成绩 decimal(4,1),
 constraint 顺 primary key(学号,课程号)--constraint:约束
 --其实就是添加了一个名为顺的索引吧，好像是，设置了两个主键
)
go
create table  成绩表
( 学号  char(8)  not null primary   key ,
  课程号  char(3)  not null,
  期中成绩  numeric(4,1) ,
 期末成绩  numeric(4,1)
) 

select * from 成绩表
select * from 档案表
select * from 课程表

use 学生管理

insert into 档案表 values('15612344','454','1998-12-02','51','14')

alter table 档案表
add constraint 顺6 primary key(学号 )
 
 
 
--今天主要学习了以下两个内容
alter table 档案表
add constraint 顺6 primary key(学号 )

create table 课程表
(
 学号 char(8) not null,
 课程号  char(3)  not null,
 成绩 decimal(4,1),
 constraint 顺 primary key(学号,课程号)--constraint:约束
 --其实就是添加了一个名为顺的索引吧，好像是，设置了两个主键
)