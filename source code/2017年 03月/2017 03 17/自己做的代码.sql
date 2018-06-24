create database pxscj
on primary
( name='pxscj_data',
  filename='E:\���ݿ����\2017 03 17\pxscj.mdf',
  size=3mb, 
  filegrowth=1
)
log on
( name='pxscj_log',
  filename='E:\���ݿ����\2017 03 17\pxscj.ldf',
  size=1mb, 
  filegrowth=1
)

go
use pxscj
go
create table xsb
(
 	
	ѧ�� 	char(6)	NOT NULL PRIMARY KEY,
  	���� 	char(8) 	NOT NULL,
  	�Ա� 	bit 		NULL DEFAULT 1,
  	����ʱ�� 	date 		NULL,
  	רҵ 	char(12) 	NULL,
  	��ѧ�� 	int 			NULL,	
  	��ע		varchar(500) NULL
)
go
CREATE TABLE KCB
( 	
	�γ̺� 	char(3)	NOT NULL PRIMARY KEY,
  	�γ��� 	char(16) 	NOT NULL,
  	����ѧ�� 	tinyint 		NULL DEFAULT 1,
  	ѧʱ 	tinyint 		NULL DEFAULT 0,
  	ѧ�� 	tinyint 	NOT	NULL DEFAULT 0

)
go
create table CJB
(
ѧ�� char(6) not null,
�γ̺� char(3) not null,
�ɼ� int null default 0,
primary key(ѧ��,�γ̺�)
)
go
use pxscj
go
INSERT INTO XSB 
VALUES('081101','����',1,'1990-02-10','�����',50,NULL),
('081102', '����' , 1, '1991-02-1', '�����',50, NULL),
('081103', '����' , 0, '1989-12-12', '�����',50, NULL),
('081104', 'Τ��ƽ' , 1, '1990-12-20', '�����',50, NULL),
('081106', '���' , 1, '1991-09-30', '�����',54, '��ǰ���꡶���ݽṹ��������ѧ��'),
('081107', 'Τ��' , 1, '1989-2-12', '�����',52, '����ǰ����һ�ſγ�'),
('081108', '���' , 0, '1990-11-26', '�����',50, '����ѧ��'),
('081109', '����' , 0, '1991-12-27', '�����',48, '��һ�ſβ����񣬴�����'),
('081201', '����' , 1, '1989-05-11', '����',42, NULL),
('081202', '����' , 1, '1989-03-25', '����',40, '��һ�ſβ����񣬴�����'),
('081203', '��ǿ' , 1, '1989-05-11', '����',42, NULL),
('081204', '����' , 0, '1991-12-11', '����',42, NULL),
('081211', '����' , 0, '1990-11-11', '����',42, NULL)

go
INSERT INTO KCB 
VALUES('101','���������',1,80,5),
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

select * from xsb
select * from KCB
select * from CJB


--1����xsb�в���������26~27����������Լ�¼��ѧ�š����������䡢�Ա𡣲���������н������С�

select ѧ��,����,YEAR(GETDATE()) - YEAR(����ʱ��) ���� ,�Ա� = case	--�Ǻ����ͱ���Ҫ������
when �Ա�='1' then '��'  
else 'Ů'  
end
from xsb
where year(getdate()) - YEAR(����ʱ��) between 26 and 27				--between���and���ʹ��
order by YEAR(GETDATE()) - YEAR(����ʱ��) desc							--order by ����    desc ����	Ĭ��asc˳��

--2����ѯ����Ů�Լ�¼��ѧ�š�������רҵ���������ڣ�����רҵ���򣬳������ڽ������м�¼��

select ����,רҵ,����ʱ��,רҵ,�Ա� = case
when �Ա�='0' then 'Ů'
else '��' end
from xsb
where �Ա�='0'
order by ����ʱ�� desc

--3����ѧ��������רҵ�������в�ѯǰ����ѧ���������Լ��������ѧ��ͬרҵ��ѧ����������

select  top 3 with ties * from xsb				--with ties���topʹ�ã���ʾ�����ĸ��������רҵ��ͬ����
order by רҵ

--4����ѯ��ĩ�ɼ���ߵ�4����¼��ѧ��ѧ�ź���ĩ�ɼ��Լ�����ĸ�ѧ����ĩ�ɼ���ͬ����Щ��¼��

select top 3 with ties * from CJB order by �ɼ� desc

--5��ͳ��ѧ�����м�¼��������

select COUNT(*) ��ѧ���� from xsb

--6��ͳ�Ƴɼ����������γ̿�Ŀ��������

insert into KCB values (221,'C#',1,100,10)
select * from KCB
select COUNT(distinct �γ���) from KCB		--distinct����

--7��ͳ�Ƴɼ�����101�ſγ����гɼ����ֺܷ����гɼ���ƽ���֡�

select avg(�ɼ�) ƽ���� from CJB where �γ̺�='101'
select sum(�ɼ�) �ܷ� from CJB where �γ̺�='101'

--8�����������������������С��ѧ���ĳ������ڡ�

select MAX(YEAR(����ʱ��)) ��С����,MIN(YEAR(����ʱ��)) ������� from xsb
--select MiN(YEAR(����ʱ��)) ��С���� from xsb


select * from xsb
