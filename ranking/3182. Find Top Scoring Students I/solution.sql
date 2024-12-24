WITH cte AS (SELECT s.student_id, s.name, s.major, c.course_id, c.name AS course_name
FROM students s INNER JOIN courses c ON s.major = c.major),

cte2 AS (SELECT 
c.student_id, c.major, c.course_id, c.course_name, e.grade,
COUNT(c.course_id) OVER(PARTITION BY e.student_id) AS num
FROM cte c 
INNER JOIN enrollments e 
ON c.student_id = e.student_id AND c.course_id = e.course_id),



num_coures AS (SELECT 
major, 
COUNT(DISTINCT name) AS total_coures
FROM courses
GROUP BY major),

final AS (SELECT 
a.student_id, a.course_id, a.grade, a.course_name, a.major, a.num, b.total_coures
FROM cte2 a INNER JOIN num_coures b ON a.major = b.major)

SELECT 
student_id
FROM final
WHERE grade = 'A' 
GROUP BY student_id,total_coures
HAVING COUNT(grade) = total_coures