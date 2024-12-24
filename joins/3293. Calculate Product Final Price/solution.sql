-- Write your PostgreSQL query statement below
SELECT
p.product_id, 
p.price * (100 - COALESCE(d.discount,0)*1.0) /100 AS final_price,
p.category
FROM products p
LEFT JOIN discounts d ON d.category = p.category
ORDER BY p.product_id