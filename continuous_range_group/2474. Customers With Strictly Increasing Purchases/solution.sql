-- Write your PostgreSQL query statement below
WITH cte AS (
SELECT
customer_id, EXTRACT(YEAR FROM order_date) AS year, 
SUM(price) AS total_amount
FROM orders
GROUP BY 1,2),


cte2 AS (SELECT
*,
LAG(year) OVER(PARTITION BY customer_id ORDER BY year) AS prev,
LAG(total_amount) OVER(PARTITION BY customer_id ORDER BY year) AS prev_amount
FROM cte)

SELECT
    customer_id
FROM cte2
GROUP BY customer_id
HAVING SUM(CASE WHEN year - prev = 1 AND total_amount > prev_amount THEN 1 ELSE 0 END) = COUNT(*) - 1