drop database ͼ�����ϵͳ		--ɾ�����ݿ�

create database ͼ�����ϵͳ
on
(
name=ͼ�����ϵͳ_data,
filename='E:\ssssssssssssssss\2017 02 23\ͼ�����ϵͳ_data.mdf',
filegrowth=3,
maxsize=15
)
log on 
(
name=ͼ�����ϵͳ_log,
filename='E:\ssssssssssssssss\2017 02 23\ͼ�����ϵͳ_log.ndf',
filegrowth=20%)

sp_renamedb	ͼ�����ϵͳ,ѧУͼ�����ϵͳ	--�޸����ݿ�����rename��������

drop database ͼ�����_data2

alter database ѧУͼ�����ϵͳ
( ͼ�����ϵͳ_data.mdf
)