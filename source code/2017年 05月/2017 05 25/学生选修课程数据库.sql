--����ѧ��ѡ�޿γ����ݿ⣬ 

create database xueshenbiao on(
name=xueshenbiao,
filename='D:\SQLserver\2017 05 25\xueshenbiao.mdf',
filegrowth=1,
size=3)
log on(
name=xueshenbiao_ldf,
filename='D:\SQLserver\2017 05 25\xueshenbiao.ldf',
filegrowth=1,
size=3)
go
use xueshenbiao

--ѧ����ѧ�ţ����������䣬�Ա�����ϵ����ַ���������ڣ� 

drop table xsb
create table xsb(
id int primary key identity(1001,1),
name varchar(10),
nianling int,
sex varchar(2),
xibu varchar(16),
dizhi varchar(30),
birthday datetime)

--�γ̱��γ̺ţ��γ����ƣ���ʦ������ 

drop table kcb
create table kcb(
kch int primary key,
kcm varchar(20),
tcname varchar(20))

--ѡ�α�ѧ�ţ��γ̺ţ��ɼ��� 

drop table xkb
create table xkb(
id int primary key,
kch int,
scour int
constraint xkb_xsb foreign key(id) references xsb(id),
constraint xkb_kcb foreign key(kch) references kcb(kch))

--��ʼ�����¼

select * from xsb
insert into xsb values('�ʽ',23,'��','����ϵ','���ϳ���','1991-02-05'),
					  ('���˷�',78,'Ů','����ϵ','������ͬ','1956-05-30'),
				      ('�·���',45,'��','����ϵ','��������','1987-04-10'),
					  ('��ϸ�',26,'Ů','��óϵ','������̶','1971-07-12'),
					  ('���',32,'��','ũ��ϵ','��������','1987-02-09')

select * from xkb
insert into xkb values(1001,54,48),(1002,74,58),(1003,68,78),(1004,45,65),(1005,35,45)

select * from kcb
insert into kcb values(54,'�����������','�µ���'),
					  (74,'C#�������','���ǵ�'),
					  (68,'��ѧ����','������'),
					  (45,'java�������','��û'),
					  (35,'��ְʵ��Ӣ��','��Ҳ')

--��SQL���Բ�ѯ�������⣺ 

--1������ʦ���̵Ŀγ̺š��γ����ơ�

select * from kcb where tcname like '��%'
select * from kcb where tcname like '��_'

--2���������23���Ůѧ����ѧ�ź������� 

select * from xsb

select * from xsb where sex = 'Ů' and YEAR(GETDATE()) - YEAR(birthday) > 23

--3�������ǵġ���ѡ�޵�ȫ���γ����ơ� 

select kcm from kcb where tcname = '���ǵ�'

--4�����гɼ�����60�����ϵ�ѧ������������ϵ�� 

select xsb.name,xsb.xibu,xkb.scour 
from xkb join xsb 
on xkb.id = xsb.id
where scour > 60

--5��û��ѡ�ޡ�C#������ơ��ε�ѧ�������� 

select * from kcb join xkb 
on xkb.kch=kcb.kch join xsb
on xsb.id=xkb.id where kcm != 'C#�������'

--6������ѡ���������Ͽγ̵�ѧ���������Ա� 

select name,sex from xsb where id in
(select id from xkb
group by id having count(id)>1)		--������ٴ�ͳ���Ƿ񳬹�1

--7��ѡ��������ʦ�����γ̵�ѧ��������

select count(id) from xkb, kcb		--����id������������ ��xkb��kcb�в�
where xkb.kch=kcb.kch and tcname='���ǵ�'

--8��û��ѡ������ʦ�����γ̵�ѧ����

select * from xsb where xsb.id in 
(select id from xkb where xkb.kch in 
(select kch from kcb where tcname != '���ǵ�'))
--����������id��=�Ļ���ô���ᱨ��
--�Ӳ�ѯ���ص�ֵ��ֹһ�������Ӳ�ѯ������ =��!=��<��<=��>��>= 
--֮�󣬻��Ӳ�ѯ�������ʽʱ����������ǲ������
select distinct xsb.id, xsb.name 
from xsb, xkb, kcb 
where (xkb.id=xsb.id) and (xkb.kch=kcb.kch)
 and (tcname<>'���ǵ�')

--9��������ϵͳ���γ̵���߷ֵ�ѧ���������Ա�����ϵ��
 
select top 1* from xsb,xkb,kcb 
where kcb.kch=xkb.kch and xsb.id=xkb.id and kcm like '��%'
order by xkb.scour		--asc ˳��_Ĭ��   desc����

 
select top 1 xsb.id,xsb.name,xsb.xibu 
from xsb,xkb,kcb 
where xsb.id=xkb.id and kcb.kch=xkb.kch
and  kcm like '��%'
order by scour desc

 