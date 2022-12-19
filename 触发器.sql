-- use SCT;

-- trigger1
-- �жϴ�����,���������ɾ��
IF (EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'Std_ans_update_trig') AND OBJECTPROPERTY(id, N'IsTrigger') = 1)) 
DROP TRIGGER Std_ans_update_trig;

-- �ϴ���׼�𰸵Ĵ�����������ظ��ϴ�����£�
create trigger Std_ans_update_trig on question
	instead of insert
as
	declare @cno char(10)
	declare @cname char(20)
	declare @qno char(10)
	declare @id char(10)
	declare @std_ans char(10)
	-- ����Ŀγ̺ţ���ҵ�ţ���ţ���׼��
	select @std_ans = std_ans from inserted
	select @cno = cno from inserted
	select @id = id from inserted
	select @qno = qno from inserted
	-- ��Ӧ�Ŀγ���
	select @cname = (select cname from course where cno = @cno);
	-- �����׼�𰸲�Ϊ�գ������б�׼��
	if (exists(select std_ans from question where @cno = cno and @qno = qno))
	begin
		-- ��ӡ��ʾָ��
		print '����Ҫ����'+convert(char,@cname)+'�ĵ�'+convert(char,@qno)+'����ҵ�ı�׼��' 
		-- �޸ı�׼��
		update question
		set std_ans = @std_ans
		where @cno = cno and @id = id and @qno = qno;
	end

-- trigger2
-- �жϴ�����,���������ɾ��
IF (EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'Grade_update_trig') AND OBJECTPROPERTY(id, N'IsTrigger') = 1))
DROP TRIGGER Grade_update_trig;

--�޸ĳɼ��Ĵ�����
create trigger Grade_update_trig on sc
	instead of update
as
	declare @sno char(10);
	declare @sname char(10);
	declare @cno char(10);
	declare @grade int;
	declare @pregrade int;
	-- �����ѧ�ţ��γ̺ţ��ɼ�
	select @sno = sno, @cno = cno, @grade = grade from inserted;
	-- ��Ӧͬѧ��������ԭ�ɼ�
	select @sname = (select sname from student where sno = @sno);
	select @pregrade = (select grade from sc where @cno = cno and @sno = sno);
	-- ���и�ͬѧ���ſ����гɼ����޸ĳɼ���ԭ�ɼ���ͬ
	if @pregrade is not null and @pregrade != @grade
	-- ��ӡ���޸�ͬѧ��������ѧ�ţ��ĺ����
	begin
		print '��Ҫ��'+convert(char,@sname)+convert(char,@sno)+'��ԭ�ɼ�'+convert(char,@pregrade)+'�޸�Ϊ'+convert(char,@grade);
		update sc
		set grade = @grade
		where @cno = cno and @sno = sno
	end

-- trigger3
-- �жϴ�����,���������ɾ��
IF (EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'Ans_update_trig') AND OBJECTPROPERTY(id, N'IsTrigger') = 1))
DROP TRIGGER Ans_update_trig;
-- �ϴ�ѧ���𰸵Ĵ�����������ظ��ϴ���ع������ѣ���һ�����ͬ�����ʹ�����ֻ����һ���������������ʹ��trigger4��
create trigger Ans_update_trig on answer
	instead of insert
as
	declare @sno char(10)
	declare @cno char(10)
	declare @qno int
	declare @id int
	declare @aid char(10)
	declare @ans char(20)
	-- ����Ŀγ̺ţ���ҵ�ţ���ţ���׼��
	select @sno = sno from inserted
	select @cno = cno from inserted
	select @id = id from inserted
	select @aid = aid from inserted
	select @qno = qno from inserted
	-- �����׼�𰸲�Ϊ�գ������б�׼��
	if ((select ans from answer where @sno = sno and @cno = cno and @aid = aid) is not null)
	begin
		-- ��ӡ��ʾָ��
		print '�������ҵ�ύ�����������ύ��' 
	end

-- ʵ�����
select * from course;
select * from question;
select * from sc;
select * from answer;
insert into question(cno,qno,id,std_ans) values('100','1','1','1')
insert into question(cno,qno,id,std_ans) values('100','1','1','2')
insert into sc(sno,cno,grade) values('2020200003','100','95')
insert into sc(sno,cno,grade) values('2020200004','100','96')
insert into sc(sno,cno,grade) values('2020200003','100','96')
update sc set grade = 96
where sno = '2020200003' and cno = '100';
insert into answer(sno,cno,qno,id,aid,ans) values('2020200003','100','1','1',NULL,'1')
insert into answer(sno,cno,qno,id,aid,ans) values('2020200003','100','1','1',NULL,'2')
insert into answer(sno,cno,qno,id,aid,ans) values('2020200003','100','1','2',NULL,'2')
insert into answer(sno,cno,qno,id,aid,ans) values('2020200003','100','1','2',NULL,'1')

-- trigger4
-- �жϴ�����,���������ɾ��
IF (EXISTS(SELECT * FROM sysobjects WHERE id=object_id(N'Ans_aid_update_trig') AND OBJECTPROPERTY(id, N'IsTrigger') = 1))
DROP TRIGGER Ans_aid_update_trig;
-- �ϴ�ѧ���𰸵Ĵ��������ύ��������ν�����Բ�ѯ���һ���ύ�����ڻ������Զ�+1��Ϊaid��
create trigger Ans_aid_update_trig on answer
	instead of insert
as
	declare @sno char(10)
	declare @cno char(10)
	declare @qno int
	declare @id int
	declare @aid char(10)
	declare @ans char(20)
	-- ����Ŀγ̺ţ���ҵ�ţ���ţ���׼��
	select @sno = sno from inserted
	select @cno = cno from inserted
	select @id = id from inserted
	--select @aid = aid from inserted
	select @qno = qno from inserted
	select @ans = ans from inserted
	--�ҳ���ǰ�γ̺���ҵ���������ύ������+1����Ϊ��һ�ε��ύ����
	select @aid = (select count(aid) from answer where @sno = sno and @cno = cno and @qno = qno and @id = id)
	-- ��ӡ��ʾָ��
	print '������������ҵ�ĵ�'+convert(char,@aid+1)+'�γ���'
	-- ����𰸣��ύ����Ϊ@aid+1
	insert into answer(sno, cno, qno, id, aid, ans) values (@sno, @cno, @qno, @id, @aid+1, @ans)
	
