CREATE OR REPLACE FUNCTION test(INT[]) RETURNS TEXT AS $$
DECLARE
   mya alias for $1;
   myret text = '';
   low int;
   high int;
BEGIN
   low  := replace(split_part(array_dims(mya),':',1),'[','')::int;
   high := replace(split_part(array_dims(mya),':',2),']','')::int;

   FOR i IN low..high LOOP
     myret := myret || '|' || mya[i];
   END LOOP;

   RETURN myret;
END;
$$ LANGUAGE 'plpgsql';


select test('{1,2,3,4}'::int[]);