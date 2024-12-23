-- Write your PostgreSQL query statement below
SELECT
a.employee_id, 
COUNT(*) AS overlapping_shifts
FROM EmployeeShifts a
INNER JOIN EmployeeShifts b ON a.employee_id = b.employee_id
AND a.start_time > b.start_time AND a.start_time < b.end_time
GROUP BY 1
ORDER BY 1