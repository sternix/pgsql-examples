CREATE TABLE foo_a(i integer);
CREATE TABLE foo_b(i integer);

CREATE OR REPLACE FUNCTION trig() RETURNS trigger AS $$
BEGIN
  RAISE NOTICE 'Trigger: %,Insert to table: %,Parameter: %',
    TG_NAME, TG_RELNAME, TG_ARGV[0];
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER foo_a_trg AFTER INSERT ON foo_a
  FOR EACH ROW EXECUTE PROCEDURE trig('a');
  
CREATE TRIGGER foo_b_trg AFTER INSERT ON foo_b
  FOR EACH ROW EXECUTE PROCEDURE trig('b');

INSERT INTO foo_a VALUES(1);
INSERT INTO foo_b VALUES(1);

-- NOTICE:  Trigger: foo_a_trg,Insert to table: foo_a,Parameter: a
-- NOTICE:  Trigger: foo_b_trg,Insert to table: foo_b,Parameter: b