--���й�ϵ���ݿ����£� 
--���ݿ�����ѧ���ɼ����ݿ�

create database xscj on(
name=xscj,
filename='E:\SQLserver\2017 05 26\xscj.mdf',
size=3,
filegrowth=1)
log on(
name=xscj_ldf,
filename='E:\SQLserver\2017 05 26\xscj.ldf',
size=3,
filegrowth=1)
use xscj
go

drop table cjb,xsb,kcb
go
--ѧ����(�༶��ţ�ѧ�ţ��������Ա����壬���֤�ţ���������)

create table xsb(
classid int identity(2017,1),
xuehao int primary key,
name varchar(20),
sex varchar(2),
minzu varchar(20),
sfzh char(20),
birthday datetime) 

select * from xsb
delete xsb
insert xsb values(1001,'����','Ů','����','123456789456123','1998-02-09'),
			     (1002,'ŶŶŶ','��','����','185415645746566','1997-07-14'),
			     (1003,'��Ϊ��','Ů','����','156456144894633','1997-02-25'),
			     (1004,'������','��','����','489795156745872','1998-03-13'),
			     (1005,'������','Ů','����','153456451674511','1998-06-12'),
			     (1006,'�ɷ���','Ů','����','451561564142313','1997-02-18'),
			     (1007,'�˰�ʱ','��','����','486486789156782','1998-01-17'),
			     (1008,'ʿ����','Ů','����','455314551484545','1996-02-02'),
			     (1009,'ȥ�밴','��','����','156561546154564','1999-09-01'),
			     (10010,'������','Ů','����','123134546544874','1998-12-28')

--�γ̱�(�γ̺ţ��γ���) 

create table kcb(
kch int primary key,			--��ΪԼ����������,����Ҫ��Ϊ����
kcm varchar(16))

select * from kcb
delete kcb
insert kcb values(1005,'C#�������'),
				 (1006,'java�������'),
				 (1007,'��ѧ����'),
				 (1008,'�ߵ���ѧ'),
				 (1009,'��Ч������'),
				 (10010,'�����������'),
				 (10011,'������'),
				 (10012,'ι��ʵս100��'),
				 (10013,'SQL���ݿ�'),
				 (10014,'��ְʹ��Ӣ��')

--�ɼ���(ID,ѧ�ţ��κţ�����) 

create table cjb(
id int identity(1001,1),
xuehao int primary key,
kch int not null,
scour int
constraint cjb_xsb_xuehao foreign key(xuehao) references xsb(xuehao),
constraint cjb_kcb_kch foreign key(kch) references kcb(kch))		--ֻ������ĺ������key

select * from cjb
delete cjb
insert cjb values(1001,10012,100),
				 (1002,1005,45),
				 (1003,1006,87),
				 (1004,1007,89),
				 (1005,1008,92),
				 (1006,1009,64),
				 (1007,10010,61),
				 (1008,10011,56),
				 (1009,10013,71),
				 (10010,10014,40)

--��SQL����ʵ�����й��ܵ�sql�����룺
--1����[ѧ���ɼ����ݿ�]��[ѧ����]�в�ѯ����Ϊ20���22���ѧ����

select * from xsb where YEAR(GETDATE()) - YEAR(birthday) in (20,22)

--2����[ѧ���ɼ����ݿ�]�в�ѯÿ��ѧ���İ༶��š�ѧ�š�������ƽ���֣������ƽ���ֽ������У�������ͬ�߰��༶���С�

select x.classid,x.xuehao,x.name,AVG(c.scour) avg	--avgΪƽ���ֵı���
from xsb x,cjb c,kcb k	
where x.xuehao=c.xuehao and k.kch=c.kch 
group by x.classid,x.xuehao,x.name		--�������ֶα���Ҫ��select��ʾ�ֶεĺ���ҲҪ��ʾ����
order by AVG(scour) desc,x.classid asc	--�����ƽ���ֽ������У�������ͬ�߰��༶����

--3����дһ���Զ��庯��������[ѧ����]�е�[��������]�У��������䡣
create function nl (@xuehao int)
returns int as
begin
	declare @nl int
	select @nl = YEAR(GETDATE()) - year(birthday) from xsb where xuehao = @xuehao
	return @nl
end

declare @nl int,@xuehao int = 1001
select @nl = dbo.nl(@xuehao)
print 'ѧ��'+convert(varchar(10),@xuehao) + '��������' + convert(varchar(10),@nl) + '��'


--4������һ����ͼ[��ѧ�ɼ�����ͼ]��ʾѧ����ѧ�š��������γ�����������

create view jxcjview as
select x.classid,x.xuehao,x.name,k.kcm,c.scour
from xsb x,cjb c,kcb k 
where x.xuehao=c.xuehao and k.kch=c.kch 

select * from jxcjview

--5����дһ���洢���̣�����ѧ�ţ���[��ѧ�ɼ�����ͼ]��ʾ��ѧ�����������γ�����������

drop proc xmkcfs
create procedure xmkcfs 
@xuehao int as
select name,kcm,scour from jxcjview where xuehao=@xuehao

exec xmkcfs 1001
exec xmkcfs @xuehao = 1006
exec xmkcfs '1002'


select * from xsb
update xsb set minzu='����',birthday='1980-12-24' where name = '����'
 
