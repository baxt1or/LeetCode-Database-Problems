WITH cte AS (SELECT
*,
ROW_NUMBER() OVER(ORDER BY salary) AS rn
FROM candidates
WHERE experience = 'Senior'
ORDER BY salary),

cte2 AS (SELECT
*,
SUM(salary) OVER(ORDER BY rn) AS cum_sum
FROM cte),


seniors AS (SELECT
*
FROM cte2
WHERE cum_sum <= 70000),



cte3 AS (SELECT
*,
ROW_NUMBER() OVER(ORDER BY salary) AS rn
FROM candidates
WHERE experience = 'Junior'
ORDER BY salary),


cte4 AS (SELECT
*,
SUM(salary) OVER(ORDER BY rn) AS cum_sum
FROM cte3)



SELECT 
DISTINCT employee_id
FROM seniors
UNION ALL
SELECT
DISTINCT employee_id
FROM cte4
WHERE cum_sum <= 70000 - COALESCE((SELECT cum_sum FROM seniors ORDER BY cum_sum DESC LIMIT 1), 0)