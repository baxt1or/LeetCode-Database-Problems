WITH cte AS (SELECT
*,
LAG(id) OVER(ORDER BY visit_date) AS prev
FROM stadium
WHERE people >= 100
ORDER BY id, visit_date),

cte2 AS (SELECT
*,
CASE WHEN id - prev = 1 THEN 0 ELSE 1 END AS grp
FROM cte),

cte3 AS (SELECT
*,
SUM(grp) OVER(ORDER BY visit_date) AS grp_id
FROM cte2),

cte4 AS (SELECT
grp_id
FROM cte3
GROUP BY 1
HAVING COUNT(*) >= 3)

SELECT
b.id, b.visit_date, b.people
FROM cte4 a
LEFT JOIN cte3 b ON a.grp_id = b.grp_id
ORDER BY b.visit_date ASC