WITH cte AS (SELECT
*,
ROW_NUMBER() OVER(PARTITION BY user_id, spend_date ORDER BY platform) AS rn
FROM spending),

cte2 AS (SELECT 
*,
SUM(rn) OVER(PARTITION BY user_id, spend_date) AS rn_id
FROM cte),


cte3 AS (SELECT
user_id, spend_date, 
'both' AS platform,
SUM(amount) AS total_amount, 
COUNT(DISTINCT user_id) AS total_users
FROM cte2
WHERE rn_id = 3
GROUP BY 1, 2),


final  AS (
SELECT
spend_date,
platform,
SUM(amount) AS total_amount,
COUNT(DISTINCT user_id) AS total_users
FROM cte2
WHERE rn_id < 2
GROUP BY 1, 2
UNION
SELECT spend_date, platform, total_amount, total_users FROM cte3),


platform AS (SELECT
'mobile' AS platform
UNION 
SELECT 'desktop' AS platform
UNION 
SELECT 'both' AS platform),

dates AS (SELECT DISTINCT spend_date FROM spending),

report AS (SELECT * FROM dates
CROSS JOIN platform)


SELECT
r.spend_date, 
r.platform, 
COALESCE(f.total_amount, 0) AS total_amount,
COALESCE(f.total_users,0) AS total_users
FROM report r
LEFT JOIN final f ON f.spend_date = r.spend_date AND f.platform = r.platform
ORDER BY r.spend_date