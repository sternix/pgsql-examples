create or replace function fortythree(text)
        returns float
        as '
        DECLARE
           v_tmp RECORD;
           ret_avg_price float;
           myid alias for $1;
        BEGIN
           FOR v_tmp IN EXECUTE ''SELECT avg(price) AS avg_price
                             FROM fortythree
                             WHERE id = '''''' || myid || ''''''
           LOOP

           ret_avg_price := v_tmp.avg_price;

           END LOOP;
           RETURN ret_avg_price;
        END;
' language 'plpgsql';


create or replace function trimtablecol(text, text )
        returns void
        as '
        DECLARE
        qry text;
        tab alias for $1;
        col alias for $2;
        BEGIN
           qry := ''update '' || tab || '' set '' || col || ''=trim('' || col || '');'';
           EXECUTE qry;
           RETURN;
        END;

' language 'plpgsql';