CREATE table people
(
           person_id   SERIAL PRIMARY KEY,
           inits       text,
           fname       text
);

CREATE table states
(
        state text PRIMARY KEY,
        state_long  text
);

CREATE table addresses
(
        person_id   int REFERENCES people (person_id) ON DELETE CASCADE,
        city  text,
        state text REFERENCES states (state),
        country  text,
        zip   text
);

CREATE VIEW people_full AS
SELECT p.person_id, p.inits, p.fname, a.city,
   a.state, s.state_long, a.country, a.zip
FROM people p JOIN addresses a USING (person_id)
   JOIN states s USING (state);

-- PostgreSQL'de view'ler aslında rule olarak oluşturulurlar
-- yukarıdaki view aslında aşağıdaki gibi oluşturuluyor,

CREATE OR REPLACE RULE "_RETURN" AS ON SELECT TO people_full DO INSTEAD
SELECT p.person_id,
        p.inits,p.fname,a.city,a.state,s.state_long,a.country,a.zip
FROM people p
JOIN addresses a USING (person_id)
JOIN states s USING (state);


CREATE RULE "del_people_full" AS ON
DELETE TO people_full DO INSTEAD
DELETE FROM people WHERE person_id=OLD.person_id;


CREATE RULE "upd_people_full" as ON UPDATE TO people_full DO INSTEAD
(
        UPDATE people set inits=NEW.inits, fname=NEW.fname WHERE person_id=OLD.person_id;
        UPDATE addresses set city=NEW.city, state=NEW.state, zip=NEW.zip WHERE person_id=OLD.person_id;
);


CREATE RULE "ins_people_full" as ON INSERT TO people_full DO INSTEAD
(
        INSERT INTO people (person_id, inits, fname) VALUES (nextval('people_person_id_seq'),NEW.inits, NEW.fname);
        INSERT INTO addresses (person_id,city, state, zip) VALUES (currval('people_person_id_seq'), NEW.city, NEW.state, NEW.zip );
);
