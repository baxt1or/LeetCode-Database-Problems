WITH cte AS (SELECT 
user_id,
MIN(CASE WHEN activity = 'login' THEN activity_date END) as first
FROM traffic
GROUP BY user_id)

SELECT 
first AS login_date, 
COUNT(DISTINCT user_id) AS user_count
FROM cte
WHERE first BETWEEN '2019-04-01' AND '2019-06-30'
GROUP BY first