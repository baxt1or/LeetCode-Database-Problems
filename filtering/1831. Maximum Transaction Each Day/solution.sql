SELECT
transaction_id
FROM (SELECT
*,
MAX(amount) OVER(PARTITION BY DATE(day) ORDER BY DATE(day)) AS max_amount
FROM transactions) AS sub
WHERE max_amount = amount
ORDER BY 1