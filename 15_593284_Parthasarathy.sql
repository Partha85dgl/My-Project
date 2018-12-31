CREATE DATABASE VINOTH
GO


USE VINOTH
GO

CREATE TABLE [dbo].Customers(
	[CustomerID] Char(5) NOT NULL,
	[CompanyName] [varchar](40) NOT NULL,
	[ContactName] [char](30) NULL,
	[Address] [varchar](60) NULL,
	[City] [char](15) NULL,
	[Phone] [char](24) NULL,
	[Fax] [char](24) NULL,
 )
GO


CREATE TABLE [dbo].Orders(
	[OrderID] Int NOT NULL,
	[CustomerID] Char(5) NOT NULL,
	[OrderDate] [DateTime] NULL,
	[ShippedDate] [DateTime] NULL,
	[Freight] [money] NULL,
	[ShipName] [varchar](40) NULL,
	[ShipAddress] [varchar](60) NULL,
	[Quantity] Int NOT NULL,
 )
 GO

 Alter table Orders add ShipRegion Int Null
 GO

 Alter table Orders alter column ShipRegion Char(8)
 GO

 Alter table Orders drop column ShipRegion
 GO

 INSERT INTO Orders Values(10, 'Ord01', GETDATE(), GETDATE(), 100.0, 'Windstar', 'Ocean', 1)
 GO

ALTER TABLE Orders ADD CONSTRAINT DF_OrderDate DEFAULT GETDATE() for [OrderDate]
GO

EXEC sp_rename 'Customers.City', 'Town', 'COLUMN';  
GO



CREATE TABLE [dbo].Department(
	[DepartmentID] Char(5) NOT NULL,
	[DepartmentName] varchar(50) NOT NULL,
	[Location] [varchar](50) NOT NULL
 )
 GO

 
CREATE TABLE [dbo].Employee(
	[EmpID] Char(5) NOT NULL,
	[Emp_FName] char(20) NOT NULL,
	[Emp_LName] char(20) NOT NULL,
	[DepartmentID] Char(5) NOT NULL
 )
 GO

 
CREATE TABLE [dbo].Project(
	[ProjectID] Char(5) NOT NULL,
	[ProjectName] char(20) NOT NULL,
	[Budget] char(20) NOT NULL
 )
 GO

 
CREATE TABLE [dbo].Works_on(
	[EmpID] Char(5) NOT NULL,
	[ProjectID] Char(5) NOT NULL,
	[Job] char(20) NULL,
	[Enter_Date] DateTime NULL
 )
 GO


SELECT * from Works_On

SELECT EMPID from Works_on where Job = 'Clerk'

SELECT EMPID from Works_on where ProjectId = 'p2' and EMPId < 10000

SELECT EMPID from Works_on where YEAR(Enter_Date) <> 1998

SELECT EMPID from Works_on where ProjectId = 'p1' and Job in ('Analyst', 'Manager')

SELECT Enter_Date from Works_on where ProjectId = 'p2' and Job is NULL

SELECT E.EMPID, Emp_LName as [Last Name] from Works_on W
JOIN Employee E on E.EmpID = W.EMPID
where LEN(REPLACE(E.Emp_FName,'t','')) = 2

SELECT E.EMPID, Emp_FName as [First Name] from Works_on W
JOIN Employee E on E.EmpID = W.EMPID
where  charindex('o',Emp_LName) =2 or charindex('a',Emp_LName) =2

SELECT E.EMPID from Department D
JOIN Employee E on E.DepartmentID = D.DepartmentID
where D.Location = 'Seattle'

SELECT E.Emp_LName, Emp_FName as [First Name] from Works_on W
JOIN Employee E on E.EmpID = W.EMPID
where W.Enter_Date = Convert(datetime, '14-1-1998', 103) 

SELECT Location, Count(1) [Total Count] from Department
Group By Location

SELECT MAX(EMPID) from Employee

SELECT JOB, Count(1) FROM Works_on
Group By JOB
having count(1) > 1

