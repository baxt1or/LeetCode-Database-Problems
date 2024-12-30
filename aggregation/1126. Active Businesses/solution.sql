-- Write your PostgreSQL query statement below
SELECT
business_id
FROM (SELECT
business_id, 
CASE WHEN occurrences > AVG(occurrences) OVER(PARTITION BY event_type) THEN 1 ELSE 0 END AS status
FROM events) AS sub
WHERE status = 1
GROUP BY business_id, status
HAVING COUNT(*) > 1