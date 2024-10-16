SELECT State, COUNT(DISTINCT CustomerId) AS TotalCustomers
FROM customers
WHERE State IS NOT NULL
AND CustomerId IS NOT NULL
GROUP BY State
ORDER BY State;