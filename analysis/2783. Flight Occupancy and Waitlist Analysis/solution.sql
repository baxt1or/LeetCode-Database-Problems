WITH cte AS (SELECT 
p.passenger_id,p.flight_id, f.capacity,
COUNT(p.flight_id) OVER(PARTITION BY p.flight_id ORDER BY p.passenger_id) AS count
FROM passengers p
INNER JOIN flights f ON p.flight_id = f.flight_id),


cte2 AS (SELECT
*,
CASE WHEN count <= capacity THEN 'con' ELSE 'wait' END AS c
FROM cte),


cte3 AS (SELECT
flight_id,
COUNT(CASE WHEN c='con' THEN 1 END) AS booked_cnt,
COUNT(CASE WHEN c='wait' THEN 1 END) AS waitlist_cnt
FROM cte2
GROUP BY flight_id
ORDER BY flight_id),


cte4 AS (SELECT DISTINCT flight_id FROM flights)



SELECT
b.flight_id,
COALESCE(a.booked_cnt,0) AS booked_cnt,
COALESCE(a.waitlist_cnt,0) AS waitlist_cnt
FROM cte3 a RIGHT JOIN cte4 b ON a.flight_id = b.flight_id
ORDER BY b.flight_id ASC