-- Write your PostgreSQL query statement below
SELECT
user_id
FROM loans
WHERE loan_type IN ('Refinance', 'Mortgage')
GROUP BY 1
HAVING COUNT(DISTINCT loan_type) >= 2
ORDER BY 1