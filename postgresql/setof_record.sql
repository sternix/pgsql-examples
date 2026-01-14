create table tbl1 (
        id serial primary key,
        a varchar(25)
);

create or replace function get_tbl1() returns setof record as
$$
declare
t record;
begin
for t in EXECUTE 'select * from tbl1'
loop
        return next t;
end loop;
return;
end
$$
language 'plpgsql';


create or replace function get_tbl1() returns setof record as
$$
declare
t record;
begin
for t in select * from tbl1
loop
        return next t;
end loop;
return;
end
$$
language 'plpgsql';

-- normal select * from get_tbl1() olmuyor
select * from get_tbl1() as (a int , b varchar)
select * from get_tbl1() as tbl1 (a int , b varchar)