-- splitting values

CREATE OR REPLACE FUNCTION first_n_lines(text, int)
RETURNS setof text AS $$
DECLARE
  i int := 0;
  oneline text;
BEGIN
  LOOP
    i := i + 1;
    IF i > $2 THEN
      EXIT;
    END IF;
    SELECT INTO oneline split_part($1, '\n', i);
    IF oneline = '' THEN
      EXIT;
    END IF;
    RETURN NEXT oneline;
  END LOOP;
  RETURN;
END
$$ LANGUAGE 'plpgsql';


select * from first_n_lines('abc\ndef\nghi', 2);