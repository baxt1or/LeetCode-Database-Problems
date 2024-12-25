WITH cte AS (SELECT * FROM matches
UNION ALL
SELECT away_team_id,home_team_id,away_team_goals,home_team_goals FROM matches),

mathes AS (SELECT
home_team_id AS team_id,
COUNT(away_team_id) AS matches_played,
COUNT(CASE WHEN home_team_goals = away_team_goals THEN 1 END) * 1 +
COUNT(CASE WHEN home_team_goals > away_team_goals THEN 1 END) * 3 +
COUNT(CASE WHEN home_team_goals < away_team_goals THEN 1 END) * 0 AS points
FROM cte 
GROUP BY home_team_id),

goal_for AS (SELECT
home_team_id AS team_id,
SUM(home_team_goals) AS goal_for
FROM  cte
GROUP BY home_team_id),


goal_against AS (SELECT
home_team_id AS team_id,
SUM(away_team_goals) AS goal_against
FROM  cte
GROUP BY home_team_id)


SELECT 
t.team_name, m.matches_played, m.points, g.goal_for, a.goal_against, g.goal_for - a.goal_against AS goal_diff
FROM mathes m
INNER JOIN goal_for g ON m.team_id = g.team_id
INNER JOIN goal_against a ON m.team_id = a.team_id
INNER JOIN teams t ON t.team_id = m.team_id
ORDER BY m.points DESC, goal_diff DESC, t.team_name ASC