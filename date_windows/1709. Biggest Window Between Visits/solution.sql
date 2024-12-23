-- Write your PostgreSQL query statement below
SELECT
 user_id, 
 MAX(total_diff) AS biggest_window
 FROM (SELECT
*,
LEAD(visit_date,1,'2021-01-01') OVER(PARTITION BY user_id ORDER BY visit_date) - visit_date  AS total_diff
FROM UserVisits) AS sub
GROUP BY 1
ORDER BY 1