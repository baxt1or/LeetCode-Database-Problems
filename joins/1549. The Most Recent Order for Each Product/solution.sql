-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
p.product_name,
p.product_id, 
o.order_id,
o.order_date, 
MAX(o.order_date) OVER(PARTITION BY p.product_name ) AS recent_order
FROM orders o 
INNER JOIN customers c ON c.customer_id = o.customer_id
INNER JOIN products p ON o.product_id = p.product_id
ORDER BY 1, 2,3)


SELECT
product_name, product_id,order_id,  order_date
FROM cte
WHERE order_date = recent_order