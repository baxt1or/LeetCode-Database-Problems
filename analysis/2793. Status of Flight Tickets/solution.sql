WITH cte AS (
SELECT
f.flight_id, f.capacity, p.passenger_id, p.booking_time,
COUNT(f.flight_id) OVER(PARTITION BY f.flight_id ORDER BY p.booking_time) AS cum_sum
FROM flights f
INNER JOIN passengers p ON f.flight_id = p.flight_id)

SELECT
passenger_id,
CASE 
    WHEN cum_sum <= capacity THEN 'Confirmed'
    ELSE 'Waitlist'
END AS status
FROM cte
ORDER BY 1