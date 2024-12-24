WITH cte AS (SELECT * FROM friends
UNION ALL 
SELECT user2, user1 FROM friends),


cte2 AS (SELECT
user1,
COUNT(DISTINCT user2) AS total_friends
FROM cte
GROUP BY user1)


SELECT
user1,
ROUND(total_friends * 1.0 / (SELECT COUNT(DISTINCT user1) AS total FROM cte) * 100,2) AS percentage_popularity
FROM cte2