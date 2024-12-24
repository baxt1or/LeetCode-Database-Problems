WITH cte AS (SELECT
*,
LAG(session_end) OVER(PARTITION BY user_id, session_type ORDER BY session_end) as prev_end
FROM sessions)

SELECT
DISTINCT user_id
FROM cte
WHERE EXTRACT(EPOCH FROM (session_start - prev_end)) / 3600 < 12