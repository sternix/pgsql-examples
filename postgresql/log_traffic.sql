CREATE OR REPLACE FUNCTION log_traffic(src varchar , dst varchar , smac varchar , dmac varchar , sport int , dport int) RETURNS void AS
$$
DECLARE
        srcid int;
        dstid int;
        smacid int;
        dmacid int;
BEGIN
        select id into srcid from hosts where host = src;
        if not found then
                insert into hosts values (default,src) returning id into srcid;
        end if;

        select id into dstid from hosts where host = dst;
        if not found then
                insert into hosts values (default,dst) returning id into dstid;
        end if;

        select id into smacid from macs where mac = smac;
        if not found then
                insert into macs values (default,smac) returning id into smacid;
        end if;

        select id into dmacid from macs where mac = dmac;
        if not found then
                insert into macs values (default,dmac) returning id into dmacid;
        end if;

        insert into traffic values (now() , srcid , dstid , smacid , dmacid , sport , dport );
END;
$$ LANGUAGE plpgsql;