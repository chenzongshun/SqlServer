------------------------�ع�����------------------------


--�������ݿ�

create database CPXS		
on
(
  name='cpxs_data',
  filename='E:\SQLserver\2017 04 06\cpxs.mdf',
  size=3,
  filegrowth=1
)

log on
(
  name='cpxs_log',
  filename='E:\SQLserver\2017 04 06\cpxs.ldf',
  size=3,
  filegrowth=1
)
use cpxs

--2��������Ʒ��

create table ��Ʒ��
(
��Ʒ��� char(6) not null primary key,		--�������� primary key
��������  varchar(20)not null,
�۸�  numeric(6,1),				--��ֵ���ͣ��൱��double   (6,1)�Ǵ����ű���һλС����
�����  int null
)

--3.���������̱�

create table �����̱�
(
�ͻ���� char(6) not null primary key,
�ͻ�����  varchar(20)not null,
����  varchar(20),
������  varchar(20),
�绰   char(12)
)

--4 ������Ʒ���۱�

create table ��Ʒ���۱�
(
�������� date,
��Ʒ��� char(6) not null ,
�ͻ���� char(6) not null ,
�ͻ�����  varchar(20)not null,
����  int,
���۶�  numeric(20,1)
)

--�����ֶ�

alter table ��Ʒ��				--�����������һ�£��޸ı���õ���alter������update��update�����޸ļ�¼��
add ��Ʒ��� varchar(50)
use CPXS
select * from ��Ʒ��

--�����ֶ�

alter table ��Ʒ��
drop column ��Ʒ���				--����ע��Ҫ��column������ɾ������constraintԼ��

--�����¼

insert into ��Ʒ�� values('132','���',42,42)
select * from ��Ʒ��
insert into ��Ʒ�� values('133222','����',5,82),('132132','���',100,22)

--�޸ı���еļ۸���,����������

update ��Ʒ�� set �۸�=�۸�*0.8 
select * from ��Ʒ�� 

--9 ����8�ۺ����Ʒ�۸����50��ɾ��

delete   from ��Ʒ�� where �۸� < 50			--�����Ϊ����
select * from ��Ʒ�� where ����� = 22			--���ѯ��Ϊ�Ա�

--10 ��������

alter table ��Ʒ���۱�
add constraint PK_��Ʒ���۱� primary key(��Ʒ���,�ͻ����,�ͻ�����)