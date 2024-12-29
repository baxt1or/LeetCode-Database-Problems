-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
customer_number,
COUNT(order_number) AS total
FROM orders
GROUP BY 1)


SELECT
customer_number
FROM cte 
WHERE total = (SELECT MAX(total) FROM cte)