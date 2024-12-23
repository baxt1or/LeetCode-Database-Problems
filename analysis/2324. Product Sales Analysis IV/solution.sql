-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
s.user_id,
p.product_id, 
SUM(p.price * s.quantity) AS amount
FROM sales s
INNER JOIN product p ON s.product_id = p.product_id
GROUP BY 1,2)

SELECT
user_id, product_id
FROM (SELECT
*,
DENSE_RANK() OVER(PARTITION BY user_id ORDER BY amount DESC) AS rn
FROM cte)
WHERE rn = 1