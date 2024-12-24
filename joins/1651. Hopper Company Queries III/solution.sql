WITH cte AS (SELECT 
a.ride_distance, a.ride_duration,EXTRACT(MONTH FROM r.requested_at) AS month
FROM AcceptedRides a 
INNER JOIN rides r ON a.ride_id = r.ride_id
INNER JOIN drivers d ON a.driver_id = d.driver_id
WHERE EXTRACT(YEAR FROM  r.requested_at) = '2020'
ORDER BY r.requested_at),

cte2 AS (SELECT 1 AS month
UNION ALL
SELECT 2
UNION ALL
SELECT 3
UNION ALL
SELECT 4
UNION ALL
SELECT 5
UNION ALL
SELECT 6
UNION ALL
SELECT 7
UNION ALL
SELECT 8
UNION ALL
SELECT 9
UNION ALL
SELECT 10
UNION ALL
SELECT 11
UNION ALL
SELECT 12
),



final AS (SELECT 
b.month, SUM(COALESCE(a.ride_distance, 0)) AS ride_distance, SUM(COALESCE(a.ride_duration,0)) AS ride_duration
FROM cte a
FULL OUTER JOIN cte2 b ON a.month = b.month
GROUP BY b.month
ORDER BY b.month),


rr AS (SELECT 
    month,
    ROUND(AVG(ride_distance) OVER(ORDER BY month ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING),2) AS average_ride_distance,
    ROUND(AVG(ride_duration) OVER(ORDER BY month ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING),2) AS average_ride_duration 
FROM final
ORDER BY month)

SELECT * FROM rr WHERE month <= 10