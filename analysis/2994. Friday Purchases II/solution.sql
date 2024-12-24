WITH cte AS (
    SELECT 
        *,
        EXTRACT(DOW FROM purchase_date) AS week_days,
        CEIL((EXTRACT(DAY FROM purchase_date) - 1) / 7.0) AS week_of_month
    FROM purchases
    WHERE TO_CHAR(purchase_date, 'YYYY-MM') = '2023-11'
),


cte2 AS (SELECT 
week_of_month, 
purchase_date,
SUM(amount_spend) AS total_amount
FROM cte
WHERE week_days = '5' 
GROUP BY week_of_month, purchase_date),


report AS (SELECT 1 AS week_of_month, '2023-11-03' AS purchase_date
UNION ALL
SELECT 2, '2023-11-10'
UNION ALL
SELECT 3, '2023-11-17'
UNION ALL
SELECT 4, '2023-11-24')


SELECT 
r.week_of_month, 
r.purchase_date,
COALESCE(c.total_amount, 0) AS total_amount
FROM cte2 c 
RIGHT JOIN report r ON c.week_of_month = r.week_of_month 
ORDER BY r.week_of_month ASC