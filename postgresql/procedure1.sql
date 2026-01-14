CREATE PROCEDURE test( IN elements INT4, OUT created int4[], OUT failed int4[] ) LANGUAGE plpgsql AS $$
DECLARE
    i int4;
BEGIN
    FOR i IN 1 .. elements loop
        IF random() < 0.5 THEN
            failed := failed || i;
        ELSE
            created := created || i;
        END IF;
    END loop;
END;
$$;


CALL test(15, '{}'::int4[], '{}'::int4[]);

-- One thing – values given to OUT parameters don't matter – values of the output are preset to NULL before executing procedure body.

CALL test(2, '{10,11}'::int4[], '{12,13}'::int4[]);
 created | failed
---------+--------
 {2}     | {1}