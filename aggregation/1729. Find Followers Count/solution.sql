-- Write your PostgreSQL query statement below
SELECT
user_id,
COUNT(DISTINCT follower_id) AS followers_count
FROM followers
GROUP BY 1
ORDER BY 1