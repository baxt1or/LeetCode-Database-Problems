-- Write your PostgreSQL query statement below
SELECT
p.project_id, 
ROUND(AVG(experience_years), 2) AS average_years
FROM project p
INNER JOIN employee e ON e.employee_id = p.employee_id
GROUP BY 1