CREATE OR REPLACE FUNCTION op_xor (a boolean, b boolean)
RETURNS boolean AS $$
BEGIN
  -- better use SQL language!
  RETURN ((NOT a) AND b) OR (a AND (NOT b));
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;

-- DROP OPERATOR # (boolean, boolean);

CREATE OPERATOR # (
  procedure = op_xor,
  leftarg = boolean,
  rightarg = boolean,
  commutator = #
);

---------8<--------------------------

CREATE OR REPLACE FUNCTION op_imp (a boolean, b boolean)
RETURNS boolean AS $$
BEGIN
  RETURN (a OR NOT b);
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;

-- sql hali
CREATE OR REPLACE FUNCTION op_imp(a boolean,b boolean)
RETURNS boolean AS $$
SELECT ($1 OR NOT $2)
$$ LANGUAGE sql;

CREATE OPERATOR >>> (
  procedure = op_imp,
  leftarg = boolean,
  rightarg = boolean,
  commutator = >>>
);

---------8<--------------------------

DROP TABLE logtab;

CREATE TABLE logtab (l boolean, p boolean);

INSERT INTO logtab VALUES(FALSE,FALSE);
INSERT INTO logtab VALUES(TRUE,FALSE);
INSERT INTO logtab VALUES(FALSE,TRUE);
INSERT INTO logtab VALUES(TRUE,TRUE);

SELECT l, p, l # p AS XOR FROM logtab;
SELECT l, p, l >>> p AS IMPL FROM logtab;