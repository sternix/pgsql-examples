-- non recursion form
CREATE OR REPLACE FUNCTION public.psqlfibnr(n integer)
 RETURNS integer
 LANGUAGE plpgsql
 IMMUTABLE STRICT
AS $function$
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
$function$


-- recursion form
CREATE OR REPLACE FUNCTION public.psqlfibr(n integer)
 RETURNS integer
 LANGUAGE plpgsql
 IMMUTABLE STRICT
AS $function$
BEGIN
  IF n < 2 THEN
    RETURN n;
  END IF;
  RETURN psqlfib(n-1) + psqlfib(n-2);
END;
$function$


-- select n, psqlfibnr(n) from generate_series(0,35,5) as n;
-- select n, psqlfib(n) from generate_series(0,35,5) as n;  