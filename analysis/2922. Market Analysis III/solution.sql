-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
o.seller_id,
COUNT(DISTINCT o.item_id) AS num_items,
DENSE_RANK() OVER(ORDER BY COUNT(DISTINCT o.item_id) DESC) AS rnk
FROM orders o
INNER JOIN users u ON o.seller_id = u.seller_id
INNER JOIN items i ON o.item_id = i.item_id
WHERE u.favorite_brand != i.item_brand
GROUP BY 1
ORDER BY 1)


SELECT
seller_id, num_items
FROM cte
WHERE rnk = 1