CREATE OR REPLACE FUNCTION drop_students_databases(_mask varchar(100))
RETURNS INTEGER AS $$
DECLARE
  db RECORD;
  deleted INTEGER := 0;
  helpstr VARCHAR(300);
BEGIN
  IF length(_mask) = 0 OR _mask ISNULL OR current_user() <> 'postgres' THEN
    helpstr  := E'Function for dropping databases of users whose\n' ||
      E'name (the name of user) suits the mask of order LIKE.\n\n' ||
      E'e.g. SELECT drop_students_databases(' || quote_literal('group%') || ')\n\n' ||
      E'note you have to be loged in as user postgres.\n' ||
      E'author: Pavel Stehule, stehule@kix.fsv.cvut.cz 19.1.2002\n';
    IF current_user <> 'postgres' THEN
      RAISE EXCEPTION E'Function might be called only by user postgres\n\n%', helpstr;
    ELSE
      RAISE EXCEPTION E'Argument of the function must be a non-empty string\n\n%', helpstr;
    END IF;
  END IF;
  FOR db IN
    SELECT datname, usename
       FROM pg_database, pg_user
      WHERE datdba=usesysid AND usename LIKE _mask
  LOOP
    deleted := deleted + 1;
    RAISE NOTICE 'Drop database %,%', db.datname, db.usename;
    EXECUTE 'drop database ' || quote_ident(db.datname);
  END LOOP;
  RETURN deleted;
END;
$$ LANGUAGE plpgsql;