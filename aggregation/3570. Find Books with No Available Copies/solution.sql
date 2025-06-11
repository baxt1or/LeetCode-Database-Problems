
WITH cte AS (SELECT
b.book_id, 
COUNT(DISTINCT r.record_id) AS current_borrowers
FROM library_books b
LEFT JOIN borrowing_records r ON b.book_id = r.book_id
WHERE r.return_date IS NULL 
GROUP BY 1)


SELECT
c.book_id,
b.title, 
b.author, 
b.genre,
b.publication_year, 
c.current_borrowers
FROM cte c 
INNER JOIN library_books b ON c.book_id = b.book_id
WHERE c.current_borrowers - b.total_copies = 0
ORDER BY c.current_borrowers DESC, b.title ASC