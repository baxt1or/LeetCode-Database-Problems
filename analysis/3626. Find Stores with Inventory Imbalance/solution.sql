-- Write your PostgreSQL query statement below
WITH rnks AS (SELECT
*,
RANK() OVER(PARTITION BY store_id ORDER BY price DESC) AS top_rnk,
RANK() OVER(PARTITION BY store_id ORDER BY price ) AS lowest_rnk
FROM inventory),

filtered_stores AS (SELECT
store_id, 
COUNT(product_name) AS ttl
FROM inventory
GROUP BY 1
HAVING COUNT(product_name) >= 3),

analysis_rnks AS (SELECT
a.store_id, a.product_name, a.quantity, a.price, a.top_rnk, a.lowest_rnk
FROM rnks a
INNER JOIN filtered_stores b ON a.store_id = b.store_id
WHERE a.top_rnk = 1 OR a.lowest_rnk = 1),

ab AS (SELECT
store_id, product_name, quantity
FROM analysis_rnks
WHERE top_rnk = 1),

ac AS (SELECT
store_id, product_name, quantity
FROM analysis_rnks
WHERE lowest_rnk = 1),

final AS (SELECT
a.store_id, 
a.product_name AS most_exp_product, 
b.product_name AS cheapest_product, 
a.quantity * 1.0 AS top,
b.quantity * 1.0 AS low 
FROM ab a
INNER JOIN ac b ON a.store_id = b.store_id)

SELECT
a.store_id, b.store_name, b.location,
a.most_exp_product, a.cheapest_product,
ROUND(a.low / a.top, 2) AS imbalance_ratio
FROM final a
INNER JOIN stores b ON a.store_id = b.store_id
WHERE a.top < low
ORDER BY imbalance_ratio DESC, b.store_name