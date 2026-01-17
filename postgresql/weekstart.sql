CREATE OR REPLACE FUNCTION weekstart(year int4,week int4)
RETURNS TIMESTAMP AS
$$
DECLARE
   startsin TIMESTAMP;
BEGIN
   SELECT INTO startsin (SELECT  CAST(year || ''-01-01'' AS TIMESTAMP) - (date_part(''dow'',CAST(year || ''-01-01'' AS TIMESTAMP))||'' days'')::INTERVAL) + ((week*7)||'' days'')::INTERVAL - ''7 days''::INTERVAL;
   RETURN startsin;
END;
$$ LANGUAGE 'plpgsql';