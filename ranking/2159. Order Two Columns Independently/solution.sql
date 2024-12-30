SELECT
c.first_col, b.second_col
FROM (SELECT
first_col,
ROW_NUMBER() OVER(ORDER BY first_col) AS rnk
FROM data) AS c
INNER JOIN (SELECT
second_col,
ROW_NUMBER() OVER(ORDER BY second_col DESC) AS rnk
FROM data) AS  b ON c.rnk = b.rnk
