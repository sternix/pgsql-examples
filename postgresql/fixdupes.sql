 create or replace function fixdupes()
   returns void as '
      DECLARE
         d record;
      BEGIN
         for d in select *
               from rawlog
               group by ldate, ltime, doc, ip, method, qs, code, dsize
               having count(*) > 1 limit 1
         loop
               delete from rawlog
               where ldate=d.ldate and ltime=d.ltime and
               doc=d.doc and ip=d.ip and method=d.method and
               qs=d.qs and code=d.code and dsize=d.dsize;

               insert into rawlog values (d.ip, d.ldate, d.ltime,
               d.method, d.doc, d.qs, d.code, d.dsize);
         end loop;
      RETURN;
   END;
' language 'plpgsql';