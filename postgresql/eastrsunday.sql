CREATE OR REPLACE FUNCTION eastrsunday(_year INTEGER)
RETURNS DATE AS $$
DECLARE B INTEGER; D INTEGER; E INTEGER; Q INTEGER;
  DD INTEGER; MM INTEGER;
BEGIN
  IF _year < 1900 OR _year > 2099 THEN
    RAISE EXCEPTION 'Out of range';
  END IF;
  B := 255 - 11 * ($1 % 19); D := ((B - 21) % 30) + 21;
  IF D > 38 THEN D := D - 1; END IF;
  E := ($1 + $1/4 + D + 1) % 7; Q := D + 7 - E;
  IF Q < 32 THEN DD:=Q; MM := 3; ELSE DD := Q - 31; MM := 4; END IF;
  RETURN to_date(to_char(DD, '00')
            || to_char(MM, '00') || to_char(_rok,'0000'), 'DD MM YYYY');
END;
$$ LANGUAGE plpgsql IMMUTABLE STRICT;