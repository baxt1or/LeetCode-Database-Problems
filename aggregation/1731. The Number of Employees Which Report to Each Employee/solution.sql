-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
reports_to, 
COUNT(DISTINCT employee_id) AS reports_count,
ROUND(AVG(age), 0) AS average_age
FROM employees
WHERE reports_to IS NOT NULL
GROUP BY 1)

SELECT
e.employee_id, e.name, c.reports_count, c.average_age
FROM cte c
INNER JOIN employees e ON e.employee_id = c.reports_to
ORDER BY 1