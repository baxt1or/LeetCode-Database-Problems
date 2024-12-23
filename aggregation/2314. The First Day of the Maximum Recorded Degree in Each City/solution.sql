-- Write your PostgreSQL query statement below
SELECT
city_id, day, degree
FROM (
SELECT
*,
ROW_NUMBER() OVER(PARTITION BY city_id ORDER BY degree DESC, day ) AS rnk
FROM weather) AS sub
WHERE rnk = 1
ORDER BY 1