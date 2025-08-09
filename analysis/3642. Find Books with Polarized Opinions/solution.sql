-- Write your PostgreSQL query statement below
WITH first_analysis AS (SELECT
book_id,
COUNT(DISTINCT session_id) AS sessions_count,
COUNT(CASE WHEN session_rating >= 4 THEN session_id END) star_four,
COUNT(CASE WHEN session_rating <= 2 THEN session_id END) star_two,
MIN(session_rating) AS lowest_rating, 
MAX(session_rating) AS highest_rating
FROM reading_sessions
GROUP BY 1
HAVING COUNT(DISTINCT session_id) >= 5 AND
COUNT(CASE WHEN session_rating >= 4 THEN session_id END) >= 1 AND
COUNT(CASE WHEN session_rating <= 2 THEN session_id END) >= 1),


final_analysis AS (SELECT
book_id,
highest_rating - lowest_rating AS rating_spread,
ROUND((star_four + star_two) * 1.0 / sessions_count * 1.0 , 2) AS polarization_score
FROM first_analysis)


SELECT
b.*, 
a.rating_spread, 
a.polarization_score
FROM final_analysis a 
INNER JOIN books b on a.book_id = b.book_id
WHERE a.polarization_score >= 0.6
ORDER BY a.polarization_score DESC, b.title DESC