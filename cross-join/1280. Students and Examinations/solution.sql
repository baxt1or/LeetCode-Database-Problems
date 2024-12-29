-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
*
FROM students s
CROSS JOIN subjects),

cte2 AS (SELECT
student_id, subject_name,
COUNT(*) AS total
FROM examinations
GROUP BY 1,2)

SELECT
a.student_id, a.student_name, a.subject_name, 
COALESCE(b.total,0) AS attended_exams
FROM cte a 
LEFT JOIN cte2 b ON a.student_id = b.student_id AND a.subject_name = b.subject_name
ORDER BY 1, 3