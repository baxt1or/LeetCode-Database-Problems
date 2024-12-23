-- Write your PostgreSQL query statement below
SELECT
COALESCE(ROUND(AVG(total_sessions) , 2), 0) AS average_sessions_per_user
FROM (SELECT
user_id, 
COUNT(DISTINCT session_id) AS total_sessions
FROM activity
WHERE activity_date >= '2019-06-28' AND activity_date <= '2019-07-27' 
GROUP BY 1) AS sub