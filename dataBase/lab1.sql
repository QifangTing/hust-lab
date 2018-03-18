USE [master];
GO
IF EXISTS(SELECT * from sys.databases where name = 'DBU201414800')
DROP DATABASE [DBU201414800];
GO
CREATE DATABASE [DBU201414800];
GO
USE [DBU201414800];
GO

IF (EXISTS (SELECT * FROM sys.schemas WHERE name = 'SPJ414800'))
DROP SCHEMA [SPJ414800];
GO
EXEC ('CREATE SCHEMA [SPJ414800]');
GO
-- ALTER USER [dbo] WITH DEFAULT_SCHEMA = [SPJ414800];
-- GO

IF OBJECT_ID('SPJ414800.SPJ', 'U') IS NOT NULL 
DROP TABLE [SPJ414800].[SPJ];
IF OBJECT_ID('SPJ414800.BIG_SPJ', 'U') IS NOT NULL 
DROP TABLE [SPJ414800].[BIG_SPJ];
IF OBJECT_ID('SPJ414800.S', 'U') IS NOT NULL 
DROP TABLE [SPJ414800].[S];
IF OBJECT_ID('SPJ414800.P', 'U') IS NOT NULL 
DROP TABLE [SPJ414800].[P];
IF OBJECT_ID('SPJ414800.J', 'U') IS NOT NULL 
DROP TABLE [SPJ414800].[J];

CREATE TABLE [SPJ414800].[S] (
	[SNO] VARCHAR(5) PRIMARY KEY,
    [SNAME] VARCHAR(30) NOT NULL,
    [STATUS] INT,
    [CITY] VARCHAR(30)
);

CREATE TABLE [SPJ414800].[P] (
	[PNO] VARCHAR(5) PRIMARY KEY,
    [PNAME] VARCHAR(30) NOT NULL,
    [COLOR] VARCHAR(10),
    [WEIGHT] INT DEFAULT 10
);

CREATE TABLE [SPJ414800].[J] (
	[JNO] VARCHAR(5) PRIMARY KEY,
    [JNAME] VARCHAR(30) NOT NULL,
    [CITY] VARCHAR(30)
);

CREATE TABLE [SPJ414800].[SPJ] (
	[SNO] VARCHAR(5),
    [PNO] VARCHAR(5),
    [JNO] VARCHAR(5),
    [QTY] INT CHECK([QTY] >= 1 AND [QTY] <= 10000),
    PRIMARY KEY([SNO], [PNO], [JNO]),
    FOREIGN KEY ([SNO])
		REFERENCES [SPJ414800].[S]([SNO])
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY ([PNO])
		REFERENCES [SPJ414800].[P]([PNO])
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY ([JNO])
		REFERENCES [SPJ414800].[J]([JNO])
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- SELECT * FROM sys.objects
-- WHERE type_desc LIKE '%CONSTRAINT';

ALTER TABLE [SPJ414800].[P] ADD [PRICE] FLOAT;
ALTER TABLE [SPJ414800].[J] ADD [JSTART] DATE NOT NULL;
ALTER TABLE [SPJ414800].[J] ADD [JEND] DATE;
GO
ALTER TABLE [SPJ414800].[J] ADD CHECK([JEND] > [JSTART])

INSERT INTO [SPJ414800].[S] VALUES('S1', '����', 20, '���');
INSERT INTO [SPJ414800].[S] VALUES('S2', 'ʢ��', 10, '����');
INSERT INTO [SPJ414800].[S] VALUES('S3', '������', 30, '����');
INSERT INTO [SPJ414800].[S] VALUES('S4', '��̩ʢ', 20, '���');
INSERT INTO [SPJ414800].[S] VALUES('S5', 'Ϊ��', 30, '�Ϻ�');

INSERT INTO [SPJ414800].[P] VALUES('P1', '��ĸ', '��', 12, FLOOR(2 + (RAND() * 3)));
INSERT INTO [SPJ414800].[P] VALUES('P2', '��˨', '��', 17, FLOOR(3 + (RAND() * 3)));
INSERT INTO [SPJ414800].[P] VALUES('P3', '��˿��', '��', 14, FLOOR(5 + (RAND() * 3)));
INSERT INTO [SPJ414800].[P] VALUES('P4', '��˿��', '��', 14, FLOOR(6 + (RAND() * 3)));
INSERT INTO [SPJ414800].[P] VALUES('P5', '͹��', '��', 40, FLOOR(7 + (RAND() * 3)));
INSERT INTO [SPJ414800].[P] VALUES('P6', '����', '��', 30, FLOOR(8 + (RAND() * 3)));

INSERT INTO [SPJ414800].[J] VALUES('J1', '����', '����', DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 14), CAST(GETDATE()AS DATE)), DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 14), CAST(GETDATE()AS DATE)));
INSERT INTO [SPJ414800].[J] VALUES('J2', 'һ��', '����', DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 14), CAST(GETDATE()AS DATE)), DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 14), CAST(GETDATE()AS DATE)));
INSERT INTO [SPJ414800].[J] VALUES('J3', '���ɳ�', '���', DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 14), CAST(GETDATE()AS DATE)), DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 14), CAST(GETDATE()AS DATE)));
INSERT INTO [SPJ414800].[J] VALUES('J4', '�촬��', '���', DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 14), CAST(GETDATE()AS DATE)), DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 14), CAST(GETDATE()AS DATE)));
INSERT INTO [SPJ414800].[J] VALUES('J5', '������', '��ɽ', DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 14), CAST(GETDATE()AS DATE)), DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 14), CAST(GETDATE()AS DATE)));
INSERT INTO [SPJ414800].[J] VALUES('J6', '���ߵ糧', '����', DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 14), CAST(GETDATE()AS DATE)), DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 14), CAST(GETDATE()AS DATE)));
INSERT INTO [SPJ414800].[J] VALUES('J7', '�뵼�峧', '�Ͼ�', DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 14), CAST(GETDATE()AS DATE)), DATEADD(DAY, ABS(CHECKSUM(NEWID()) % 14), CAST(GETDATE()AS DATE)));

