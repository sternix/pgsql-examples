SELECT relname, n_dead_tup, last_vacuum, last_autovacuum FROM
pg_catalog.pg_stat_all_tables
WHERE n_dead_tup > 0 and relname = 'tbltest';

-- dead tuples olan tablolar ne zaman vacuum gördü

SELECT relname, n_dead_tup, last_vacuum, last_autovacuum FROM
pg_catalog.pg_stat_all_tables
WHERE n_dead_tup > 0;

-----

select
    relfrozenxid, age(relfrozenxid)
from
    pg_class
where
    relname = 'tbltest';

show vacuum_freeze_table_age;

show vacuum_freeze_min_age;

vacuum_freeze_table_age - vacuum_freeze_min_age

eğer autovacuumu kapatsak bile
show autovacuum_freeze_max_age;
bu değer kadar transaction geçtiğinde
autovauum işlemini otomatik olarak başlatır