 create view showcasts as
   select t.typname as source, t1.typname as target, p.proname as function,
   (select case when c.castcontext = 'e'
      then 'Must use Explicit Cast'
      else ( select case when c.castcontext = 'i'
            then 'Implicit cast for expressions and assignments'
            else 'Implicit cast only for assignments'
            end)
      end ) as casttype
   from pg_cast c, pg_type t, pg_type t1, pg_proc p
   where c.castsource = t.oid and
      c.casttarget = t1.oid and
      c.castfunc = p.oid;