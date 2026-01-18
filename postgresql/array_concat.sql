-- Array Concat
-- max yerine $1 kullanılabilir

create or replace function array_concat(max int)
returns varchar[] as
$$
declare
    arr varchar[] := '{}';
begin
    for i in 1..max loop
        arr = arr || i::varchar;
    end loop;
    return arr;
end;
$$ language plpgsql;

-- select array_concat(1000000);