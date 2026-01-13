CREATE OR REPLACE FUNCTION ins_timetravel() RETURNS TRIGGER AS $$
DECLARE
        this_id TEXT;
BEGIN
        SELECT INTO this_id 1 FROM timetravel WHERE id = NEW.id AND edate IS NULL;
        IF FOUND AND NEW.edate IS NULL THEN
                UPDATE timetravel SET data=NEW.data WHERE id=NEW.id;
                RETURN NULL; -- no insert
        END IF;
        RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER ins_timetravel BEFORE INSERT ON timetravel
FOR EACH ROW EXECUTE PROCEDURE ins_timetravel();