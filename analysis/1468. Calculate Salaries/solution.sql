WITH cte AS (SELECT
*,
MAX(salary) OVER(PARTITION BY company_id) AS max_salary_com
FROM salaries)


SELECT
company_id, employee_id, employee_name,
ROUND(CASE 
    WHEN max_salary_com < 1000 THEN salary
    WHEN max_salary_com BETWEEN 1000 AND 10000 THEN salary * 0.76
    ELSE salary * 0.51
END, 0) AS salary
FROM cte