-- Write your PostgreSQL query statement below
WITH cte AS (
    SELECT
        *,
        DENSE_RANK() OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS rnk
    FROM performance_reviews
),

cte2 AS (
    SELECT
        employee_id, review_date, rating, rnk
    FROM cte
    WHERE rnk BETWEEN 1 AND 3
),

cte3 AS (
    SELECT
        employee_id
    FROM cte2
    GROUP BY employee_id
    HAVING COUNT(DISTINCT review_date) >= 3
),

cte4 AS (
    SELECT
        a.employee_id,
        a.review_date,
        a.rating,
        LAG(a.rating) OVER(PARTITION BY a.employee_id ORDER BY a.review_date) AS prev
    FROM cte2 a
    INNER JOIN cte3 b ON a.employee_id = b.employee_id
),

final_filter AS (
    SELECT
        employee_id
    FROM cte4
    GROUP BY employee_id
    HAVING COUNT(CASE WHEN rating > prev THEN 1 END) >= 2
)

SELECT
    a.employee_id,
    c.name,
    MAX(b.rating) - MIN(b.rating) AS improvement_score
FROM final_filter a
JOIN cte4 b ON a.employee_id = b.employee_id
JOIN employees c ON a.employee_id = c.employee_id
GROUP BY a.employee_id, c.name
ORDER BY improvement_score DESC, c.name ASC
