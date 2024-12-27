-- Write your PostgreSQL query statement below
SELECT
stock_name,
SUM(CASE WHEN operation = 'Sell' THEN price ELSE -price END) AS capital_gain_loss
FROM stocks
GROUP BY 1