WITH cte AS (SELECT
from_id, to_id, duration
FROM calls
UNION ALL
SELECT
to_id, from_id, duration
FROM calls)

SELECT
from_id AS person1, to_id AS person2, 
COUNT(*) AS call_count, 
SUM(duration) AS total_duration
FROM cte
WHERE from_id < to_id
GROUP BY 1, 2