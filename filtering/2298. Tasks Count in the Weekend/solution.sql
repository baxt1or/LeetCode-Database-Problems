SELECT
COUNT(CASE WHEN day = 0 OR day = 6 THEN 1 END) AS weekend_cnt,
COUNT(CASE WHEN day != 0 AND day != 6 THEN 1 END) AS working_cnt
FROM ((SELECT
*,
EXTRACT(DOW FROM submit_date)::INTEGER AS day
FROM tasks)) AS sub