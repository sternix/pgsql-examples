CREATE OR REPLACE FUNCTION drop_table(TEXT) RETURNS VOID AS $$
BEGIN
        BEGIN
                EXECUTE 'DROP TABLE ' || $1;
                EXCEPTION WHEN UNDEFINED_TABLE THEN
                        RAISE NOTICE 'Table % not defined.  Moving on anyhow.', $1;
                        RETURN;
        END;
        RAISE NOTICE 'Dropped table %', $1;
        RETURN;
END;
$$ LANGUAGE plpgsql


COMMENT ON FUNCTION drop_table(TEXT) IS
$$
   This function drops a table if it exists and does not raise
   an error if it does not exist.
$$;
