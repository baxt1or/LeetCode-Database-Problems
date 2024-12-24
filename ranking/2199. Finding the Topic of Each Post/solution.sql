-- Write your PostgreSQL query statement below
WITH cte AS (SELECT
post_id,
UNNEST(STRING_TO_ARRAY(content,' ')) AS word
FROM posts),


cte2 AS (SELECT
c.post_id, k.topic_id AS topic
FROM cte c 
INNER JOIN Keywords k ON LOWER(c.word) = LOWER(k.word)
GROUP BY 1, 2
ORDER BY post_id, topic),


cte3 AS (SELECT
p.post_id,
COALESCE(c.topic::TEXT, 'Ambiguous!') AS topic
FROM Posts p 
LEFT JOIN cte2 c ON p.post_id = c.post_id
ORDER BY p.post_id)


SELECT
post_id,
STRING_AGG(topic::TEXT, ',') AS topic
FROM cte3
GROUP BY 1

