SELECT
DATE(sale_date) AS sale_date,
SUM(CASE WHEN fruit = 'apples' THEN sold_num END)  -
SUM(CASE WHEN fruit = 'oranges' THEN sold_num END) AS diff
FROM sales
GROUP BY 1
ORDER BY 1