SELECT
ad_id, 
ROUND(COALESCE(COUNT(CASE WHEN action = 'Clicked' THEN 1 END) * 1.0 /
NULLIF((COUNT(CASE WHEN action = 'Viewed' THEN 1 END)  + COUNT(CASE WHEN action = 'Clicked' THEN 1 END)), 0) * 100, 0), 2) AS ctr 
FROM ads
GROUP BY 1 
ORDER BY 2 DESC, 1