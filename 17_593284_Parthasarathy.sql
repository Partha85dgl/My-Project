/*--------Exercise 1------------*/

CREATE TABLE [dbo].[Customers](
	CustomerID	CHAR(5)	NOT NULL,
	CompanyName	varCHAR(40)	NOT NULL,
	ContactName	CHAR(30) NULL,
	Address	VARCHAR(60)	NULL,
	Town	CHAR(15) NULL,
	Phone	CHAR(24) NULL,
	Fax	CHAR(24) NULL,
	CONSTRAINT PK_Orders_CustomerID PRIMARY KEY(CustomerID)
)
GO

CREATE TABLE [dbo].[Orders](
	OrderID	INT	NOT NULL,
	CustomerID	CHAR(5)	NOT NULL,
	OrderDate DATETIME NULL,
	ShippedDate	DATETIME NULL,
	Freight	MONEY NULL,
	ShipName VARCHAR(40)	NULL,
	ShipAddress	VARCHAR(60)	NULL,
	Quantity INT NOT NULL,
	CONSTRAINT PK_Orders_OrderID PRIMARY KEY(OrderID), 
	CONSTRAINT FK_Orders_CustomerID Foreign Key(CustomerID) REFERENCES [dbo].[Customers](CustomerID)
	
)
GO

/*--------Exercise 2------------*/

ALTER TABLE [dbo].[Orders] ADD CONSTRAINT CK_Orders_Quantity CHECK (Quantity BETWEEN 1 AND 30)
GO
/*--------Exercise 3------------*/

CREATE TYPE [dbo].[WesternCountries] FROM VARCHAR(2) NOT NULL
GO
	
CREATE DEFAULT [dbo].[Default_WesternCountries] AS 'CA'
GO

EXEC sp_bindefault '[Default_WesternCountries]' ,'[WesternCountries]'
GO

CREATE RULE [dbo].[RULE_WesternCountries] AS @Value IN ('CA','NM', 'OR','WA')
GO

EXEC sp_bindrule '[RULE_WesternCountries]' ,'[WesternCountries]'
GO


CREATE TABLE [dbo].[Regions](
	City WesternCountries,
	Country VARCHAR(30) NOT NULL
)
GO

INSERT INTO [Regions] (Country) values ('USA')
INSERT INTO [Regions] (City,Country) values ('WA','USA')
INSERT INTO [Regions] (City,Country) values ('NM','USA')
INSERT INTO [Regions] (City,Country) values ('OR','USA')
INSERT INTO [Regions] (City,Country) values ('SL','USA') -- Throws Error A column insert or update conflicts with a rule imposed by a previous CREATE RULE statement. The statement was terminated. The conflict occurred in database 'test', table 'dbo.Regions', column 'City'.
GO



/*--------Exercise 4------------*/ 


select * from sys.sysobjects 
select * from sys.default_constraints where parent_object_id = 757577737
select * from sys.check_constraints	  where parent_object_id = 757577737
select * from sys.key_constraints	  where parent_object_id = 757577737
select * from sys.foreign_keys		  where parent_object_id = 757577737
select * from sys.tables where object_id = 261575970

select a.name, b.name AS 'Default Constraint',c.name AS 'Check Constraints',d.name AS 'Primary Key',e.name 'Foreign Keys'
from sys.tables a 
left join sys.default_constraints b on a.object_id = b.parent_object_id
left join sys.check_constraints c on a.object_id = c.parent_object_id
left join sys.key_constraints d on a.object_id = d.parent_object_id
left join sys.foreign_keys e on a.object_id = e.parent_object_id
WHERE a.name = 'Orders'

/*--------Exercise 5------------*/ 

ALTER TABLE [dbo].[Customers] DROP CONSTRAINT PK_Orders_CustomerID -- Throws error becuase the column associated with this constraint is FK of  CustomerID column in Orders table 
GO
/*--------Exercise 6------------*/ 

ALTER TABLE [dbo].[Orders] DROP CONSTRAINT CK_Orders_Quantity 
GO
/*--------Exercise 7------------*/ 


CREATE FUNCTION dbo.Func_Find_Age(@DOB DATETIME)
RETURNS INT
AS 
BEGIN
	DECLARE @Age INT

	SET @AGE = DATEDIFF(YEAR, @DOB, GETDATE())

	RETURN @AGE

END
GO




/*--------Exercise 8------------*/ 

CREATE TABLE [dbo].[Students](
	SID INT NOT NULL,
	StudentName	varCHAR(50)	NOT NULL,
	DOB DATETIME NOT NULL,
	CONSTRAINT PK_Students_SID PRIMARY KEY(SID)
)

GO

CREATE PROCEDURE usp_Insert_Students(
	@StudentName VARCHAR(50),
	@DOB DATETIME
)
AS BEGIN
 SET NOCOUNT ON
	DECLARE @SID INT

	IF EXISTS (SELECT 1 FROM [Students])
		BEGIN
			SELECT @SID = MAX(SID)+1 FROM [dbo].[Students]
		END
	ELSE
		BEGIN 
			SELECT @SID = 1
		END 

	INSERT INTO [Students](SID, StudentName, DOB) VALUES (@SID, @StudentName, @DOB)

END

EXEC usp_Insert_Students 'Test Student','01-03-1993 00:00:00'
EXEC usp_Insert_Students 'Test Student2','10-12-1993 00:00:00'


GO

/*--------Select Statements------------*/ 
select * from [Regions]
select  dbo.Func_Find_Age('01-03-1993 00:00:00')
select * from [Students]


