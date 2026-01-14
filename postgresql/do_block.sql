do $$
      declare
        child oid;
      begin
        for child in select inhrelid from pg_inherits where inhparent = 'parent'::regclass
        loop
            execute 'alter table ' || child::regclass || ' drop column if exists some_column';
        end loop;
      end;
$$;