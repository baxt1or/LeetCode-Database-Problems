-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
sales_id
FROM orders o 
INNER JOIN company c ON o.com_id = c.com_id
WHERE c.name = 'RED')

SELECT
p.name
FROM SalesPerson p
LEFT JOIN cte c ON p.sales_id = c.sales_id
WHERE c.sales_id IS NULL