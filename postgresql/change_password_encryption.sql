show password_encryption;
create user u1 login password 'u1';
select passwd from pg_shadow where usename = 'u1';
alter system set password_encryption = 'scram-sha-256';
select pg_reload_conf();
select current_setting('password_encryption');


pg_hba.conf'ta "md5"'i "scram-sha-256" olarak değiştir

select passwd from pg_shadow where usename = 'user';
md5dfgd....

\password

select passwd from pg_shadow where usename = 'user';
 SCRAM-SHA-256$4096:dfd....

md5'ler hala kullanılıyor,
fakat şifreyi yenileyenlerinki SHA'a geçiyor

pgbouncer'da vs tekrar kullanıcıların şifrelerini değiştirmek mantıklı
