CREATE OR REPLACE FUNCTION check_ISBN(ISBN CHAR(12))
RETURNS boolean AS $$
DECLARE
  pos INTEGER;
  asc INTEGER;
  sum INTEGER DEFAULT 0;
  weight INTEGER[] DEFAULT '{10,9,8,7,6,5,4,3,2,1}';  -- for ISSN {8,7,6,5,4,3,2,1}
  digits INTEGER DEFAULT 1;
BEGIN
  FOR pos IN 1..length(ISBN)
  LOOP
    asc := ascii(substr(ISBN,pos,1));
    IF asc IN (88, 120) THEN -- ISDN might contain control number X
      sum := sum + 10;
      digits := digits + 1;
    ELSIF asc >= 48 AND asc <= 57 THEN
      sum := sum + (asc - 48)*weight[digits];
      digits := digits + 1;
    END IF;
  END LOOP;
  IF digits <> 11 THEN -- for ISSN <> 9
    RETURN 'f';
  ELSE
    RETURN (sum % 11) = 0;
  END IF;
END;
$$ LANGUAGE plpgsql STRICT IMMUTABLE;