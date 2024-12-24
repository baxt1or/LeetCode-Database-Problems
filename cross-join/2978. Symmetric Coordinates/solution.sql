WITH cte AS (SELECT
*,
ROW_NUMBER() OVER() AS id
FROM coordinates),


cte2 AS (SELECT
a.X AS x1, a.Y AS y1, b.X AS x2, b.Y AS y2
FROM cte a
INNER JOIN cte b ON a.id != b.id
)

SELECT
DISTINCT x1 AS X,y1 AS Y
FROM cte2
WHERE x1 =y2 AND x2 = y1 AND x1 <= y1
ORDER BY x1, y1