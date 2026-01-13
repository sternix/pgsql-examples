-- int tipi ile

create or replace function f1() returns setof int as $$
declare
        kid int;
begin
        for kid in select id from tbltest
        loop
                return next kid;
        end loop;
        return;
end;
$$ language plpgsql;


-- record tipi ile

create or replace function f1() returns setof int as $$
declare
        k record;
begin
        for k in select * from tbltest
        loop
                return next k.id;
        end loop;
        return;
end;
$$ language plpgsql;