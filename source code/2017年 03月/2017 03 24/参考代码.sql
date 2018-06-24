use pxscj
create table student
(
sno char(6) not null primary key,
xm  char(8) null
)

create table course
(
cno char(6) not null primary key,
km  char(8) null
)
insert into student values('1','张三'),('2','李四'),('3','王五')

insert into course values('1','数学'),('2','英语'),('4','体育')
select * from student
select * from course

select * 
from student,course
where student.sno=course.cno
--内连接,左表，右表
select * 
from student inner join course
on student.sno=course.cno
--外连接outer
--左连接：左表完全显示
select * 
from student left outer join course
on student.sno=course.cno
--右连接：右表完全显示
select * 
from student right outer join course
on student.sno=course.cno
--完全连接：左、右表完全显示
select * 
from student full outer join course
on student.sno=course.cno
--交叉连接：
select * 
from student cross join course
select * 
from student ,course

select * from xsb
select * from cjb
select *
from xsb inner join CJB
on xsb.学号=CJB.学号

select xsb.*,CJB.课程号,CJB.成绩
from xsb inner join CJB
on xsb.学号=CJB.学号

select xsb.*,CJB.课程号,CJB.成绩
from xsb ,CJB
where xsb.学号=CJB.学号
--查找选修了103号课程且成绩在80分以上的学生姓名及成绩。
select 姓名,成绩
from xsb inner join CJB
on xsb.学号=CJB.学号
where 课程号='103' and 成绩>=80
--：查找选修了“计算机基础”课程且成绩在80分以上的学生学号、姓名、课程名及成绩。
SELECT 	XSB.学号, 姓名, 课程名, 成绩
	FROM XSB JOIN CJB JOIN KCB 	 
		ON  CJB.课程号 = KCB.课程号  
         		ON  XSB.学号 = CJB.学号 
         		
         		
 SELECT 	XSB.学号, 姓名, 课程名, 成绩
	FROM kcb JOIN CJB JOIN xsb 	
	ON  XSB.学号 = CJB.学号  
		ON  CJB.课程号 = KCB.课程号 
	where 课程名='计算机基础'  and 成绩>=80

	
SELECT a.学号, a.课程号, b.课程号, a.成绩
FROM CJB a  JOIN  CJB b 
ON  a.成绩=b.成绩 AND  a.学号=b.学号 AND  a.课程号!=b.课程号       		

