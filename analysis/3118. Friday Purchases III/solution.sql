WITH cte AS (SELECT 
u.user_id, u.membership, p.purchase_date,p.amount_spend,
EXTRACT(DOW FROM p.purchase_date) AS week_days,
CEIL((EXTRACT(DAY FROM p.purchase_date) - 1) / 7.0) AS week_of_month
FROM users u INNER JOIN purchases p ON u.user_id = p.user_id
WHERE TO_CHAR(p.purchase_date, 'YYYY-MM') = '2023-11'),

cte2 AS (SELECT 
membership,
week_of_month, 
SUM(amount_spend) AS total_amount
FROM cte
WHERE membership IN ('Premium','VIP') AND week_days = 5
GROUP BY membership,week_of_month ),

cte3 AS (SELECT 1 AS week_of_month, 'Premium' AS membership
UNION ALL
SELECT 1, 'VIP'
UNION ALL
SELECT 2, 'Premium'
UNION ALL
SELECT 2, 'VIP'
UNION ALL
SELECT 3, 'Premium'
UNION ALL
SELECT 3, 'VIP'
UNION ALL
SELECT 4, 'Premium'
UNION ALL
SELECT 4, 'VIP')


SELECT
a.week_of_month, 
a.membership, 
COALESCE(b.total_amount, 0) AS total_amount 
FROM cte3 a LEFT JOIN cte2 b ON a.week_of_month = b.week_of_month AND a.membership = b.membership
ORDER BY a.week_of_month,a.membership