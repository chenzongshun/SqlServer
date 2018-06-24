create database pxscj
on primary
( name='pxscj_data',
  filename='E:\SQLserver\2017 04 21\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\SQLserver\2017 04 21\pxscj.ldf',
  size=1mb,
  maxsize=10mb,
  filegrowth=10%
)

go
use pxscj
go
create table xsb
(
 	
	学号 	char(6)	NOT NULL PRIMARY KEY,
  	姓名 	char(8) 	NOT NULL,
  	性别 	bit 		NULL DEFAULT 1,
  	出生时间 	date 		NULL,
  	专业 	char(12) 	NULL,
  	总学分 	int 			NULL,	
  	备注		varchar(500) NULL
)
go
CREATE TABLE KCB
( 	
	课程号 	char(3)	NOT NULL PRIMARY KEY,
  	课程名 	char(16) 	NOT NULL,
  	开课学期 	tinyint 		NULL DEFAULT 1,
  	学时 	tinyint 		NULL DEFAULT 0,
  	学分 	tinyint 	NOT	NULL DEFAULT 0

)
go
create table CJB
(
学号 char(6) not null,
课程号 char(3) not null,
成绩 int null default 0,
primary key(学号,课程号)
)
go
use pxscj
go
INSERT INTO XSB 
VALUES('081101','王林',1,'1990-02-10','计算机',50,NULL),
('081102', '程明' , 1, '1991-02-1', '计算机',50, NULL),
('081103', '王燕' , 0, '1989-12-12', '计算机',50, NULL),
('081104', '韦严平' , 1, '1990-12-20', '计算机',50, NULL),
('081106', '李方方' , 1, '1991-09-30', '计算机',54, '提前修完《数据结构》，并获学分'),
('081107', '韦明' , 1, '1989-2-12', '计算机',52, '已提前修完一门课程'),
('081108', '李红' , 0, '1990-11-26', '计算机',50, '三好学生'),
('081109', '赵琳' , 0, '1991-12-27', '计算机',48, '有一门课不及格，待补考'),
('081201', '王敏' , 1, '1989-05-11', '网络',42, NULL),
('081202', '王林' , 1, '1989-03-25', '网络',40, '有一门课不及格，待补考'),
('081203', '孙强' , 1, '1989-05-11', '网络',42, NULL),
('081204', '李研' , 0, '1991-12-11', '网络',42, NULL),
('081211', '胡琴' , 0, '1990-11-11', '网络',42, NULL)

go
INSERT INTO KCB 
VALUES('101','计算机基础',1,80,5),
('102','C#',1,80,5),
('103','HTML',1,80,5),
('202','SQL',1,80,5),
('205','JAVA',1,80,5),
('301','JAVA WEB',1,80,5),
('305','PHP',1,80,5),
('311','C#.NET',1,80,5)

go
insert into cjb
values('081101','101',89),
('081101','102',79),
('081101','103',80),
('081102','101',83),
('081102','102',73),
('081102','103',83),
('081103','101',54),
('081103','102',79),
('081103','103',80),
('081104','101',49),
('081104','102',79),
('081104','103',80),
('081106','101',89),
('081106','102',59),
('081106','103',80),
('081201','101',60),
('081201','102',79),
('081201','103',80),
('081203','101',78),
('081203','102',79),
('081203','103',80)

--0、计算1到100相加的和。（用goto）

declare @i int = 0 ,@s int = 1	--赋初始值
loop:if(@i<=10)					--如果i小于等于10   loop：循环
  begin
    set @s=@s+@i	set @i=@i+1
    goto loop						--千万不要把goto放到end后，否则视为死循环
  end								--因为并没有跳转到标志行进行判断语句
print 'i最后的值为：'+CONVERT(VARCHAR(10),@i)
print '累加的值为：'+CONVERT(VARCHAR(10),@s) 
go

--1、计算1到100相加的和。(用while)

declare @i int = 0 ,@s int = 1	--赋初始值
while(@i<=10)					--如果i小于等于10   loop：循环
	begin
		set @s=@s+@i	set @i=@i+1
	end								--因为并没有跳转到标志行进行判断语句
print 'i最后的值为：'+CONVERT(VARCHAR(10),@i)
print '累加的值为：'+CONVERT(VARCHAR(10),@s) 
go

--2、计算1到100中的奇数之和。

declare @i int = 0 ,@s int = 0	--赋初始值
while(@i<100)		--循环一百次
 begin
  set @i=@i+1
  if(@i%2<0)
   continue
 set @s=@s+@i  
 end
print @s
go

declare @i int = 0 ,@s int = 0	--赋初始值
for(set @s = 0,@i<100,@i++)		--循环一百次
 begin
  set @i=@i+1
  if(@i%2<0)
   continue
 set @s=@s+@i
 end

update xsb set 总学分=30 where 学号=081101	--修改分数
declare @xhjc int = 0
while((select 总学分 from xsb where 学号=081101)<60)		--如果小于60
begin
 update xsb set 总学分+=2 where 学号=081101
 set @xhjc+=1
end
print '总共循环了'+convert(varchar(10),@xhjc)
