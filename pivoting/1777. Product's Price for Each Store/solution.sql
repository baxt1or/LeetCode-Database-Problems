-- Write your PostgreSQL query statement below
WITH cte AS (SELECT product_id, price AS store1  FROM products WHERE store = 'store1'),

cte2 AS (SELECT product_id, price AS store2  FROM products WHERE store = 'store2'),

cte3 AS (SELECT product_id, price AS store3  FROM products WHERE store = 'store3'),

cte4 AS (SELECT DISTINCT product_id FROM products)

SELECT
a.product_id, d.store1, b.store2, c.store3
FROM cte4 a 
FULL OUTER JOIN cte2 b ON a.product_id = b.product_id
FULL OUTER JOIN cte3 C ON a.product_id = c.product_id
FULL OUTER JOIN cte d ON a.product_id = d.product_id
WHERE a.product_id IS NOT NULL