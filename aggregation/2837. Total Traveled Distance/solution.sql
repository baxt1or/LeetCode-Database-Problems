WITH cte AS (
SELECT
user_id, 
SUM(distance) AS distance
FROM rides r
GROUP BY 1)

SELECT
u.user_id,u.name, COALESCE(c.distance, 0) AS "traveled distance"
FROM users u 
LEFT JOIN cte c ON u.user_id = c.user_id
ORDER BY 1
