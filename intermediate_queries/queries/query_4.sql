-- Query No. 4
SELECT Orders.OrderDate,
    Products.ProductName,
    Customers.CompanyName
FROM Orders
    INNER JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
    INNER JOIN Products ON Products.ProductID = [Order Details].ProductID
    INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE YEAR(OrderDate) = 1997
    AND MONTH(OrderDate) = 6
    AND ProductName LIKE '%Chai%';