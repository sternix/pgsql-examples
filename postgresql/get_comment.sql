create type comments_t AS (thing text, oname text, comment text);

create or replace function get_comment(text, text)
returns setof comments_t as
$$
DECLARE
   ret comments_t%ROWTYPE;
   rec RECORD;
   objtype alias for $1;
   iname alias for $2;
   tbl text;
   qry text;
   types text;
BEGIN
   ret.thing = objtype;
   IF objtype = 'table'
   THEN
      tbl = 'pg_class';
      qry := $q1$select relname as oname , obj_description( p.oid, '$q1$ || tbl ||
         $q2$') as comm from pg_class p where relname = '$q2$ || iname || $q3$';$q3$;

   ELSIF objtype = 'function'
   THEN
      tbl := 'pg_proc';
      qry := $q4$select proname || oidvectortypes(proargtypes) as oname,
         obj_description( oid, '$q4$ || tbl || $q5$' ) as comm from $q5$ ||
         tbl || $q6$ where proname = '$q6$ || iname || $q7$';$q7$;
   ELSE
      RAISE EXCEPTION $q$USAGE: get_comment( 'table | function', object_name )$q$;
   END IF;
   FOR rec IN EXECUTE qry
   LOOP
      ret.oname = rec.oname;
      ret.comment = rec.comm;
      RETURN NEXT ret;
   END LOOP;
   RETURN ;
END;
$$ LANGUAGE plpgsql;
