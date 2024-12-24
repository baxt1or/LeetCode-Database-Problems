WITH cte AS (SELECT
country, 
winery,
SUM(points) AS points
FROM wineries
GROUP BY country, winery),


cte2 AS (SELECT
*,
DENSE_RANK() OVER(PARTITION BY country ORDER BY points DESC, winery ASC) AS ranking
FROM cte)



SELECT 
    country,
    MAX(CASE WHEN ranking = 1 THEN CONCAT(winery, ' (', points, ')') END) AS top_winery,
     COALESCE(
        MAX(CASE WHEN ranking = 2 THEN CONCAT(winery, ' (', points, ')') END),
        'No second winery'
    ) AS second_winery,
    COALESCE(
        MAX(CASE WHEN ranking = 3 THEN CONCAT(winery, ' (', points, ')') END),
        'No third winery'
    ) AS third_winery 
FROM cte2
WHERE ranking <= 3
GROUP BY country
