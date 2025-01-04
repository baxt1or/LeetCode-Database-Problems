SELECT
e.emp_name AS manager_name, e.dep_id
FROM employees e 
INNER JOIN (SELECT
dep_id, 
DENSE_RANK() OVER(ORDER BY COUNT(DISTINCT emp_id) DESC) AS rnk
FROM employees
GROUP BY 1) AS sub
ON e.dep_id = sub.dep_id
WHERE sub.rnk = 1 AND position = 'Manager'
ORDER BY e.dep_id