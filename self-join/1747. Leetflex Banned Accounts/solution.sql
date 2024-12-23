-- Write your PostgreSQL query statement below
SELECT
DISTINCT a.account_id
FROM LogInfo a 
INNER JOIN LogInfo b ON a.account_id = b.account_id
WHERE a.ip_address != b.ip_address AND a.login BETWEEN b.login AND b.logout