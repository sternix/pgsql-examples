CREATE OR REPLACE FUNCTION clean(VARCHAR)
RETURNS VARCHAR AS $$
DECLARE pom varchar DEFAULT $1;
BEGIN pom := to_ascii(lower(trim(both FROM pom)));
  pom = replace(pom,'rec' ,'records');
  pom = replace(pom,'rec.' ,'records');
  pom = replace(pom,'rc','records');
  /* replace multiple spaces by single space */
  WHILE position('  ' IN pom) <> 0
  LOOP
    pom := replace(pom, '  ',' ');
  END LOOP;
  RETURN trim(both FROM pom);
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;