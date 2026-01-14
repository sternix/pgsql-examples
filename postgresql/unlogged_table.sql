unlogged table does not have to write the data twice (no WAL needed)

test=# SELECT pg_current_wal_lsn();
pg_current_wal_lsn
--------------------
5/3AC7CCD0
(1 row)

test=# ALTER TABLE t_sample SET LOGGED;
ALTER TABLE

test=# SELECT pg_current_wal_lsn();
pg_current_wal_lsn
--------------------
5/3F9048A8
(1 row)

lsn'ler ile çıkarma işlemi yapılabiliyor

SELECT '5/3F9048A8'::pg_lsn - '5/3AC7CCD0'::pg_lsn;
?column?
-----------
80247768
(1 row)

Time: 11.298 ms

Wow, we have produced 80 MB of WAL (if you do exactly one COPY on an empty table - the amount will grow if you run more imports)

------

CREATE UNLOGGED TABLE pgbench_accounts_lag_local (LIKE pgbench_accounts INCLUDING ALL);

INSERT INTO pgbench_accounts_lag_local SELECT * FROM dblink('host=10.110.0.5', 'select aid, bid, abalance, filler from pgbench_accounts') AS x(aid int, bid int, abalance int, filler text);

VACUUM ANALYZE pgbench_accounts_lag_local;
