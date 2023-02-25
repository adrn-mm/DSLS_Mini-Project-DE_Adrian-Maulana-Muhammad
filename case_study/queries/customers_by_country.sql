-- Query of Analysis of Customer Spending by Country
WITH CountryRevenue AS(
    SELECT Customers.Country,
        SUM(
            [Order Details].Quantity * [Order Details].UnitPrice
        ) as Revenue
    FROM Customers
        JOIN Orders ON Customers.CustomerID = Orders.CustomerID
        JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
    GROUP BY Country
)
SELECT *
FROM CountryRevenue
WHERE Revenue > (
        SELECT AVG(Revenue)
        FROM CountryRevenue
    )