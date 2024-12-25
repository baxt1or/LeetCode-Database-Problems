WITH cte  AS (SELECT 
viewer_id, view_date, COUNT(DISTINCT article_id) AS views
FROM views
GROUP BY viewer_id, view_date)


SELECT DISTINCT viewer_id AS id
FROM cte 
WHERE views >= 2
ORDER BY id 