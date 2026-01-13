-- Converting a comma seperated list into rows

create or replace function unravel(v_list text) returns SETOF int as $$
declare
        v_delim text := ',';
        v_arr text[];
begin
        v_arr := string_to_array(v_list, v_delim);
        for i in array_lower(v_arr, 1)..array_upper(v_arr, 1)
        loop
                return next v_arr[i]::int;
        end loop;
        return;
end;
$$ language plpgsql;


select * from unravel('1,2,3,4,5');