INSERT INTO [SPJ414800].[SPJ] VALUES('S1', 'P1', 'J1', 200);
INSERT INTO [SPJ414800].[SPJ] VALUES('S1', 'P1', 'J3', 100);
INSERT INTO [SPJ414800].[SPJ] VALUES('S1', 'P1', 'J4', 700);
INSERT INTO [SPJ414800].[SPJ] VALUES('S1', 'P2', 'J2', 100);
INSERT INTO [SPJ414800].[SPJ] VALUES('S2', 'P3', 'J1', 400);
INSERT INTO [SPJ414800].[SPJ] VALUES('S2', 'P3', 'J2', 200);
INSERT INTO [SPJ414800].[SPJ] VALUES('S2', 'P3', 'J4', 500);
INSERT INTO [SPJ414800].[SPJ] VALUES('S2', 'P3', 'J5', 400);
INSERT INTO [SPJ414800].[SPJ] VALUES('S2', 'P5', 'J1', 400);
INSERT INTO [SPJ414800].[SPJ] VALUES('S2', 'P5', 'J2', 100);
INSERT INTO [SPJ414800].[SPJ] VALUES('S3', 'P1', 'J1', 200);
INSERT INTO [SPJ414800].[SPJ] VALUES('S3', 'P3', 'J1', 200);
INSERT INTO [SPJ414800].[SPJ] VALUES('S4', 'P5', 'J1', 100);
INSERT INTO [SPJ414800].[SPJ] VALUES('S4', 'P6', 'J3', 300);
INSERT INTO [SPJ414800].[SPJ] VALUES('S4', 'P6', 'J4', 200);
INSERT INTO [SPJ414800].[SPJ] VALUES('S5', 'P2', 'J4', 100);
INSERT INTO [SPJ414800].[SPJ] VALUES('S5', 'P3', 'J1', 200);
INSERT INTO [SPJ414800].[SPJ] VALUES('S5', 'P6', 'J2', 200);
INSERT INTO [SPJ414800].[SPJ] VALUES('S5', 'P6', 'J4', 500);

/* integrity violation insertion */
INSERT INTO [SPJ414800].[S] VALUES('S1', '�����ع�', 30, '�人');	/* error: primary key */
INSERT INTO [SPJ414800].[S] VALUES(NULL, '�����ع�', 30, '�人');	/* error: entity integrity */
INSERT INTO [SPJ414800].[SPJ] VALUES('S233', 'P233', 'J233', 233);	/* error: referential integrity */
INSERT INTO [SPJ414800].[S] VALUES('S6', NULL, 30, '�人');			/* error: user-defined integrity */
INSERT INTO [SPJ414800].[SPJ] VALUES('S1', 'P1', 'J7', 23333);		/* error: user-defined integrity */
INSERT INTO [SPJ414800].[J] VALUES('J8', '��ķ˹���ʶ�ײ�������������', '�人', '2017-07-01', '2016-12-25');	/* error: user-defined integrity */

