-- Query No. 6
SELECT *
FROM (
        SELECT Customers.CompanyName,
            SUM(
                [Order Details].UnitPrice * [Order Details].Quantity
            ) AS 'TotalSales'
        FROM Orders
            INNER JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
            INNER JOIN Customers ON Customers.CustomerID = Orders.CustomerID
        WHERE YEAR(OrderDate) = 1997
        GROUP BY CompanyName
    ) AS CompanyNameTotalSales
WHERE TotalSales > 500;