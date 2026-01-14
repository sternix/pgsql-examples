SELECT
	table_name,
	pg_relation_size(table_schema || '.' || table_name) as size,
	pg_size_pretty(pg_relation_size(table_schema || '.' || table_name)) as pretty
FROM
	information_schema.tables
WHERE
	table_schema NOT IN ('information_schema', 'pg_catalog')
ORDER BY size DESC
LIMIT 10;