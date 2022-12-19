use SCT;

-- ѧ����Student
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Student]') AND type in (N'U')) DROP TABLE [dbo].[Student];
CREATE TABLE [dbo].[Student](
    sno VARCHAR(10) NOT NULL,
    sname VARCHAR(20),
    ssex VARCHAR(20),
    sage INT,
    sdept VARCHAR(20),
    spwd VARCHAR(20),
    PRIMARY KEY (sno)
);

EXEC sp_addextendedproperty 'MS_Description', 'ѧ��', 'SCHEMA', dbo, 'table', Student, null, null;
EXEC sp_addextendedproperty 'MS_Description', 'ѧ��', 'SCHEMA', dbo, 'table', Student, 'column', sno;
EXEC sp_addextendedproperty 'MS_Description', 'ѧ������', 'SCHEMA', dbo, 'table', Student, 'column', sname;
EXEC sp_addextendedproperty 'MS_Description', 'ѧ���Ա�', 'SCHEMA', dbo, 'table', Student, 'column', ssex;
EXEC sp_addextendedproperty 'MS_Description', 'ѧ������', 'SCHEMA', dbo, 'table', Student, 'column', sage;
EXEC sp_addextendedproperty 'MS_Description', 'ѧ��Ժϵ', 'SCHEMA', dbo, 'table', Student, 'column', sdept;
EXEC sp_addextendedproperty 'MS_Description', 'ѧ������', 'SCHEMA', dbo, 'table', Student, 'column', spwd;

-- ��ʦ��Teacher
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Teacher]') AND type in (N'U')) DROP TABLE [dbo].[Teacher];
CREATE TABLE [dbo].[Teacher](
    tno VARCHAR(10) NOT NULL,
    tname VARCHAR(20),
    tsex VARCHAR(4),
    tage INT,
    tdept VARCHAR(20),
    tpwd VARCHAR(20),
    PRIMARY KEY (tno)
);

EXEC sp_addextendedproperty 'MS_Description', '��ʦ', 'SCHEMA', dbo, 'table', Teacher, null, null;
EXEC sp_addextendedproperty 'MS_Description', '��ְ����', 'SCHEMA', dbo, 'table', Teacher, 'column', tno;
EXEC sp_addextendedproperty 'MS_Description', '��ʦ����', 'SCHEMA', dbo, 'table', Teacher, 'column', tname;
EXEC sp_addextendedproperty 'MS_Description', '��ʦ�Ա�', 'SCHEMA', dbo, 'table', Teacher, 'column', tsex;
EXEC sp_addextendedproperty 'MS_Description', '��ʦ����', 'SCHEMA', dbo, 'table', Teacher, 'column', tage;
EXEC sp_addextendedproperty 'MS_Description', '��ʦԺϵ', 'SCHEMA', dbo, 'table', Teacher, 'column', tdept;
EXEC sp_addextendedproperty 'MS_Description', '��ʦ����', 'SCHEMA', dbo, 'table', Teacher, 'column', tpwd;

-- �γ̱�course
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Course]') AND type in (N'U')) DROP TABLE [dbo].[Course];
CREATE TABLE [dbo].[Course](
    cno VARCHAR(10) NOT NULL,
    tno VARCHAR(10),
    cname VARCHAR(20),
    ccredit INT,
    PRIMARY KEY (cno),
	foreign key (tno) references teacher(tno)
);

EXEC sp_addextendedproperty 'MS_Description', '�γ�', 'SCHEMA', dbo, 'table', Course, null, null;
EXEC sp_addextendedproperty 'MS_Description', '�γ̺�', 'SCHEMA', dbo, 'table', Course, 'column', cno;
EXEC sp_addextendedproperty 'MS_Description', '��ְ����', 'SCHEMA', dbo, 'table', Course, 'column', tno;
EXEC sp_addextendedproperty 'MS_Description', '�γ���', 'SCHEMA', dbo, 'table', Course, 'column', cname;
EXEC sp_addextendedproperty 'MS_Description', '�γ�ѧ��', 'SCHEMA', dbo, 'table', Course, 'column', ccredit;

