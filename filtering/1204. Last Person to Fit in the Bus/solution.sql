WITH cte AS (SELECT
*,
SUM(weight) OVER(ORDER BY turn) AS cum_sum
FROM queue)


SELECT
person_name 
FROM (SELECT
*
FROM cte
WHERE cum_sum <= 1000
ORDER BY cum_sum DESC) AS sub
LIMIT 1