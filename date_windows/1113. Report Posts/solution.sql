-- Write your PostgreSQL query statement below
SELECT
extra AS report_reason, 
COUNT(*) AS report_count
FROM (SELECT
DISTINCT post_id, extra
FROM actions
WHERE DATE(action_date) >= DATE('2019-07-05') - INTERVAL '1 day' AND action = 'report') AS sub
GROUP BY 1