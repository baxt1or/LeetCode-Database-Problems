-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
*,
ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY match_day) -
ROW_NUMBER() OVER(PARTITION BY result, player_id ORDER BY match_day) AS rn2
FROM matches),


cte2 AS (SELECT
player_id, 
COUNT(*) AS longest_streak
FROM cte
WHERE result = 'Win'
GROUP BY player_id, rn2),

players AS (SELECT DISTINCT player_id FROM matches),


cte3 AS (SELECT
player_id, 
MAX(longest_streak) AS longest_streak
FROM cte2
GROUP BY 1)

SELECT 
a.player_id, 
COALESCE(b.longest_streak, 0) AS longest_streak 
FROM players a
LEFT JOIN cte3 b ON a.player_id = b.player_id 
ORDER BY a.player_id