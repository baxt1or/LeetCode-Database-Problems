WITH cte AS (SELECT 
s.id, e.department_id, s.employee_id, s.amount, TO_CHAR(s.pay_date, 'YYYY-MM') AS pay_month
FROM salary s INNER JOIN employee e ON s.employee_id = e.employee_id),


cte2 AS (SELECT
pay_month,
department_id,
AVG(amount) AS avg_dep
FROM cte
GROUP BY pay_month, department_id),


cte3 AS (SELECT
pay_month, 
AVG(amount) AS avg_sal
FROM cte
GROUP BY pay_month)

SELECT
a.pay_month, a.department_id,
CASE 
    WHEN avg_dep = avg_sal  THEN 'same' 
    WHEN avg_dep > avg_sal THEN 'higher' 
    WHEN avg_dep < avg_sal THEN 'lower' 
END AS comparison
FROM cte2 a 
FULL OUTER JOIN cte3 b ON a.pay_month = b.pay_month
ORDER BY a.department_id