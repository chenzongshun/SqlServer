--���й�ϵ���ݿ����£� 
--���ݿ�����ҽԺ���ݿ�
use master
drop database hospital
go
create database hospital on(
name = hospital,
filename = 'E:\SQLserver\2017 05 24\hospital.mdf',
filegrowth = 1,
size = 3)
log on(
name = hospital_log,
filename = 'E:\SQLserver\2017 05 24\hospital.ldf',
filegrowth = 1,
size = 1)
go
--ҽ����(��ţ��������Ա𣬳������ڣ�ְ��) 
use hospital
create table yishengbiao(
yid int not null,
name varchar(10),
sex varchar(2),
birthday datetime,
zhicheng varchar(10) not null)

--���˱�(��ţ��������Ա����壬���֤��) 

create table bingrenbiao(
bid int not null identity(1,1),
name varchar(10) not null,
sex varchar(2),
mingzu varchar(10),
idcard int)

--������(ID�����˱��,ҽ����ţ���������) 

create table binglibiao(
blid int identity(1,1),
brid int,
ysid int,
binglimiaoshu varchar(100))
go

--��SQL����ʵ�����й��ܵ�sql�����룺
--1.	������������Ľ��⡢������룻
--   Ҫ��ʹ�ã�����(ҽ����.��ţ����˱�.���)�����(������.ҽ����ţ�
--   ������.���˿κ�)���ǿ�(ְ�ƣ�����)�����(�Ա�),�Զ����(ID) 
--yishengbiao  bingrenbiao  binglibiao

alter table yishengbiao add constraint zj primary key (yid)
alter table bingrenbiao add constraint br primary key (bid)

alter table binglibiao
add constraint ysidbrid foreign key(ysid) references yishengbiao(yid)
alter table binglibiao
add constraint ysidbrid1 foreign key(brid) references bingrenbiao(bid)

alter table yishengbiao add check(sex = 'Ů' or sex = '��') 
alter table bingrenbiao add check(sex = 'Ů' or sex = '��') 
go

--2.	������ҽ����Ϣ��ӵ�ҽ����Ĵ���
-- ���   ���� �Ա� �������� ְ��
--100001 ��ҽ�� �� 1963-5-18 ������ҽʦ
--100002 ��ҽ�� Ů 1950-7-26 ������ҽʦ
--100003 ��ҽ�� �� 1973-9-18 ҽʦ

select * from yishengbiao
insert yishengbiao values(100001 ,'��ҽ��' ,'��' ,1963-5-18 ,'������ҽʦ')
insert yishengbiao values(100002 ,'��ҽ��' ,'Ů' ,1950-7-26 ,'������ҽʦ')
insert yishengbiao values(100003 ,'��ҽ��' ,'��' ,1973-9-18 ,'ҽʦ')

--        �޸�  ���Ϊ100002��ҽ��ְ��Ϊ������ҽʦ��

update yishengbiao set zhicheng = '����ҽʦ' where yid = 100002

--        ɾ��  ���Ϊ100003��ҽ����Ϣ        

delete yishengbiao where yid = 100003

--3.	д��������ҽ�Ʊ���ͼ(ҽ����ţ���������������������)�Ĵ��룻
drop view ylsbt
create view ylsbt as(
select y.yid , y.name, br.name bm, b.binglimiaoshu	--���ȥ��br.name����� bm�ͻᱨ����ͼ���� 'ylsbt' �ж��ָ�������� 'name'����Ϊ�������е����ֶ��ǽ�name,���ܹ�������ͬ��name
from yishengbiao y join binglibiao b 
on y.yid = b.ysid join bingrenbiao br 
on br.bid = b.brid)

select * from ylsbt

--4.	д�����в��˱�š��������������Լ���������Ӧ��ҽ����ŵĲ�ѯ��䣻

select br.bid,br.name,b.binglimiaoshu,y.yid 
from yishengbiao y join binglibiao b 
on y.yid = b.ysid join bingrenbiao br 
on br.bid = b.brid

--5.	д��������  ���ĳҽ��������ҽ����ż��ɣ����������洢����

create procedure kysbh @ysid int as(
select COUNT(*) ���� from binglibiao where ysid = @ysid)

--	�Լ�ִ�й��̣�Ҫ������ҽ�������Ĳ������������������

exec kysbh 100001

--6.	д����ѯ1970����ǰ������ҽ����

select * from yishengbiao
update yishengbiao set birthday = '1998-7-26' where yid = 100002

select * from yishengbiao where YEAR(birthday)<1970

--7.	�����в��˵�ҽ����Ϣ��

select * from yishengbiao b where b.yid in (select ysid from binglibiao)

--8.	����һ��Ĭ�ϣ�������󶨵�ҽ����ĳɼ�ְ�����ϣ�Ĭ��ֵΪ��ҽʦ����
     	
select * from yishengbiao
create  default  zhicheng AS 'ҽʦ'  

exec sp_bindefault 'zhicheng', 'yishengbiao.zhicheng'

--�����˼��������ӱ��¼��ʱ����Զ���ӵ�Ĭ��ֵ��ǰ����û���ֶ��������ֶε�ǰ����