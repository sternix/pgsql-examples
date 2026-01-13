CREATE FUNCTION letter_fk () RETURNS TRIGGER AS '
DECLARE
        ind     integer;
BEGIN
        FOR ind IN array_dims(NEW.letters) LOOP
                PERFORM 1 FROM lettervals WHERE id = NEW.letters[ind];
                IF NOT FOUND THEN
                        RAISE EXCEPTION
                                ''My foreign key constraint violation'';
                END IF;
        END LOOP;
        RETURN NEW;
END;
' AS LANGUAGE 'plpgsql';

CREATE TRIGGER lettercheck BEFORE INSERT ON foo
FOR EACH row
EXECUTE PROCEDURE letter_fk();