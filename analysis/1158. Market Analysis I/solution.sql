-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
user_id, 
MIN(join_date) AS join_date
FROM users
GROUP BY 1),

cte2 AS (SELECT
buyer_id,
COUNT(order_id) AS total
FROM orders
WHERE EXTRACT(YEAR FROM order_date) = '2019'
GROUP BY 1)


SELECT
a.user_id AS buyer_id, 
a.join_date, 
COALESCE(b.total, 0) AS orders_in_2019 
FROM cte a 
LEFT JOIN cte2 b ON a.user_id = b.buyer_id