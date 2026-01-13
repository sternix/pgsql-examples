 CREATE OR REPLACE VIEW funcsource as
   SELECT '--create or replace function ' || n.nspname::text || '.'::text || p.proname::text || '('::text || oidvectortypes(p.proargtypes) || ')'::text ||
        'returns ' || t.typname || ' as "' || p.prosrc || '  "' ||  'language "' || l.lanname || ' ";' as func_source, proname as function, nspname as schema, t.typname as rettype,
        oidvectortypes(p.proargtypes) as args, l.lanname as language
   FROM pg_proc p, pg_type t, pg_namespace n, pg_language l
   WHERE p.prorettype = t.oid AND p.pronamespace = n.oid AND p.prolang = l.oid
   AND l.lanname <> 'c' AND l.lanname <> 'internal'  ;

