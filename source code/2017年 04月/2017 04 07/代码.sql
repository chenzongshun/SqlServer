create database pxscj
on primary
( name='pxscj_data',
  filename='E:\SQLserver\2017 04 07\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\SQLserver\2017 04 07\pxscj.ldf',
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
('081103','101',89),
('081103','102',79),
('081103','103',80),
('081104','101',49),
('081104','102',79),
('081104','103',80),
('081106','101',89),
('081106','102',59),
('081106','103',80),
('081201','101',89),
('081201','102',79),
('081201','103',80),
('081203','101',89),
('081203','102',79),
('081203','103',80)



--以下是针对pxscj数据库中的xsb、cjb、kcb三表的操作，如没有满足条件的记录，请设计数据并插入表中。

--1、查询所有年龄不是27岁的学生的姓名、性别、出生日期。

select * from xsb where YEAR(出生时间)-YEAR(GETDATE())!=27

--2、查询网络和计算机专业学生的学号、姓名和性别。

select 学号,姓名,性别 from xsb where 专业='计算机' or 专业='网络'

--3、在pxscj数据库中将学生的出生日期分为三个阶段：1988年12月31日以前出生的为“89年以前出生”；1989年1月1日－1989年12月31日出生的为“89年出生”；1990年1月1日以后出生为“90年以后出生”。请查询学生的姓名、性别、出生时段、专业。
--
select 姓名,性别,出生时段 = case							--注意case在显示字段的后面使用
when 出生时间>'1988-12-31' then '89年以前出生'
when 出生时间>'1989-1-1' then '89年出生'
when 出生时间>'1990-1-1' then '89年以后出生'
end,专业 from xsb											--使用完case后一定要记得用end结束，否则出错

--4、查询期末成绩最高的4条记录的学生学号和期末成绩以及与第四个学生期末成绩相同的哪些记录。

select top 4 * from CJB order by 成绩 desc					--desc倒序		asc顺序

--5、查出档案表中年龄最大和最小的学生的出生日期。
--
select MAX(出生时间) 年龄最大,年龄最小 = MIN(出生时间) from xsb

--6、统计各专业学生的总人数。					--各  group分组查询
--
select 专业,COUNT(*) as 人数 from xsb group by 专业

--7、分别查询101、103号课程的期中考试成绩的总分、参考人数、平均分。
--
select 课程号,sum(cjb.成绩) 总分,count(xsb.学号) 参考人数,avg(成绩)平均分 
from CJB join xsb 
on xsb.学号=CJB.学号
where 课程号 in (102,103)
group by 课程号 

--8、从成绩表、学生表、课程表中检索记录，显示输出：学号、姓名、课程名、期平成绩，并根据课程名称排序。
--
select xsb.学号,姓名,KCB.课程名,成绩 
from xsb inner join CJB on xsb.学号=CJB.学号 
inner join KCB on KCB.课程号=CJB.课程号
order by kcb.课程名 

--9、查询选修了计算机基础且期中成绩在70分以上的学生的学号、姓名、课程名及期中成绩
--
select x.学号,姓名,课程名,成绩 
from xsb x join CJB c on x.学号=c.学号 
join KCB k on k.课程号=c.课程号
where 课程名='计算机基础' and 成绩>70

--10、查询哪些专业的学生选修了计算机基础。
--
select * from xsb join CJB
on xsb.学号=CJB.学号
where 课程号 = 
(select 课程号 from KCB where 课程名='计算机基础')

select * from xsb join CJB
on xsb.学号=CJB.学号
join KCB on CJB.课程号=KCB.课程号
where 课程名='计算机基础'


--11、根据学号将成绩表中的记录分为两组，学号尾数是1、2、3的为第一组。学号尾数为4、5、6的为第二组。
--    列出第一组中101号课程期末成绩高于第二组中此门课程期末成绩最低的学生名单。			any 任意一个

select * from cjb
Where 课程号='101' and 学号 like '%[1-3]'
and 成绩> all
(select 成绩 from cjb where 课程号='101' and 学号 like '%[4-6]')
group by 学号


Select * from cjb
Where   课程号='101' and 学号 like '%[1-3]'
 and    成绩>　all 
　　　　　 ( select   成绩　from   cjb
　　　　　　where　课程号='101'　and  
　　　　　　　　　 学号   like  '%[4-6]' )

--12、列出网络专业的所有学生的成绩情况。

select *,CJB.成绩 from xsb join CJB on xsb.学号=CJB.学号 where 专业='网络'

--13、创建一个网络专业学生的档案表，表名为“wlxsb”。

create table wlxsb
(姓名 varchar(10),
年龄 datetime)
select * from wlxsb

