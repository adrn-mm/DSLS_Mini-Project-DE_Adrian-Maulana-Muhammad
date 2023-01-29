-- Query No. 1
SELECT MONTH(OrderDate) AS OrderMonth,
COUNT(DISTINCT CustomerID) AS CostumerCount
FROM Orders
WHERE YEAR(OrderDate) = 1997
GROUP BY MONTH(OrderDate);

-- Query No. 2
SELECT CONCAT(FirstName, ' ', LastName) AS EmployeeName, Title
FROM Employees
WHERE Title = 'Sales Representative';

-- Query No. 3
SELECT
TOP 5
Orders.OrderDate,
[Order Details].Quantity,
Products.ProductName
FROM Orders
INNER JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
WHERE YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 1
ORDER BY Quantity DESC;

-- Query No. 4
SELECT 
Orders.OrderDate,
Products.ProductName,
Customers.CompanyName
FROM Orders
INNER JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Products ON Products.ProductID = [Order Details].ProductID
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 6 
AND ProductName LIKE '%Chai%';

-- Query No. 5
SELECT 
[Kategori Sales],
COUNT(OrderID) AS 'Jumlah OrderID'
FROM
(
SELECT Orders.OrderID,
	CASE 
		WHEN ([Order Details].UnitPrice * [Order Details].Quantity) <= 100 THEN 'Dibawah 100'
		WHEN ([Order Details].UnitPrice * [Order Details].Quantity) > 100
			AND ([Order Details].UnitPrice * [Order Details].Quantity) <= 250 THEN 'Antara 100-250'
		WHEN ([Order Details].UnitPrice * [Order Details].Quantity) > 250
			AND ([Order Details].UnitPrice * [Order Details].Quantity) <= 500 THEN 'Antara 250-500'
		WHEN ([Order Details].UnitPrice * [Order Details].Quantity) > 500 THEN 'Diatas 500'
	END as "Kategori Sales"
FROM Orders
INNER JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
) AS SalesCategoryTable
GROUP BY [Kategori Sales];

-- Query No. 6
SELECT * FROM (
SELECT
Customers.CompanyName,
SUM([Order Details].UnitPrice * [Order Details].Quantity) AS 'TotalSales'
FROM Orders
INNER JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
INNER JOIN Customers ON Customers.CustomerID = Orders.CustomerID
WHERE YEAR(OrderDate) = 1997 
GROUP BY CompanyName
) AS CompanyNameTotalSales
WHERE TotalSales > 500;

-- Query No. 7
WITH MonthlySales AS (
	SELECT  
		Products.ProductName,
		MONTH(Orders.OrderDate) AS Month, 
		SUM([Order Details].UnitPrice * [Order Details].Quantity) AS 'TotalSales'
	FROM Orders
	JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
	JOIN Products ON Products.ProductID = [Order Details].ProductID
	WHERE YEAR(OrderDate) = 1997
	GROUP BY MONTH(OrderDate), ProductName
	)
SELECT 
	Month, 
	ProductName, 
	Rank 
	FROM (
		SELECT 
			*,
			ROW_NUMBER() OVER (PARTITION BY Month Order By TotalSales DESC) AS Rank
		FROM MonthlySales
	) AS MonthlyRankTable
WHERE Rank <= 5;

-- View No. 8
CREATE VIEW OrderDetailsView AS
SELECT 
	Products.ProductID,
	Products.ProductName,
	[Order Details].OrderID,
	[Order Details].UnitPrice,
	[Order Details].Quantity, [Order Details].Discount,
	([Order Details].UnitPrice
	* [Order Details].Quantity)
	- ([Order Details].UnitPrice
	* [Order Details].Quantity
	* [Order Details].Discount) AS 'Harga setelah diskon'
FROM [Order Details]
JOIN Products ON Products.ProductID = [Order Details].ProductID;

-- Procedure No.9
CREATE PROCEDURE Invoice (@customerID INT)
AS
BEGIN
SELECT
Customers.CustomerID,
CONCAT(Customers.ContactName, ' / ', Customers.CompanyName) AS 'CustomerName/CompanyName',
Orders.OrderID,
Orders.OrderDate,
Orders.RequiredDate,
Orders.ShippedDate
FROM Customers
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.CustomerID = @customerID
END