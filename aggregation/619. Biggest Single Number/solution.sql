-- Write your PostgreSQL query statement below
SELECT
MAX(num) AS num
FROM (SELECT
num
FROM MyNumbers
GROUP BY 1
HAVING COUNT(*) = 1) AS sub