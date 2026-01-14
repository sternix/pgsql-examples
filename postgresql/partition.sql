-- http://stormatics.com/big-data-and-postgresql-scaling-out-by-partitioning-tables/

-- drop table events cascade
CREATE TABLE events
(
        id SERIAL,
        type INTEGER,
        time TIMESTAMP WITH TIME ZONE,
        comments TEXT
);

create table events_1_2015_01
(
        CONSTRAINT events_type_time_check CHECK (time >= '2015-01-01' AND time < '2015-02-01' AND type = 1)
) inherits(events);

create table events_2_2015_01
(
        CONSTRAINT events_type_time_check CHECK (time >= '2015-01-01' AND time < '2015-02-01' AND type = 2)
) inherits(events);

create table events_3_2015_01
(
        CONSTRAINT events_type_time_check CHECK (time >= '2015-01-01' AND time < '2015-02-01' AND type = 3)
) inherits(events);

create table events_1_2015_02
(
        CONSTRAINT events_type_time_check CHECK (time >= '2015-02-01' AND time < '2015-03-01' AND type = 1)
) inherits(events);

create table events_2_2015_02
(
        CONSTRAINT events_type_time_check CHECK (time >= '2015-02-01' AND time < '2015-03-01' AND type = 2)
) inherits(events);

create table events_3_2015_02
(
        CONSTRAINT events_type_time_check CHECK (time >= '2015-02-01' AND time < '2015-03-01' AND type = 3)
) inherits(events);

create table events_1_2015_03
(
        CONSTRAINT events_type_time_check CHECK (time >= '2015-03-01' AND time < '2015-04-01' AND type = 1)
) inherits(events);

create table events_2_2015_03
(
        CONSTRAINT events_type_time_check CHECK (time >= '2015-03-01' AND time < '2015-04-01' AND type = 2)
) inherits(events);

create table events_3_2015_03
(
        CONSTRAINT events_type_time_check CHECK (time >= '2015-03-01' AND time < '2015-04-01' AND type = 3)
) inherits(events);

\d+ events

CREATE or REPLACE FUNCTION events_partition_function() RETURNS TRIGGER
LANGUAGE plpgsql
AS $_$
DECLARE
v_Table   VARCHAR;
sql       VARCHAR;
BEGIN
        v_Table = 'events' || '_' || NEW.type || '_' || to_char(NEW.time, 'YYYY_MM');
        sql := 'INSERT INTO ' || v_Table || ' VALUES ( ($1).*)';
        EXECUTE sql USING NEW;
        return NULL;
END $_$;

CREATE TRIGGER trg_events_insert
BEFORE INSERT ON events
FOR EACH ROW EXECUTE PROCEDURE events_partition_function();

insert into events (type, time, comments) values
(1, '2015-01-15', 'This should be in events_1_2015_01'),
(2, '2015-01-15', 'This should be in events_2_2015_01'),
(3, '2015-01-15', 'This should be in events_3_2015_01'),
(1, '2015-02-15', 'This should be in events_1_2015_02'),
(2, '2015-02-15', 'This should be in events_2_2015_02'),
(3, '2015-02-15', 'This should be in events_3_2015_02'),
(1, '2015-03-15', 'This should be in events_1_2015_03'),
(2, '2015-03-15', 'This should be in events_2_2015_03'),
(3, '2015-03-15', 'This should be in events_3_2015_03');

SELECT * FROM events;

select * from events where type = 3 and time > '2015-02-01' and time < '2015-03-01';

explain select * from events where type = 3 and time > '2015-02-01' and time < '2015-03-01';