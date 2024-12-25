WITH cte AS (SELECT 
*,
(EXTRACT(EPOCH FROM exit_time) - EXTRACT(EPOCH FROM entry_time)) / 3600 AS time_spent,
MAX((EXTRACT(EPOCH FROM exit_time) - EXTRACT(EPOCH FROM entry_time)) / 3600) OVER(PARTITION BY car_id) AS max_lot
FROM ParkingTransactions),


cte3 AS (SELECT 
car_id,
SUM(fee_paid) AS total_fee_paid,
ROUND(SUM(fee_paid) * 1.0 / SUM(time_spent), 2) AS avg_hourly_fee
FROM cte 
GROUP BY car_id
),

cte2 AS (SELECT 
*,
MAX(total) OVER(PARTITION BY car_id) AS most
FROM (SELECT 
lot_id, car_id,
SUM(time_spent) AS total
FROM cte
GROUP BY lot_id, car_id)),


final AS (SELECT lot_id, car_id FROM cte2 WHERE total=most
)


SELECT DISTINCT b.car_id, b.total_fee_paid, b.avg_hourly_fee, a.lot_id AS most_time_lot
FROM final a INNER JOIN cte3 b ON a.car_id = b.car_id
ORDER BY b.car_id