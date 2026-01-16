SELECT
    pid
    ,datname
    ,usename
    ,application_name
    ,client_hostname
    ,client_port
    ,backend_start
    ,query_start
    ,state
FROM pg_stat_activity;

-- yada sadece aktif bağlantılar

SELECT
    pid
    ,datname
    ,usename
    ,application_name
    ,client_hostname
    ,client_port
    ,backend_start
    ,query_start
    ,query
    ,state
FROM pg_stat_activity
WHERE state = 'active';

-- sorguyu'da göster

SELECT LEFT(query,50) AS query FROM pg_stat_activity;

-- query alanının 50 karakterini veriyor
-- substring kullanmak yerine mantıklı

SELECT right(query,5) AS query
FROM pg_stat_activity;

-- buda sağdan ( sondan ) veriyor


SELECT LEFT(query,50) AS query FROM pg_stat_activity where query is not null and query != ''