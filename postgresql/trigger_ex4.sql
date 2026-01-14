CREATE FUNCTION test_trg() RETURNS TRIGGER AS $$
DECLARE
BEGIN
    raise notice 'Trigger called % % on %, for each %', TG_WHEN, TG_OP, TG_TABLE_NAME, TG_LEVEL;
    IF TG_OP = 'DELETE' THEN
        RETURN OLD;
    ELSE
        RETURN NEW;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER xx
    BEFORE INSERT ON test
    FOR each ROW EXECUTE FUNCTION
    test_trg();
