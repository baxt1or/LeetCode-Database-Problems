WITH cte AS (SELECT
o.customer_id,
c.name,
EXTRACT(MONTH FROM o.order_date)::INTEGER AS month,
SUM(o.quantity * p.price) AS amount
FROM orders o 
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN product p ON o.product_id = p.product_id
WHERE order_date BETWEEN '2020-06-01' AND '2020-07-31'
GROUP BY 1, 2,3
HAVING SUM(o.quantity * p.price) >= 100)

SELECT
customer_id, 
name
FROM cte
GROUP BY 1, 2
HAVING COUNT(DISTINCT month) >= 2