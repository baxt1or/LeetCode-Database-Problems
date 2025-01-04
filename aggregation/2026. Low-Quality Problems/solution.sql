SELECT
problem_id
FROM problems
WHERE likes * 1.0 / (likes + dislikes)* 100 <= 60.0
ORDER BY 1