-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
*
FROM transactions
ORDER BY customer_id, amount),

cte2 AS (SELECT
*,
LAG(transaction_date) OVER(PARTITION BY customer_id ORDER BY transaction_date) AS prev_day,
LAG(amount) OVER(PARTITION BY customer_id ORDER BY transaction_date) AS prev_amount
FROM cte),

cte3 AS (SELECT
*,
CASE WHEN transaction_date - prev_day = 1 AND amount > prev_amount THEN 0 ELSE 1 END AS gap
FROM cte2),

cte4 AS (SELECT
*,
SUM(gap) OVER(PARTITION BY customer_id ORDER BY transaction_date) AS group_id
FROM cte3)

SELECT
customer_id,
MIN(transaction_date) AS consecutive_start, 
MAX(transaction_date) AS consecutive_end
FROM cte4
GROUP BY customer_id, group_id
HAVING COUNT(*) >= 3
ORDER BY customer_id, consecutive_start