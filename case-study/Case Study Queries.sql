-- Query of Analysis of Product Sales by Category
WITH category_sales AS (
    SELECT 
        Categories.CategoryName, 
        SUM([Order Details].Quantity) as QuantitySold, 
        SUM([Order Details].Quantity*[Order Details].UnitPrice) as Revenue
    FROM 
        Products 
    JOIN 
        [Order Details] ON Products.ProductID = [Order Details].ProductID
    JOIN 
        Categories ON Products.CategoryID = Categories.CategoryID
    GROUP BY 
        Categories.CategoryName
)
SELECT 
    CategoryName,
    QuantitySold,
    Revenue
FROM 
    category_sales
WHERE 
    QuantitySold > (SELECT AVG(QuantitySold) FROM category_sales)


-- Query of Analysis of The Best Selling Products
WITH Product_Sales AS (
  SELECT 
    Products.ProductID, 
	Products.ProductName,
    SUM(Quantity) AS Total_Quantity_Sold
  FROM 
    Orders
  INNER JOIN 
	[Order Details] ON Orders.OrderID = [Order Details].OrderID
  INNER JOIN
	Products ON [Order Details].ProductID = Products.ProductID
  WHERE 
    ShippedDate IS NOT NULL
  GROUP BY 
    Products.ProductID, Products.ProductName
)
SELECT 
  ProductID, 
  ProductName,
  Total_Quantity_Sold,
  ROW_NUMBER() OVER (ORDER BY Total_Quantity_Sold DESC) AS Rank
FROM 
  Product_Sales


-- Query of Analysis of Customer Spending by Country
WITH CountryRevenue AS(
SELECT 
	Customers.Country,
	SUM([Order Details].Quantity*[Order Details].UnitPrice) as Revenue
FROM Customers 
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
GROUP BY Country)
SELECT * FROM CountryRevenue
WHERE Revenue > (SELECT AVG(Revenue) FROM CountryRevenue)


-- Query of Analysis of The Most Frequent Customers by Number of Orders
WITH CustomerOrderCount AS (
SELECT
	CustomerID,
	COUNT(OrderID) AS OrderCount
FROM Orders
GROUP BY CustomerID
)
SELECT TOP 10
	Customers.CompanyName,
	CustomerOrderCount.OrderCount
FROM Customers
JOIN CustomerOrderCount ON Customers.CustomerID = CustomerOrderCount.CustomerID
WHERE
CustomerOrderCount.OrderCount > (SELECT AVG(OrderCount) FROM CustomerOrderCount)
ORDER BY
CustomerOrderCount.OrderCount DESC


-- Query of Analysis of Average Delivery Time per Shipper
WITH deliveries AS (
  SELECT 
    Shippers.CompanyName AS Shipper,
    DATEDIFF(day, Orders.OrderDate, Orders.ShippedDate) AS DeliveryTime
  FROM Orders
  JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
)
SELECT 
  Shipper,
  AVG(DeliveryTime) AS AverageDeliveryTime
FROM deliveries
GROUP BY Shipper


--Query of Analysis of The Busiest Shippers
SELECT 
  Shippers.CompanyName, 
  COUNT(Orders.OrderID) AS NumberOfOrders
FROM 
  Orders 
  INNER JOIN Shippers 
  ON Orders.ShipVia = Shippers.ShipperID
GROUP BY 
  Shippers.CompanyName
ORDER BY 
  NumberOfOrders DESC