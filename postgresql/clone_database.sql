-- veritabanı clone'lamak

CREATE DATABASE newdb WITH TEMPLATE originaldb OWNER dbuser;

--eğer kullanıcı bağlıysa
ERROR:  source database "originaldb" is being accessed by other users

SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'originaldb' AND pid <> pg_backend_pid();

yada

CREATE DATABASE new_database_name;
GRANT ALL PRIVILEGES ON DATABASE new_database_name TO my_user;
\d

pg_dump old_database_name | psql new_database_name

pg_dump production-db | psql test-db