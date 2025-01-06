WITH cte AS (SELECT 
p.session_id, p.customer_id, 
p.start_time,
p.end_time ,
COALESCE(a.ad_id,0) AS ad_id, COALESCE(a.timestamp,0) AS timestamp
FROM playback p FULL OUTER JOIN ads a ON p.customer_id = a.customer_id),


cte2 AS (SELECT DISTINCT session_id FROM cte WHERE timestamp  BETWEEN start_time AND end_time),

cte3 AS (SELECT DISTINCT session_id FROM cte WHERE timestamp NOT BETWEEN start_time AND end_time)


SELECT DISTINCT b.session_id FROM cte2 a FULL OUTER JOIN cte3 b ON a.session_id = b.session_id WHERE a.session_id IS NULL