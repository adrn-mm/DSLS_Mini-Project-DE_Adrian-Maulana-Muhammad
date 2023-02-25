-- Procedure No.9
CREATE PROCEDURE Invoice (@customerID INT) AS BEGIN
SELECT Customers.CustomerID,
    CONCAT(
        Customers.ContactName,
        ' / ',
        Customers.CompanyName
    ) AS 'CustomerName/CompanyName',
    Orders.OrderID,
    Orders.OrderDate,
    Orders.RequiredDate,
    Orders.ShippedDate
FROM Customers
    INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Customers.CustomerID = @customerID
END