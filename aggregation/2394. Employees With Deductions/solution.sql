WITH cte AS (
    SELECT employee_id, 
           SUM(CEIL(EXTRACT(EPOCH FROM (out_time - in_time)) / 60)) AS worked_minutes  
    FROM logs 
    GROUP BY employee_id
),

cte2 AS (
    SELECT 
        e.employee_id, 
        e.needed_hours * 60 AS needed_minutes,  
        COALESCE(c.worked_minutes, 0) AS worked_minutes  
    FROM employees e 
    LEFT JOIN cte c 
        ON e.employee_id = c.employee_id
)


SELECT employee_id 
FROM cte2 
WHERE needed_minutes > worked_minutes;
