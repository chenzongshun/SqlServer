--1. �����ݿ�supplier�У�����������4����

 create database supplier
 on (
 name='supplier',
 filename='E:\SQLserver\2017 05 18\supplier.mdf',
 size=3mb,
 maxsize=100mb,
 filegrowth=1mb
 )
 
 log on(
 name='supplier_ldf',
 filename='E:\SQLserver\2017 05 18\supplier.ldf',
 size=3mb,
 maxsize=100mb,
 filegrowth=1mb
 )
go

--��Ӧ�̱�S(SNO,SNAME,CITY)

use supplier
create table s
(SNO int,		--SNO��SNAME��CITY�ֱ��ʾ��Ӧ�̴��롢��Ӧ������������
SNAME varchar(20),
CITY varchar(20))

--�����J(JNO,JNAME,COLOR,WEIGHT)

create table j     --��Ӧ�����ڳ��У�JNO��JNAME��COLOR��WEIGHT�ֱ��ʾ������롢���������ɫ������
(JNO int,
JNAME varchar(20),
COLOR varchar(10),
WEIGHTT int)

--���̱�P(PNO,PNAME,CITY)

create table p(		--PNO��PNAME��CITY�ֱ��ʾ���̴��롢���������������ڳ���
PNO int,
PNAME varchar(20),
CITY varchar(20))

--��Ӧ�����SPJ(SNO,PNO,JNO,QTY)

create table spj(		--SNO��Ӧ�̴��룬PNO���̴��룬JNO������룬QTY��ʾĳ��Ӧ�̹�Ӧĳ����ĳ�����������
SNO int,
PNO int,
JNO int,
QTY int) 

--Ȼ����ÿ������¼���������ɼ�¼��

select * from j		--�����	������롢���������ɫ������

insert into j values(1,'����','sliver',50)
insert into j values(2,'�ϻ�ǯ','red',20),
					(3,'��˿��','yellow',10),
					(4,'����','white',1),
					(5,'����','green',200)

select * from p		--���̱�   ���̴��롢���������������ڳ���

insert into p values(001,'¦��������','¦��'),
					(002,'��ɳһ����','��ɳ'),
					(003,'��̶���㳡','��̶'),
					(004,'������������ѧԺ��ַ','����'),
					(005,'��ɳ���','��ɳ')

select * from s		--��Ӧ�̱�	�ֱ��ʾ��Ӧ�̴��롢��Ӧ������������
insert into s values(1,'����','��̶'),
					(2,'����','��ɳ'),
					(3,'����','����'),
					(4,'��ô','��ɳ'),
					(5,'����','¦��')

select * from spj	--��Ӧ�����	SNO��Ӧ�̴��룬PNO���̴��룬JNO������룬QTY��ʾĳ��Ӧ�̹�Ӧĳ����ĳ�����������
insert into spj values(1,1,1,123),
					  (2,2,2,45),
					  (3,3,3,54),
					  (4,4,4,36),
					  (5,5,5,12)

--2���ֱ�д��SQL��䣬������¹��ܣ�
--(1)��ѯ����������30����ɫΪ"red"���������

select * from j where WEIGHTT>30 or COLOR = 'red'

--(2)��ѯ��ÿ����Ӧ��Ϊÿ�����̹�Ӧ��������� 

select sum(QTY) from SPJ group by SNO,PNO

--(3)��ѯ����"����"�Ĺ��̹�Ӧ"����"����Ĺ�Ӧ������

select s.SNAME from s where s.SNO=(
select SNO from spj where JNO=(
select jno from j where JNO = ))


select SNAME from S where SNO in (
select SNO from SPJ,P,J
where (CITY='��ɳ') and (SPJ.PNO=P.PNO) 
and (JNAME='�ϻ�ǯ') and (SPJ.JNO=J.JNO))

select * from j
select * from p
select * from s
select * from spj



--(4)��һ����ͼ������Ϊ����"green"��ɫ�������

create view gre as
select * from j where COLOR='green'

select * from gre

--3. ���й�ϵ���ݿ⡮study�����£�
--ѧ��(ѧ�ţ��������Ա�רҵ����ѧ��) �γ�(�γ̺ţ����ƣ�ѧ��) ѧϰ(ѧ�ţ��γ̺ţ�����) 
--��SQLʵ�֣�
--(0)�������ݿⲢ¼�����ɼ�¼��

 create database study
 on (
 name='study',
 filename='E:\SQLserver\2017 05 18\study.mdf',
 size=3mb,
 maxsize=100mb,
 filegrowth=1mb
 )
 
 log on(
 name='study_ldf',
 filename='E:\SQLserver\2017 05 18\study.ldf',
 size=3mb,
 maxsize=100mb,
 filegrowth=1mb
 )
go

create table student(		 --ѧ��(ѧ�ţ��������Ա�רҵ����ѧ��
sidd int,
sname varchar(10),
ssex varchar(2),
szy varchar(10),
sjxj int) 

create table cours(    -- �γ�(�γ̺ţ����ƣ�ѧ��) 
cid int,
cname varchar(10),
cxf int)

create table scour(	--�ɼ�(ѧ�ţ��γ̺ţ�����)
sidd int,
cid int,
sfs int)

--(1)��ѯû�л�ý�ѧ��ͬʱ������һ�ſγ̳ɼ���95�����ϵ�ѧ����Ϣ������ѧ�š�������רҵ�� 

select student.sidd,student.sname,student.szy from student join scour on scour.sidd = student.sidd join cours
on cours.cid = scour.cid where scour.sfs > 95

--(2)��ѯû���κ�һ�ſγ̳ɼ���80�����µ�����ѧ������Ϣ������ѧ�š�������רҵ�� 

select student.sidd,student.sname,student.szy from student join scour on scour.sidd = student.sidd join cours
on cours.cid = scour.cid where scour.sfs < 80 

--(3)�Գɼ��ù�����(100��)��ѧ�������û�л�ý�ѧ��ģ����佱ѧ����Ϊ 1000Ԫ�� 

update student
set sjxj = 1000 where student.sidd in(
select distinct scour.sidd from student,scour
where (student.sjxj is null) and (student.sidd=scour.cid) and(scour.sfs=100))

--(4)����ѧ���ɼ��ù�����(100��)�Ŀγ���ͼAAA�������γ̺š����ƺ�ѧ�֣�

create view AAA as
select distinct cours.cid,cours.cname,cours.cxf
from cours,scour
where (cours.cid=scour.cid) and(scour.sfs=100)

