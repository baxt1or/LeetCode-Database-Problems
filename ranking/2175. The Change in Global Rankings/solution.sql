WITH cte AS (SELECT t.team_id, t.name, t.points, t.points + p.points_change AS points_after
FROM TeamPoints t INNER JOIN PointsChange p ON t.team_id = p.team_id ORDER BY t.team_id)


SELECT 
team_id, name,
DENSE_RANK() OVER(ORDER BY points DESC, name ASC) -
DENSE_RANK() OVER(ORDER BY points_after DESC, name ASC) AS rank_diff 
FROM cte