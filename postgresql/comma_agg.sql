CREATE OR REPLACE FUNCTION comma_aggreg(state text,p text) RETURNS text AS $$
BEGIN
  IF p IS NULL THEN
    RETURN state;
  END IF;
  IF length(state) > 0 THEN
    IF position(p in state) = 0 THEN
      RETURN state || ', ' || p;
    ELSE
      RETURN state;
    END IF;
  ELSE
    RETURN p;
  END IF;
END;
$$ LANGUAGE plpgsql IMMUTABLE;



DROP AGGREGATE comma(text);

CREATE AGGREGATE comma (
  basetype = text,
  sfunc = comma_aggreg,
  stype = text,
  initcond = ''
);

SELECT comma(name) FROM names;