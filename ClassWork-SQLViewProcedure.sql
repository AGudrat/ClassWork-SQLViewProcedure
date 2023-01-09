CREATE DATABASE ElovsetMMC

CREATE TABLE Employees(
	Id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	FirstName nvarchar(255) NOT NULL,
	LastName nvarchar(255) NOT NULL,
	MiddleName nvarchar(255) NOT NULL,
	PositionId int FOREIGN KEY REFERENCES Position(Id),
	Salary decimal NOT NULL

);

CREATE TABLE Position(
	Id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	PositionName nvarchar(255) NOT NULL
);

CREATE TABLE Branch(
	Id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	BranchName nvarchar(255) NOT NULL
);

CREATE TABLE Product(
	Id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Name nvarchar(255) NOT NULL,
	UnitPrice decimal NOT NULL,
);

CREATE TABLE Orders(
	ProductId int FOREIGN KEY REFERENCES Product(Id),
	EmployeeId int FOREIGN KEY REFERENCES Employees(Id),
	OrderedTime DateTime NOT NULL,
	BranchId int FOREIGN KEY REFERENCES Branch(Id),
	SalePrice decimal NOT NULL,

);

--AllSales
CREATE VIEW AllSales
AS
SELECT SUM(SalePrice) AS AllSales FROM Orders


SELECT * FROM AllSales

--AllSales in CurrentMonth

CREATE VIEW AllSalesInCurrentMonth
AS
SELECT SUM(SalePrice) AS AllSales from Orders as O WHERE MONTH(O.OrderedTime) + YEAR(O.OrderedTime) = MONTH(GETDATE()) + YEAR(GETDATE())


--Sales for Employees
CREATE VIEW SalesForEmployees
AS
SELECT E.FirstName, Count(O.ProductId) AS AllSales FROM Orders as O 
join Employees as E on O.EmployeeId = E.Id
GROUP BY E.FirstName

--AllSales for Company in CurrentMonth

CREATE VIEW AllSalesForComponayInCurrentDay
AS
SELECT TOP 1 B.BranchName, Count(O.ProductId) AS AllSales FROM Orders as O 
join Branch as B on O.BranchId = B.Id
WHERE DAY(O.OrderedTime) + YEAR(O.OrderedTime) + MONTH(O.OrderedTime) = DAY(GETDATE()) + YEAR(GETDATE()) + MONTH(GETDATE())
GROUP BY B.BranchName

--Most Saled Product In Current Month
ALTER VIEW MostSaledProductInCurrentMonth
AS
SELECT TOP 1 P.Name,COUNT(O.ProductId) AS AllSales from Orders as O 
join Product as P on P.Id = O.ProductId
WHERE MONTH(O.OrderedTime) + YEAR(O.OrderedTime) = MONTH(GETDATE()) + YEAR(GETDATE())
GROUP BY P.Name




