WITH cte AS (SELECT 
*,
MAX(score) OVER(PARTITION BY exam_id ) AS max_score,
MIN(score) OVER(PARTITION BY exam_id) AS min_score
FROM exam),


cte2 AS (SELECT 
DISTINCT student_id
FROM cte
WHERE score = max_score OR score = min_score),



final AS (SELECT
DISTINCT b.student_id
FROM cte2 a 
FULL OUTER JOIN cte b ON a.student_id = b.student_id
WHERE a.student_id IS NULL
)


SELECT
f.student_id, s.student_name
FROM final f
INNER JOIN student s ON f.student_id = s.student_id