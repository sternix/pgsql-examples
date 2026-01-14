https://blog.dbi-services.com/modifying-pg_hba-conf-from-inside-postgresql/

select * from pg_hba_file_rules ;
select setting from pg_settings where name like '%hba%';
create table hba (lines text);

// hata veriyor
copy hba from '/opt/pgsql/13_2/data/pg_hba.conf';

select * from hba where lines !~ '^#' and lines !~ '^$';
insert into hba (lines) values ('host  all mydb  ::1/128                 trust');
select * from hba where lines !~ '^#' and lines !~ '^$';
copy hba to '/opt/pgsql/13_2/data/pg_hba.conf';
select pg_read_file('pg_hba.conf');
select pg_reload_conf();