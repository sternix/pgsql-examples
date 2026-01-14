CREATE PROCEDURE dummy_proc (id int) AS $$
DECLARE
BEGIN
    raise notice 'id is %', id;
END;
$$ LANGUAGE plpgsql;

call dummy_proc(1);