create table items (id int, name varchar);

insert into items select id, 'item ' || id name from generate_series(1,1000) as id;

yada name kullanmamıza gerek yok

insert into items select id, 'item ' || id from generate_series(1,1000) as id;