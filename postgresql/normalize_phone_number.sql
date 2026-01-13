CREATE OR REPLACE FUNCTION normalise_phone_number(text)
RETURNS text AS $$
DECLARE aux text := translate($1, ' ','');
BEGIN
  IF aux ~ e'^\\+\\d{12}$' THEN
    RETURN substring(aux FROM 2);
  ELSEIF aux ~ e'^\\d{9}$' THEN
    RETURN aux;
  ELSE
    RAISE EXCEPTION 'Unexpected format of phone number "%".', $1;
  END IF;
END;
$$ LANGUAGE plpgsql STRICT IMMUTABLE;


-- select normalise_phone_number('+420 222 222 222');
-- select normalise_phone_number('+420 222 222222');
-- select normalise_phone_number('+420 22 222222');
-- select normalise_phone_number('724 191 000');
