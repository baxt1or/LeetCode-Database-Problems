-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
*,
CASE WHEN activity_type = 'start' THEN 0 ELSE 1 END AS type
FROM activity
ORDER BY machine_id, process_id, type)


SELECT
machine_id, 
ROUND((SUM(time_spent) * 1.0 / COUNT(DISTINCT process_id))::NUMERIC, 3) AS processing_time
FROM (SELECT
machine_id,
process_id,
timestamp - LAG(CASE WHEN activity_type = 'start' THEN timestamp END) OVER(PARTITION BY machine_id) AS time_spent
FROM cte) AS sub
GROUP BY 1