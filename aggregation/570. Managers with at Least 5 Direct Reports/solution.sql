-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
managerId
FROM employee
GROUP BY 1
HAVING COUNT(*) >= 5)

SELECT
e.name
FROM employee e
INNER JOIN cte c ON e.id = c.managerId