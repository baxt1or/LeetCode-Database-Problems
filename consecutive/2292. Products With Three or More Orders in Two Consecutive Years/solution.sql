-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
order_id, product_id, quantity, EXTRACT(YEAR FROM purchase_date) AS year
FROM orders
ORDER BY product_id, year),

cte3 AS (SELECT
product_id, year
FROM cte
GROUP BY 1, 2
HAVING COUNT(order_id) >= 3),

cte4 AS (SELECT
*,
LAG(year) OVER(PARTITION BY product_id ORDER BY year) AS prev_year
FROM cte3 a )

SELECT
DISTINCT product_id
FROM cte4
WHERE year - prev_year = 1