-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
*
FROM posts
WHERE post_date >= '2024-02-01' AND post_date <= '2024-02-28'),

cte2 AS (SELECT
user_id, 
COUNT(post_id) * 1.0 / 4 AS avg_posts
FROM cte
GROUP BY 1),

cte3 AS (SELECT
*,
COUNT(post_id)
OVER(PARTITION BY user_id ORDER BY post_date 
         RANGE BETWEEN INTERVAL '6 days' PRECEDING AND CURRENT ROW) AS max_7day_posts 
FROM cte),

cte4 AS (SELECT
user_id, 
MAX(max_7day_posts) AS max_7day_posts
FROM cte3
GROUP BY 1)

SELECT
a.user_id, b.max_7day_posts, a.avg_posts  AS avg_weekly_posts
FROM cte2 a 
INNER JOIN cte4 b ON a.user_id = b.user_id AND b.max_7day_posts >= 2 * a.avg_posts
ORDER BY a.user_id