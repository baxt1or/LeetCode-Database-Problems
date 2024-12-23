-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
*,
CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END AS status,
MIN(order_date) OVER(PARTITION BY customer_id ORDER BY order_date) AS first_order
FROM delivery)

SELECT
ROUND((SELECT
COUNT(*)
FROM cte
WHERE order_date = first_order AND status = 1) * 1.0/ COUNT(DISTINCT customer_id) * 100, 2) AS immediate_percentage
FROM cte