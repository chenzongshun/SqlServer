--���й�ϵ���ݿ����£� 
--���ݿ�������ʦ���ݿ�

create database ��ʦ���ݿ� 
on
(name = ��ʦ���ݿ�,
filename = 'E:\SQLserver\2017 05 19\��ʦ���ݿ�.mdf',
filegrowth=1,
size=3)
log on
(name = ��ʦ���ݿ�_ldf,
filename = 'E:\SQLserver\2017 05 19\��ʦ���ݿ�.ldf',
filegrowth=1,
size=3)

--��ʦ��(��� char(6)���������Ա����壬ְ�ƣ����֤��) 

create table ��ʦ��(
��� char(6) primary key,
���� varchar(10),
�Ա� varchar(2) check(�Ա�='��' or �Ա� ='Ů'),		--����ֻ�������к�Ů
���� varchar(10) not null default '����',
ְ�� varchar(10),
���֤�� int unique,
constraint sfzhaoma unique(���֤��))

--�γ̱�(�κ� char(6)������) 

create table �γ̱�(
�γ̺� char(6)  primary key,
�γ��� varchar(10))

alter table �γ̱�
alter column �γ��� varchar(20)		--�޸ı��ֶε���������

--�οα�(ID����ʦ���,�κţ���ʱ��) 

create table �οα�(
ID int identity(1,1),     --��֪ʶ����ʶ��identity(1,1)����Ǵ�1��ʼ������Ϊ1
��ʦ��� char(6),
�γ̺� char(6),
��ʱ��  int check(��ʱ��> 1 and ��ʱ��<100))		--������1---100�����Χ��

--��SQL����ʵ�����й��ܵ�sql�����룺

--1.	������������Ľ��⡢������룻
--   Ҫ��ʹ�ã�����(��ʦ��.��ţ��γ̱�.�κ�)��
--���(�οα�.��ʦ��ţ��οα�.�κ�)��

alter table �οα�
add constraint ��ʦ��_���_�οα�_��ʦ��� foreign key(��ʦ���) references ��ʦ��(���)

alter table �οα�
add constraint �γ̱�_�κ�_�οα�_�κ� foreign key(�γ̺�) references �γ̱�(�γ̺�)

--   Ĭ��(����)���ǿ�(���壬����)��Ψһ(���֤��)�����(�Ա𡢿�ʱ��),�Զ����(ID)
--2.	�����пγ���Ϣ��ӵ��γ̱�Ĵ���
--        �κ�      �γ�����
--        100001    SQL Server���ݿ�
--        100002    ���ݽṹ
--        100003    VB�������

select * from �γ̱�

insert into �γ̱� 
values(100001,'SQL Server���ݿ�'),
	  (100002,'���ݽṹ'),
	  (100003,'VB�������')

--        �޸�  �κ�Ϊ100003�Ŀγ����ƣ�Visual Basic�������

update �γ̱� set �γ���='Visual Basic�������' where �γ̺�=100003

--        ɾ��  �κ�Ϊ100003�Ŀγ���Ϣ        

delete �γ̱� where �γ̺�=100003

--3.	д������[�οα���ͼ](��ʦ��ţ��������κţ��γ����ƣ���ʱ��)�Ĵ��룻

create view �οα���ͼ as
select a.���,a.����,c.�γ̺�,c.�γ���,b.��ʱ�� 
from ��ʦ�� a join �οα� b on a.��� = b.��ʦ��� join �γ̱� c
on b.�γ̺�=c.�γ̺�

select * from �οα���ͼ

--4.	д������[ĳ�ſ��ον�ʦ]��Ƕ��ֵ�����Լ������Ĵ��룻

create function ĳ�ſ��ον�ʦ 
(@kename varchar(20))				--�ֲ������ǵô�����
returns table as
return (select a.���,a.����,c.�γ̺�,c.�γ���,b.��ʱ�� 
from ��ʦ�� a 
join �οα� b on a.���=b.��ʦ���
join �γ̱� c on b.�γ̺�=c.�γ̺�)

select * from ĳ�ſ��ον�ʦ ('���ݽṹ')	--��ֵ�ǵô�����,�͸�C#һ��

create function [ĳ�ſ��ον�ʦ](@�γ��� varchar(15))
returns table as
return (select �γ�����, ��ʱ��, ��ʦ����=���� from �οα���ͼ
where �γ���=@�γ���)
go

--	    ���������д�'SQL Server���ݿ�'���ſγ̵���ʦ������

select * from ĳ�ſ��ον�ʦ ('SQL Server���ݿ�')

--5.	д������[ͳ�ƿ�ʱ��]���������ʱ������Ϳ�ʱ����ƽ����ʱ�Ĵ洢�����Լ�ִ�д��룻

drop proc ͳ�ƿ�ʱ��
create procedure ͳ�ƿ�ʱ�� as
select ����ʱ�� = max(a.��ʱ��),��С�γ��� = min(a.��ʱ��),
ƽ����ʱ�� = avg(a.��ʱ��) from �οα� as a

exec ͳ�ƿ�ʱ��

--6.	д������������ĳ��ʦ�����ܿ�ʱ������ֵ���صĴ洢�����Լ�ִ�д��롣(6��)
--ִ�У����㡰����ʦ�����ܿ�ʱ��

drop proc ĳ��ʦ�����ܿ�ʱ 
create procedure ĳ��ʦ�����ܿ�ʱ 
@��ʦ�� nchar(16)
as
begin
   declare @�ܿ�ʱ int 
   select @�ܿ�ʱ=sum (��ʱ��) from �οα���ͼ
   where ���� = @��ʦ�� 
   print '�ܿ�ʱΪ' + convert(varchar(20), @�ܿ�ʱ)
   
   print convert(varchar(20), @��ʦ��)+ '���ܿ�ʱΪ'
end
go

execute ĳ��ʦ�����ܿ�ʱ '��ʦ��'

--7.	������һ�Ż�һ�����Ͽγ̿�ʱ������90�����н�ʦ����Ϣ��������š�������

select * from ��ʦ�� where ��ʦ��.��� in(
select distinct  ��ʦ��� from �οα� where ��ʱ�� > 90)		-distinctct����

--8.	��һ�����򣬲�����󶨵���ʦ���ְ�����ϣ��涨ȡֵΪ��'����','������','��ʦ', '����'��֮һ��

create rule zhicheng _rule
as @zhicheng  in ('����','������','��ʦ', '����')
go
sp_bindrule zhicheng_rule, '��ʦ��.ְ��'





