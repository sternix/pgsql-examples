CREATE OR REPLACE FUNCTION upd_timetravel()
RETURNS TRIGGER AS
$$
BEGIN
        IF OLD.edate IS NOT NULL THEN -- NEW.edate can be non-null
                RETURN NULL; -- no update
        END IF;
        IF NEW.edate IS NULL THEN
                INSERT INTO timetravel VALUES (OLD.id, OLD.data, OLD.sdate, now());
                NEW.sdate = now();
        END IF;
        RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER upd_timetravel BEFORE UPDATE ON timetravel
FOR EACH ROW EXECUTE PROCEDURE upd_timetravel();