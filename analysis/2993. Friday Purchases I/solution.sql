WITH cte AS (SELECT 
*,EXTRACT(DOW FROM purchase_date) AS day_week
FROM purchases
WHERE TO_CHAR(purchase_date, 'YYYY-MM') = '2023-11')

SELECT
FLOOR((EXTRACT(DAY FROM purchase_date) - 1) / 7) + 1 AS week_of_month,
purchase_date, SUM(amount_spend) AS total_amount
FROM cte 
WHERE day_week = 5
GROUP BY purchase_date
