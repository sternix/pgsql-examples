CREATE OR REPLACE FUNCTION nonull_append_strings (text, text ) RETURNS text AS $$
        SELECT CASE WHEN $1 IS NULL THEN $2
                WHEN $2 IS NULL THEN $1
                ELSE $1 || ' ' || $2
        END;
$$ LANGUAGE sql IMMUTABLE;

CREATE OPERATOR ||+ ( LEFTARG = TEXT, RIGHTARG = TEXT, PROCEDURE = nonull_append_strings );

UPDATE companies_fti SET all_text = ( name ||+ summary ||+ description ||+ pr ||+ comments )
FROM companies
WHERE companies.id = companies_fti.id;