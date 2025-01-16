-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
*,
MIN(exam_date) OVER(PARTITION BY student_id, subject ORDER BY exam_date) AS first_date,
MAX(exam_date) OVER(PARTITION BY student_id, subject ) AS last_date,
COUNT(*) OVER(PARTITION BY student_id, subject ) AS cnt
FROM scores)


SELECT
*
FROM (SELECT 
student_id, subject,score AS first_score, 
LEAD(score) OVER(PARTITION BY student_id, subject ORDER BY first_date) AS latest_score
FROM cte
WHERE (exam_date = first_date OR exam_date = last_date) AND cnt > 1 ) AS sub
WHERE latest_score IS NOT NULL AND first_score < latest_score
ORDER BY 1, 2