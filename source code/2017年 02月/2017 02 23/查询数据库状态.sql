create database aaa

use aaa
go	
select DATABASEPROPERTYEX('aaa','status')		--status状态
as ' aaa数据库库状态'

sp_spaceused		--查看数据库

sp_spaceused

use aaa
alter database aaa
modify name = bbb;
go

sp_renamedb	图书管理系统,学校图书管理系统	--修改数据库名称rename：重命名