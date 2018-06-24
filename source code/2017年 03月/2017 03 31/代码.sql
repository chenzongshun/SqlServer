create database pxscj
on primary
( name='pxscj_data',
  filename='E:\���ݿ����\2017 03 31\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\���ݿ����\2017 03 31\pxscj.ldf',
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

--�Ӳ�ѯ:

--1����ѯ102�ſγ����гɼ���80�����ϵ�ѧ��������

select * from xsb join CJB on xsb.ѧ��=CJB.ѧ�� where CJB.�ɼ�>80	 --��ʾ7��

select distinct xsb.ѧ��,���� from xsb join CJB on xsb.ѧ��=CJB.ѧ�� where CJB.�ɼ�>80 

select * from xsb			--������Դ�distinct����ѧ�ŵĲ�����	��ʾ6��
where ѧ�� in (
select ѧ�� from CJB where �ɼ� >80
)

--2���г�����רҵ������ѧ���ĳɼ������

select xsb.*,CJB.�ɼ� from xsb join CJB on xsb.ѧ��=CJB.ѧ�� where רҵ='����'

select * from xsb
where ѧ�� in (
select ѧ�� from CJB where רҵ='����'
)

select * from CJB
where ѧ�� in (
select ѧ�� from xsb where רҵ='����'
)

--3����XSB���в�������Ůѧ����������ѧ�ż�����081101��ѧ���������ࡣ

select ����,ѧ��,YEAR(����ʱ��)-YEAR
(( 							--ע��year�������Ӳ�ѯ�ĺ������Ŷ�Ҫд������ ����Ҫдin
   select ����ʱ�� from xsb where ѧ��='081101'
)) as ������� 
from xsb
where �Ա� = '0'

--4����ѯ�γ̺�Ϊ103�����гɼ����ڿγ̺�Ϊ102���������гɼ���ѧ����ѧ�ź����гɼ���

select * from CJB where �γ̺�='103' and �ɼ� > all(
select �ɼ� from CJB where �γ̺�='102'
)

--5���ӳɼ������г�102�ſγ̵����гɼ�
--���ڴ˿γ����гɼ�ƽ��ֵ
--�ļ�¼��ѧ�š��������γ̺ź����гɼ���

select * from CJB where �γ̺�='102' and �ɼ� > all(
(select AVG(�ɼ�) from CJB where �γ̺�='102')
)



