-- Query of Analysis of Average Delivery Time per Shipper
WITH deliveries AS (
    SELECT Shippers.CompanyName AS Shipper,
        DATEDIFF(day, Orders.OrderDate, Orders.ShippedDate) AS DeliveryTime
    FROM Orders
        JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
)
SELECT Shipper,
    AVG(DeliveryTime) AS AverageDeliveryTime
FROM deliveries
GROUP BY Shipper