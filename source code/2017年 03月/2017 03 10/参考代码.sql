1��������kcb2��ͬʱ������ѧ�ֵ�Լ������Ϊ0��60��
create table kcb2
(
	�γ̺� char(6) not null,
	�γ��� char(8) not null,
	ѧ�� tinyint check (ѧ��>=0 and ѧ��<=60) null 	/*ͨ��check�Ӿ䶨��Լ������*/
)
2������xsb1������xsb1��δ�����������ԡ�ѧ�š��ֶδ���primary keyԼ�����ԡ��������ֶζ���uniqueԼ����
use pxscj
go
create table xsb1
(
	ѧ�� 	char(6) 	not null	constraint  xh_pk  primary key,
	����	char(8) 	not null	constraint xm_uk  unique,
	�Ա� 	bit 		not null	default 1,
	����ʱ�� 	date 		not null,
	רҵ 	char(12) 	null,
	��ѧ�� 	int 		null,
	��ע 	varchar(500) null
) 
3������һ��course_name������¼ÿ�ſγ̵�ѧ��ѧ�š��������γ̺š�ѧ�ֺͱ�ҵ���ڡ����У�ѧ�š��γ̺źͱ�ҵ���ڹ��ɸ���������ѧ��ΪΨһ����
create table course_name
(
	ѧ��  	varchar(6)  not null,
	����  	varchar(8)  not null,
	��ҵ���� date	 	 not null,
	�γ̺�	varchar(3) ,
	ѧ��		tinyint,
	primary  key (ѧ��, �γ̺�, ��ҵ����),
	constraint xf_uk  unique (ѧ��)
)
4���޸���6.14�е�xsb1�����������һ�������֤���롱�ֶΣ��Ը��ֶζ���uniqueԼ�����ԡ�����ʱ�䡱�ֶζ���uniqueԼ����
alter table  xsb1    
	add????���֤���� char(20) 
		constraint sf_uk ??unique nonclustered (���֤����)
go
alter table  xsb1    
	add????constraint cjsj_uk  unique nonclustered (����ʱ��)
5��ɾ����6.14�д�����primary keyԼ����uniqueԼ����
alter table  xsb1 
	drop????constraint xh_pk, xm_uk
go
6������һ����student��ֻ���ǡ�ѧ�š��͡��Ա����У��Ա�ֻ�ܰ����л�Ů��
use pxscj
go
create  table  student
 (	
	ѧ�� char(6) not null,
 	�Ա� char(1) not null check(�Ա� in ('��', 'Ů'))
 )
7������һ����student1��ֻ���ǡ�ѧ�š��͡��������ڡ����У��������ڱ������1980��1��1�գ�������checkԼ����
create table student1
 (	
	ѧ�� char(6) 	not null,
 	����ʱ�� datetime  not null,
 	constraint  df_student1_cjsj  check(����ʱ��>'1980-01-01')
 )
8��������student2���С�ѧ�š�������óɼ����͡�ƽ���ɼ������У�Ҫ����óɼ��������ƽ���ɼ���
create  table  student2
 (	
	ѧ�� char(6)    not null,
 	��óɼ� int  not null,
	ƽ���ɼ� int  not null,
 	   check(��óɼ�>ƽ���ɼ�)
)
9��ͨ���޸�pxscj���ݿ��cjb�����ӡ��ɼ����ֶε�checkԼ����
use pxscj
go
alter table cjb     
	add constraint cj_constraint  check ?(�ɼ�>=0 and �ɼ�<=100) 
10��ɾ��cjb���ɼ����ֶε�checkԼ����
alter table cjb     
	drop constraint cj_constraint  



