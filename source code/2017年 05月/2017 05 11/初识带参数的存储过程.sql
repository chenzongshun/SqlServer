create database pxscj
on primary
( name='pxscj_data',
  filename='E:\SQLserver\2017 05 11\pxscj.mdf',
  size=3mb,
  maxsize=100mb,
  filegrowth=1mb
)
log on
( name='pxscj_log',
  filename='E:\SQLserver\2017 05 11\pxscj.ldf',
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

--����֮ǰ��ʶ������

select * from sys.procedures			--�鿴���ݿ������еĴ洢����
select * from sys.procedures where name = '�洢������'

--����exists�ظ������洢����
if exists(select * from sys.procedures where name = '�鿴xsb')--���ھ�true
drop proc �鿴xsb		--���ھ�ɾ����
go
create proc �鿴xsb as
select * from xsb

exec �鿴xsb

--1������ѧ�ţ��鿴��ѧ���Ŀ����������������������

select * from xsb 
select * from CJB	--�Ȳ���ı�����ڲ�ͬ
insert cjb values('081101','010','55')
insert cjb values('081101','110','55')

drop proc ��������
create proc �������� @xh int=081101 as
select COUNT(*) from CJB where ѧ��=@xh

--2������ѧ�ţ��鿴��ѧ���Ŀ����������������������

drop proc ��������_���������
create proc ��������_��������� 
@xh int=081101, @num int output as
select @num=COUNT(*) from CJB where ѧ��=@xh

--3���ֱ����ǰ���������鿴��081101���Ŀ��������

exec �������� 081102

declare @n int
exec ��������_��������� 081101 , @n output		--��������ǵö���
select @n ����

--4������һ���洢����do_insert����������XSB���в���һ������
--('091201', '��ΰ', 1, '1990-03-05', '�������',50, NULL);

create proc do_insert as
insert xsb values('091201', '��ΰ', 1, '1990-03-05', '�������',50, NULL)
 
select * from xsb

--��������һ���洢����do_action
--�����е��õ�һ���洢���̣���������������������ݣ�����������Ӧ����Ϣ
--������0�޸����ݣ�������������Ӣ���Ա�Ϊ0������1��ɾ���ü�¼����
drop proc do_action
create proc do_action @n int as
begin
    exec do_insert        
  if(@n=0)    
    begin
      update xsb set ����='��Ӣ',�Ա�=0 where ѧ��='091201'
      print '�޸ĳɹ�'
    end
   else if(@n=1)
    begin
      delete xsb where ѧ��='091201'
      print '�ü�¼��ɾ��'
    end
  else
    print '��������ȷ������'   
end

exec do_action 0
exec do_action 1
select * from xsb