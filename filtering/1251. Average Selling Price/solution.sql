-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
p.product_id,
ROUND(SUM(p.price * u.units) * 1.0 / SUM(u.units), 2) AS average_price
FROM prices p
INNER JOIN UnitsSold u ON p.product_id = u.product_id
WHERE u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY 1),

products_ids AS (SELECT
DISTINCT product_id
FROM prices)

SELECT
i.product_id, 
COALESCE(c.average_price, 0) AS average_price
FROM products_ids i
LEFT JOIN cte c ON i.product_id = c.product_id