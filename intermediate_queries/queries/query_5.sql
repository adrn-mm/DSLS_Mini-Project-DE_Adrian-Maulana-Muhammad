-- Query No. 5
SELECT [Kategori Sales],
	COUNT(OrderID) AS 'Jumlah OrderID'
FROM (
		SELECT Orders.OrderID,
			CASE
				WHEN (
					[Order Details].UnitPrice * [Order Details].Quantity
				) <= 100 THEN 'Dibawah 100'
				WHEN (
					[Order Details].UnitPrice * [Order Details].Quantity
				) > 100
				AND (
					[Order Details].UnitPrice * [Order Details].Quantity
				) <= 250 THEN 'Antara 100-250'
				WHEN (
					[Order Details].UnitPrice * [Order Details].Quantity
				) > 250
				AND (
					[Order Details].UnitPrice * [Order Details].Quantity
				) <= 500 THEN 'Antara 250-500'
				WHEN (
					[Order Details].UnitPrice * [Order Details].Quantity
				) > 500 THEN 'Diatas 500'
			END as "Kategori Sales"
		FROM Orders
			INNER JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
	) AS SalesCategoryTable
GROUP BY [Kategori Sales];