create table fieldtrip_students
(
        sname   text PRIMARY KEY
);

create table fieldtrip_chaperones
(
        cname   text PRIMARY KEY
);

create or replace function field_trip() returns trigger as $$
DECLARE
        students integer;
        chaps integer;
BEGIN
        select into students count(*) from fieldtrip_students;
        select into chaps count(*) from fieldtrip_chaperones;

        if (chaps = 0 and students != 0) or (chaps != 0 and students/chaps < 5) then
                raise exception 'There are % students and % chaperones. There must be 1 chaperone for each 5 students.',students, chaps;
        else
                return NEW;
        end if;
        return NEW;
END;
$$ language 'plpgsql';

create constraint trigger sc after insert on fieldtrip_students
initially deferred for each row execute procedure field_trip();

create constraint trigger sc after delete on fieldtrip_chaperones
initially deferred for each row execute procedure field_trip();

insert into fieldtrip_students values ('jeremy');
insert into fieldtrip_students values ('joan');
insert into fieldtrip_students values ('janis');
insert into fieldtrip_students values ('john');
insert into fieldtrip_students values ('jacob');
insert into fieldtrip_chaperones values ('Lila');