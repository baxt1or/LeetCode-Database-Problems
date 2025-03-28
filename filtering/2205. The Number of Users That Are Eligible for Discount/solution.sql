CREATE OR REPLACE FUNCTION getUserIDs(startDate DATE, endDate DATE, minAmount INT) RETURNS INT AS $$
BEGIN
  RETURN (
	
          SELECT
          COUNT(DISTINCT user_id) AS user_cnt
          FROM purchases
          WHERE time_stamp BETWEEN startDate AND endDate AND amount >= minAmount
      
  );
END;
$$ LANGUAGE plpgsql;