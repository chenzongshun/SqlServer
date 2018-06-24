create database pxscj_2
on primary
( name='pxscj_2_data',
  filename='g:\SQLserver\2017 05 05\pxscj_2.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_2_log',
  filename='g:\SQLserver\2017 05 05\pxscj_2.ldf',
  size=1mb,
  maxsize=10mb,
  filegrowth=10%
)

go
use pxscj_2
go

use pxscj_2
go
create table student				--����һ��ѧ����
(
sno varchar(3)not null,		--ѧ��ѧ��
sname varchar(4)not null,	--ѧ������
ssex varchar(2) not null,	--ѧ���Ա�
sbirthday datetime ,		--��������
class varchar(5)			--���ڰ༶
) 
go  
create table course					--����һ���γ̱�
(
cno varchar(5)not null,			--�γ̺�
cname varchar(10) not null,		--�γ�����
tno varchar(10)not null			--���Һ�
) 
go  
create table score   				--����һ���ɼ���
(
sno varchar(3)not null,			--ѧ��ѧ��
cno varchar(5)not null,			--�γ̺�
degree numeric(10, 1)not null	--�ɼ�
)
  
go  
create table teacher  				--����һ����ʦ��
(
tno varchar(3)not null,			--��ʦ��
tname varchar(4) not null,		--��ʦ����
tsex varchar(2) not null,		--��ʦ�Ա�
tbirthday datetime not null,	--��ʦ����ʱ��
prof varchar(6),				--��ʦְλ
depart varchar(10)not null		--����ϵ��
) 
go
insert into student(sno,sname,ssex,sbirthday,class) 
values (108 ,'����' ,'��' ,'1977-09-01',95033);  
insert into student(sno,sname,ssex,sbirthday,class) 
values (105 ,'����' ,'��' ,'1975-10-02',95031);  
insert into student(sno,sname,ssex,sbirthday,class) 
values (107 ,'����' ,'Ů' ,'1976-01-23',95033);  
insert into student(sno,sname,ssex,sbirthday,class) 
values  (101 ,'���' ,'��' ,'1976-02-20',95033);  
insert into student(sno,sname,ssex,sbirthday,class) 
values (109 ,'����' ,'Ů' ,'1975-02-10',95031);  
insert  into student(sno,sname,ssex,sbirthday,class)
values (103 ,'½��' ,'��' ,'1974-06-03',95031); 
go  
insert into course(cno,cname,tno)
values ('3-105','���������',825) 
insert into course(cno,cname,tno)
values ('3-245','����ϵͳ',804); 
insert into course (cno,cname,tno)
values ('6-166','���ݵ�·',856); 
insert into course(cno,cname,tno)
values ('9-888','�ߵ���ѧ',831); 
go  
insert into score(sno,cno,degree)
values (103,'3-245',86);  
insert into score(sno,cno,degree)
values (105,'3-245',75); 
insert into score(sno,cno,degree)
values (109,'3-245',68); 
insert into score(sno,cno,degree)
values (103,'3-105',92); 
insert into score(sno,cno,degree)
values (105,'3-105',88); 
insert into score(sno,cno,degree)
values (109,'3-105',76); 
insert into score(sno,cno,degree)
values (101,'3-105',64); 
insert into score(sno,cno,degree)
values (107,'3-105',91); 
insert  into score (sno,cno,degree)
values (108,'3-105',78); 
insert into score(sno,cno,degree)
values (101,'6-166',85); 
insert into score(sno,cno,degree)
values (107,'6-106',79); 
insert into score(sno,cno,degree)
values (108,'6-166',81); 
go  
insert into teacher(tno,tname,tsex,tbirthday,prof,depart)  
values (804,'���','��','1958-12-02','������','�����ϵ'); 
insert into teacher(tno,tname,tsex,tbirthday,prof,depart)  
values (856,'����','��','1969-03-12','��ʦ','���ӹ���ϵ'); 
insert  into teacher(tno,tname,tsex,tbirthday,prof,depart) 
values (825,'��Ƽ','Ů','1972-05-05','����','�����ϵ');  
insert into teacher(tno,tname,tsex,tbirthday,prof,depart)
values (831,'����','Ů','1977-08-14','����','���ӹ���ϵ');  
go

select * from COURSE		--�γ̱�
select * from SCORE			--�ɼ���
select * from STUDENT		--ѧ����
select * from TEACHER		--��ʦ��




--1����ѯ�����񡰽�ʦ�οε�ѧ���ɼ���

select * from score where cno=		--�ɼ���Ŀγ̺� = 
(select cno from course where tno=	--��ÿγ̺ţ�����Ϊ��ʦ��Ϊ
(select tno from teacher where tname='����'))

