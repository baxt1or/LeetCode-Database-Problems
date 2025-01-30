-- Write your PostgreSQL query statement below
SELECT
user_id, email
FROM users
WHERE email ~ '[0-9a-zA-Z_]+@[a-z]+\.com'
ORDER BY 1