use master
drop database pxscj
create database pxscj
on primary
( name='pxscj_data',
  filename='g:\���ݿ����\2017 03 09\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='g:\���ݿ����\2017 03 09\pxscj.ldf',
  size=1mb,
  maxsize=10mb,
  filegrowth=10%
)
go
use pxscj
go
create table xsb
(
 	
	ѧ�� 	char(6)	not null primary key,
  	���� 	char(8) 	not null,
  	�Ա� 	bit 		null default 1,
  	����ʱ�� 	date 		null,
  	רҵ 	char(12) 	null,
  	��ѧ�� 	int 			null,	
  	��ע		varchar(500) null
)
go
create table kcb
( 	
	�γ̺� 	char(3)	not null primary key,
  	�γ��� 	char(16) 	not null,
  	����ѧ�� 	tinyint 		null default 1,
  	ѧʱ 	tinyint 		null default 0,
  	ѧ�� 	tinyint 	not	null default 0

)
go
create table cjb
(
ѧ�� char(6) not null,
�γ̺� char(3) not null,
�ɼ� int null default 0,
primary key(ѧ��,�γ̺�)
)

--��񴴽����

use pxscj

--��ʼ����������
delete xsb  where ѧ��='201611'		--ɾ��ѧ������ѧ��Ϊ201611����

use pxscj
go
insert into xsb 
values('081101','����',1,'1990-02-10','�����',50,null),
('081102', '����' , 1, '1991-02-1', '�����',50, null),
('081103', '����' , 0, '1989-12-12', '�����',50, null),
('081104', 'Τ��ƽ' , 1, '1990-12-20', '�����',50, null),
('081106', '���' , 1, '1991-09-30', '�����',54, '��ǰ���꡶���ݽṹ��������ѧ��'),
('081107', 'Τ��' , 1, '1989-2-12', '�����',52, '����ǰ����һ�ſγ�'),
('081108', '���' , 0, '1990-11-26', '�����',50, '����ѧ��'),
('081109', '����' , 0, '1991-12-27', '�����',48, '��һ�ſβ����񣬴�����'),
('081201', '����' , 1, '1989-05-11', '����',42, null),
('081202', '����' , 1, '1989-03-25', '����',40, '��һ�ſβ����񣬴�����'),
('081203', '��ǿ' , 1, '1989-05-11', '����',42, null),
('081204', '����' , 0, '1991-12-11', '����',42, null),
('081211', '����' , 0, '1990-11-11', '����',42, null)

go
insert into kcb 
values('101','���������',1,80,5),
('102','c#',1,80,5),
('103','html',1,80,5),
('202','sql',1,80,5),
('205','java',1,80,5),
('301','java web',1,80,5),
('305','php',1,80,5),
('311','c#.net',1,80,5)

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
select * from kcb
select * from cjb


--0������cjb�е�ѧ�źͿγ̺�Ϊ�����

use pxscj		--��ǰ��Ϊ���
alter table cjb
add constraint fk_cjb_xsb foreign key(ѧ��)references xsb(ѧ��)
--��ǰ���ѧ���ֶ�Ϊ'xsb'����'ѧ��'�ֶε������'xsb'�е�'ѧ��'Ϊ����

use pxscj
alter table cjb
add constraint fk_cjb_kcb foreign key(�γ̺�)references kcb(�γ̺�)			
--foreign:���	constraint:Լ��	references:ѡ�������
	
--1������xsb1������xsb1��δ�����������ԡ�ѧ�š�
--�ֶδ���primary keyԼ�����ԡ��������ֶζ���
--uniqueԼ����
use pxscj
create table xsb1	--��������ʱ������
(ѧ�� char(6),
���� char(6),
constraint pk primary key(ѧ��),
constraint px unique(����))	--����Ψһ��

drop table xsb1
use pxscj
create table xsb1	--����������
(ѧ�� char(6) not null,
���� char(6))
 
 
alter table xsb1
add constraint pk primary key(ѧ��)	--�������
 
 
alter table xsb1
add constraint px unique (����)	--����Ψһ��

--2������һ��course_name������¼ÿ�ſγ̵�ѧ
--��ѧ�š��������γ̺š�ѧ�ֺͱ�ҵ���ڡ�����
--��ѧ�š��γ̺źͱ�ҵ���ڹ��ɸ���������ѧ��
--ΪΨһ����

--constraint pk primary key(ѧ��,����)	--�������

--3���޸�xsb1�����������һ�������֤����
--���ֶΣ��Ը��ֶζ���uniqueԼ�����ԡ�����ʱ
--�䡱�ֶζ���uniqueԼ����
use pxscj
alter table xsb1 
add ����ʱ�� datetime
add ���֤ char(20)

alter table xsb1 
add constraint up unique(���֤)
alter table xsb1 
add constraint ux unique(����ʱ��)

--4��ɾ�������д�����primary keyԼ����
--uniqueԼ����
insert into xsb values(123456,'����˳',1,'1998-07-13','���',100,null)
delete cjb where ѧ��='123456'
insert into cjb values(123456,101,88)

select * from xsb where ����='����˳'
select * from kcb
select * from cjb

