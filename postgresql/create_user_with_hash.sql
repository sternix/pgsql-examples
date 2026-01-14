sadece admin kullanıcısı görebiliyor

select passwd from pg_shadow where usename = 'user';

create user w login encrypted password 'md56277e2a744d05j98edc9bcf0a4bc1a8f';

pg_dumpall --globals-only > a.sql

ALTER ROLE w WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS PASSWORD 'md56277e2a844d05j98edc9bcf0a4bc1a8f';