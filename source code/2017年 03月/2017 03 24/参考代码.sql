use pxscj
create table student
(
sno char(6) not null primary key,
xm  char(8) null
)

create table course
(
cno char(6) not null primary key,
km  char(8) null
)
insert into student values('1','����'),('2','����'),('3','����')

insert into course values('1','��ѧ'),('2','Ӣ��'),('4','����')
select * from student
select * from course

select * 
from student,course
where student.sno=course.cno
--������,����ұ�
select * 
from student inner join course
on student.sno=course.cno
--������outer
--�����ӣ������ȫ��ʾ
select * 
from student left outer join course
on student.sno=course.cno
--�����ӣ��ұ���ȫ��ʾ
select * 
from student right outer join course
on student.sno=course.cno
--��ȫ���ӣ����ұ���ȫ��ʾ
select * 
from student full outer join course
on student.sno=course.cno
--�������ӣ�
select * 
from student cross join course
select * 
from student ,course

select * from xsb
select * from cjb
select *
from xsb inner join CJB
on xsb.ѧ��=CJB.ѧ��

select xsb.*,CJB.�γ̺�,CJB.�ɼ�
from xsb inner join CJB
on xsb.ѧ��=CJB.ѧ��

select xsb.*,CJB.�γ̺�,CJB.�ɼ�
from xsb ,CJB
where xsb.ѧ��=CJB.ѧ��
--����ѡ����103�ſγ��ҳɼ���80�����ϵ�ѧ���������ɼ���
select ����,�ɼ�
from xsb inner join CJB
on xsb.ѧ��=CJB.ѧ��
where �γ̺�='103' and �ɼ�>=80
--������ѡ���ˡ�������������γ��ҳɼ���80�����ϵ�ѧ��ѧ�š��������γ������ɼ���
SELECT 	XSB.ѧ��, ����, �γ���, �ɼ�
	FROM XSB JOIN CJB JOIN KCB 	 
		ON  CJB.�γ̺� = KCB.�γ̺�  
         		ON  XSB.ѧ�� = CJB.ѧ�� 
         		
         		
 SELECT 	XSB.ѧ��, ����, �γ���, �ɼ�
	FROM kcb JOIN CJB JOIN xsb 	
	ON  XSB.ѧ�� = CJB.ѧ��  
		ON  CJB.�γ̺� = KCB.�γ̺� 
	where �γ���='���������'  and �ɼ�>=80

	
SELECT a.ѧ��, a.�γ̺�, b.�γ̺�, a.�ɼ�
FROM CJB a  JOIN  CJB b 
ON  a.�ɼ�=b.�ɼ� AND  a.ѧ��=b.ѧ�� AND  a.�γ̺�!=b.�γ̺�       		

