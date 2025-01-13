-- Write your PostgreSQL query statement below
WITH movie_rating AS (SELECT
m.title, 
AVG(r.rating) AS average
FROM MovieRating r
INNER JOIN Movies m ON r.movie_id = m.movie_id
WHERE TO_CHAR(r.created_at, 'YYYY-MM') = '2020-02'
GROUP BY r.movie_id, m.title 
ORDER BY average DESC, m.title 
LIMIT 1),

user_rating AS (SELECT
u.name, 
COUNT(r.movie_id) AS total
FROM MovieRating r
INNER JOIN Users u ON r.user_id = u.user_id
GROUP BY r.user_id, u.name
ORDER BY total DESC, u.name
LIMIT 1)

SELECT title AS results FROM movie_rating
UNION ALL
SELECT name FROM user_rating