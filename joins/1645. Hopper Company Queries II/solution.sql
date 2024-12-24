WITH months AS (
    SELECT generate_series(1, 12) AS month
),

cte AS (
    SELECT
        TO_CHAR(join_date, 'YYYY-MM') AS year_month,
        COUNT(DISTINCT driver_id) AS total_drivers
    FROM drivers
    WHERE join_date >= '2019-12-01' AND join_date <= '2020-12-31'
    GROUP BY 1
),

cte2 AS (
    SELECT
        year_month,
        SUM(total_drivers) OVER (ORDER BY year_month) AS total_drivers
    FROM cte
),

cte3 AS (
    SELECT
        CAST(TO_CHAR(TO_DATE(year_month || '-01', 'YYYY-MM-DD'), 'MM') AS INTEGER) AS month,
        total_drivers
    FROM cte2
    WHERE year_month > '2019-12'
),

td AS (
    SELECT
        m.month,
        MAX(c.total_drivers) OVER (PARTITION BY 1 ORDER BY m.month) AS total_drivers
    FROM months m
    LEFT JOIN cte3 c ON m.month = c.month
),

r_t AS (
    SELECT
        CAST(TO_CHAR(r.requested_at, 'MM') AS INTEGER) AS month,
        a.driver_id,
        COUNT(DISTINCT a.ride_id) AS total_rides
    FROM AcceptedRides a
    LEFT JOIN drivers d ON a.driver_id = d.driver_id
    LEFT JOIN rides r ON a.ride_id = r.ride_id
    WHERE TO_CHAR(r.requested_at, 'YYYY') = '2020'
    GROUP BY 1, 2
    HAVING COUNT(DISTINCT a.ride_id) >= 1
),

cte4 AS (
    SELECT
        month,
        COUNT(total_rides) AS total_rides
    FROM r_t
    GROUP BY 1
)

SELECT
    t.month, 
    COALESCE(ROUND(COALESCE(c.total_rides, 0) * 1.0 / t.total_drivers * 100, 2),0) AS working_percentage
FROM td t 
LEFT JOIN cte4 c ON t.month = c.month
ORDER BY t.month