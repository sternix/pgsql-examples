-- sistemde hangi backend ne kadar io işlemi yapıyor

select
    backend_type,
    sum(writes) blocks,
    -- pg_size_pretty(sum(writes * op_bytes)) size, orijinali bu
    pg_size_pretty(sum(write_bytes)) size,
    round(sum(write_time)) "time, ms"
from
    pg_stat_io
where
    writes > 0
group by rollup (backend_type)
order by blocks;
