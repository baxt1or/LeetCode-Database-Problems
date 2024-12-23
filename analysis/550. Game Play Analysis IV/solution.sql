-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
*,
MIN(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS first_login
FROM activity)

SELECT
ROUND((SELECT
COUNT(player_id)
FROM cte
WHERE first_login + 1 = event_date) * 1.0 /  COUNT(DISTINCT player_id), 2) AS fraction
FROM cte