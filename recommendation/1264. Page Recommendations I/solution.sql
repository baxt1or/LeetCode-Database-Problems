-- Write your PostgreSQL query statement below
WITH cte AS (SELECT user2_id FROM friendship WHERE user1_id = 1
UNION ALL
SELECT user1_id FROM friendship WHERE user2_id = 1)

SELECT
DISTINCT page_id AS recommended_page
FROM likes
WHERE user_id IN (SELECT DISTINCT user2_id FROM cte) AND page_id NOT IN (SELECT
page_id
FROM likes
WHERE user_id = 1)