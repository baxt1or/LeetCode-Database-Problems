-- Write your PostgreSQL query statement below
WITH cte AS (
SELECT DISTINCT l.id, a.name,l.login_date
FROM logins l 
INNER JOIN accounts a ON l.id = a.id
ORDER BY l.id, l.login_date
),


cte2 AS (SELECT
*,
CASE WHEN login_date- LAG(login_date) OVER(PARTITION BY id ORDER BY login_date) =1 THEN 0 ELSE 1 END AS gap
FROM cte),

cte3 AS (SELECT
*,
SUM(gap) OVER(PARTITION BY id ORDER BY login_date) AS group_id
FROM cte2)

SELECT
DISTINCT id, name
FROM cte3
GROUP BY id, name, group_id
HAVING COUNT(*) >= 5
ORDER BY id