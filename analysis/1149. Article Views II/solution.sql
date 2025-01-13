SELECT
DISTINCT id
FROM (SELECT
viewer_id AS id
FROM views
GROUP BY viewer_id, view_date
HAVING COUNT(DISTINCT article_id) > 1
ORDER BY 1) AS sub