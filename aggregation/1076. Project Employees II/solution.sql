SELECT
project_id
FROM (SELECT
project_id,
DENSE_RANK() OVER(ORDER BY COUNT(DISTINCT employee_id) DESC) AS rnk
FROM project 
GROUP BY 1) AS sub
WHERE rnk =1
