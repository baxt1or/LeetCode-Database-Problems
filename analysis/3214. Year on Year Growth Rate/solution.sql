--Write your PostgreSQL query statement below
SELECT
    EXTRACT(YEAR FROM transaction_date) AS year, product_id,
    SUM(spend) AS curr_year_spend,
    LAG(SUM(spend)) 
    OVER(PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date)) AS prev_year_spend,
    ROUND(
        (SUM(spend) - LAG(SUM(spend)) OVER(PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date))) / 
        LAG(SUM(spend)) OVER(PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date))* 100, 2) AS yoy_rate 
FROM user_transactions
GROUP BY 1, 2
ORDER BY product_id, year