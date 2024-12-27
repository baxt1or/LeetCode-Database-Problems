-- Write your PostgreSQL query statement below
SELECT
TO_CHAR(trans_date,'YYYY-MM') AS month,
country,
COUNT(*) AS trans_count, 
COUNT(CASE WHEN state = 'approved' THEN 1 END) AS approved_count, 
SUM(amount) AS trans_total_amount,
COALESCE(SUM(CASE WHEN state='approved' THEN amount END), 0) AS approved_total_amount
FROM transactions
GROUP BY 1, 2