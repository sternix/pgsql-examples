CREATE TYPE tf AS (f1 varchar(10), f2 varchar(10));

CREATE OR REPLACE FUNCTION makesettf(mx integer)
RETURNS SETOF tf AS $$
DECLARE f tf%ROWTYPE;
BEGIN
  FOR i IN 1..mx
  LOOP
    f.f1 := CAST(i AS varchar(10));
    f.f2 := 'bbbbb '||CAST(i AS varchar(10));
    RAISE NOTICE '%', f.f1;
    RETURN NEXT f;
  END LOOP;
  RETURN;
END;
$$ LANGUAGE plpgsql;

SELECT a.*, b.*
   FROM makesettf(10) a
        JOIN
        makesettf(5) b
        ON a.f1 = b.f1;

SELECT * FROM makesettf(3)
UNION ALL
SELECT * FROM makesettf(8);