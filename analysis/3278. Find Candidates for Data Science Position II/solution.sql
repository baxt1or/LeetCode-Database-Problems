WITH cte AS (SELECT 
book_id, name
FROM books
WHERE available_from < '2019-05-23'
GROUP BY book_id, name)


SELECT 
b.book_id,b.name
FROM cte b LEFT JOIN orders o ON b.book_id = o.book_id
GROUP BY b.book_id, b.name
HAVING SUM(CASE WHEN o.dispatch_date BETWEEN '2018-06-23' AND '2019-06-23' THEN quantity ELSE 0 END) < 10