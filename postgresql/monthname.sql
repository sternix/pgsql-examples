CREATE OR REPLACE FUNCTION MonthName1 (_month INTEGER)
RETURNS VARCHAR(10) AS $$
DECLARE result varchar;
BEGIN
  IF _month <1 OR _month > 12 THEN
     RAISE EXCEPTION E'Parameter is outside acceptable limits!\n';
  END IF;
  SELECT INTO result
        CASE _month
             WHEN  1 THEN 'January'
             WHEN  2 THEN 'February'
             WHEN  3 THEN 'March'
             WHEN  4 THEN 'April'
             WHEN  5 THEN 'May'
             WHEN  6 THEN 'June'
             WHEN  7 THEN 'July'
             WHEN  8 THEN 'August'
             WHEN  9 THEN 'September'
             WHEN 10 THEN 'October'
             WHEN 11 THEN 'November'
             WHEN 12 THEN 'December' END;
  RETURN result;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;


select MonthName1(2);