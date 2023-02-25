-- Query of Analysis of The Most Frequent Customers by Number of Orders
WITH CustomerOrderCount AS (
    SELECT CustomerID,
        COUNT(OrderID) AS OrderCount
    FROM Orders
    GROUP BY CustomerID
)
SELECT TOP 10 Customers.CompanyName,
    CustomerOrderCount.OrderCount
FROM Customers
    JOIN CustomerOrderCount ON Customers.CustomerID = CustomerOrderCount.CustomerID
WHERE CustomerOrderCount.OrderCount > (
        SELECT AVG(OrderCount)
        FROM CustomerOrderCount
    )
ORDER BY CustomerOrderCount.OrderCount DESC