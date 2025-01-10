-- Write your PostgreSQL query statement below
SELECT
email
FROM person
GROUP BY 1
HAVING COUNT(id) >= 2