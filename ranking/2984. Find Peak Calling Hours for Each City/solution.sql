-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
*,
DATE_PART('hour', call_time) AS hour,
COUNT(*) OVER(PARTITION BY city, DATE_PART('hour', call_time)) AS total
FROM calls),

cte2 AS (SELECT
city, 
MAX(total) AS max_total
FROM cte
GROUP BY 1)

SELECT
DISTINCT a.city, a.hour AS peak_calling_hour, b.max_total AS number_of_calls
FROM cte a
INNER JOIN cte2 b ON a.city = b.city AND total = max_total
ORDER BY peak_calling_hour DESC, a.city DESC