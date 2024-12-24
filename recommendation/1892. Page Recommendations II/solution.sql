-- Write your PostgreSQL query statement below
WITH cte AS (SELECT * FROM friendship
UNION ALL
SELECT user2_id, user1_id FROM friendship),

cte2 AS (SELECT
DISTINCT a.user1_id, a.user2_id
FROM cte a
INNER JOIN cte b ON a.user2_id = b.user2_id 
ORDER BY a.user1_id),

cte3 AS (SELECT
c.user1_id AS user_id, l.page_id, c.user2_id AS friend_id
FROM cte2 c
INNER JOIN likes l ON l.user_id = c.user2_id
ORDER BY c.user1_id)


SELECT
c.user1_id AS user_id, l.page_id,
COUNT(*) AS friends_likes
FROM cte2 c
LEFT JOIN likes l ON l.user_id = c.user2_id
LEFT JOIN likes l2 ON l2.user_id = c.user1_id AND l2.page_id = l.page_id
WHERE l2.page_id IS NULL
GROUP BY 1, 2