WITH cte AS (SELECT
*,
SUM(salary) OVER(ORDER BY rn) AS cum_sum
FROM (SELECT
*,
ROW_NUMBER() OVER(ORDER BY salary) AS rn
FROM candidates
WHERE experience = 'Senior' 
ORDER BY salary) AS sub),


cte2 AS (SELECT
*
FROM cte
WHERE cum_sum <= 70000),


cte3 AS (SELECT
*,
SUM(salary) OVER(ORDER BY rn) AS cum_sum
FROM (SELECT
*,
ROW_NUMBER() OVER(ORDER BY salary) AS rn
FROM candidates
WHERE experience = 'Junior' 
ORDER BY salary) AS sub),



final AS (SELECT
DISTINCT experience, COUNT(*) AS accepted_candidates
FROM cte3
WHERE cum_sum <= 70000 - COALESCE((SELECT cum_sum FROM cte2 ORDER BY cum_sum DESC LIMIT 1),0)
UNION ALL
SELECT DISTINCT experience, COUNT(*)
FROM cte2),



frame AS (SELECT 'Senior' AS experience
UNION ALL
SELECT 'Junior' AS experience)


SELECT
f.experience, 
COALESCE(l.accepted_candidates, 0) AS accepted_candidates
FROM frame f
FULL OUTER JOIN final l ON f.experience = l.experience
