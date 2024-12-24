-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
seller_id,
CASE WHEN favorite_brand = item_brand THEN 'yes' ELSE 'no' END AS type
FROM (SELECT
o.seller_id, u.favorite_brand, o.item_id, i.item_brand,
ROW_NUMBER() OVER(PARTITION BY o.seller_id ORDER BY o.order_date) AS rnk
FROM orders o
INNER JOIN users u ON o.seller_id = u.user_id
INNER JOIN items i ON o.item_id = i.item_id) AS sub
WHERE rnk = 2),

users_table AS (SELECT DISTINCT user_id FROM users)

SELECT
u.user_id AS seller_id, 
COALESCE(c.type,'no') AS "2nd_item_fav_brand"
FROM users_table u 
LEFT JOIN cte c ON u.user_id = c.seller_id