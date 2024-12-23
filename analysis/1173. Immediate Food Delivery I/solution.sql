-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
*,
CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END AS status
FROM delivery)

SELECT
ROUND(COUNT(*) * 1.0 / (SELECT COUNT(*) FROM cte) *100, 2) AS immediate_percentage
FROM cte
WHERE status = 1