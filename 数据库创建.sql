-- ���Ѵ�����ɾ������ʼ��ʱʹ�ã�����ֱ��ɾ��ԭ��SCT���ݿ⣬��ԭ������SCT���ݿ������Ҫ��ת�ƺ�ʹ��
IF  (EXISTS (SELECT * FROM dbo.sysdatabases where name=N'SCT')) DROP DATABASE SCT;

-- �������ݿ�
create database SCT
on primary
(
  name=SCT,
  filename='D:\database\sql\file\SCT.mdf',
  size=100,
  maxsize=unlimited,
  filegrowth=10%
)
log on
(
  name=SCTlog,
  filename='D:\database\sql\file\SCTlog.ldf',
  size=50,
  maxsize=500,
  filegrowth=1
)

