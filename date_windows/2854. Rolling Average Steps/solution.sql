WITH cte AS (
    SELECT 
        user_id,
        steps_date,
        ROUND(AVG(steps_count) 
        OVER (
            PARTITION BY user_id 
            ORDER BY steps_date
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2) AS rolling_average,
        LAG(steps_date, 2) OVER(PARTITION BY user_id ) AS two_days_ago
    FROM Steps)

SELECT
user_id, 
steps_date, rolling_average
FROM cte
WHERE steps_date - INTERVAL '2 days' = two_days_ago