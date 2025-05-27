-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
s.sale_id, 
s.product_id, 
s.quantity * s.price AS total,
s.quantity,
p.category,
CASE 
    WHEN TO_CHAR(s.sale_date, 'MM') IN ('12', '01', '02') THEN 'Winter' 
    WHEN TO_CHAR(s.sale_date, 'MM') IN ('03', '04', '05') THEN 'Spring' 
    WHEN TO_CHAR(s.sale_date, 'MM') IN ('06', '07', '08') THEN 'Summer' 
    WHEN TO_CHAR(s.sale_date, 'MM') IN ('09', '10', '11') THEN 'Fall' 
END AS season
FROM sales s
LEFT JOIN products p ON s.product_id = p.product_id),


final_analysis AS (SELECT
category, 
season, 
SUM(quantity) AS total_quantity, 
SUM(total) AS total_revenue
FROM cte
GROUP BY 1,2)


SELECT
season, category, total_quantity, total_revenue
FROM (SELECT
season, category, total_quantity, total_revenue,
DENSE_RANK() OVER(PARTITION BY season ORDER BY total_quantity DESC, total_revenue DESC) AS rnk
FROM final_analysis) AS sub
WHERE rnk = 1