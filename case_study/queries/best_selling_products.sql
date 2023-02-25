-- Query of Analysis of The Best Selling Products
WITH Product_Sales AS (
    SELECT Products.ProductID,
        Products.ProductName,
        SUM(Quantity) AS Total_Quantity_Sold
    FROM Orders
        INNER JOIN [Order Details] ON Orders.OrderID = [Order Details].OrderID
        INNER JOIN Products ON [Order Details].ProductID = Products.ProductID
    WHERE ShippedDate IS NOT NULL
    GROUP BY Products.ProductID,
        Products.ProductName
)
SELECT ProductID,
    ProductName,
    Total_Quantity_Sold,
    ROW_NUMBER() OVER (
        ORDER BY Total_Quantity_Sold DESC
    ) AS Rank
FROM Product_Sales