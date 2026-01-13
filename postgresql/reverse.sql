CREATE OR REPLACE FUNCTION reverse(original TEXT) RETURNS TEXT AS $$
DECLARE
        reversed TEXT := '\';
        onechar  VARCHAR;
        mypos    INTEGER;
BEGIN
        SELECT LENGTH(original) INTO mypos;
        LOOP
                EXIT WHEN mypos < 1;
                SELECT substring(original FROM mypos FOR 1) INTO onechar;
                reversed := reversed || onechar;
                mypos := mypos -1;
        END LOOP;
        RETURN reversed;
END
$$ LANGUAGE plpgsql;

select reverse('abcdefghıijklmn')