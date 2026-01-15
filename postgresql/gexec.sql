-- https://www.depesz.com/2021/01/17/are-there-limits-to-partition-counts/

-- psql'de kullanılabilir

$ CREATE TABLE test_ranged (
    id serial PRIMARY KEY,
    payload TEXT
) partition BY range (id);

$ SELECT format('CREATE TABLE %I partition OF test_ranged FOR VALUES FROM (%s) to (%s);', 'test_ranged_' || i, i, i+1)
    FROM generate_series(1,10000) i \gexec

$ SELECT format('CREATE TABLE %I partition OF test_ranged FOR VALUES FROM (%s) to (%s);', 'test_ranged_' || i, i, i+1)
    FROM generate_series(10001, 20000) i \gexec

$ SELECT format('CREATE TABLE %I partition OF test_ranged FOR VALUES FROM (%s) to (%s);', 'test_ranged_' || i, i, i+1)
    FROM generate_series(20001, 30000) i \gexec

$ SELECT format('CREATE TABLE %I partition OF test_ranged FOR VALUES FROM (%s) to (%s);', 'test_ranged_' || i, i, i+1)
    FROM generate_series(30001, 40000) i \gexec

$ SELECT format('CREATE TABLE %I partition OF test_ranged FOR VALUES FROM (%s) to (%s);', 'test_ranged_' || i, i, i+1)
    FROM generate_series(40001, 50000) i \gexec

$ SELECT format('CREATE TABLE %I partition OF test_ranged FOR VALUES FROM (%s) to (%s);', 'test_ranged_' || i, i, i+1)
    FROM generate_series(50001, 60000) i \gexec

$ SELECT format('CREATE TABLE %I partition OF test_ranged FOR VALUES FROM (%s) to (%s);', 'test_ranged_' || i, i, i+1)
    FROM generate_series(60001, 70000) i \gexec

------

select 'create table tt'||gen||' (a int, b int )'||';' from generate_series(1,20) gen;

select 'create table tt'||gen||' (a int, b int )'
  from generate_series(1,20) gen
\gexec

select 'create table tt'||gen||' (a int, b int )' from generate_series(1,20) gen \gexec

------

with tabs as
( select 'tt'||a tab
    from generate_series(1,20) a
)
select format('create index on %I',b.tab)||format('(%I)' ,c.attname)
  from tabs b
     , pg_attribute c
 where c.attrelid = b.tab::varchar::regclass
   and c.attnum > 0
  order by 1
\gexec

------

select 'drop table tt'||gen
  from generate_series(1,20) gen
\gexec

------

https://www.cybertec-postgresql.com/en/gexec-psql-postgresql-poweruser-practice/

postgres=# SELECT 'GRANT SELECT ON TABLE ' || tablename || ' TO someuser;' FROM pg_tables WHERE tablename~'^pgbench';
?column?
-----------------------------------------------------
GRANT SELECT ON TABLE pgbench_accounts TO someuser;
GRANT SELECT ON TABLE pgbench_branches TO someuser;
GRANT SELECT ON TABLE pgbench_history TO someuser;
GRANT SELECT ON TABLE pgbench_tellers TO someuser;
(4 rows)

postgres=# \gexec
GRANT
GRANT
GRANT
GRANT

------

SELECT 'GRANT ' || action || ' ON TABLE ' || tablename || ' TO someuser;' FROM pg_tables CROSS JOIN (VALUES ('INSERT'),('UPDATE'),('DELETE')) AS t(action) WHERE tablename~'^pgbench';

....

\gexec

