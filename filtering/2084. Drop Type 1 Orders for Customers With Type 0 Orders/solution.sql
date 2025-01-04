WITH cte AS (SELECT
*,
COUNT(CASE WHEN order_type = 0 THEN 1 END) OVER(PARTITION BY customer_id ) AS status
FROM orders)


SELECT
order_id, customer_id, order_type
FROM cte
WHERE status = 0
UNION ALL
SELECT 
order_id, customer_id,order_type
FROM cte WHERE order_type = 0 