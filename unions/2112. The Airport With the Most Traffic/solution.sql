-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
departure_airport AS airport_id,
SUM(flights_count) AS total_flights
FROM (SELECT departure_airport, arrival_airport, flights_count FROM flights
UNION ALL
SELECT arrival_airport, departure_airport, flights_count FROM flights)
GROUP BY 1)

SELECT
airport_id
FROM cte
WHERE total_flights = (SELECT MAX(total_flights) FROM cte)