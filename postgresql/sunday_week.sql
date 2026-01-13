create or replace function sunday_week(timestamptz) returns date as $$
DECLARE
   dy integer;
   ret date;
BEGIN
   dy := extract('dow' from $1 );
   ret := $1 - ( dy || ' days ')::interval;
   return ret::date;
END;
$$ language 'plpgsql';


create or replace function saturday_week(timestamptz) returns date as $$
DECLARE
   dy integer;
   ret date;
BEGIN
   dy := 6 - extract('dow' from $1 );
   ret := $1 + ( dy || ' days ')::interval;
   return ret::date;
END;
$$ language 'plpgsql';


select sunday_week(now());
select saturday_week(now());


select sunday_week('4/6/04'::timestamp);
select saturday_week('4/6/04'::timestamp);