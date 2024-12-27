CREATE OR REPLACE FUNCTION NthHighestSalary(N INT) 
RETURNS TABLE (Salary INT) 
AS $$
BEGIN
  RETURN QUERY (
    SELECT
        DISTINCT s.salary
    FROM (
        SELECT
            e.salary,
            DENSE_RANK() OVER (ORDER BY e.salary DESC) AS rnk
        FROM employee e
    ) AS s
    WHERE s.rnk = N
  );
END;
$$ LANGUAGE plpgsql;
