-- Write your PostgreSQL query statement below
SELECT
product_id, 
first_year, 
quantity, 
price 
FROM (SELECT
*,
MIN(year) OVER(PARTITION BY product_id ORDER BY year) AS first_year
FROM sales
) AS sub
WHERE year = first_year