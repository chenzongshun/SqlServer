--1.�������ݿ�
create database pxscj
	on
	(
		name= 'pxscj_data',
		filename='f:\data\pxscj.mdf',
		size=3 mb,
		maxsize=50 mb,
		filegrowth=1mb		
	)
	log on			--��ʼ��־�ļ�
	(
		name='pxscj_log',		--��־�ļ������ݿ�����е�����
		filename='f:\data\pxscj.ldf',		--��־�ļ������е������ļ�����
		size=1 mb,
		maxsize=5 mb,
		filegrowth=10%
	);
--2������ѧ����
create table xsb
( 	
	ѧ�� 	char(6)	not null primary key,
  	���� 	char(8) 	not null,
  	�Ա� 	bit 		null default 1,
  	����ʱ�� 	datetime 		null,
  	רҵ 	char(12) 	null,
  	��ѧ�� 	int 			null,	
  	��ע		varchar(500) null
)
--3�������γ̱�
create table kcb
( 	
	�γ̺� 	char(3)	not null primary key,
  	�γ��� 	char(16) 	not null,
  	����ѧ�� 	tinyint 		null default 1,
  	ѧʱ 	tinyint 		null default 0,
  	ѧ�� 	tinyint 	not	null default 0

)
--4�������ɼ���
create table cjb
(
ѧ�� char(6) not null,
�γ̺� char(3) not null,
�ɼ� int null default 0,
primary key(ѧ��,�γ̺�)
)
--5����pxscj���ݿ�ı�xsb�в�������һ�����ݣ�
insert into xsb 
  	values('081101', '����' , 1, '1990-02-10', '�����',50, null)

select  *	from xsb

insert into xsb 
  	values('081111', '����' , 0, '1990-03-18', '�����',50, '����ѧ��')

insert into xsb (ѧ��, ����, �Ա�, ����ʱ��, ��ѧ��)
  	values('081102', '����', 1, '1990-02-10', 50)

insert into xsb 
  	values('081103', '����', 1, '1990-02-10', default,50, null);
--һ����xsb���в�����������
insert into xsb values
	('091101', '����', 1, '1991-05-10', '�������', 50, null),values('091102', '����', 0, '1991-04-12', '�������', 52, null)

insert into kcb values('101','���������',1,80,5)
insert into cjb values('081101',101,80)

--��create��佨����xsb1��
use pxscj
go
create table xsb1
( 	num  char(6) not null primary key,
	name  char(8) not null,
	speiality char(10) null
)
--��insert�����xsb1���в������ݣ�
insert top(5) into xsb1
	select ѧ��, ����, רҵ	from xsb   where רҵ= '�����'








