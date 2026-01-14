SELECT current_database();
SELECT current_user;
// DB address. Will be blank when using sockets
SELECT inet_server_addr(), inet_server_port();
SELECT version();
SELECT date_trunc('second', current_timestamp - pg_postmaster_start_time()) as uptime;
// number of tables in given db
SELECT count(*) FROM information_schema.tables WHERE table_schema NOT IN ('information_schema','pg_catalog');
SELECT pg_size_pretty(pg_database_size(current_database()));
SELECT pg_size_pretty(pg_relation_size('tbltest'));
// total size of a table, including indexes and other related spaces
SELECT pg_size_pretty(pg_total_relation_size('tbltest'));
SELECT * FROM pg_extension;
// print file locations
SHOW config_file;
SHOW hba_file;
SHOW ident_file;

--sadece psql'de çalışıyor
\conninfo
