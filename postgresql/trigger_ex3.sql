BEGIN;

CREATE TABLE row_counts (
  relname   text PRIMARY KEY,
  reltuples bigint
);

-- establish initial count
INSERT INTO row_counts (relname, reltuples)
  VALUES ('items', (SELECT count(*) from items));

CREATE OR REPLACE FUNCTION adjust_count()
RETURNS TRIGGER AS
$$
   DECLARE
   BEGIN
   IF TG_OP = 'INSERT' THEN
      EXECUTE 'UPDATE row_counts set reltuples=reltuples +1 where relname = ''' || TG_RELNAME || '''';
      RETURN NEW;
   ELSIF TG_OP = 'DELETE' THEN
      EXECUTE 'UPDATE row_counts set reltuples=reltuples -1 where relname = ''' || TG_RELNAME || '''';
      RETURN OLD;
   END IF;
   END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER items_count BEFORE INSERT OR DELETE ON items
  FOR EACH ROW EXECUTE PROCEDURE adjust_count();

COMMIT;