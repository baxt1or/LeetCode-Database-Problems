-- Write your PostgreSQL query statement below
WITH RECURSIVE cte AS (
    SELECT 1 AS number
    UNION ALL
    SELECT number +1 FROM cte
    WHERE number < (SELECT COALESCE(MAX(customer_id),0) FROM customers)
)


SELECT
a.number AS ids
FROM cte a
LEFT JOIN customers b ON a.number = b.customer_id
WHERE b.customer_id IS NULL
ORDER BY ids