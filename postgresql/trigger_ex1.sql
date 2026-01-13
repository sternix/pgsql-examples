DROP SEQUENCE codebook_id_seq;
DROP TABLE codebook;

CREATE TABLE codebook (
  id SERIAL PRIMARY KEY,
  description VARCHAR(100) CHECK (description <> '')
);

CREATE OR REPLACE FUNCTION trig_static_id() RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'UPDATE' AND NEW.id <> OLD.id THEN
    RAISE EXCEPTION 'You can not update PRIMARY KEY column on table %', TG_RELNAME;
  ELSE
    RETURN NEW;
  END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER static_id_codebook
  BEFORE UPDATE ON codebook
  FOR EACH ROW EXECUTE PROCEDURE trig_static_id();