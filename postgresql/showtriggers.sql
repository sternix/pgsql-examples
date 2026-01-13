create view showtriggers as
        select trg.tgname as trigger_name , tbl.relname as table_name,
              p.proname as function_name,
               case trg.tgtype & cast(2 as int2)
                 when 0 then 'AFTER'
                 else 'BEFORE'
               end as trigger_type,
               case trg.tgtype & cast(28 as int2)
                 when 16 then 'UPDATE'
                 when 8 then 'DELETE'
                 when 4 then 'INSERT'
                 when 20 then 'INSERT, UPDATE'
                 when 28 then 'INSERT, UPDATE, DELETE'
                 when 24 then 'UPDATE, DELETE'
                 when 12 then 'INSERT, DELETE'
               end as trigger_event
        from pg_trigger trg, pg_class tbl, pg_proc p
        where trg.tgrelid = tbl.oid and trg.tgfoid = p.oid;

select * from showtriggers