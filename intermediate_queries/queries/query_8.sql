-- View No. 8
CREATE VIEW OrderDetailsView AS
SELECT Products.ProductID,
	Products.ProductName,
	[Order Details].OrderID,
	[Order Details].UnitPrice,
	[Order Details].Quantity,
	[Order Details].Discount,
	(
		[Order Details].UnitPrice * [Order Details].Quantity
	) - (
		[Order Details].UnitPrice * [Order Details].Quantity * [Order Details].Discount
	) AS 'Harga setelah diskon'
FROM [Order Details]
	JOIN Products ON Products.ProductID = [Order Details].ProductID;