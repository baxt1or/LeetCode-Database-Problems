--Solution 1:
WITH cte AS (SELECT
*,
LAG(recordDate) OVER(ORDER BY recordDate) AS prev_date,
LAG(temperature) OVER(ORDER BY recordDate) AS prev_temp
FROM weather)

SELECT
id
FROM cte
WHERE recordDate - prev_date = 1 AND temperature > prev_temp


--Solution 2:
WITH cte AS (SELECT
*,
CAST(recordDate - INTERVAL '1 days' AS DATE) AS minus_one
FROM weather)


SELECT
c.id
FROM cte c
LEFT JOIN Weather w  ON w.recordDate = c.minus_one 
WHERE w.temperature < c.temperature
