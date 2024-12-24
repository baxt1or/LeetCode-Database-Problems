WITH cte AS (
    SELECT
        a.employee_id,
        CASE 
            WHEN COUNT(*) = 1 THEN COUNT(*) + 1
            ELSE COUNT(*)
        END AS overlapping_shift,
        SUM(EXTRACT(EPOCH FROM (b.end_time - a.start_time)) / 60) AS total_overlap_duration
    FROM EmployeeShifts a
    JOIN EmployeeShifts b ON a.employee_id = b.employee_id
    AND a.start_time > b.start_time AND a.start_time < b.end_time
    GROUP BY a.employee_id
)

SELECT
    DISTINCT a.employee_id,
    COALESCE(b.overlapping_shift, 1) AS max_overlapping_shifts,
    COALESCE(b.total_overlap_duration, 0) AS total_overlap_duration
FROM EmployeeShifts a 
LEFT JOIN cte b ON a.employee_id = b.employee_id
ORDER BY a.employee_id;
