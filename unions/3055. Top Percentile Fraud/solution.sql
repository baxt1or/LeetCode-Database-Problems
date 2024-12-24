WITH cte AS (SELECT
state, 
PERCENTILE_DISC(0.95) WITHIN GROUP (ORDER BY fraud_score ) AS p95 
FROM Fraud
GROUP BY state
)


SELECT 
f.policy_id, c.state, c.p95 AS fraud_score
FROM cte c
INNER JOIN Fraud f ON c.state = f.state AND c.p95 = fraud_score
ORDER BY state ASC, fraud_score DESC, policy_id ASC