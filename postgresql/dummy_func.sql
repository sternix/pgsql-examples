CREATE FUNCTION dummy_func (id int) RETURNS VOID AS $$
DECLARE
BEGIN
RAISE NOTICE 'id is %', id;
END;
$$  LANGUAGE plpgsql;

set client_min_messages = 'NOTICE';
select dummy_func(1);