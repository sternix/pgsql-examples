-- https://gist.github.com/drob/4923ab4ab569c9770aee

SELECT
  nspname,
  relname,
  dead_tuples,
  autovacuum_threshold,
  dead_tuples > autovacuum_threshold AS overdue
FROM (
  SELECT
    nspname,
    relname,
    pg_stat_get_dead_tuples(pg_class.oid) AS dead_tuples,
    round(current_setting('autovacuum_vacuum_threshold')::INTEGER
        + current_setting('autovacuum_vacuum_scale_factor')::NUMERIC * reltuples) AS autovacuum_threshold
  FROM pg_class, pg_namespace
  WHERE pg_class.relnamespace = pg_namespace.oid
) t
ORDER BY overdue DESC;