-- Write your PostgreSQL query statement below
SELECT
r.contest_id, 
ROUND(COUNT(u.user_id) * 1.0 / (SELECT COUNT(DISTINCT user_id) FROM users) * 100, 2) AS percentage 
FROM register r
INNER JOIN users u ON r.user_id = u.user_id
GROUP BY 1
ORDER BY 2 DESC, 1