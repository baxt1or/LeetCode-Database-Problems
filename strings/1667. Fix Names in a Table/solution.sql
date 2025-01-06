-- Write your PostgreSQL query statement below
SELECT
user_id,
CONCAT(UPPER(LEFT(name, 1)),
LOWER(SUBSTRING(name FROM 2))) AS name
FROM users
ORDER BY 1