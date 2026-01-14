-- https://reconshell.com/postgresql-drop-trigger/

CREATE FUNCTION check_staff_user()
    RETURNS TRIGGER
AS $$
BEGIN
    IF length(NEW.username) < 8 OR NEW.username IS NULL THEN
        RAISE EXCEPTION 'The username cannot be less than 8 characters';
    END IF;
    IF NEW.NAME IS NULL THEN
        RAISE EXCEPTION 'Username cannot be NULL';
    END IF;
    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER username_check
    BEFORE INSERT OR UPDATE
ON staff
FOR EACH ROW
    EXECUTE PROCEDURE check_staff_user();

DROP TRIGGER username_check ON staff;
