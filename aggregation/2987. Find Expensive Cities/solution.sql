-- Write your PostgreSQL query statement below
SELECT
city
FROM listings
GROUP BY 1
HAVING AVG(price) > (SELECT AVG(price) FROM listings)
ORDER BY 1