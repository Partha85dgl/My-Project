
--1
CREATE NONCLUSTERED INDEX IX_dbo_Works_on_EnterDate
ON dbo.Works_on (Enter_Date)

ALTER INDEX ALL ON dbo.Works_on REBUILD WITH (FILLFACTOR = 80, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON);


--2
CREATE UNIQUE NONCLUSTERED INDEX IX_Employee_Emp_LName_Emp_FName ON Employee
(
        Emp_LName  ,
        Emp_FName
) WITH( IGNORE_DUP_KEY = OFF)

--3
CREATE VIEW EmployeeByDepartmentD1 AS
SELECT * FROM Employee 
WHERE DepartmentId = 'd1';

--TEST : select * from EmployeeByDepartmentD1


--4
CREATE VIEW GetProjectWithoutBudget AS
SELECT ProjectID, ProjectName FROM Project
--TEST : select * from GetProjectWithoutBudget

--5
CREATE VIEW GetEmployees AS
SELECT Emp_LName, Emp_FName FROM Employee P
join Works_on W on P.EmpID = W.EmpID
Where YEAR(W.Enter_Date) = 1988
AND MONTH(W.Enter_Date) > 6

--TEST : select * from GetEmployees

--6
Alter VIEW [GetEmployees] AS
SELECT Emp_LName as [Last Name],  Emp_FName as [First Name] FROM Employee P
join Works_on W on P.EmpID = W.EmpID
Where YEAR(W.Enter_Date) = 1988
AND MONTH(W.Enter_Date) > 6

-8
CREATE VIEW [GetEmployeesWithCheckOption] AS
SELECT Emp_LName as [Last Name],  Emp_FName as [First Name] FROM Employee P
join Works_on W on P.EmpID = W.EmpID
Where W.EmpID > 1000
WITH CHECK OPTION;
