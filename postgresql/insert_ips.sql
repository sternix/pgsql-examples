
CREATE OR REPLACE FUNCTION insert_ips( ip text, host text) RETURNS integer AS $$
DECLARE
        rcount integer;
BEGIN
        BEGIN
        INSERT INTO ip_hosts VALUES (ip, host);
        EXCEPTION WHEN UNIQUE_VIOLATION THEN
                RAISE NOTICE 'Duplicate Key ''%'' for ''%'' ignored.', ip, host;
        END;
        GET DIAGNOSTICS rcount = ROW_COUNT;
        RETURN rcount;
END
$$ LANGUAGE 'plpgsql';

-- bunu yerine if not found yapılabilir