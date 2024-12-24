WITH cte AS (SELECT caller_id, recipient_id, DATE(call_time) AS date, call_time FROM calls
UNION 
SELECT recipient_id,caller_id, DATE(call_time) AS date , call_time FROM calls),

cte2 AS (SELECT
*,
MIN(call_time) OVER(PARTITION BY caller_id, date) AS first_day,
MAX(call_time) OVER(PARTITION BY caller_id, date) AS last_day
FROM cte),

final AS (SELECT 
caller_id, 
date,
MAX(CASE WHEN call_time = first_day THEN recipient_id END) AS kk,
MAX(CASE WHEN call_time = last_day THEN recipient_id END) AS kk2
FROM cte2
GROUP BY 1, 2)

SELECT
DISTINCT caller_id AS user_id
FROM final
WHERE kk = kk2