CREATE TYPE monthnum as
(
        num INTEGER,
        month TEXT
);

CREATE OR REPLACE FUNCTION monthnums()
RETURNS SETOF monthnum AS
$$
DECLARE
        monrow monthnum%ROWTYPE;
        i integer;
        mon text;
BEGIN
        FOR  i IN 1..12
        LOOP
                SELECT INTO mon to_char((i::text || '/03/' || '15')::date, 'Mon');
                monrow.num = i;
                monrow.month = mon;
                RETURN NEXT monrow;
        END LOOP;
        RETURN;
END;
$$ LANGUAGE 'plpgsql';

COMMENT ON FUNCTION monthnums() IS
$$
Returns type monthnum tuples like (1, 'Jan')(2, 'Feb'), etc.
$$;

select monthnums();

CREATE VIEW monthnums AS
SELECT s.i+1 , to_char(date_trunc('year', current_date) + s.i * '1 month'::interval, 'Month')
FROM generate_series(0,11) AS s(i);

COMMENT ON VIEW monthnums IS
$$
Returns tuples like (1, 'Jan')(2, 'Feb'), etc.
$$;

select * from monthnums