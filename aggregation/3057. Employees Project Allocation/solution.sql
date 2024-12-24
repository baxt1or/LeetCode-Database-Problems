WITH cte AS (SELECT 
p.project_id, p.employee_id, e.name, p.workload, e.team,
AVG(p.workload) OVER(PARTITION BY e.team) AS avg_work
FROM project p 
INNER JOIN employees e ON p.employee_id = e.employee_id)


SELECT 
employee_id, project_id, name AS employee_name, workload AS project_workload
FROM cte
WHERE workload > avg_work
ORDER BY employee_id, project_id