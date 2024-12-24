
SELECT COALESCE(ROUND((SELECT COUNT(DISTINCT (requester_id, accepter_id)) AS total
FROM RequestAccepted) *1.0 / NULLIF(COUNT(DISTINCT (sender_id, send_to_id)), 0),2),0) AS accept_rate  FROM FriendRequest