-- bir tabloya update yapıldığında dead tuples hot tuples değerleri

select
    n_tup_hot_upd,
    n_tup_newpage_upd
from
    pg_stat_all_tables
where
    relname = 't';

-- counter'ları resetlemek için

select pg_stat_reset_single_table_counters('tbltest'::regclass);