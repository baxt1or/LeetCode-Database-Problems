-- Write your PostgreSQL query statement below
SELECT
s.user_id, 
ROUND(COALESCE(COUNT(CASE WHEN c.action='confirmed' THEN 1 END) * 1.0 /
NULLIF(COUNT(c.action), 0), 0), 2) AS confirmation_rate
FROM signups s 
LEFT JOIN confirmations c ON s.user_id = c.user_id
GROUP BY 1