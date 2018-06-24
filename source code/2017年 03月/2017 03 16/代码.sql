use master
drop database pxscj
create database pxscj
on primary
( name='pxscj_data',
  filename='D:\˳���ļ�\��������\���ݿ����\Դ����\2017�� 03��\2017 03 16\pxscj.mdf',
  size=3mb, 
  filegrowth=1
)
log on
( name='pxscj_log',
  filename='D:\˳���ļ�\��������\���ݿ����\Դ����\2017�� 03��\2017 03 16\pxscj.ldf',
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


--0����ѡ��101�γ̵�ѧ����ƽ���ɼ����ܳɼ���

select ƽ���ɼ� = AVG(�ɼ�),SUM(�ɼ�) as �ܳɼ� from CJB where �γ̺�='101'

--1����ѡ��101�γ̵�ѧ������߷ֺ���ͷ֡�

select ��߷� = max(�ɼ�),min(�ɼ�) as ��ͷ� from CJB where �γ̺�='101'

--2����ѧ��������

select COUNT(*) as ������ from xsb

--3��ͳ�Ʊ�ע��Ϊ�յ�ѧ������

select COUNT(*) from xsb where ��ע is null
select COUNT(*) from xsb where ��ע is not null
select * from xsb where ��ע is not null

--4��ͳ����ѧ����50�����ϵ�������

select * from xsb where ��ѧ��>50

--5����ѡ���˿γ̵�ѧ��������������Ϊѡ��

select * from xsb
select COUNT(רҵ) as ѡ������ѡ�޿ε� from xsb where רҵ='����'

--6�������±�xsb1,��ṹ��xsbһ����

select * into xsb1 from xsb
select * from xsb1

--7����ѯXSB���м����רҵ��ѧ�ִ��ڵ���42��ͬѧ�������

select * from xsb where רҵ='�����' and ��ѧ��>42

--8����ѯXSB�����ա������ҵ�����ѧ������������պ����գ�

select * from xsb
select * from xsb where ���� like ('��%')						--������
select * from xsb where ���� like ('%��%')						--�ַ�����ֻҪ������
select * from xsb where ���� like '��%' and ���� like '��%'		--������������Ĳ�����
select * from xsb where ���� like '��%' or ���� like '��%'		--ע�ⲻ��and����or

--9����ѯXSB����ѧ�ŵ�����3������Ϊ1���ҵ�����1������1��5֮���ѧ��ѧ�š�������רҵ��

select * from xsb where ѧ�� like '%1_[1-5]'					--ͨ����� % �������������򵥸��ַ�
select ѧ��,����,רҵ from xsb where ѧ�� like '%1_[12345]'		--�� _ ��ͨ����»��ߣ��������ⵥ���ַ�

--10����ѯXSB���в���1989�������ѧ�������

select * from xsb where ����ʱ�� between '1989-01-01' and '1989-12-31'		--between:�ڡ�֮��

--11����ѯXSB����רҵΪ�������������ͨ�Ź��̡������ߵ硱��ѧ�������

select * from xsb where רҵ = '�����' or רҵ = 'ͨ�Ź���' or רҵ = '���ߵ�'
select * from xsb where רҵ in ('�����','ͨ�Ź���','���ߵ�')				--in:�ڡ�֮��

--12����ѯ��ע�в�����ѧ�������
select * from xsb
select * from xsb where ��ע is null
select * from xsb where ��ע is not null

