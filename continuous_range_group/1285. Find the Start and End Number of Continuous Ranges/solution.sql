-- Write your PostgreSQL query statement below
SELECT MIN(log_id) AS start_id, MAX(log_id) AS end_id
FROM(SELECT
*,
log_id- ROW_NUMBER() OVER(ORDER BY log_id) AS group_id
FROM logs)
GROUP BY group_id
ORDER BY start_id