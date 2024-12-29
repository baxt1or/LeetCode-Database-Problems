-- Write your PostgreSQL query statement below
SELECT
DISTINCT e.user_id
FROM texts t 
INNER JOIN emails e ON t.email_id = e.email_id
WHERE t.action_date - e.signup_date = 1 AND t.signup_action = 'Verified'
ORDER BY 1