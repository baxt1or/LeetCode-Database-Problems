WITH cte AS (SELECT 
*,
RANK() OVER(PARTITION BY username ORDER BY endDate DESC) AS ranking
FROM UserActivity),

cte2 AS (SELECT
*,
COUNT(ranking) OVER(PARTITION BY username) AS count
FROM cte)


SELECT username,activity,startDate,endDate FROM cte WHERE ranking =2
UNION ALL
SELECT 
username,activity,startDate,endDate
FROM cte2
WHERE count =1