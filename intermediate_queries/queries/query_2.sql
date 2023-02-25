-- Query No. 2
SELECT CONCAT(FirstName, ' ', LastName) AS EmployeeName,
    Title
FROM Employees
WHERE Title = 'Sales Representative';