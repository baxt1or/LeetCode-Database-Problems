-- Write your PostgreSQL query statement below
SELECT
s.user_id, 
SUM(p.price * s.quantity) AS spending
FROM sales s
INNER JOIN product p ON s.product_id = p.product_id
GROUP BY 1
ORDER BY spending DESC, s.user_id