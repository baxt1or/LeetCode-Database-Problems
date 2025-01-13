WITH cte AS (SELECT DISTINCT  action_date, post_id,
COUNT(post_id) OVER(PARTITION BY action_date) AS count
FROM actions 
WHERE action = 'report' AND extra  = 'spam'
ORDER BY action_date),


cte2 AS (SELECT 
a.action_date, 
COUNT(a.action_date) AS ac_count,
COUNT(r.remove_date) AS re_count
FROM cte a 
LEFT JOIN removals r ON a.post_id = r.post_id
GROUP BY a.action_date)


SELECT ROUND(AVG(re_count * 1.0/ac_count* 100), 2) AS average_daily_percent
FROM cte2
