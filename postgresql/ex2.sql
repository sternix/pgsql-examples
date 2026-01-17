CREATE OR REPLACE FUNCTION t1() RETURNS INT AS
$$
DECLARE
        v_i INT;
BEGIN
        v_i := 1;
        RETURN v_i;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION t2() RETURNS INT AS
$$
DECLARE
        v_i INT;
BEGIN
        SELECT 1 INTO v_i;
        RETURN v_i;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION t4() RETURNS INT AS
$$
DECLARE
        v_i INT;
        ret INT;
BEGIN
        FOR v_i IN 1..1000 LOOP
                ret := v_i;
        END LOOP;
        RETURN ret;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION t5() RETURNS INT AS
$$
DECLARE
        v_i INT;
        ret INT;
BEGIN
        FOR v_i IN 1..1000 LOOP
                SELECT v_i INTO ret;
        END LOOP;
        RETURN ret;
END;
$$ LANGUAGE plpgsql;