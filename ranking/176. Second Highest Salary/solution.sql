-- Write your PostgreSQL query statement below
SELECT 
(SELECT
salary  
FROM (SELECT
*,
DENSE_RANK() OVER(ORDER BY salary DESC) AS rank
FROM employee) AS sub
WHERE rank =2
LIMIT 1
) AS SecondHighestSalary