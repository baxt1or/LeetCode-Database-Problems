-- Write your PostgreSQL query statement below
WITH active_users AS (SELECT
   user_id
FROM UserActivity
WHERE activity_type IN ('free_trial', 'paid')
GROUP BY 1
HAVING  COUNT(DISTINCT activity_type) > 1)

SELECT
    u.user_id, 
    ROUND(AVG(CASE WHEN u.activity_type = 'free_trial' THEN u.activity_duration END), 2) AS trial_avg_duration,
    ROUND(AVG(CASE WHEN u.activity_type = 'paid' THEN u.activity_duration END), 2) AS paid_avg_duration
FROM UserActivity u
INNER JOIN active_users a ON u.user_id = a.user_id
GROUP BY 1
ORDER BY 1