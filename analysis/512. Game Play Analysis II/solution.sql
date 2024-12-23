-- Write your PostgreSQL query statement below
SELECT
DISTINCT player_id, device_id
FROM (SELECT
*,
MIN(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS min
FROM activity) AS sub
WHERE event_date = min