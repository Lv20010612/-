--��SC��������޸�ѧ�Ż��Ӧ�޸�����
IF(OBJECT_ID('show_Sname') is not null)        -- �ж���Ϊ show_Sname �Ĵ������Ƿ����
DROP TRIGGER show_Sname        -- ɾ��������
GO

CREATE TRIGGER show_Sname
ON SC  	         
FOR UPDATE
AS 
	declare @NEWSno NCHAR(10),
			@Sname NCHAR(10);
IF(UPDATE(ѧ��))
	BEGIN
	SELECT @NEWSno =ѧ�� FROM INSERTED
	SELECT @Sname =���� FROM Student WHERE ѧ��=@NEWSno
	UPDATE SC SET ����=@Sname WHERE ѧ��=@NEWSno

END;

--��SC��������޸Ŀγ̺Ż��Ӧ�޸Ŀγ���
IF(OBJECT_ID('show_Cname') is not null)        -- �ж���Ϊ show_Cname �Ĵ������Ƿ����
DROP TRIGGER show_Cname        -- ɾ��������
GO

CREATE TRIGGER show_Cname
ON SC  	         
FOR UPDATE
AS 
	declare @NEWCno NCHAR(10),
			@Cname NCHAR(10),
			@credit SMALLINT;
IF(UPDATE(�γ̺�))
	BEGIN
	SELECT @NEWCno =�γ̺� FROM INSERTED
	SELECT @Cname =�γ��� FROM Course WHERE �γ̺�=@NEWCno
	SELECT @credit = ѧ�� FROM Course WHERE �γ̺�=@NEWCno
	UPDATE SC SET �γ���=@Cname WHERE �γ̺�=@NEWCno
	UPDATE SC SET ѧ��=@credit WHERE �γ̺�=@NEWCno AND �ɼ�>=60
	UPDATE SC SET ѧ��=0 WHERE �γ̺�=@NEWCno AND �ɼ�<60

END;

--��SC��������޸ĳɼ����ɼ�����60ʱ��ѧ�ֻ�ã�����Ϊ0
IF(OBJECT_ID('show_credit') is not null)        -- �ж���Ϊ show_credit �Ĵ������Ƿ����
DROP TRIGGER show_credit        -- ɾ��������
GO

CREATE TRIGGER show_credit
ON SC  	         
FOR UPDATE
AS 
	declare @NEWgrade SMALLINT,
			@Sno NCHAR(10),
			@Cno NCHAR(10),
			@credit SMALLINT;
			--@average SMALLINT;
IF(UPDATE(�ɼ�))
	BEGIN
	SELECT @NEWgrade = �ɼ� FROM INSERTED
	SELECT @Sno = ѧ�� FROM DELETED
	SELECT @Cno = �γ̺� FROM DELETED 
	SELECT @credit  =ѧ�� FROM Course WHERE �γ̺�=@Cno
	UPDATE SC SET ѧ��=0 WHERE �γ̺�=@Cno AND �ɼ�<60
	UPDATE SC SET ѧ��=@credit WHERE �γ̺�=@Cno AND �ɼ�>=60
	--SELECT avg(�ɼ�) as average FROM SC WHERE �γ̺� = @Cno AND �ɼ� != NULL
	--UPDATE Course SET ƽ���ɼ� = 1 WHERE �γ̺� = @Cno

END;

--��Course��������޸�ѧ�֣�SC���еĶ�Ӧѧ��ҲҪ�޸�
IF(OBJECT_ID('change_credit') is not null)        -- �ж���Ϊ change_credit �Ĵ������Ƿ����
DROP TRIGGER change_credit        -- ɾ��������
GO
CREATE TRIGGER change_credit
ON Course  	         
FOR UPDATE
AS 
	declare @Cno NCHAR(10),
			@credit SMALLINT;
IF(UPDATE(ѧ��))
	BEGIN
	SELECT @Cno = �γ̺� FROM DELETED 
	SELECT @credit  =ѧ�� FROM INSERTED
	UPDATE SC SET ѧ��=0 WHERE �γ̺�=@Cno AND �ɼ�<60
	UPDATE SC SET ѧ��=@credit WHERE �γ̺�=@Cno AND �ɼ�>=60

END;