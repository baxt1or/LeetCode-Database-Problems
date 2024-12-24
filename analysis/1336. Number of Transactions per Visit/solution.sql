WITH RECURSIVE cte AS (
    SELECT
        v.user_id, 
        v.visit_date, 
        COUNT(t.transaction_date) AS count
    FROM visits v
    LEFT JOIN transactions t 
        ON v.user_id = t.user_id AND v.visit_date = t.transaction_date
    GROUP BY v.user_id, v.visit_date
),
cte3 AS (
    SELECT
        count, 
        COUNT(user_id) AS visit_count
    FROM cte
    GROUP BY count
),
report AS (
    SELECT 0 AS number  
    FROM cte3
    UNION ALL
    SELECT number + 1            
    FROM report
    WHERE number < (SELECT MAX(count) FROM cte3) 
)
SELECT 
    DISTINCT r.number AS transactions_count,
    COALESCE(c.visit_count, 0) AS visits_count
FROM report r
LEFT JOIN cte3 c 
    ON c.count = r.number
ORDER BY transactions_count