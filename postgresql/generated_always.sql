alter table t1 add column c int generated always as (a*2) stored;
alter table t1 add column d int generated always as (3*2) stored;
alter table t1 add column e int generated always as (random()) stored;
alter table t1 add column e text generated always as (md5(b)) stored;



CREATE TABLE person (
   person_id smallserial PRIMARY KEY
,  first_name varchar(50)
,  last_name varchar(50)
,  full_name varchar(101) GENERATED ALWAYS AS
                         (CASE WHEN first_name IS NULL THEN last_name
                               WHEN last_name IS NULL THEN first_name
                               ELSE first_name || ' ' || last_name END) STORED
);

INSERT INTO person (first_name, last_name)
VALUES
  ('Jon', 'Doe')
, ('OnlyFirst', null)  -- NULL last
, (null, 'OnlyLast')   -- NULL first
;

TABLE person;