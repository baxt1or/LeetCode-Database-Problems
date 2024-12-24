-- Write your PostgreSQL query statement below
SELECT
UNNEST(REGEXP_MATCHES(tweet,'#\w+', 'g')) AS hashtag,
COUNT(*) AS count
FROM Tweets
GROUP BY 1
ORDER BY count DESC, hashtag DESC
LIMIT 3

