-- Write your PostgreSQL query statement below
SELECT
*
FROM users
WHERE mail ~ '^[a-zA-Z][0-9a-zA-Z_.-]*@leetcode\.com$'