-- Write your PostgreSQL query statement below
WITH sold AS (SELECT
p.product_id, p.product_name
FROM sales s
INNER JOIN product p ON s.product_id = p.product_id
WHERE sale_date BETWEEN '2019-01-01' AND '2019-03-31'),

not_sold AS (SELECT
p.product_id, p.product_name
FROM sales s
INNER JOIN product p ON s.product_id = p.product_id
WHERE sale_date NOT BETWEEN '2019-01-01' AND '2019-03-31')


SELECT
DISTINCT s.*
FROM sold s
LEFT JOIN not_sold n ON s.product_id = n.product_id
WHERE n.product_id IS NULL