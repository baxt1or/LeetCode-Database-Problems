-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
*,
MIN(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS first_login
FROM activity),

installs AS (SELECT
event_date, 
COUNT(*) AS installs
FROM cte
WHERE event_date = first_login
GROUP BY 1),

logsback AS (SELECT
first_login, COUNT(*) AS total_logsback
FROM cte a
WHERE first_login+1 = event_date
GROUP BY 1)

SELECT
i.event_date AS install_dt, 
i.installs,
ROUND(COALESCE(l.total_logsback, 0) * 1.0 / i.installs, 2) AS Day1_retention
FROM installs i 
LEFT JOIN logsback l ON i.event_date = l.first_login