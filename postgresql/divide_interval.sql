CREATE OR REPLACE FUNCTION div_op(a interval, b interval)
RETURNS double precision AS $$
BEGIN
  -- note - better to use SQL language
  RETURN EXTRACT(EPOCH FROM a) / EXTRACT(EPOCH FROM b);
END;
$$ LANGUAGE plpgsql IMMUTABLE RETURNS NULL ON NULL INPUT;

CREATE OPERATOR / (procedure = div_op, leftarg = interval, rightarg = interval);

-- select '1hour'::interval / '10min'::interval;
