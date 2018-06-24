drop database 图书管理系统		--删除数据库

create database 图书管理系统
on
(
name=图书管理系统_data,
filename='E:\ssssssssssssssss\2017 02 23\图书管理系统_data.mdf',
filegrowth=3,
maxsize=15
)
log on 
(
name=图书管理系统_log,
filename='E:\ssssssssssssssss\2017 02 23\图书管理系统_log.ndf',
filegrowth=20%)

sp_renamedb	图书管理系统,学校图书管理系统	--修改数据库名称rename：重命名

drop database 图书管理_data2

alter database 学校图书管理系统
( 图书管理系统_data.mdf
)