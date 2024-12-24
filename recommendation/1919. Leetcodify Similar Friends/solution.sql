WITH cte AS (SELECT user1_id, user2_id FROM friendship
UNION ALL
SELECT user2_id, user1_id FROM friendship),


cte2 AS (SELECT
DISTINCT a.user_id AS user1_id, b.user_id AS user2_id, a.day
FROM listens a
INNER JOIN listens b ON a.day = b.day AND a.song_id = b.song_id AND a.user_id != b.user_id
AND (a.user_id, b.user_id) IN (SELECT DISTINCT user1_id, user2_id FROM friendship)
GROUP BY 1, 2, 3
HAVING COUNT(DISTINCT a.song_id) >= 3)


SELECT DISTINCT user1_id, user2_id
FROM cte2