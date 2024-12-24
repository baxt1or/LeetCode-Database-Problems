WITH cte AS (SELECT o.order_id, o.customer_id, o.order_date, o.item_id, o.quantity,
i.item_name, i.item_category,
EXTRACT(DOW FROM o.order_date)AS day_of_week
FROM orders o 
FULL OUTER JOIN items i ON o.item_id = i.item_id)

SELECT 
item_category AS Category  ,
SUM(CASE WHEN day_of_week = 1 THEN quantity ELSE 0 END) AS Monday,
SUM(CASE WHEN day_of_week = 2 THEN quantity ELSE 0 END) AS Tuesday,
SUM(CASE WHEN day_of_week = 3 THEN quantity ELSE 0 END) AS Wednesday,
SUM(CASE WHEN day_of_week = 4 THEN quantity ELSE 0 END) AS Thursday,
SUM(CASE WHEN day_of_week = 5 THEN quantity ELSE 0 END) AS Friday,
SUM(CASE WHEN day_of_week = 6 THEN quantity ELSE 0 END) AS Saturday,
SUM(CASE WHEN day_of_week = 0 THEN quantity ELSE 0 END) AS Sunday
FROM cte
GROUP BY item_category
ORDER BY item_category