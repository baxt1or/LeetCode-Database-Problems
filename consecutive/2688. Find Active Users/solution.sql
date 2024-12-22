-- Write your PostgreSQL query statement below
SELECT
    DISTINCT user_id
FROM (SELECT
*,
COUNT(*)
    OVER(PARTITION BY user_id ORDER BY created_at
           RANGE BETWEEN INTERVAL '7 days' PRECEDING AND CURRENT ROW) AS count
FROM users) AS sub_query
WHERE count >= 2