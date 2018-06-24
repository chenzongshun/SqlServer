if exists(select * from sys.databases where name='wssd')
begin						--����Ƿ��Ѿ��������ݿ⣬������ھ�ɾ��
	use master
	drop database wssd
end
go 

--���濪ʼ����wssd���ݿ�
create database wssd		--��д�����̵�
on (name=wssd,
filename='F:\SQL_Serverʵѵ\wssd.mdf',
filegrowth=1,
size=3)
log on (name=wssd_ldf,
filename='F:\SQL_Serverʵѵ\wssd.ldf',
filegrowth=1,
size=3)
go
use wssd
go 

/*			SQL��PK��FK��˼��
--����			constraint PK_�ֶ� primary key(�ֶ�),
--ΨһԼ��		constraint UK_�ֶ� unique key(�ֶ�),
--Ĭ��Լ��		constrint DF_�ֶ� default('Ĭ��ֵ') for �ֶ�,
--���Լ��		constraint CK_�ֶ� check(Լ�����磺len(�ֶ�)>1),
--�������ϵ	constraint FK_����_�ӱ� foreign(����ֶ�) references ����(���������ֶ�)
*/



--���濪ʼ����commodity��		commodity:��Ʒ

if exists(select * from sys.tables where name = 'commodity')
	drop table commodity
create table commodity(			--��Ʒ��
/*��Ʒ���*/	id bigint primary key,			--����int��Ȼ��SQL Server����Ҫ�������������ͣ���������������������������bigint����Ӧ������������int���ݷ�Χ�ĳ��ϡ�
/*��Ʒ����*/	name varchar(50),
/*��Ʒ�۸�*/	jiage decimal(10,2),
/*��Ӧ�̱��*/	gysid varchar(20),
/*������*/		scd varchar(50))

--���濪ʼ����indent��			indent:����

if exists(select * from sys.tables where name = 'indent')
	drop table indent
create table indent(			--������
/*�������*/	ddid bigint primary key,
/*��Ʒ���*/	cmid bigint,
/*��������*/	dgcount int,
/*�ܼ�*/		zongjia money)

--���濪ʼ������distributor��	distributor:��Ӧ��

if exists(select * from sys.tables where name = 'distributor')
	drop table distributor 
create table distributor(		--��Ӧ�̱�
/*��Ӧ�̱��*/	gysid varchar(20) primary key,
/*��Ӧ������*/	gysname varchar(50))

--�������ö��������Ʒ��Ĺ�ϵ��������Ʒ���е���Ʒid���������в�������Ʒ��id��
alter table indent add constraint commodity_indent_id 
foreign key(cmid) references commodity(id)
go
--����������Ʒ��͹�Ӧ�̱�Ĺ�ϵ�����˹�Ӧ�̵�id����Ʒ�����������Ʒ�Ĺ�Ӧ��id��
alter table commodity add constraint commodity_distributor_id 
foreign key(gysid) references distributor(gysid)
go

--			�ֱ����������в���2.13  2.15�е���������

--��ʼ����Ʒ���������
insert into commodity values(1000,'ʢ�ƱʼǱ�',5600,430102,'�㶫'),
							(1001,'��ʿ�ʼǱ�',6700,540199,'�Ϻ�'),
							(1002,'360�ֻ�',2300,100001,'����'),
							(1003,'�����ֱ�',4500,100002,'�㶫'),
							(1004,'�������',7800,100003,'����'),
							(1005,'ˬ��ˮ��Ʒ',8900,100004,'����'),
							(1006,'���ձʼǱ�',7400,100005,'�㽭'),
							(1007,'��˶�ʼǱ�',1800,100006,'����')
							
----��ʼ�򶩵����������
insert into indent values(11070232,1000,3,16800),
						 (11060343,1002,21,125600),
						 (11050345,1003,2,3400),
						 (11050346,1004,5,13400),
						 (11050347,1005,9,28400),
						 (11050325,1006,6,13400),
						 (11050378,1007,15,53400)
						 
--��ʼ��Ӧ�̱��������
insert into distributor values(100001,'����Ƽ�'),
							  (100002,'�㽭����'),
							  (540199,'����СС'),
							  (430102,'ʢ�ƿƼ�'),
							  (100003,'��������'),
							  (100004,'�廪ͬ��'),
							  (100005,'�Ϸʽ�ΰ'),
							  (100006,'��ʿ�Ƽ�'),
							  (440708,'���տƼ�')
 
select * from commodity				--��Ʒ��
select * from indent				--������
select * from distributor			--��Ӧ�̱�
go

--				����ƷΪ�����ձʼǱ�������Ʒ�۸��µ�10%
update commodity set jiage=jiage*90/100 where name='���ձʼǱ�'

--				�����Ʒ���Ϊ��1002�����ܶ�������
select dgcount �ܶ������� from indent where cmid = 1002

--��ѯ����Ʒ����Ϊ�����ձʼǱ�������Ʒ���������ͼ۸�

select �������� = cmid , zongjia as �۸� from indent 
where cmid = (select id from commodity where name = '���ձʼǱ�')

--�����洢����P_stored_proc,ָ����Ӧ�̴��룬��ѯ�ù�Ӧ�̵Ķ�����Ϣ

create procedure P_stored_proc @gysid int as
select * from distributor d inner 
join commodity c on c.gysid = d.gysid
join indent i on i.cmid=c.id where d.gysid = @gysid
go

--���濪ʼ���ô洢����
exec P_stored_proc 430102
exec P_stored_proc @gysid = 440708
exec P_stored_proc '540199'


--��ѯ�������ư������Ƽ����Ĺ�Ӧ�̱�ţ���Ӧ������
update distributor set gysname ='��ʿ����' where gysname = '��ʿ�Ƽ�'

select Ӧ�̱�� = d.gysid , d.gysname ��Ӧ������ 
from commodity c,distributor d,indent i
where c.gysid = d.gysid and c.id = i.cmid
and gysname like '%�Ƽ�%'

use wssd EXEC sp_changedbowner 'sa'		--ʹ��wssd�������ݿ��ϵͼ