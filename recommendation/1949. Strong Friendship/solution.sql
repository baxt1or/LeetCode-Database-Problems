WITH cte AS (SELECT user1_id, user2_id FROM friendship
UNION ALL
SELECT user2_id,user1_id FROM friendship)


SELECT
a.user1_id, b.user1_id AS user2_id,
COUNT(*) AS common_friend
FROM cte a
INNER JOIN cte b ON a.user2_id = b.user2_id AND a.user1_id < b.user1_id  
WHERE (a.user1_id,b.user1_id) IN (SELECT * FROM friendship)
GROUP BY 1,2
HAVING COUNT(*) >=3