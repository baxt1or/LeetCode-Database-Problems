WITH cte AS (SELECT team_name,wins*3+draws * 1+losses *0 AS points,
RANK() OVER(ORDER BY wins*3+draws * 1+losses *0 DESC) AS position
FROM TeamStats)


SELECT
*,
CASE 
    WHEN position <= ROUND((SELECT COUNT(*) FROM cte) * 0.35,0) THEN 'Tier 1'
    WHEN position <= ROUND((SELECT COUNT(*) FROM cte) * 0.7, 0) THEN 'Tier 2'
    ELSE 'Tier 3'
END AS tier
FROM cte
ORDER BY points DESC, team_name
