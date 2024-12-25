WITH cte AS (SELECT 
*,
COUNT(candidate) OVER(PARTITION BY voter) AS votes
FROM votes),

cte2 AS (SELECT 
*,
CASE WHEN votes >1 THEN 1.0 / votes ELSE votes END AS total
FROM cte)

SELECT candidate
FROM (SELECT
candidate,
DENSE_RANK() OVER(ORDER BY SUM(total) DESC) AS ranking
FROM cte2
WHERE candidate IS NOT NULL
GROUP BY candidate) AS sub
WHERE ranking = 1
ORDER BY candidate