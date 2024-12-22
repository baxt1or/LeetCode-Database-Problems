--Write your PostgreSQL query statement below
SELECT DISTINCT num AS ConsecutiveNums
FROM
(SELECT 
  *, 
  LAG(num) OVER(ORDER BY id) AS row1,
  LEAD(num) OVER(ORDER BY id) AS row2
FROM logs) AS s
WHERE num = row1 AND row1 = row2