CREATE TABLE [SPJ414800].[BIG_SPJ] (
	[SNO] VARCHAR(5),
    [PNO] VARCHAR(5),
    [JNO] VARCHAR(5),
    [QTY] INT CHECK([QTY] >= 1 AND [QTY] <= 10000),
    PRIMARY KEY([SNO], [PNO], [JNO]),
    FOREIGN KEY ([SNO])
		REFERENCES [SPJ414800].[S]([SNO])
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY ([PNO])
		REFERENCES [SPJ414800].[P]([PNO])
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY ([JNO])
		REFERENCES [SPJ414800].[J]([JNO])
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO [SPJ414800].[BIG_SPJ]
SELECT *
FROM [SPJ414800].[SPJ]
WHERE [SPJ414800].[SPJ].[QTY] > 400;

SELECT * FROM [SPJ414800].[S];
SELECT * FROM [SPJ414800].[P];
SELECT * FROM [SPJ414800].[J];
SELECT * FROM [SPJ414800].[SPJ];
SELECT * FROM [SPJ414800].[BIG_SPJ];

/* 2-6 */

SELECT DISTINCT [SNO]
FROM [SPJ414800].[SPJ]
WHERE [JNO] = 'J1';

SELECT DISTINCT [SNO]
FROM [SPJ414800].[SPJ]
WHERE [PNO] = 'P1' AND [JNO] = 'J1';

SELECT DISTINCT [SNO]
FROM [SPJ414800].[P], [SPJ414800].[SPJ]
WHERE [SPJ414800].[P].[PNO] = [SPJ414800].[SPJ].[PNO]
	AND [JNO] = 'J1'
    AND [COLOR] = '��';

SELECT  DISTINCT [JNO]
FROM [SPJ414800].[SPJ]
WHERE [JNO] NOT IN (
	SELECT [JNO]
    FROM [SPJ414800].[S], [SPJ414800].[P], [SPJ414800].[SPJ]
    WHERE [SPJ414800].[S].[SNO] = [SPJ414800].[SPJ].[SNO]
		AND [SPJ414800].[P].[PNO] = [SPJ414800].[SPJ].[PNO]
        AND [CITY] ='���'
        AND [COLOR] = '��'
);

SELECT DISTINCT [JNO]
FROM [SPJ414800].[SPJ] [SPJX]
WHERE NOT EXISTS (
	SELECT *
    FROM [SPJ414800].[SPJ] [SPJY]
    WHERE [SPJY].[SNO] = 'S1'
		AND NOT EXISTS (
			SELECT *
			FROM [SPJ414800].[SPJ] [SPJZ]
			WHERE [SPJX].[JNO] = [SPJZ].[JNO]
				AND [SPJY].[PNO] = [SPJZ].[PNO]
		)
);

/* 2-6 */


/* 3-5 part1 */

SELECT [SNAME], [CITY]
FROM [SPJ414800].[S];

SELECT [PNAME], [COLOR], [WEIGHT]
FROM [SPJ414800].[P];

SELECT DISTINCT [JNO]
FROM [SPJ414800].[SPJ]
WHERE [SNO] = 'S1';

SELECT [PNAME], [QTY]
FROM [SPJ414800].[P], [SPJ414800].[SPJ]
WHERE [SPJ414800].[P].[PNO] = [SPJ414800].[SPJ].[PNO]
	AND [JNO] = 'J2';

SELECT DISTINCT [PNO]
FROM [SPJ414800].[S], [SPJ414800].[SPJ]
WHERE [SPJ414800].[S].[SNO] = [SPJ414800].[SPJ].[SNO]
	AND [CITY] = '�Ϻ�';

SELECT DISTINCT [JNAME]
FROM [SPJ414800].[S], [SPJ414800].[J], [SPJ414800].[SPJ]
WHERE [SPJ414800].[S].[SNO] = [SPJ414800].[SPJ].[SNO]
	AND [SPJ414800].[J].[JNO] = [SPJ414800].[SPJ].[JNO]
    AND [SPJ414800].[S].[CITY] = '�Ϻ�';

SELECT DISTINCT [JNO]
FROM [SPJ414800].[SPJ]
WHERE [JNO] NOT IN (
	SELECT DISTINCT [JNO]
    FROM [SPJ414800].[S], [SPJ414800].[SPJ]
    WHERE [SPJ414800].[S].[SNO] = [SPJ414800].[SPJ].[SNO]
		AND [CITY]= '���'
);

/* 3-5 part1 */

/* additional SQL */

SELECT DISTINCT [SPJ414800].[P].[PNO], [PNAME], [JNAME]
FROM [SPJ414800].[P], [SPJ414800].[J], [SPJ414800].[SPJ]
WHERE [SPJ414800].[P].[PNO] = [SPJ414800].[SPJ].[PNO]
	AND [SPJ414800].[J].[JNO] = [SPJ414800].[SPJ].[JNO]
    AND [JNAME] LIKE '%��'
ORDER BY [JNAME], [PNO], [PNAME];

SELECT DISTINCT [JNO], SUM([PRICE]) AS [JPRICE]
FROM [SPJ414800].[P], [SPJ414800].[SPJ]
WHERE [SPJ414800].[P].[PNO] = [SPJ414800].[SPJ].[PNO]
GROUP BY [JNO]
ORDER BY [JPRICE] DESC;

SELECT DISTINCT [SNO], SUM([QTY]) AS [SQTY]
FROM [SPJ414800].[SPJ]
GROUP BY [SNO];

SELECT DISTINCT [JNO], DATEDIFF(DAY, [JSTART], [JEND]) AS [JDAY]
FROM [SPJ414800].[J]
WHERE DATEDIFF(DAY, [JSTART], [JEND]) <= 365;

SELECT DISTINCT [JNO]
FROM [SPJ414800].[SPJ]
WHERE [JNO] NOT IN (
	SELECT [SPJ414800].[J].[JNO]
    FROM [SPJ414800].[S], [SPJ414800].[J], [SPJ414800].[SPJ]
    WHERE [SPJ414800].[S].[SNO] = [SPJ414800].[SPJ].[SNO]
		AND [SPJ414800].[J].[JNO] = [SPJ414800].[SPJ].[JNO]
        AND [SPJ414800].[S].[CITY] = [SPJ414800].[J].[CITY]
);
GO

/* additional SQL */


/* 3-9 */

/* multiple-table view: can't get updated */
CREATE VIEW [SPJ414800].[SANJIAN_SPJ]([SNO], [PNO], [QTY])
AS
SELECT [SNO], [PNO], [QTY]
FROM [SPJ414800].[J], [SPJ414800].[SPJ]
WHERE [SPJ414800].[J].[JNO] = [SPJ414800].[SPJ].[JNO]
	AND [JNAME] = '����'
WITH CHECK OPTION;
GO

SELECT [PNO], [QTY] FROM [SPJ414800].[SANJIAN_SPJ];
SELECT * FROM [SPJ414800].[SANJIAN_SPJ] WHERE [SNO] = 'S1';
GO

CREATE VIEW [SPJ414800].[TIANJING_S]
AS
SELECT [SNO], [SNAME], [STATUS]
FROM [SPJ414800].[S]
WHERE [CITY] = '���';
-- WHERE [CITY] = '���'
-- WITH CHECK OPTION;
GO

INSERT INTO [SPJ414800].[TIANJING_S] VALUES('S23', '�����ع�', 30);
SELECT * FROM [SPJ414800].[S];

/* 3-9 */


/* 3-5 part2 */

UPDATE [SPJ414800].[P]
SET [COLOR] = '��'
WHERE [COLOR] = '��';
SELECT * FROM [SPJ414800].[P];

UPDATE [SPJ414800].[SPJ]
SET [SNO] = 'S3'
WHERE [SNO] = 'S5'
	AND [PNO] = 'P6'
	AND [JNO] = 'J4';
SELECT * FROM [SPJ414800].[SPJ];

INSERT INTO [SPJ414800].[SPJ] VALUES('S2', 'P4', 'J6', 200);
SELECT * FROM [SPJ414800].[SPJ];

DELETE FROM [SPJ414800].[S] WHERE [SNO] = 'S2';		/* cascade */
SELECT * FROM [SPJ414800].[S];
SELECT * FROM [SPJ414800].[SPJ];

/* 3-5 part2 */