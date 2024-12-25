WITH cte AS (SELECT 
p.id, p.name, p.phone_number, c.name AS country_name,c.country_code
FROM person p INNER JOIN country c ON SUBSTR(p.phone_number, 1, 3) = c.country_code),

final AS (SELECT caller_id, duration FROM calls
UNION ALL 
SELECT callee_id, duration FROM calls
)

SELECT 
c.country_name AS country
FROM final f FULL OUTER JOIN cte c ON f.caller_id = c.id
GROUP BY c.country_name
HAVING AVG(f.duration) > (SELECT AVG(duration) FROM calls)