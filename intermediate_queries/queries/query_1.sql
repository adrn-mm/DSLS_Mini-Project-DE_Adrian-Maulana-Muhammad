-- Query No. 1
SELECT MONTH(OrderDate) AS OrderMonth,
    COUNT(DISTINCT CustomerID) AS CostumerCount
FROM Orders
WHERE YEAR(OrderDate) = 1997
GROUP BY MONTH(OrderDate);