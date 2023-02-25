-- Query No. 3
SELECT TOP 5 Orders.OrderDate,
    [Order Details].Quantity,
    Products.ProductName
FROM Orders
    INNER JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
    INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
WHERE YEAR(OrderDate) = 1997
    AND MONTH(OrderDate) = 1
ORDER BY Quantity DESC;