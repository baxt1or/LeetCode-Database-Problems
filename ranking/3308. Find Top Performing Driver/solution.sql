-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
v.fuel_type,
v.driver_id,
ROUND(AVG(t.rating), 2) AS rating,
SUM(t.distance) AS distance,
DENSE_RANK() OVER(PARTITION BY v.fuel_type ORDER BY AVG(t.rating) DESC, d.accidents) AS ranking
FROM trips t
INNER JOIN vehicles v ON t.vehicle_id = v.vehicle_id
INNER JOIN drivers d ON v.driver_id = d.driver_id
GROUP BY 1, 2, d.accidents)


SELECT
fuel_type, driver_id, rating, distance
FROM cte
WHERE ranking = 1
ORDER BY fuel_Type