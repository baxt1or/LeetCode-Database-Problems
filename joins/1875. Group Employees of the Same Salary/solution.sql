WITH salaries AS (SELECT
salary
FROM employees 
GROUP BY 1
HAVING COUNT(*) >= 2)


SELECT
e.*,
DENSE_RANK() OVER(ORDER BY e.salary) AS team_id
FROM employees e
INNER JOIN salaries s ON e.salary = s.salary
ORDER BY team_id, employee_id