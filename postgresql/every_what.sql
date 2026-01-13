CREATE OR REPLACE FUNCTION every_what(start_date date,end_date date,incr integer, unit text)
RETURNS SETOF date AS $$
DECLARE
        N  integer=0;
        next_date date = start_date;
        int_type interval = '1 ' || unit;
BEGIN
        WHILE end_date > next_date
        LOOP
                RETURN NEXT next_date;
                next_date = start_date + (N + incr) * int_type;
                N = N + incr;
        END LOOP;
        RETURN;
END;
$$ LANGUAGE 'plpgsql';

select * from every_what(current_date, (current_date + interval '5 months')::date, 1, 'months' );