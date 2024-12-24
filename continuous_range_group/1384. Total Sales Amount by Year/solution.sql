-- Write your PostgreSQL query statement below
WITH cte AS (SELECT 
    s.*,
    g.date
FROM 
    sales s,
    LATERAL GENERATE_SERIES(
        s.period_start,
        s.period_end,
        '1 day'::INTERVAL
    ) AS g(date)),

cte2 AS (SELECT
product_id,
EXTRACT(YEAR FROM date) AS year,
COUNT(*) AS days
FROM cte
GROUP BY 1, 2
ORDER BY product_id),

cte3 AS (SELECT
c.*, c.days * s.average_daily_sales AS total_amount
FROM cte2 c
INNER JOIN sales s ON c.product_id = s.product_id
ORDER BY c.product_id, c.year)


SELECT
p.product_id, p.product_name, c.year::TEXT AS report_year, c.total_amount
FROM cte3 c
INNER JOIN Product p ON c.product_id = p.product_id