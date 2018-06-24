create database pxscj
on primary
( name='pxscj_data',
  filename='E:\SQLserver\2017 05 02\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\SQLserver\2017 05 02\pxscj.ldf',
  size=1mb,
  maxsize=10mb,
  filegrowth=10%
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



--1����ѯ��ѧ����40��50��֮���ѧ��ѧ�ź�����

select xsb.ѧ��,xsb.����,��ѧ�� from xsb 
where ��ѧ�� >= 40 and ��ѧ�� <= 50

select ѧ��, ����, ��ѧ��
from  xsb where ��ѧ�� between 40 and 50

--2����ѯ��ѧ����40��50��֮���ѧ��ѧ�ź�����
 
select xsb.ѧ��,xsb.����,��ѧ�� from xsb where ��ѧ�� <= 40 or ��ѧ�� >= 50
select ѧ��, ����, ��ѧ��
from  xsb
where ��ѧ�� not between 40 and 50

--3����ѯ�γ����ԡ��ơ���C��ͷ�����

select * from KCB where �γ��� like '[c]%'
select * from KCB where �γ��� like '��%'

--4����ѯ����ѡ��ѧ��������

select distinct ���� from xsb x inner join CJB c
on x.ѧ�� = c.ѧ�� join KCB k
on c.�γ̺�=k.�γ̺�
where c.�γ̺� != 'null'

select distinct ���� from xsb 
where  exists 
(select * from cjb where  xsb.ѧ��= cjb.ѧ��)

--5����ѯ�ɼ����ڡ����֡���߳ɼ���ѧ�������Լ��ɼ�

select a.ѧ��,a.����,a.�Ա�,b.�ɼ� 
from xsb a inner join CJB b 
on a.ѧ��=b.ѧ�� where 
�ɼ�>(select max(c.�ɼ�) 
from xsb x join CJB c on x.ѧ��=c.ѧ��
where x.����='����' )

update CJB set �ɼ�=�ɼ�-10 where CJB.ѧ��=081101
 
select ����, �γ���, �ɼ�
from xsb, cjb, kcb
where �ɼ�> all
(select top 2 b.�ɼ� from xsb a,  cjb b where a.ѧ��= b.ѧ�� and  a.����= '����')
	and xsb.ѧ��=cjb.ѧ��
	and kcb.�γ̺�=cjb.�γ̺�
	and ����<>'����'

