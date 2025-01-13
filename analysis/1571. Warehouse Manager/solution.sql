-- Write your PostgreSQL query statement below
SELECT 
name AS warehouse_name, 
SUM(volume) AS volume FROM (SELECT 
*,w.units * (p.Width*p.Length*p.Height) AS volume
FROM warehouse w 
INNER JOIN products p ON w.product_id = p.product_id) AS sub_query
GROUP BY 1
