-- tehlikeli olabilir

create or replace function pg_wal_cycle_all()
returns int language plpgsql
as $$
declare
    wal_count int;
    wal_seg varchar;
begin
    select count(*) - 1
    into wal_count
    from pg_ls_dir('pg_wal');

    for wal in 1..wal_count loop
        select pg_walfile_name(pg_switch_wal()) into wal_seg;
        raise notice 'segment %', wal_seg;
        checkpoint;
    end loop;
    return wal_count;
end;$$;

-- select pg_wal_cycle_all();