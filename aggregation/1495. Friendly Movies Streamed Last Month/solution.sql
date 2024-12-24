SELECT DISTINCT c.title
FROM TVProgram  t 
INNER JOIN Content c ON t.content_id = c.content_id
WHERE c.content_type = 'Movies' AND c.Kids_content = 'Y' AND TO_CHAR(t.program_date,'YYYY-MM') = '2020-06'