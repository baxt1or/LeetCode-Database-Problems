-- Write your PostgreSQL query statement below
SELECT
transaction_date, 
COALESCE(SUM(CASE WHEN amount % 2 != 0 THEN amount END), 0) AS odd_sum,
COALESCE(SUM(CASE WHEN amount % 2 = 0 THEN amount END), 0) AS even_sum
FROM transactions
GROUP BY 1
ORDER BY 1