--2����ѯѡ��ĳ�γ̵�ͬѧ��������5�˵Ľ�ʦ������

select a.tname from teacher a where a.tno in(		---tno��ʦ��
	select x.tno from course x,score y where x.cno=y.cno	--con�γ̺�
	group by x.tno			--tno��ʦ��
	having count(x.tno)>5)

--3����ѯ������85�����ϳɼ��Ŀγ�cno.

select cno from score group by cno having max(degree)>85

--4����ѯ���������ϵ����ʦ���̿γ̵ĳɼ���

select s.* from score s join course c 
on s.cno=c.cno join teacher t
on t.tno=c.tno where t.depart='�����ϵ'

--5*����ѯ���н�ʦ��ͬѧ��name��sex��birthday.��union����

select t.tname,t.tsex,t.tbirthday from teacher t
union		--������,�����������ֶ�һ���Ļ��Ϳ��Խ�������
select s.sname,s.ssex,s.sbirthday from student s

--6*����ѯ�ɼ��ȸÿγ�ƽ���ɼ��͵�ͬѧ�ĳɼ���

select a.* from score a		--score�ɼ���
where degree<				--�ɼ�С��
(select avg(degree) from score b where a.cno=b.cno)--a.cno=b.cnoȷ���γ̺Ŷ����ٶԱ�

--7����ѯ�����пν�ʦ��tname��depart	���ֺ�ϵ��

select tname,depart 
from teacher join course on teacher.tno=course.tno

--8����ѯ������2�������İ�š�

select class from student  where ssex='��' group by class having count(ssex)>1

--9����ѯstudent���в��ա�������ͬѧ��¼��

select * from student where sname not like '��%' --����not

--10����ѯstudent����ÿ��ѧ�������������䡣

select s.sname,���� = year(getdate())-year(s.sbirthday) from student s 

--11����ѯstudent����������С��sbirthday����ֵ��

select year(max(sbirthday)),year(min(sbirthday)) from student

--12���԰�ź�����Ӵ�С��˳���ѯstudent���е�ȫ����¼��

select * from student order by sbirthday desc

--13����ѯ���С���ʦ�������ϵĿγ̡�

select * from course c join teacher t on c.tno=t.tno where t.tsex='��'

--14����ѯ��߷�ͬѧ��sno��cno��degree�С�

select top 1 * from score order by degree desc

--15����ѯ����ѡ�ޡ���������ۡ��γ̵ġ��С�ͬѧ�ĳɼ���
 
select student.*,score.* from score join student 
on student.sno=score.sno where cno=
(select cno from course where cname='���������')  and student.ssex='��'

 




/*							�ο���						*/

1��
select a.sno,a.degree 
from score a join teacher b join course c
 on b.tno=c.tno
on a.cno=c.cno
where b.tname='����'
��
select cno,sno,degree from score 
where cno=(
           select x.cno 
           from course x,teacher y 
           where x.tno=y.tno and y.tname='����'
           )
2��
select a.tname from teacher a ,course b,score c
where  b.cno=c.cno  and  a.tno=b.tno
group by a.tname 
having count(a.tname)>5
��
select tname from teacher where tno in(
         select x.tno from course x,score y 
         where x.cno=y.cno 
         group by x.tno 
         having count(x.tno)>5
         )
3��
select cno from score group by cno having max(degree)>85
��
select distinct cno from score where degree in (select degree from score where 
degree>85)
4��
select a.* from score a join teacher b join course c
on b.tno=c.tno 
on a.cno=c.cno 
where b.depart='�����ϵ'
5��
select sname as name, ssex as sex, sbirthday as birthday from student
union
select tname as name, tsex as sex, tbirthday as birthday from teacher;
6��
select a.* from score a 
where degree<(select avg(degree) from score b where a.cno=b.cno)
7��
select a.tname,a.depart from teacher a join course b on a.tno=b.tno
��
select tname,depart from teacher a where exists
(select * from course b where a.tno=b.tno)
��
select tname,depart from teacher where tno in (select tno from course)
8��
select class from student  where ssex='��' group by class having count(ssex)>1;
9��
select * from student a where sname not like '��%'
10��
select sname,(year(getdate())-year(sbirthday)) as age from student;
11��
select sname,sbirthday as themax from student where sbirthday =(select min(sbirthday)
from student)
union
select sname,sbirthday as themin from student where sbirthday =(select max(sbirthday) from 
student);
12��
select class,(year(getdate())-year(sbirthday)) as age from student order by class desc,age 
desc;
13��
select a.tname,b.cname from teacher a join course b on a.tno=b.tno where a.tsex='��';
14��
select a.* from score a where degree=(select max(degree) from score b )
15��
select * from score where sno in(select sno from student where
ssex='��') and cno=(select cno from course
where cname='���������')

