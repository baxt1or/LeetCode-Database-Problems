    WITH app_count AS (
    SELECT
        TO_CHAR(t.trans_date, 'YYYY-MM') AS month,
        t.country, 
        SUM(CASE WHEN t.state = 'approved' THEN amount END) AS amount,
        COUNT(CASE WHEN t.state = 'approved' THEN amount END) AS count
    FROM transactions t 
    LEFT JOIN chargebacks c ON t.id = c.trans_id
    GROUP BY 1, 2
    HAVING SUM(CASE WHEN t.state = 'approved' THEN amount END) IS NOT NULL
),

ch_count AS (
SELECT 
    TO_CHAR(c.trans_date, 'YYYY-MM') AS month,
    t.country,
    COUNT(*) AS count,
    SUM(t.amount) AS total
FROM transactions t
INNER JOIN chargebacks c ON t.id = c.trans_id
GROUP BY month, t.country
),

report AS (SELECT month, country FROM app_count
UNION ALL
SELECT month, country FROM ch_count
)

SELECT
DISTINCT a.month, a.country,
COALESCE(c.count, 0) AS approved_count,
COALESCE(c.amount, 0) AS approved_amount,
COALESCE(t.count, 0) AS chargeback_count,
COALESCE(t.total, 0) AS chargeback_amount
FROM report a
LEFT JOIN ch_count t ON a.month = t.month AND a.country = t.country
LEFT JOIN app_count c ON a.month = c.month AND a.country = c.country

