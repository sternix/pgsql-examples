SELECT
    relname as relation,
    pg_size_pretty(pg_total_relation_size(C.oid)) as total_size
FROM
    pg_class C JOIN pg_namespace N ON (N.oid = C.relnamespace)
WHERE
    nspname NOT IN ('pg_catalog','information_schema')
    AND C.relkind = 'i'
    AND nspname !~ '^pg_toast'
ORDER BY
    pg_total_relation_size(C.oid) DESC
LIMIT 10;
