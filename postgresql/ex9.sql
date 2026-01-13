select testset.info,  avg(load_avg) as load_avg,
    pg_size_pretty(avg(swap_free::numeric * 1024)) as swap_free_avg,
    pg_size_pretty(avg((pages_available::numeric * sys_stats.page_size)))
      as least_free_mem,
    pg_size_pretty(avg(page_cache::numeric * 1024)) as max_page_cache_size
  from tests
    inner join testset on testset.set = tests.set
    inner join sys_stats on
          measured_at > tests.start_time and
          measured_at < tests.end_time
    group by testset.info
    order by testset.info;
