-- Write your PostgreSQL query statement below
SELECT
interval_no, 
SUM(order_count) AS total_orders
FROM (SELECT
*,
CEIL(minute/6) AS interval_no
FROM orders) AS sub
GROUP BY 1
ORDER BY 1