-- ��׼�𰸱�question
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Question]') AND type in (N'U')) DROP TABLE [dbo].[Question];
CREATE TABLE [dbo].[Question](
    cno VARCHAR(10) NOT NULL,
    qno VARCHAR(10) NOT NULL,
    id VARCHAR(10) NOT NULL,
    std_ans VARCHAR(20),
    PRIMARY KEY (cno,qno,id),
	foreign key (cno) references course(cno)
);

EXEC sp_addextendedproperty 'MS_Description', '��׼��', 'SCHEMA', dbo, 'table', Question, null, null;
EXEC sp_addextendedproperty 'MS_Description', '�γ̺�', 'SCHEMA', dbo, 'table', Question, 'column', cno;
EXEC sp_addextendedproperty 'MS_Description', '��ҵ��', 'SCHEMA', dbo, 'table', Question, 'column', qno;
EXEC sp_addextendedproperty 'MS_Description', '���', 'SCHEMA', dbo, 'table', Question, 'column', id;
EXEC sp_addextendedproperty 'MS_Description', '��׼��', 'SCHEMA', dbo, 'table', Question, 'column', std_ans;

-- ѧ���𰸱�answer
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Answer]') AND type in (N'U')) DROP TABLE [dbo].[Answer];
CREATE TABLE [dbo].[Answer](
    sno VARCHAR(10) NOT NULL,
    cno VARCHAR(10) NOT NULL,
    qno VARCHAR(10) NOT NULL,
    id VARCHAR(10) NOT NULL,
    aid VARCHAR(10) NOT NULL,
    ans VARCHAR(20),
    PRIMARY KEY (sno,cno,qno,id,aid),
	foreign key (sno) references student(sno),
	foreign key (cno) references course(cno)
);

EXEC sp_addextendedproperty 'MS_Description', 'ѧ����', 'SCHEMA', dbo, 'table', Answer, null, null;
EXEC sp_addextendedproperty 'MS_Description', 'ѧ��', 'SCHEMA', dbo, 'table', Answer, 'column', sno;
EXEC sp_addextendedproperty 'MS_Description', '�γ̺�', 'SCHEMA', dbo, 'table', Answer, 'column', cno;
EXEC sp_addextendedproperty 'MS_Description', '��ҵ��', 'SCHEMA', dbo, 'table', Answer, 'column', qno;
EXEC sp_addextendedproperty 'MS_Description', '���', 'SCHEMA', dbo, 'table', Answer, 'column', id;
EXEC sp_addextendedproperty 'MS_Description', '��ǰ��ҵ�ύ����', 'SCHEMA', dbo, 'table', Answer, 'column', aid;
EXEC sp_addextendedproperty 'MS_Description', 'ѧ����', 'SCHEMA', dbo, 'table', Answer, 'column', ans;

-- ѡ�α�sc
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SC]') AND type in (N'U')) DROP TABLE [dbo].[SC];
CREATE TABLE [dbo].[SC](
    sno VARCHAR(10) NOT NULL,
    cno VARCHAR(10) NOT NULL,
    grade INT DEFAULT NULL,
    PRIMARY KEY (sno,cno),
	foreign key (sno) references student(sno),
	foreign key (cno) references course(cno)
);

EXEC sp_addextendedproperty 'MS_Description', 'ѡ��', 'SCHEMA', dbo, 'table', SC, null, null;
EXEC sp_addextendedproperty 'MS_Description', 'ѧ��', 'SCHEMA', dbo, 'table', SC, 'column', sno;
EXEC sp_addextendedproperty 'MS_Description', '�γ̺�', 'SCHEMA', dbo, 'table', SC, 'column', cno;
EXEC sp_addextendedproperty 'MS_Description', '����', 'SCHEMA', dbo, 'table', SC, 'column', grade;

