-- Write your PostgreSQL query statement below
WITH cte AS (SELECT 
*,
LAG(spend) OVER(PARTITION BY user_id ORDER BY transaction_date) AS first_transaction,
LAG(spend, 2) OVER(PARTITION BY user_id ORDER BY transaction_date) AS second_transaction,
ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) AS num_transaction
FROM transactions)

SELECT
user_id, spend AS third_transaction_spend, transaction_date AS third_transaction_date
FROM cte
WHERE num_transaction = 3 AND spend > first_transaction AND spend > second_transaction