use master
drop database �˵�����ϵͳ
create database �˵�����ϵͳ
on
(
name='�˵�����ϵͳ',
filename='D:\˳���ļ�\��������\Cshar�������\C#����Դ����\2017\2017 �� 03 ��\2017 03 15\ʵս�˵�����\�˵�����ϵͳ.mdf',
size=3,
filegrowth=1)

log on
(
name='�˵�����ϵͳ_ldf',
filename='D:\˳���ļ�\��������\Cshar�������\C#����Դ����\2017\2017 �� 03 ��\2017 03 15\ʵս�˵�����\�˵�����ϵͳ_123.ldf',
size=1,
filegrowth=1)

use �˵�����ϵͳ

create table UserPwd
(bianhao int not null,
usernm varchar(8) primary key,
pwd varchar(8) not null)

insert into UserPwd values('4','3')
insert into UserPwd values('3','3')
insert into UserPwd values('1','1')

update UserPwd set pwd='1' where usernm='3'

select * from UserPwd 

use �˵�����ϵͳ
select * from UserPwd where usernm= '1' and  pwd= '1'

drop table shozhi
create table shouzhi
(bianhao int identity (1,1) not null,	--��ʶ����1��ʼ������Ϊ1
��֧ varchar(8) not null,
��֧���� varchar(50),
��֧���� varchar(200) 
+
)

insert into shouzhi values('֧��','�Է�','��һ����')
insert into shouzhi values('֧��','��fff��','��ffffһ����')
insert into shouzhi values('֧��','��fff��','��ffffһ����')
insert into shouzhi values('֧��','��fff��','��ffffһ����')
insert into shouzhi values('����','��ٹ�','�ڳ�ɳ�潭���ͳ��е��ǲ���')
insert into shouzhi values('����','��ٹ�','�ڳ�ɳ�潭���ͳ��е��ǲ���')

select * from shouzhi