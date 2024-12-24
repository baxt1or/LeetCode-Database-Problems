WITH cte AS (
    SELECT 
        pass_from,
        (TIME '00:00' + (INTERVAL '1 MINUTE' * split_part(time_stamp, ':', 1)::INT) + (INTERVAL '1 SECOND' * split_part(time_stamp, ':', 2)::INT)) AS time_stamp,
        pass_to
    FROM passes
)
,

cte2 AS (SELECT
*,
CASE 
    WHEN time_stamp >= '00:00:00' AND time_stamp <= '00:45:00' THEN 1 ELSE 2
END AS round_type
FROM cte),

cte3 AS (
SELECT pass_to, time_stamp, pass_from, round_type FROM cte2),

cte4 AS (SELECT
c.pass_from, c.time_stamp, c.pass_to, t.team_name AS from_team, round_type
FROM teams t
INNER JOIN cte3 c ON t.player_id = c.pass_from),

final AS (SELECT
c.*, t.team_name AS to_team
FROM cte4 c
INNER JOIN teams t ON c.pass_to = t.player_id
ORDER BY c.time_stamp)


SELECT
from_team AS team_name,round_type AS half_number,
SUM(tt) AS dominance
FROM (SELECT
*,
CASE WHEN from_team = to_team THEN 1 ELSE -1 END AS tt
FROM final) AS sub
GROUP BY 1, 2
ORDER BY team_name, half_number

