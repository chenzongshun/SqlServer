create database pxscj
on primary
( name='pxscj_data',
  filename='E:\SQLserver\2017 05 12\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\SQLserver\2017 05 12\pxscj.ldf',
  size=1mb,
  maxsize=10mb,
  filegrowth=10%
)

go
use pxscj
go
create table xsb
(
 	
	ѧ�� 	char(6)	NOT NULL PRIMARY KEY,
  	���� 	char(8) 	NOT NULL,
  	�Ա� 	bit 		NULL DEFAULT 1,
  	����ʱ�� 	date 		NULL,
  	רҵ 	char(12) 	NULL,
  	��ѧ�� 	int 			NULL,	
  	��ע		varchar(500) NULL
)
go
CREATE TABLE KCB
( 	
	�γ̺� 	char(3)	NOT NULL PRIMARY KEY,
  	�γ��� 	char(16) 	NOT NULL,
  	����ѧ�� 	tinyint 		NULL DEFAULT 1,
  	ѧʱ 	tinyint 		NULL DEFAULT 0,
  	ѧ�� 	tinyint 	NOT	NULL DEFAULT 0

)
go
create table CJB
(
ѧ�� char(6) not null,
�γ̺� char(3) not null,
�ɼ� int null default 0,
primary key(ѧ��,�γ̺�)
)
go
use pxscj
go
INSERT INTO XSB 
VALUES('081101','����',1,'1990-02-10','�����',50,NULL),
('081102', '����' , 1, '1991-02-1', '�����',50, NULL),
('081103', '����' , 0, '1989-12-12', '�����',50, NULL),
('081104', 'Τ��ƽ' , 1, '1990-12-20', '�����',50, NULL),
('081106', '���' , 1, '1991-09-30', '�����',54, '��ǰ���꡶���ݽṹ��������ѧ��'),
('081107', 'Τ��' , 1, '1989-2-12', '�����',52, '����ǰ����һ�ſγ�'),
('081108', '���' , 0, '1990-11-26', '�����',50, '����ѧ��'),
('081109', '����' , 0, '1991-12-27', '�����',48, '��һ�ſβ����񣬴�����'),
('081201', '����' , 1, '1989-05-11', '����',42, NULL),
('081202', '����' , 1, '1989-03-25', '����',40, '��һ�ſβ����񣬴�����'),
('081203', '��ǿ' , 1, '1989-05-11', '����',42, NULL),
('081204', '����' , 0, '1991-12-11', '����',42, NULL),
('081211', '����' , 0, '1990-11-11', '����',42, NULL)

go
INSERT INTO KCB 
VALUES('101','���������',1,80,5),
('102','C#',1,80,5),
('103','HTML',1,80,5),
('202','SQL',1,80,5),
('205','JAVA',1,80,5),
('301','JAVA WEB',1,80,5),
('305','PHP',1,80,5),
('311','C#.NET',1,80,5)

go
insert into cjb
values('081101','101',89),
('081101','102',79),
('081101','103',80),
('081102','101',83),
('081102','102',73),
('081102','103',83),
('081103','101',54),
('081103','102',79),
('081103','103',80),
('081104','101',49),
('081104','102',79),
('081104','103',80),
('081106','101',89),
('081106','102',59),
('081106','103',80),
('081201','101',60),
('081201','102',79),
('081201','103',80),
('081203','101',78),
('081203','102',79),
('081203','103',80)



--1����ѧ������ϵͳ�д���һ�����Է������ݼ��Ĵ洢���̡����Բ�ѯ����
--���Բ�ѯĳרҵĳ����ѧ����ѧ�š��������γ������ɼ���

create proc ���Բ�ѯ @zy varchar(20),@xm varchar(20) as
select xsb.ѧ��,����,רҵ,�γ���,�ɼ� 
from xsb join CJB 
on xsb.ѧ��=CJB.ѧ�� join KCB 
on CJB.�γ̺�=KCB.�γ̺�
where רҵ=@zy and ����=@xm

exec ���Բ�ѯ ����� , ����

--2����ѧ���������ݿ��д���һ����ͳ�ƿ��Կ�Ŀ���� �Ĵ洢���̡�
--�������������ĳѧ����������������������ѧ���Ŀ��Կ�Ŀ����
--ִ�иô洢���̣��鿴��������Ľ����

create proc ͳ�ƿ��Կ�Ŀ�� 
@name varchar(10),@num int output as
select @num=COUNT(*) from xsb join CJB 
on xsb.ѧ��=CJB.ѧ�� where ����=@name

declare @mz varchar(10),@n int
set @mz = '����'
exec ͳ�ƿ��Կ�Ŀ�� @mz,@n output
print @n

--3����ѧ������ϵͳ�д���һ��������ѧ���� �Ĵ洢���̡�
--����ҵ��и�ѧ���洢���̾ͷ���1�����򷵻�0��

drop proc ����ѧ��
create proc ����ѧ�� @name varchar(20) as		--�����varchar(20)����д����ķ�Χ��
if exists(select * from xsb where ���� = @name)	--exists:����
	return 1	--return����		begin   end  {}
else 
	return 0

declare @s int
exec @s=����ѧ�� '���'
print @s		--print:��ӡ

exec ����ѧ�� '���'

--4����ѧ������ϵͳ�д���һ�������Բ�ѯ���Ĵ洢���̣�
--������ҵ���ѧ�����������Ҳμ���һ�����ϵĿ��ԣ��洢���̾ͷ���1��
--����ҵ��˸�ѧ����û�вμ��κο��Դ洢���̾ͷ���2������ͷ���0��
drop proc ���Բ�ѯ2

create proc ���Բ�ѯ2 @name varchar(10) as
if exists(select ���� from xsb,CJB where ����=@name and xsb.ѧ�� = CJB.ѧ��)
	return 1
else if exists(select * from xsb where ����=@name)
	return 2
else
	return 0

--�������ѧ����һ���ֶΣ���Ϊû�гɼ���
insert into xsb values('040203','˳',1,'1998-07-13','���','100',null)


declare @s int
exec @s = ���Բ�ѯ2 ˳
if @s=1
	print cast(@s as varchar(20))+'�μ��˿��Բ����гɼ�'
if @s=2
	print convert(varchar(20),@s)+'�����ѧ��,����û�гɼ�'
if @s=0
	print cast(@s as varchar(20))+'��ȷ�������Ƿ�������ȷ'

--cast(@s as varchar(20)) === convert(varchar(20),@s) ����ת������˼,ע������



