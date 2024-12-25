-- Write your PostgreSQL query statement below
SELECT
d.dept_name,
COUNT(s.student_id) AS student_number 
FROM department d LEFT JOIN student s ON d.dept_id = s.dept_id
GROUP BY d.dept_name
ORDER BY student_number DESC, d.dept_name ASC