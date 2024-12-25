WITH gold AS (SELECT 
gold_medal AS user_id
FROM contests
GROUP BY gold_medal
HAVING COUNT(gold_medal) >= 3),


cte AS (SELECT contest_id, gold_medal AS user_id FROM contests
UNION ALL 
SELECT contest_id , silver_medal FROM contests
UNION ALL 
SELECT contest_id,bronze_medal FROM contests),


cte2 AS (SELECT 
contest_id, 
user_id,
COUNT(*) AS medals
FROM cte
GROUP BY contest_id, user_id
ORDER BY user_id, contest_id),


cte3 AS (SELECT 
*,
SUM(medals) OVER(PARTITION BY user_id) AS sum
FROM cte2),

cte4 AS (SELECT 
user_id,
LAG(contest_id) OVER(PARTITION BY user_id) AS prev,
contest_id,
LEAD(contest_id) OVER(PARTITION BY user_id) AS next
FROM cte3 WHERE sum >=3) ,

final AS (SELECT DISTINCT user_id 
FROM cte4 
WHERE next - contest_id = 1 AND contest_id - prev = 1
UNION ALL 
SELECT * FROM gold)


SELECT DISTINCT u.name, u.mail FROM users u INNER JOIN final f ON u.user_id = f.user_id