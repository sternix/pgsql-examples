CREATE TYPE topscores AS (id integer, query integer, checksum char(2), score integer);

CREATE OR REPLACE FUNCTION topscores(integer) RETURNS SETOF topscores AS $$
DECLARE
   t topscores%ROWTYPE;
   r RECORD;
   q RECORD;
   n alias for $1;
BEGIN
        FOR q IN SELECT distinct query from table70 order by query
        LOOP
                FOR t IN SELECT id , query, checksum, score FROM table70 where query = q.query ORDER BY query, score DESC LIMIT n
                LOOP
                        RETURN NEXT t;
                END LOOP;
        END LOOP;
        RETURN;
END;
$$ language 'plpgsql';