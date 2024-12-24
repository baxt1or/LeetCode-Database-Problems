WITH months AS (SELECT 1 AS month
UNION
SELECT 2
UNION
SELECT 3
UNION
SELECT 4
UNION
SELECT 5
UNION
SELECT 6
UNION
SELECT 7
UNION
SELECT 8
UNION
SELECT 9
UNION
SELECT 10
UNION
SELECT 11
UNION
SELECT 12),


active_users AS (SELECT 
*,
EXTRACT(MONTH FROM join_date)::INTEGER AS month,
COUNT(driver_id) OVER(ORDER BY TO_CHAR(join_date, 'YYYY-MM') ) AS num
FROM drivers
WHERE TO_CHAR(join_date, 'YYYY-MM') BETWEEN '2019-12' AND '2020-12'),


cte3 AS (SELECT month  AS month, num FROM active_users WHERE TO_CHAR(join_date, 'YYYY-MM') >= '2020-01'),


final_drivers AS (SELECT
    m.month,
    COALESCE(
        c.num,
        MAX(c.num) OVER (
            PARTITION BY 1
            ORDER BY m.month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        )
    ) AS active_drivers
FROM months m
LEFT JOIN cte3 c ON m.month = c.month
ORDER BY m.month),


acc_rides AS (SELECT
EXTRACT(MONTH FROM r.requested_at)::INTEGER AS month,
COUNT(*) AS num
FROM rides r
INNER JOIN AcceptedRides a ON r.ride_id = a.ride_id
WHERE EXTRACT(YEAR FROM r.requested_at) = '2020'
GROUP BY 1)


SELECT
DISTINCT f.month, COALESCE(f.active_drivers,0) AS active_drivers, COALESCE(a.num, 0) AS accepted_rides
FROM final_drivers f 
LEFT JOIN acc_rides a ON f.month = a.month