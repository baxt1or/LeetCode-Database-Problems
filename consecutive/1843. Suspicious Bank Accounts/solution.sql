-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
account_id, EXTRACT(MONTH FROM day)::INTEGER AS month,
SUM(amount) AS total
FROM transactions
WHERE type = 'Creditor' 
GROUP BY account_id, month
ORDER BY account_id, month),


cte2 AS (SELECT
c.account_id, c.month, c.total, a.max_income,
CASE WHEN c.month - LAG(c.month) OVER(PARTITION BY c.account_id ORDER BY c.month) = 1 THEN 0 ELSE 1 END AS gap
FROM cte c
INNER JOIN accounts a ON a.account_id = c.account_id AND c.total > a.max_income)


SELECT
DISTINCT account_id
FROM (SELECT
*,
SUM(gap) OVER(PARTITION BY account_id ORDER BY month) AS group_id
FROM cte2)
GROUP BY account_id, group_id
HAVING COUNT(*) >= 2



