create or replace function sp_test() returns setof record as $$
declare
        r record;
begin
        for r in execute 'select * from tblkisiler'
        loop
                return next r;
        end loop;

        return;
end
$$ language plpgsql;

-- select * from  sp_test() as tblkisiler (id int , adi varchar , soyadi varchar);
