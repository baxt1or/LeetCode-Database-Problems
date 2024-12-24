WITH cte AS (SELECT user_id1, user_id2 FROM friends
UNION ALL
SELECT user_id2, user_id1 FROM friends),


cte2 AS  (SELECT
a.user_id1, b.user_id1 AS user_id2,
COUNT(*) AS comm
FROM cte a
INNER JOIN cte b ON a.user_id2 = b.user_id2 AND a.user_id1 < b.user_id1
GROUP BY 1, 2
HAVING COUNT(*) >= 1
)


SELECT
user_id1, user_id2
FROM friends
WHERE (user_id1, user_id2) NOT IN (SELECT user_id1, user_id2 FROM cte2)
AND (user_id2, user_id1) NOT IN (SELECT user_id1, user_id2 FROM cte2)
ORDER BY user_id1, user_id2