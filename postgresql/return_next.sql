CREATE OR REPLACE FUNCTION foo(
        open_id numeric,
        OUT p1 varchar,
        OUT p2 varchar,
        OUT p3 varchar
)
RETURNS SETOF RECORD AS
$$
BEGIN
    p1 := '1'; p2 := '2'; p3 := '3';
    raise notice 'bir';
    RETURN NEXT;

    p1 := '3'; p2 := '4'; p3 := '5';
    raise notice 'iki';
    RETURN NEXT;

    p1 := '3'; p2 := '4'; p3 := '5';
    raise notice 'uc';
    RETURN NEXT;

    RETURN;
END;
$$ LANGUAGE plpgsql;

select * from foo(1);