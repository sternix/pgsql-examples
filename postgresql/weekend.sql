CREATE OR REPLACE FUNCTION weekend(year int4,week int4)
RETURNS TIMESTAMP
AS'
   DECLARE
      endsin TIMESTAMP;
   BEGIN

      SELECT INTO endsin
         (SELECT  CAST(year || ''-01-01'' AS TIMESTAMP) -
         (date_part(''dow'',CAST(year || ''-01-01'' AS TIMESTAMP))||'' days'')::INTERVAL) +
         ((week*7)||'' days'')::INTERVAL - ''1 days''::INTERVAL;

      RETURN endsin;
   END;
' LANGUAGE 'plpgsql';