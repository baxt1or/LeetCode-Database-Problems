-- Write your PostgreSQL query statement below
SELECT
student_id,
department_id,
COALESCE(   ROUND(
        (RANK() OVER(PARTITION BY department_id ORDER BY mark DESC) * 1.0 - 1) * 100 
        / NULLIF(COUNT(student_id) OVER(PARTITION BY department_id) - 1, 0),
        2
), 0) AS percentage
FROM students