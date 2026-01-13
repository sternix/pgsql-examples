-- zor yolu
create or replace function check_phone_number (text)
returns boolean as $$
declare
  _str alias for $1;
  _char text;
  i    int4;
begin
  i=1;
  while true loop
    if length (_str) != 16 then exit; end if;
    _char := substring(_str from i for 1);
    if _char != '+' then exit; end if;
    i:=i+1; _char := substring(_str from i for 1);
    if _char < '0' or _char >'9' then exit; end if;
    i:=i+1; _char := substring(_str from i for 1);
    if _char < '0' or _char >'9' then exit; end if;
    i:=i+1; _char := substring(_str from i for 1);
    if _char < '0' or _char >'9' then exit; end if;
    i:=i+1; _char := substring(_str from i for 1);
    if _char != ' ' then exit; end if;
    i:=i+1; _char := substring(_str from i for 1);
    if _char < '0' or _char >'9' then exit; end if;
    i:=i+1; _char := substring(_str from i for 1);
    if _char < '0' or _char >'9' then exit; end if;
    i:=i+1; _char := substring(_str from i for 1);
    if _char < '0' or _char >'9' then exit; end if;
    i:=i+1; _char := substring(_str from i for 1);
    if _char != ' ' then exit; end if;
    i:=i+1; _char := substring(_str from i for 1);
    if _char < '0' or _char >'9' then exit; end if;
    i:=i+1; _char := substring(_str from i for 1);
    if _char < '0' or _char >'9' then exit; end if;
    i:=i+1; _char := substring(_str from i for 1);
    if _char < '0' or _char >'9' then exit; end if;
    i:=i+1; _char := substring(_str from i for 1);
    if _char != ' ' then exit; end if;
    i:=i+1; _char := substring(_str from i for 1);
    if _char < '0' or _char >'9' then exit; end if;
    i:=i+1; _char := substring(_str from i for 1);
    if _char < '0' or _char >'9' then exit; end if;
    i:=i+1; _char := substring(_str from i for 1);
    if _char < '0' or _char >'9' then exit; end if;
    return true;
  end loop;
  raise exception e'wrong char \'%\' on position %. Use format +XXX XXX XXX XXX', _char, i;
  return false; -- << death code
end;
$$ language plpgsql;

-- kolay yolu

CREATE OR REPLACE FUNCTION check_phone_number(text)
RETURNS boolean AS $$
BEGIN
  IF NOT $1 ~  e'^\\+\\d{3}\\ \\d{3} \\d{3} \\d{3}$' THEN
    RAISE EXCEPTION 'Wrong formated string "%". Expected format is +999 999 999 999';
  END IF;
  RETURN true;
END;
$$ LANGUAGE plpgsql STRICT IMMUTABLE;