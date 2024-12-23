-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
event_type,
AVG(occurrences) AS avg_total
FROM events
GROUP BY 1),

cte2 AS (SELECT
business_id, 
event_type, 
SUM(occurrences) AS total
FROM events
GROUP BY 1, 2)


SELECT
a.business_id
FROM cte2 a
INNER JOIN cte b ON a.event_type = b.event_type
WHERE a.total > b.avg_total
GROUP BY 1
HAVING COUNT(*) >= 2