Insert into EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly','Flax', NULL, 'Male'),
(1013, 'Darryl', 'Philbin', NULL, 'Male')


Insert into WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')

Create Table WareHouseEmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)



INSERT INTO EmployeeSalary VALUES
(1010, NULL, 47000),
(NULL, 'Salesman', 43000)
--(1001, 'Salesman', 45000),
--(1002, 'Receptionist', 36000),
--(1003, 'Salesman', 63000),
--(1004, 'Accountant', 47000),
--(1005, 'HR', 50000),
--(1006, 'Regional Manager', 65000),
--(1007, 'Supplier Relations', 41000),
--(1008, 'Salesman', 48000),
--(1009, 'Accountant', 42000)

SELECT *
FROM EmployeeDemographics
ORDER BY 4 DESC, 5 DESC


SELECT Gender, COUNT(Gender) AS CountGender
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender
ORDER BY Gender

----Inner/Outer Joins

SELECT *
FROM EmployeeDemographics

SELECT *
FROM EmployeeSalary

--Inner Join, Left Outer Join, Right Outer Join

SELECT EmployeeSalary.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM SQLPractice.dbo.EmployeeDemographics
Left Outer Join SQLPractice.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM SQLPractice.dbo.EmployeeDemographics
Left Outer Join SQLPractice.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

-- USE Cases

SELECT EmployeeDemographics.EmployeeID,FirstName,LastName,Salary
FROM SQLPractice.dbo.EmployeeDemographics
Inner Join SQLPractice.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE FirstName <> 'Michael'
ORDER BY Salary DESC


SELECT JobTitle, AVG(Salary) as SalesManAverageSalary
FROM SQLPractice.dbo.EmployeeDemographics
Inner Join SQLPractice.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman'
GROUP BY JobTitle

--UNION

SELECT *
FROM EmployeeDemographics

SELECT *
From WareHouseEmployeeDemographics

SELECT *
FROM EmployeeDemographics
UNION
--UNION Duplicateleri siler, hepsini görmek için ALL ekle
SELECT *
From WareHouseEmployeeDemographics
ORDER BY EmployeeID

-- USE'un yanlýþ kullanýmý

SELECT EmployeeID, FirstName, Age
FROM SQLPractice.dbo.EmployeeDemographics
UNION
--UNION Duplicateleri siler, hepsini görmek için ALL ekle
SELECT EmployeeID, JobTitle, Salary
From SQLPractice.dbo.EmployeeSalary
ORDER BY EmployeeID


SELECT *
FROM SQLPractice.dbo.EmployeeDemographics
Full Outer Join SQLPractice.dbo.WareHouseEmployeeDemographics
ON EmployeeDemographics.EmployeeID = WareHouseEmployeeDemographics.EmployeeID


-- CASE   TOBY XD

--SELECT FirstName, LastName, Age,
--CASE
--WHEN Age = 38 THEN 'Bumasz'
--WHEN Age > 30 THEN 'Old'
--ELSE 'bABY baby baBy uuuuv yeee'
--END
--FROM SQLPractice.dbo.EmployeeDemographics
--WHERE Age is NOT NULL
--ORDER BY Age

SELECT FirstName, LastName,JobTitle, Salary,
CASE
WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .10)
WHEN JobTitle = 'HR' THEN Salary + (Salary* .000001)
ELSE Salary + (Salary* .03)
END AS SalaryAfterRaise
FROM SQLPractice.dbo.EmployeeDemographics
JOIN SQLPractice.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

-- HAVING (GROUP BY'DAN SONRA)

SELECT JobTitle, AVG(Salary)
FROM SQLPractice.dbo.EmployeeDemographics
Join SQLPractice.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary)

-- UPDATE, DELETE

SELECT *
FROM SQLPractice.dbo.EmployeeDemographics

UPDATE SQLPractice.dbo.EmployeeDemographics
SET EmployeeID = 1012
WHERE FirstName = 'Holly' AND LastName = 'Flax'

UPDATE SQLPractice.dbo.EmployeeDemographics
SET AGE = 31, Gender = 'Female'
WHERE FirstName = 'Holly' AND LastName = 'Flax'

DELETE FROM SQLPractice.dbo.EmployeeDemographics
WHERE EmployeeID = 1005

--ALIASING

SELECT Demo.EmployeeID, Sal.Salary
FROM SQLPractice.dbo.EmployeeDemographics Demo
JOIN SQLPractice.dbo.EmployeeSalary Sal
ON Demo.EmployeeID = Sal.EmployeeID

--Partition BY

SELECT FirstName, LastName, Gender, Salary
, COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
FROM SQLPractice.dbo.EmployeeDemographics dem
JOIN SQLPractice.dbo.EmployeeSalary sal
ON dem.EmployeeID = sal.EmployeeID

--Group By ile karþýlaþtýrma

SELECT FirstName, LastName, Gender, Salary, COUNT(Gender)
FROM SQLPractice.dbo.EmployeeDemographics dem
JOIN SQLPractice.dbo.EmployeeSalary sal
ON dem.EmployeeID = sal.EmployeeID
GROUP BY FirstName, LastName, Gender, Salary

-- ya da

SELECT Gender, COUNT(Gender)
FROM SQLPractice.dbo.EmployeeDemographics dem
JOIN SQLPractice.dbo.EmployeeSalary sal
ON dem.EmployeeID = sal.EmployeeID
GROUP BY Gender


-- CTE temporary result set

WITH CTE_Employee as (
SELECT FirstName, LastName, Gender, Salary
, COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
, AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
FROM SQLPractice.dbo.EmployeeDemographics dem
JOIN SQLPractice.dbo.EmployeeSalary sal
ON dem.EmployeeID = sal.EmployeeID
WHERE Salary > '45000'
)
SELECT FirstName, AvgSalary
FROM CTE_Employee

-- TEMP TABLES

CREATE TABLE #temp_Employee (
EmployeeID int,
JobTitle varchar(100),
Salary int
)

Select *
FROM #temp_Employee

INSERT INTO #temp_Employee VALUES (
'1001', 'HR', '45000'
)

--illa deðer atamak zorunda deðilsin, bir tabloyu da ekleyebilirsin.

INSERT INTO #temp_Employee
SELECT *
FROM SQLPractice.dbo.EmployeeSalary

--2nd örnek

DROP TABLE IF EXISTS #Teamp_Employee2
CREATE TABLE #Teamp_Employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int)

INSERT INTO #Teamp_Employee2
SELECT JobTitle, COUNT(JobTitle), Avg(Age), AVG(Salary)
FROM SQLPractice.dbo.EmployeeDemographics
Join SQLPractice.dbo.EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #Teamp_Employee2

-- String Functions & Use Cases 

CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired') -- michael being michael xDD

Select *
From EmployeeErrors

-- trim, left trim, rigth trim

SELECT EmployeeID, TRIM(EmployeeID) AS IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, LTRIM(EmployeeID) AS IDTRIM
FROM EmployeeErrors

SELECT EmployeeID, RTRIM(EmployeeID) AS IDTRIM
FROM EmployeeErrors


-- replace

SELECT LastName, REPLACE(LastName, '- Fired','') as LastNameFixed
FROM EmployeeErrors

-- substrings

 SELECT SUBSTRING(FirstName, 1,3)
FROM EmployeeErrors

Select err.FirstName, SUBSTRING(err.FirstName, 1, 3), dem.FirstName, SUBSTRING(dem.FirstName,1 , 3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
ON SUBSTRING(err.FirstName, 1, 3) = SUBSTRING(dem.FirstName,1 ,3)

-- upper and lower case

SELECT 

SELECT FirstName, LOWER(FirstName)
FROM EmployeeErrors

SELECT FirstName, upper(FirstName)
FROM EmployeeErrors

-- stored precodure

CREATE PROCEDURE TEST
AS
SELECT *
FROM EmployeeDemographics

EXEC TEST

-- updating stored procedure

CREATE PROCEDURE [dbo].[UpdateTEST]
@FirstName varchar(50)
AS
UPDATE EmployeeDemographics
SET FirstName = @FirstName
WHERE FirstName = 'Dwight'

--bunu yaptýktan sonra programmability>str procedure>updated olaný exec et ve istediðin deðeri gir.



-- subqueries

Select *
FROM EmployeeSalary

-- subqueries in select

Select EmployeeID, Salary, (Select AVG(Salary) FROM EmployeeSalary) AS AllAvgSalary
FROM EmployeeSalary

-- subqueries in partition by

Select EmployeeID, Salary, AVG(Salary) OVER() AS AllAvgSalary
FROM EmployeeSalary

---- subqueries why group by doesn't work

Select EmployeeID, Salary, AVG(Salary) AS AllAvgSalary
FROM EmployeeSalary
Group By EmployeeID, Salary
Order By 1,2

-- subqueries in from 

SELECT a.EmployeeID, AllAvgSalary
FROM (Select EmployeeID, Salary, AVG(Salary) OVER() AS AllAvgSalary
      FROM EmployeeSalary) a

--subqueries in where (join yerine bu da kullanýlabilir) bu iyiymiþ 

Select EmployeeID, JobTitle, Salary
FROM EmployeeSalary
Where EmployeeID in (
		Select EmployeeID
		From EmployeeDemographics
		Where Age > 30)