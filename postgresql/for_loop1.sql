do $$
begin
    for i in 1..5 loop
        raise notice 'for loop counter %',i;
    end loop;
end; $$;

do $$
begin
    for i in 1..10 by 2 loop
        raise notice 'for loop counter: %', i;
    end loop;
end; $$;

do $$
begin
    for i in reverse 5..1 loop
        raise notice 'for loop counter: %',i;
    end loop;
end; $$;