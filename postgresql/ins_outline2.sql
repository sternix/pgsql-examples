create table outline2 (
        level_one   serial,
        level_two   integer default 888,
        data        text,
        PRIMARY KEY (level_one, level_two)
);

create function ins_outline2( ) returns trigger as $$
DECLARE
        seqname text;
BEGIN
        seqname := 'seq_outline2_' || NEW.level_one ; -- for readability
        -- This is NOT bulletproof
        if not exists ( select 1 from pg_class where relname = seqname)
        then
           -- execute is required because the name of the sequence
           -- is dynamically created
           execute 'create sequence ' || seqname || ' start 2';
           NEW.level_two := 1;
        else
           NEW.level_two := nextval( seqname );
        end if;
        return NEW;
END;
$$ language 'plpgsql';


create trigger insupd_outline2 before insert on outline2
for each row execute procedure ins_outline2();


insert into outline2 values (default, NULL, 'one_one');
insert into outline2 values (1, NULL, 'one_two');
insert into outline2 values (1, NULL, 'one_three');
insert into outline2 values (default, NULL, 'two_one');
insert into outline2 values (2, NULL, 'two_two');
insert into outline2 values (3, NULL, 'three_one');


select * from outline2;