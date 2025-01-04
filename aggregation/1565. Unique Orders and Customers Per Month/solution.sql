-- Write your PostgreSQL query statement below
SELECT
TO_CHAR(order_date, 'YYYY-MM') AS month,
COUNT(DISTINCT order_id) AS order_count,
COUNT(DISTINCT customer_id) AS customer_count
FROM orders
WHERE invoice > 20
GROUP BY month