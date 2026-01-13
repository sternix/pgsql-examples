CREATE OR REPLACE FUNCTION generate_string(integer) RETURNS SETOF varchar AS $$
BEGIN
    FOR _i IN 1 .. $1 LOOP 
        RETURN NEXT '<item>'||_i||'</item>';
    END LOOP;
    RETURN;
END; $$ LANGUAGE plpgsql;

SELECT array_to_string(ARRAY(SELECT * FROM generate_string(1000)), '');