create or replace function hex_to_int(char(2)) returns integer as $$
declare
        v_ret record;
begin
        for v_ret in execute 'select x''' || $1 || '''::int as f'
        loop
                return v_ret.f;
        end loop;
end;
$$ language 'plpgsql';