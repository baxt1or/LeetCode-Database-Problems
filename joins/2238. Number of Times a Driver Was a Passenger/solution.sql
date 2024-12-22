-- Write your PostgreSQL query statement below
WITH cte AS (
SELECT DISTINCT driver_id FROM rides
),

cte2 AS (SELECT
c.driver_id, 
COUNT(*) AS count
FROM cte c
INNER JOIN rides r ON c.driver_id = r.passenger_id
GROUP BY 1)


SELECT
a.driver_id, 
COALESCE(b.count, 0) AS cnt
FROM cte a
LEFT JOIN cte2 b ON a.driver_id = b.driver_id