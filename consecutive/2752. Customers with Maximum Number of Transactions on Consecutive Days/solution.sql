-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
*
FROM transactions
ORDER BY customer_id,transaction_date),

cte2 AS (SELECT
customer_id,
COUNT(transaction_date) AS total_transactions
FROM cte
GROUP BY 1),

cte3 AS (SELECT
*,
CASE WHEN transaction_date - LAG(transaction_date) OVER(PARTITION BY customer_id ORDER BY transaction_date) = 1 THEN 0 ELSE 1 END AS gap 
FROM cte),

cte4 AS (SELECT
*,
SUM(gap) OVER(PARTITION BY customer_id ORDER BY transaction_date) AS group_id
FROM cte3),

cte5 AS (SELECT
customer_id, 
group_id,
COUNT(*) AS total
FROM cte4
GROUP BY 1, 2)


SELECT
customer_id
FROM cte5
WHERE total = (SELECT MAX(total) FROM cte5)
ORDER BY customer_id