create database ѧ������
on primary
( name='ѧ������_data',
  filename='E:\���ݿ����\2017 03 07\ѧ������.mdf',
  size=3mb,
  maxsize=100mb,
  filegrow
)
log on
( name='ѧ������_log',
  filename='E:\���ݿ����\2017 03 07\ѧ������.ldf',
  size=1mb,
  maxsize=10mb,
  filegrowth=10%
)
go
use ѧ������
go
create table ������
(
 ѧ�� char(8) not null,
 ���� varchar(8) null,
 �������� datetime,
 ��ѧ�ɼ� decimal(4,1),
 ��ͥסַ varchar(30) 
)
go
drop table �γ̱�
create table �γ̱�
(
 ѧ�� char(8) not null,
 �γ̺�  char(3)  not null,
 �ɼ� decimal(4,1),
 constraint ˳ primary key(ѧ��,�γ̺�)--constraint:Լ��
 --��ʵ���������һ����Ϊ˳�������ɣ������ǣ���������������
)
go
create table  �ɼ���
( ѧ��  char(8)  not null primary   key ,
  �γ̺�  char(3)  not null,
  ���гɼ�  numeric(4,1) ,
 ��ĩ�ɼ�  numeric(4,1)
) 

select * from �ɼ���
select * from ������
select * from �γ̱�

use ѧ������

insert into ������ values('15612344','454','1998-12-02','51','14')

alter table ������
add constraint ˳6 primary key(ѧ�� )
 
 
 
--������Ҫѧϰ��������������
alter table ������
add constraint ˳6 primary key(ѧ�� )

create table �γ̱�
(
 ѧ�� char(8) not null,
 �γ̺�  char(3)  not null,
 �ɼ� decimal(4,1),
 constraint ˳ primary key(ѧ��,�γ̺�)--constraint:Լ��
 --��ʵ���������һ����Ϊ˳�������ɣ������ǣ���������������
)