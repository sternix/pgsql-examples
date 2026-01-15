-- çalışan sorgular

SELECT pid, age(clock_timestamp(), query_start), usename, query
    FROM pg_stat_activity
WHERE query != '<IDLE>' AND query NOT ILIKE '%pg_stat_activity%'
ORDER BY query_start desc;


-- https://gist.github.com/rgreenjr/3637525

-- show running queries (9.2)
SELECT pid, age(clock_timestamp(), query_start), usename, query
FROM pg_stat_activity
WHERE query != '<IDLE>' AND query NOT ILIKE '%pg_stat_activity%'
ORDER BY query_start desc;

-- bu daha güzel
SELECT pid, age(clock_timestamp(), query_start), usename, query
FROM pg_stat_activity
WHERE query != '<IDLE>' AND query NOT ILIKE '%pg_stat_activity%' and query NOT LIKE '<%'
ORDER BY query_start desc;

