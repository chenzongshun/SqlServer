create  database  Sqlname
on primary			--��������ļ���
(name=employee1,
filename='d:\Sqlname.mdf',
size=10,
maxsize=unlimited,	--unlimited���޵�
filegrowth=10%),	--growth����������
(name=Sqlname2,
filename='d:\Sqlname1.mdf',
size=20,
maxsize=100,
filegrowth=1)

log on 
(name=Sqlname_log,
filename='d:\Sqlname_log.ldf',
size=10,
maxsize=50,
filegrowth=1),
(name=Sqlname_log2,
filename='d:\Sqlname_log1.ldf',
size=10,
maxsize=50,
filegrowth=1)