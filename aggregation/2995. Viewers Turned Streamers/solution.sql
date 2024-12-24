WITH cte AS (SELECT
*,
 MIN(session_start) OVER (PARTITION BY user_id) AS first_session_start,
MIN(CASE WHEN session_type = 'Viewer' THEN session_start END) OVER(PARTITION BY user_id) AS mn
FROM sessions
ORDER BY user_id),

cte2 AS (
SELECT
*,
ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY  session_start) AS rn
FROM cte
WHERE mn IS NOT NULL  AND first_session_start = mn

)

SELECT
user_id, 
COUNT(CASE WHEN session_type = 'Streamer' THEN session_type END) AS sessions_count
FROM cte2
WHERE rn > 1
GROUP BY user_id
ORDER BY sessions_count DESC, user_id DESC
