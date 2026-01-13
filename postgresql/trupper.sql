CREATE OR REPLACE FUNCTION trupper(val varchar)
RETURNS varchar AS
$$
BEGIN
        RETURN UPPER(TRANSLATE(val,'ıi','Iİ°'));
END;
$$
LANGUAGE 'plpgsql';

-- http://ahmetsinav.blogcu.com/postgresql-ve-turkce/1434399
CREATE OR REPLACE FUNCTION tupper("varchar")
RETURNS "varchar" AS
$BODY$
BEGIN
RETURN UPPER(TRANSLATE($1,'ıi','Iİ'));
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE;