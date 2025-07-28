/*****************************************************************************************************************
NAME:    My Script Name  3.4 Adventure Works—Create Answers
PURPOSE: My script purpose... Answer 8 selected business and metadata questions using SQL

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     05/23/2022   IJConteh       1. Built this script for EC IT143


RUNTIME: 
Xs

NOTES: 
finding answers to user questions by creating SQL statements using AdventureWork...
 
******************************************************************************************************************/
--Adventure works meta data https://www.google.com/search?q=Where+to+find+metadata+about+AdventureWorks


-/***********************************************************************
 BUSINESS USER QUESTIONS — MARGINAL COMPLEXITY
************************************************************************/

-- Q1 (Marginal) — What is the total number of employees that joined the company in February?
-- Author: Guillermo Ezequiel Chehda

SELECT COUNT(*) AS TotalEmployeesJoinedFebruary
FROM HumanResources.Employee
WHERE MONTH(HireDate) = 2;


-- Q2 (Marginal) — Which product has the highest list price in the Production.Product table?
-- Author: Guillermo Ezequiel Chehda

SELECT TOP 1 Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;


/***********************************************************************
 BUSINESS USER QUESTIONS — MODERATE COMPLEXITY
************************************************************************/

-- Q3 (Moderate) — What is the total sales amount for each product sold in the year 2022? Include product names.
-- Author: Kendall David Navarro Sandoya

SELECT p.Name AS ProductName,
       SUM(sod.LineTotal) AS TotalSalesAmount
FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
WHERE YEAR(soh.OrderDate) = 2022
GROUP BY p.Name
ORDER BY TotalSalesAmount DESC;


-- Q4 (Moderate) — Which sales representatives have sold more than 50 orders, and what are their total sales amounts?
-- Author: Kendall David Navarro Sandoya

SELECT sp.SalesPersonID,
       e.FirstName + ' ' + e.LastName AS SalesRepName,
       COUNT(soh.SalesOrderID) AS TotalOrders,
       SUM(soh.TotalDue) AS TotalSalesAmount
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesPerson sp ON soh.SalesPersonID = sp.SalesPersonID
JOIN HumanResources.Employee e ON sp.BusinessEntityID = e.BusinessEntityID
GROUP BY sp.SalesPersonID, e.FirstName, e.LastName
HAVING COUNT(soh.SalesOrderID) > 50
ORDER BY TotalSalesAmount DESC;


/***********************************************************************
 BUSINESS USER QUESTIONS — INCREASED COMPLEXITY
************************************************************************/

-- Q5 (Increased) — List of employees hired after 2015, what are their names, job titles, and current departments?
-- Author: Frederick Boafo Ampofo

SELECT e.FirstName + ' ' + e.LastName AS EmployeeName,
       e.JobTitle,
       d.Name AS DepartmentName
FROM HumanResources.Employee e
JOIN HumanResources.EmployeeDepartmentHistory edh 
     ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department d 
     ON edh.DepartmentID = d.DepartmentID
WHERE YEAR(e.HireDate) > 2015
  AND edh.EndDate IS NULL;  -- Current Department


-- Q6 (Increased) — A customer named 'Brian Welcker' made a purchase last month. What products did he buy and at what unit prices?
-- Author:Frederick Boafo Ampofo

SELECT p.Name AS ProductName,
       sod.UnitPrice
FROM Sales.Customer c
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
WHERE c.FirstName = 'Brian'
  AND c.LastName = 'Welcker'
  AND MONTH(soh.OrderDate) = MONTH(DATEADD(MONTH, -1, GETDATE()))
  AND YEAR(soh.OrderDate) = YEAR(DATEADD(MONTH, -1, GETDATE()));


/***********************************************************************
 METADATA QUESTIONS — SYSTEM INFORMATION SCHEMA
************************************************************************/

-- Q7 (Metadata) — List all tables in the AdventureWorksLT database that contains a column named CustomerID.
-- Author: ME
SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'CustomerID';


-- Q8 (Metadata) — Which columns in the database are using the nvarchar data type? Provide table name and column.
-- Author: ME
SELECT TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE DATA_TYPE = 'nvarchar'
ORDER BY TABLE_SCHEMA, TABLE_NAME;