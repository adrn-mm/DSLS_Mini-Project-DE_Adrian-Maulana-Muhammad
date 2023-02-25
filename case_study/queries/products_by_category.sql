-- Query of Analysis of Product Sales by Category
WITH category_sales AS (
    SELECT Categories.CategoryName,
        SUM([Order Details].Quantity) as QuantitySold,
        SUM(
            [Order Details].Quantity * [Order Details].UnitPrice
        ) as Revenue
    FROM Products
        JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
        JOIN Categories ON Products.CategoryID = Categories.CategoryID
    GROUP BY Categories.CategoryName
)
SELECT CategoryName,
    QuantitySold,
    Revenue
FROM category_sales
WHERE QuantitySold > (
        SELECT AVG(QuantitySold)
        FROM category_sales
    )