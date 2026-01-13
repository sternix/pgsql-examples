CREATE OR REPLACE FUNCTION column_in_table_sql( text, text, text)
RETURNS boolean AS
$$
SELECT CASE WHEN
(SELECT attname::text
FROM pg_catalog.pg_attribute a
   JOIN pg_catalog.pg_class c ON (a.attrelid = c.oid)
   JOIN pg_catalog.pg_namespace n ON (n.oid = c.relnamespace)
WHERE a.attname = $3 AND pg_catalog.pg_table_is_visible(c.oid)
   AND c.relname = $2 AND n.nspname=coalesce($1,'public'::text)
) IS NOT NULL
THEN 't'::boolean
ELSE 'f'::boolean
END;
$$ LANGUAGE 'sql';

select column_in_table_sql(NULL,'tbltest','id')

-- plpgsql versiyonu

CREATE OR REPLACE FUNCTION column_in_table(_nspname text, _relname text, _attname text) RETURNS boolean AS
$$
DECLARE
        ret boolean;
BEGIN
        SELECT INTO ret CASE WHEN
                (SELECT attname::text
                FROM pg_catalog.pg_attribute a
                JOIN pg_catalog.pg_class c ON (a.attrelid = c.oid)
                JOIN pg_catalog.pg_namespace n ON (n.oid = c.relnamespace)
                WHERE a.attname = _attname
                        AND pg_catalog.pg_table_is_visible(c.oid)
                        AND c.relname = _relname
                        AND n.nspname=coalesce(_nspname,'public'::text)
                ) IS NOT NULL
        THEN
                't'::boolean
        ELSE
                'f'::boolean
        END;

        RETURN ret;
END;
$$ LANGUAGE plpgsql;

select * from column_in_table(NULL,'tbltest','adi')