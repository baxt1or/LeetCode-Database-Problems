WITH man_courses AS (SELECT
major,
course_id,
COUNT(DISTINCT name) AS total_courses
FROM courses
WHERE mandatory = 'Yes'
GROUP BY 1, 2),

elect_courses AS (SELECT
major,course_id,
COUNT(DISTINCT name) AS total_courses
FROM courses
WHERE mandatory = 'No'
GROUP BY 1,2),


man_students AS (SELECT
e.student_id, s.major
FROM enrollments e 
INNER JOIN man_courses m ON e.course_id = m.course_id
INNER JOIN students s ON e.student_id = s.student_id AND m.major = s.major
WHERE e.grade = 'A' 
GROUP BY 1, 2
HAVING COUNT(DISTINCT e.course_id) = (SELECT COUNT(*) FROM man_courses WHERE s.major = major)),


elect_students AS (SELECT
e.student_id, s.major
FROM enrollments e
INNER JOIN elect_courses ec ON e.course_id = ec.course_id
INNER JOIN students s ON e.student_id = s.student_id AND ec.major = s.major
WHERE e.grade IN ('A', 'B')
GROUP BY 1,2
HAVING COUNT(DISTINCT e.course_id) >= 2)


SELECT
DISTINCT a.student_id
FROM man_students a
INNER JOIN elect_students b ON a.student_id = b.student_id