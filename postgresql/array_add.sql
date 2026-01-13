CREATE OR REPLACE FUNCTION array_add(int[],int[]) RETURNS int[] AS $$
DECLARE
        x ALIAS FOR $1;
        y ALIAS FOR $2;
        a int;
        b int;
        i int;
        res int[];
BEGIN
        res = x;

        a := array_lower (y, 1);
        b := array_upper (y, 1);

        IF a IS NOT NULL THEN
                FOR i IN a .. b LOOP
                        res[i] := coalesce(res[i],0) + y[i];
                END LOOP;
        END IF;

        RETURN res;
END;
$$ LANGUAGE plpgsql;

select array_add('{1,2,3}', '{1,1,1}');
