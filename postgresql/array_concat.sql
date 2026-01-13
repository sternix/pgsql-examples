-- Array Concat
-- max yerine $1 kullanılabilir

create or replace function foo(max int) returns varchar[] as $$
 declare
   arr varchar[] := '{}';
 begin
   for i in 1..max loop
     arr = arr || i::varchar;
   end loop;
 return arr;
end;
$$ language plpgsql;

-- select foo(1000000);