alter table t1 add column c int generated always as (a*2) stored;
alter table t1 add column d int generated always as (3*2) stored;
alter table t1 add column e int generated always as (random()) stored;
alter table t1 add column e text generated always as (md5(b)) stored;