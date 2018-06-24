create database pxscj
on primary
( name='pxscj_data',
  filename='E:\���ݿ����\2017 03 21\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\���ݿ����\2017 03 21\pxscj.ldf',
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
  	�Ա� 	varchar(2) 		NULL DEFAULT 1,
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

select * from CJB
select * from KCB
select * from xsb

update xsb set �Ա� = '��' where �Ա�=1
update xsb set �Ա� = 'Ů' where �Ա�='0'


-----------�����޸ı�����------------

--���ݵķ����ѯ

--0��ͳ�Ƴɼ����������γ̿�Ŀ��������

select �γ�����=COUNT(distinct �γ̺�) from CJB		--distinct:���죬�ų�����ͬ��

--1��ͳ�Ƹ�רҵѧ������������

select COUNT(*)������ from xsb
select רҵ,����=COUNT(*) from xsb
group by רҵ

--2����cjb��ͳ�Ʋο����ſγ̵���������

delete CJB where ѧ��='081101' and �γ̺�='101'
delete CJB where ѧ��='081104' and �γ̺�='103'
delete CJB where ѧ��='081106' and �γ̺�='103'
select * from CJB
select �γ̺�,COUNT(ѧ��) as ���� from CJB
group by �γ̺�							--���γ̺������з���

--3��ͳ�Ƹ��ſγ���ĩ���Ե��ܷ֡�ƽ���֡���߷֡���ͷ���μӿ��Ե�������

select �γ̺�, sum(�ɼ�) �ܷ� ,AVG(�ɼ�) ƽ���� ,MAX(�ɼ�) ��߷� ,MIN(�ɼ�) ��ͷ�,COUNT(*)������ from CJB
group by �γ̺�

--4����רҵ�ֱ�ͳ����Ů����������

select count(רҵ)����,רҵ,�Ա� from xsb
group by רҵ,�Ա�
order by �Ա� desc

--5���ֱ��ѯ101��103�ſγ̵Ŀ��Գɼ����ܷ֡��ο�������ƽ���֡�

select  * from CJB
select �γ̺�,sum(�ɼ�) �ܷ� ,AVG(�ɼ�) ƽ���� ,MAX(�ɼ�) ��߷� ,MIN(�ɼ�) ��ͷ�,COUNT(*)���� from CJB
where �γ̺�='101' or �γ̺�='103'
group by �γ̺�

--6��������������5��רҵ��ʾ������					--�����п�ʼ�����û��ѧ

Select   רҵ, ����=count(*) 
From  xsb
Group  by   רҵ
Having   count(רҵ)>5

--7��ͳ�ƿ����������ϵĿγ̵�ѧ����ѧ�źͿγ�������

Select   ѧ��,count(*)
From  cjb
Group  by   ѧ��
Having  count(�γ̺�)>2
