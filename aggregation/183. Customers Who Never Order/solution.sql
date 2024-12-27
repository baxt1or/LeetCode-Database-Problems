-- Write your PostgreSQL query statement below
SELECT
c.name AS Customers 
FROM customers c
LEFT JOIN orders o ON c.id = o.customerId
WHERE o.customerId IS NULL