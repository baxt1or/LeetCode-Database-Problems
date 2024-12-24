WITH cte AS (SELECT
*
FROM friendship
UNION ALL
SELECT user2_id, user1_id FROM friendship),



cte2 AS  (SELECT
DISTINCT a.user_id AS user_id, b.user_id AS recommended_id,a.day
FROM listens a
INNER JOIN listens b ON a.day = b.day AND a.song_id = b.song_id AND a.user_id != b.user_id
AND (a.user_id, b.user_id) NOT IN (SELECT DISTINCT user1_id, user2_id FROM cte)
GROUP BY a.user_id, b.user_id, a.day
HAVING COUNT(DISTINCT a.song_id) >= 3)


SELECT DISTINCT user_id, recommended_id
FROM cte2