-- Write your PostgreSQL query statement below
SELECT
DISTINCT user_id 
FROM (SELECT
*,
COUNT(*)
     OVER(PARTITION BY user_id ORDER BY purchase_date
          RANGE BETWEEN INTERVAL '7 days' PRECEDING AND CURRENT ROW) AS count
FROM Purchases 
ORDER BY user_id, purchase_date)
WHERE count >= 2

-- Second way of implement the query
WITH cte AS (SELECT
*,
purchase_date - LAG(purchase_date) OVER(PARTITION BY user_id ORDER BY purchase_date) AS days_diff
FROM Purchases)

SELECT
user_id
FROM cte
WHERE days_diff >= 0 AND days_diff <= 7
GROUP BY 1
ORDER BY 1