--Query of Analysis of The Busiest Shippers
SELECT Shippers.CompanyName,
    COUNT(Orders.OrderID) AS NumberOfOrders
FROM Orders
    INNER JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
GROUP BY Shippers.CompanyName
ORDER BY NumberOfOrders DESC