use master
drop database pxscj
create database pxscj
on(
name=pxscj_data,
filename='d:\���ݿ����\2017 03 02\pxscj.mdf')

log on(
name=pxscj_log,
filename='d:\���ݿ����\2017 03 02\pxscj_log.ldf')

use pxscj
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

--��������

use pxscj
insert into xsb values('201606','����',0,'1998-07-23','����רҵ',78,'Ʒѧ����')
insert into xsb values('201604','������',0,'1998-05-13','ҩƷӪ��',87,'����ѧ��')
insert into xsb values('201605','�¶���',1,'1997-11-28','��е����',99,'����ѧ��')
insert into xsb values('201603','����˳',1,'1998-07-03','�������',100,'Ʒѧ����')

select * from xsb	--��ѯ���ݱ�

use pxscj
select ���� from xsb where ��ע='Ʒѧ����'


