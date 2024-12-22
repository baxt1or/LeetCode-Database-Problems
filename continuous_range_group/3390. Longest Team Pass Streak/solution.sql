-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
p.pass_from , p.time_stamp, p.pass_to, t.team_name AS from_team
FROM passes p
INNER JOIN teams t ON p.pass_from  = t.player_id),

cte2 AS (SELECT
a.pass_from, a.time_stamp, a.pass_to, a.from_team, t.team_name AS to_team,
CASE WHEN a.from_team = t.team_name THEN 1 ELSE 0 END AS points
FROM cte a
INNER JOIN teams t ON a.pass_to = t.player_id),

cte3 AS (SELECT
*,
ROW_NUMBER() OVER(PARTITION BY from_team ORDER BY time_stamp)-
ROW_NUMBER() OVER(PARTITION BY points, from_team ORDER BY time_stamp) AS group_id
FROM cte2)


SELECT
from_team AS team_name, 
MAX(total) AS longest_streak
FROM (SELECT
from_team, 
group_id, 
COUNT(*) AS total
FROM cte3
WHERE points = 1
GROUP BY 1, 2) AS sub
GROUP BY 1
ORDER BY team_name