create or replace function f2() returns setof tbltest as $$
declare t tbltest%rowtype;
begin
        create temp table sdfsd as select * from tbltest;
        for t in select * from tbltest
        loop
                return next t;
        end loop;
        drop table sdfsd;
        return;
end;
$$ language plpgsql;

select * from f2();