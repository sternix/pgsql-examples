-- non recursion form
CREATE OR REPLACE FUNCTION psqlfibnr(n integer)
RETURNS integer AS
$$
DECLARE
  prev1 int = 0;
  prev2 int = 1;
  result int = 0;
BEGIN
  FOR i IN 1..n
  LOOP
    result := prev1 + prev2;
    prev2 := prev1;
    prev1 := result;
  END LOOP;
  RETURN result;
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT

-- recursion form
CREATE OR REPLACE FUNCTION psqlfibr(n integer)
RETURNS integer AS 
$$
BEGIN
  IF n < 2 THEN
    RETURN n;
  END IF;
  RETURN psqlfibr(n-1) + psqlfibr(n-2);
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT

-- select n, psqlfibnr(n) from generate_series(0,35,5) as n;
-- select n, psqlfibr(n) from generate_series(0,35,5) as n;

-- recursive olanı çok yavaş