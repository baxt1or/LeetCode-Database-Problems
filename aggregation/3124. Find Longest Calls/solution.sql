WITH cte AS (SELECT 
first_name, type, 
duration * 1.0 / 60 AS total
FROM contacts c INNER JOIN calls cl ON c.id = cl.contact_id
GROUP BY first_name,type, duration),

cte2 AS (SELECT 
*,
MAX(total)  OVER(PARTITION BY first_name) AS max_total
FROM cte)

SELECT
first_name, type, TO_CHAR((total * interval '1 minute'), 'HH24:MI:SS') AS duration_formatted
FROM (SELECT 
*,
RANK() OVER(PARTITION BY type ORDER BY total DESC) AS ranking
FROM cte2 )
WHERE ranking <= 3
ORDER BY type DESC, duration_formatted DESC, total DESC