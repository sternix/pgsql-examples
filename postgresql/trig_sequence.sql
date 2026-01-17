create table axyz
(
        aid bigint,
        val varchar(25)
);

create sequence axyz_id_seq;

CREATE OR REPLACE FUNCTION "axyz_seq_func"() RETURNS trigger AS
$$
BEGIN
   NEW.AID = NEXTVAL(''axyz_id_seq'');
   RETURN NEW;
END
$$LANGUAGE 'plpgsql'

CREATE TRIGGER axyz_id_trg BEFORE INSERT ON "axyz"
FOR EACH ROW EXECUTE PROCEDURE axyz_seq_func();

--drop TRIGGER axyz_id_trg ON "axyz"

insert into axyz(val) values ('dsfgfdsg')
select * from axyz
