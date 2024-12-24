-- Write your PostgreSQL query statement below
WITH cte AS (SELECT 
accepter_id, 
COUNT(requester_id) AS num
FROM RequestAccepted
GROUP BY accepter_id
ORDER BY num DESC ),

cte2  AS (SELECT 
requester_id, 
COUNT(accepter_id) AS num
FROM RequestAccepted
GROUP BY requester_id
ORDER BY num DESC ),

cte3 AS (SELECT * FROM cte
UNION ALL
SELECT * FROM cte2)

SELECT 
accepter_id  AS id,
SUM(num) AS num
FROM cte3
GROUP BY accepter_id
ORDER BY num DESC
LIMIT 1