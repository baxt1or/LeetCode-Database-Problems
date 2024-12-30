-- Write your PostgreSQL query statement below
SELECT
emp_id, dept
FROM (SELECT
*,
DENSE_RANK() OVER(PARTITION BY dept ORDER BY salary DESC) AS rnk
FROM employees) AS sub
WHERE rnk = 2
ORDER BY 1