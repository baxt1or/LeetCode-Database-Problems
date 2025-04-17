-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
    sub.product1_id, 
    i.category AS product1_category,
    sub.customer_count,
    sub.product2_id
FROM ProductInfo i
INNER JOIN (SELECT
   a.product_id AS product1_id,
   b.product_id AS product2_id,
   COUNT(DISTINCT a.user_id) AS customer_count
FROM ProductPurchases a
INNER JOIN ProductPurchases b ON a.user_id = b.user_id AND a.product_id < b.product_id
GROUP BY 1, 2
HAVING COUNT(DISTINCT a.user_id) >= 3) AS sub
ON i.product_id = sub.product1_id)




SELECT
    c.product1_id, 
    c.product2_id,
    c.product1_category, 
    i.category AS product2_category,
    c.customer_count
FROM ProductInfo i 
INNER JOIN cte c ON i.product_id = c.product2_id
ORDER BY c.customer_count DESC, c.product1_id, c.product2_id