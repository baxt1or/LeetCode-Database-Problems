WITH cte AS (SELECT * FROM matches
UNION ALL
SELECT match_id, guest_team,host_team,guest_goals,host_goals FROM matches),

cte2 AS (SELECT
host_team,
COUNT(CASE WHEN host_goals = guest_goals THEN host_goals END) * 1 +
COUNT(CASE WHEN host_goals > guest_goals THEN host_goals END) * 3 +
COUNT(CASE WHEN host_goals < guest_goals THEN host_goals END) * 0 AS num_points
FROM cte
GROUP BY host_team)


SELECT 
t.team_id, t.team_name, COALESCE(num_points, 0) AS num_points 
FROM cte2 c 
RIGHT JOIN teams t ON t.team_id = c.host_team
ORDER BY num_points DESC, t.team_id ASC
