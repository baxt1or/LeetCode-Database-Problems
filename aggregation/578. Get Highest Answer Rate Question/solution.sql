SELECT
question_id AS survey_log
FROM (SELECT
question_id, 
RANK() OVER(ORDER BY COUNT(CASE WHEN action = 'answer' THEN 1 END) * 1.0 /
NULLIF(COUNT(CASE WHEN action = 'show' THEN 1 END), 0) DESC, question_id) AS rnk
FROM SurveyLog
GROUP BY 1) AS sub
WHERE rnk = 1