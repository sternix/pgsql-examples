-- https://pbs.twimg.com/media/E9QvBrMVkAEmX9z?format=jpg

SELECT
    schemaname AS schema_name,
    relname AS relation_name,
    indexrelname AS idx_relation_name,
    idx_scan,
    idx_tup_read,
    idx_tup_fetch,
    pg_size_pretty(pg_relation_size(relid)) as idx_size
FROM
    pg_stat_all_indexes
WHERE
    schemaname NOT IN ('pg_catalog','pg_toast')
    AND idx_scan = 0
    AND idx_tup_read = 0
    AND idx_tup_fetch = 0
ORDER BY
    pg_relation_size(relid) DESC;