-- Write your PostgreSQL query statement below
WITH cte AS (SELECT fail_date AS date,'failed' AS status
FROM failed
UNION ALL
SELECT *,'succeeded' AS status FROM succeeded
ORDER BY date),

cte2 AS (SELECT
*,
ROW_NUMBER() OVER(ORDER BY date) - ROW_NUMBER() OVER(PARTITION BY status ORDER BY date) AS group_id
FROM cte
WHERE date >= '2019-01-01' AND date <= '2019-12-31')


SELECT
status AS period_state,
MIN(date) AS start_date,
MAX(date) AS end_date
FROM cte2
GROUP BY group_id, status
ORDER BY start_date