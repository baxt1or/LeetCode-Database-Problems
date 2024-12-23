-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
c.name AS customer_name, c.customer_id,o.order_id,o.order_date,
ROW_NUMBER() OVER(PARTITION BY c.customer_id ORDER BY o.order_date DESC) AS count
FROM orders o 
INNER JOIN customers c ON o.customer_id = c.customer_id
GROUP BY 1, 2, 3, 4)


SELECT
customer_name, customer_id, order_id, order_date
FROM cte
WHERE count <=3
ORDER BY customer_name, customer_id, order_date DESC