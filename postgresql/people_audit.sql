Logging audit changes with composite typed columns

--drop table people
create table people
(
        person_id serial primary key,
        first_name text,
        middle_name  text,
        last_name  text
);

-- drop table  people_audit
create table  people_audit
(
        actor varchar(25),
        action  varchar(25),
        action_timestamp timestamp default now(),
        old_people people,
        new_people people
);

CREATE OR REPLACE FUNCTION people_audit_trig () RETURNS TRIGGER AS $$
DECLARE
        rows_affected INTEGER;
BEGIN
        IF TG_OP = 'INSERT' THEN
                INSERT INTO people_audit (action, new_people) VALUES ('INSERT', NEW );
        ELSIF TG_OP = 'UPDATE' THEN
                INSERT INTO people_audit (action, old_people, new_people) VALUES ('UPDATE', OLD , NEW );
        ELSIF TG_OP = 'DELETE' THEN
                INSERT INTO people_audit (action, old_people) VALUES ('DELETE', OLD );
        ELSE
                RAISE EXCEPTION 'TG_OP % is none of INSERT, UPDATE or DELETE.', TG_OP;
        END IF;

        GET DIAGNOSTICS rows_affected = ROW_COUNT;
        IF rows_affected = 1 THEN
                IF TG_OP IN ('INSERT', 'UPDATE') THEN
                        RETURN NEW;
                ELSE
                        RETURN OLD;
                END IF;
        ELSE
                RAISE EXCEPTION 'INSERT failed on people_audit';
        END IF;
END;
$$ LANGUAGE plpgsql

CREATE TRIGGER people_audit_trig
BEFORE INSERT OR UPDATE OR DELETE ON people
FOR EACH ROW EXECUTE PROCEDURE people_audit_trig();

insert into people values (default,'First INSERT','','');
insert into people values (default,'Second INSERT','','');
insert into people values (default,'Third INSERT','','');
insert into people values (default,'Fourth INSERT','','');
insert into people values (default,'Fifth INSERT','','');

select * from people;
select * from people_audit;

UPDATE people SET first_name= first_name || ' updated once' WHERE person_id < 4;

CREATE OR REPLACE FUNCTION undo_people_update(integer)
RETURNS integer AS
$$
DECLARE
        rows_affected integer;
BEGIN
        update people set
                first_name=(pa.old_people).first_name,
                middle_name=(pa.old_people).middle_name,
                last_name=(pa.old_people).last_name
        from people_audit pa
        where
                person_id = $1 and
                person_id = (pa.old_people).person_id and
                pa.action_timestamp = (select max(action_timestamp) from people_audit a, people p where (a.old_people).person_id = $1);

        GET DIAGNOSTICS rows_affected = ROW_COUNT;
        RETURN rows_affected;
END;
$$ language 'plpgsql';

select * from people_audit;

select undo_people_update(1)
select * from people;
select undo_people_update(2)
select * from people;
select undo_people_update(3)
select * from people;
