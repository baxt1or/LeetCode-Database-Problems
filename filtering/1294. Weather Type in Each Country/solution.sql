SELECT
c.country_name, 
CASE 
    WHEN AVG(w.weather_state) <= 15 THEN 'Cold' 
    WHEN AVG(w.weather_state) >= 25 THEN 'Hot'
    ELSE 'Warm'
END AS weather_type 
FROM countries c
INNER JOIN weather w ON c.country_id = w.country_id
WHERE TO_CHAR(w.day, 'YYYY-MM') = '2019-11'
GROUP BY 1