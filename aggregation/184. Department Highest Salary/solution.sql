-- Write your PostgreSQL query statement below
SELECT
department, employee, salary
FROM (SELECT
d.name AS department, e.name AS employee, e.salary,
MAX(e.salary) OVER(PARTITION BY d.id) AS max_sal
FROM employee e 
INNER JOIN department d ON e.departmentId = d.id) AS sub
WHERE salary = max_sal