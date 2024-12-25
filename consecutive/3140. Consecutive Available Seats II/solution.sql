WITH cte AS (SELECT
*,
seat_id - ROW_NUMBER() OVER(ORDER BY seat_id) AS group_id
FROM cinema
WHERE free = 1),


final AS (SELECT
group_id,
MIN(seat_id) AS first_seat_id ,
MAX(seat_id) AS last_seat_id,
COUNT(*) AS consecutive_seats_len
FROM cte
GROUP BY 1)

SELECT
first_seat_id, last_seat_id, consecutive_seats_len
FROM final
WHERE consecutive_seats_len = (SELECT MAX(consecutive_seats_len)  FROM final)
