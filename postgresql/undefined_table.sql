
CREATE TABLE exceptions(
    id serial primary key,
    MESSAGE text,
    DETAIL text,
    HINT text,
    ERRCODE text
);

INSERT INTO exceptions (message, detail, hint, errcode) VALUES ('wrong', 'really wrong!', 'fix this problem', 'P0000');

CREATE OR REPLACE FUNCTION foo() RETURNS int LANGUAGE plpgsql AS
$$
DECLARE
    row record;
BEGIN
    PERFORM * FROM fox; -- does not exist, undefined_table, fail

    EXCEPTION
        WHEN undefined_table THEN
            SELECT * INTO row FROM exceptions WHERE id = 1; -- get your exception
            RAISE EXCEPTION USING MESSAGE = row.message, DETAIL = row.detail, HINT = row.hint, ERRCODE = row.errcode;

    RETURN 1;
END;
$$

SELECT foo();