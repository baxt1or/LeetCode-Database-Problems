-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
customer_id, 
product_id, 
COUNT(*) AS freq
FROM orders
GROUP BY 1, 2)


SELECT
c.customer_id, c.product_id, p.product_name
FROM cte c
INNER JOIN products p ON p.product_id = c.product_id
WHERE freq = (SELECT MAX(freq) FROM cte WHERE customer_id = c.customer_id)