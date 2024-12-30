SELECT
activity
FROM (SELECT
activity, 
COUNT(DISTINCT id) AS total,
MIN(COUNT(DISTINCT id)) OVER() AS min_total,
MAX(COUNT(DISTINCT id)) OVER() AS max_total
FROM friends
GROUP BY 1) AS sub
WHERE total != min_total AND total != max_total