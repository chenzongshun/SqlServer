1、建立表kcb2，同时定义总学分的约束条件为0～60。
create table kcb2
(
	课程号 char(6) not null,
	课程名 char(8) not null,
	学分 tinyint check (学分>=0 and 学分<=60) null 	/*通过check子句定义约束条件*/
)
2、创建xsb1表（假设xsb1表未创建），并对“学号”字段创建primary key约束，对“姓名”字段定义unique约束。
use pxscj
go
create table xsb1
(
	学号 	char(6) 	not null	constraint  xh_pk  primary key,
	姓名	char(8) 	not null	constraint xm_uk  unique,
	性别 	bit 		not null	default 1,
	出生时间 	date 		not null,
	专业 	char(12) 	null,
	总学分 	int 		null,
	备注 	varchar(500) null
) 
3、创建一个course_name表来记录每门课程的学生学号、姓名、课程号、学分和毕业日期。其中，学号、课程号和毕业日期构成复合主键，学分为唯一键。
create table course_name
(
	学号  	varchar(6)  not null,
	姓名  	varchar(8)  not null,
	毕业日期 date	 	 not null,
	课程号	varchar(3) ,
	学分		tinyint,
	primary  key (学号, 课程号, 毕业日期),
	constraint xf_uk  unique (学分)
)
4、修改例6.14中的xsb1表，向其中添加一个“身份证号码”字段，对该字段定义unique约束。对“出生时间”字段定义unique约束。
alter table  xsb1    
	add????身份证号码 char(20) 
		constraint sf_uk ??unique nonclustered (身份证号码)
go
alter table  xsb1    
	add????constraint cjsj_uk  unique nonclustered (出生时间)
5、删除例6.14中创建的primary key约束和unique约束。
alter table  xsb1 
	drop????constraint xh_pk, xm_uk
go
6、创建一个表student，只考虑“学号”和“性别”两列，性别只能包含男或女。
use pxscj
go
create  table  student
 (	
	学号 char(6) not null,
 	性别 char(1) not null check(性别 in ('男', '女'))
 )
7、创建一个表student1，只考虑“学号”和“出生日期”两列，出生日期必须大于1980年1月1日，并命名check约束。
create table student1
 (	
	学号 char(6) 	not null,
 	出生时间 datetime  not null,
 	constraint  df_student1_cjsj  check(出生时间>'1980-01-01')
 )
8、创建表student2，有“学号”、“最好成绩”和“平均成绩”三列，要求最好成绩必须大于平均成绩。
create  table  student2
 (	
	学号 char(6)    not null,
 	最好成绩 int  not null,
	平均成绩 int  not null,
 	   check(最好成绩>平均成绩)
)
9、通过修改pxscj数据库的cjb表，增加“成绩”字段的check约束。
use pxscj
go
alter table cjb     
	add constraint cj_constraint  check ?(成绩>=0 and 成绩<=100) 
10、删除cjb表“成绩”字段的check约束。
alter table cjb     
	drop constraint cj_constraint  



