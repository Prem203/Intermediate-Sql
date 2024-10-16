SELECT DISTINCT(Email), LastName
FROM customers c
INNER JOIN invoices i ON c.CustomerId = i.CustomerId
WHERE Email IS NOT NULL
AND LastName IS NOT NULL;