CREATE OR REPLACE FUNCTION tabsin(_p1 float, _p2 float, _p3 float)
RETURNS void AS $$
DECLARE _i float = _p1; _do float = _p2; _step float = _p3;
BEGIN
  IF NOT EXISTS(SELECT relname FROM pg_class
    WHERE relname = 'tabsin' AND relkind = 'r' AND pg_table_is_visible(oid)) THEN
    RAISE NOTICE 'Create table tabsin';
    CREATE TEMP TABLE tabsin (x NUMERIC(5,4) PRIMARY KEY, fx NUMERIC(5,4));
  ELSE
    RAISE NOTICE 'Deleting all records from table tabsin';
    TRUNCATE TABLE tabsin;
  END IF;
  WHILE _i < _do LOOP
    INSERT INTO tabsin VALUES(CAST(_i AS NUMERIC(5,4)), SIN(_i));
    _i := _i + _step;
  END LOOP;
END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM tabsin WHERE x=0.1234;