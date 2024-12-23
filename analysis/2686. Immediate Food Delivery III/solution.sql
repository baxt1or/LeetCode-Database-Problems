-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
*,
CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END AS status
FROM delivery)

SELECT
order_date, 
ROUND(COALESCE(NULLIF(COUNT(CASE WHEN status = 1 THEN 1 END), 0) * 1.0 /COUNT(*) * 100, 0), 2) AS immediate_percentage
FROM cte
GROUP BY 1
ORDER BY 1