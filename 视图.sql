-- �ж���ͼ,���������ɾ��
-- R�е���ʱ�����Ӧ����
-- select cno, qno, id_num from cal_id_num
-- where cno = '�κ�' and qno = '��ҵ��'
IF (EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'cal_id_num') AND OBJECTPROPERTY(id, N'IsView') = 1)) 
DROP VIEW cal_id_num;
-- ������ҵ����Ŀ��
create view cal_id_num(cno, qno, id_num)
as 
select distinct answer.cno, answer.qno,(select count(*) from question, answer where answer.cno = question.cno and question.qno=answer.qno)
from answer, question where answer.cno = question.cno and question.qno = answer.qno and question.id = answer.id

-- ʵ��
select cno,qno,id_num from cal_id_num

select * from answer
select * from question

-- ����ʵ�����ݿ�Ľṹ��Ϊ�򵥣�����ʹ����ͼ���ܵĲ���������R��ʹ��dataframeʵ�ָ�Ϊֱ�ۼ�࣬��ֻչʾʵ�����