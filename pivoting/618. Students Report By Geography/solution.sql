WITH cte AS (SELECT
CASE WHEN continent = 'America' THEN name END AS America,
CASE WHEN continent = 'Asia' THEN name END AS Asia ,
CASE WHEN continent = 'Europe' THEN name END AS Europe ,
ROW_NUMBER() OVER(PARTITION BY continent ORDER BY name) AS rn
FROM student)


SELECT
MIN(America) AS America,
MIN(Asia) AS Asia, 
MIN(Europe) AS Europe
FROM cte
GROUP BY rn
ORDER BY rn