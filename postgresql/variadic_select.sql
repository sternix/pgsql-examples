create or replace function GetRows1(text) returns setof record as
$$
declare
        r record;
begin
        for r in EXECUTE 'select * from ' || $1
        loop
                return next r;
        end loop;

        return;
end
$$
language 'plpgsql';

select * from GetRows1('tbltest') as test  (id int , adi varchar , soyadi varchar)



create or replace function GetRows2(text) returns setof record as
$$
declare
        r record;
begin
        for r in EXECUTE 'select * from ' || $1
        loop
                if r.id != 27 then
                        return next r;
                end if;
        end loop;

        return;
end
$$
language 'plpgsql';


select * from GetRows2('tbltest') as test  (id int , adi varchar , soyadi varchar)