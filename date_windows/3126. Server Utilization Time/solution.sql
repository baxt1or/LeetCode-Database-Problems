WITH cte AS (
    SELECT *,
           EXTRACT(EPOCH FROM status_time - s) / 86400 AS total -- Calculate difference in days
    FROM (
        SELECT *,
               LAG(CASE WHEN session_status = 'start' THEN status_time END) 
               OVER (PARTITION BY server_id ORDER BY status_time) AS s
        FROM servers
    ) subquery
)
SELECT FLOOR(SUM(total)) AS total_uptime_days
FROM cte;