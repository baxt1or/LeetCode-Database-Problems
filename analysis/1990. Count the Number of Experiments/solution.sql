WITH cte AS (SELECT 
platform, experiment_name,
COUNT(experiment_id) AS total
FROM experiments
GROUP BY platform, experiment_name),


all_com AS (SELECT platform, experiment_name
              FROM (SELECT 'IOS' AS platform UNION SELECT 'Android' UNION SELECT 'Web') E1 
                   CROSS JOIN
                   (SELECT 'Programming' AS experiment_name UNION SELECT 'Sports' UNION SELECT 'Reading') E2

)


SELECT 
a.platform, a.experiment_name, COALESCE(c.total,0) AS num_experiments
FROM all_com a
LEFT JOIN cte c ON a.platform = c.platform AND a.experiment_name = c.experiment_name