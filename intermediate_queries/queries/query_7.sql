-- Query No. 7
WITH MonthlySales AS (
	SELECT Products.ProductName,
		MONTH(Orders.OrderDate) AS Month,
		SUM(
			[Order Details].UnitPrice * [Order Details].Quantity
		) AS 'TotalSales'
	FROM Orders
		JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
		JOIN Products ON Products.ProductID = [Order Details].ProductID
	WHERE YEAR(OrderDate) = 1997
	GROUP BY MONTH(OrderDate),
		ProductName
)
SELECT Month,
	ProductName,
	Rank
FROM (
		SELECT *,
			ROW_NUMBER() OVER (
				PARTITION BY Month
				Order By TotalSales DESC
			) AS Rank
		FROM MonthlySales
	) AS MonthlyRankTable
WHERE Rank <= 5;