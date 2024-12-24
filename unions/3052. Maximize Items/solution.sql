WITH cte AS (SELECT
item_type,
COUNT(*) *
FLOOR(500000 / SUM(square_footage)) AS item_count,
FLOOR(SUM(square_footage) * FLOOR(500000 / SUM(square_footage))) AS remaining
FROM inventory
WHERE item_type = 'prime_eligible'
GROUP BY 1),


cte2 AS (SELECT
item_type,
COUNT(*)*
FLOOR((500000 - (SELECT remaining FROM cte)) / 
SUM(square_footage)) AS item_count
FROM inventory
WHERE item_type = 'not_prime'
GROUP BY 1)


SELECT item_type, item_count FROM cte
UNION ALL
SELECT item_type, item_count FROM cte2
ORDER BY item_count DESC