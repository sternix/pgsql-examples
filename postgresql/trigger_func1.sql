CREATE OR REPLACE FUNCTION trig_build_object_F() RETURNS OPAQUE AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    DELETE FROM object WHERE code = OLD.code;
    RETURN OLD;
  ELSE
    IF TG_OP = 'UPDATE' THEN
      UPDATE object SET code = NEW.code, description = NEW.description WHERE code = OLD.code;
      RETURN NEW;
    ELSE
      INSERT INTO object VALUES(NEW.code, NEW.description,
        CASE TG_RELNAME WHEN 'source1' THEN 1 WHEN 'source2' THEN 2 END);
      RETURN NEW;
    END IF;
  END IF;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER t_source1
  BEFORE INSERT OR UPDATE OR DELETE ON source1
  FOR EACH ROW EXECUTE PROCEDURE trig_build_object_F();

CREATE TRIGGER t_zdroj2
  BEFORE INSERT OR UPDATE OR DELETE ON source2
  FOR EACH ROW EXECUTE PROCEDURE trig_build_object_F();