WITH cte AS (SELECT 
v.candidateId, c.name, COUNT(v.id) AS total_votes
FROM candidate c INNER JOIN vote v ON c.id = v.candidateId
GROUP BY v.candidateId, c.name
)

SELECT 
name
FROM cte
WHERE total_votes = (SELECT MAX(total_votes) FROM cte)