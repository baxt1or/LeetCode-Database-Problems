WITH cte AS (SELECT 
a.activity_id, a.user_id, a.time_spent,a.activity_type, ag.age_bucket,
SUM(a.time_spent) OVER(PARTITION BY ag.age_bucket) AS total_spent
FROM activities a INNER JOIN age ag ON a.user_id = ag.user_id)

SELECT 
age_bucket,
COALESCE(ROUND(SUM(CASE WHEN activity_type = 'send' THEN time_spent END) / total_spent * 100, 2),0) AS send_perc,
COALESCE(ROUND(SUM(CASE WHEN activity_type = 'open' THEN time_spent END) / total_spent * 100, 2),0) AS open_perc 
FROM cte 
GROUP BY age_bucket, total_spent
ORDER BY age_bucket