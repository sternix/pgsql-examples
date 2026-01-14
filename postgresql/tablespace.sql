CREATE TABLESPACE mytbsp LOCATION '/tmp/mytbsp';

CREATE TABLE newtab (
   id  integer NOT NULL,
   val text    NOT NULL
) TABLESPACE mytbsp;

ALTER TABLE newtab
   ADD CONSTRAINT newtab_pkey PRIMARY KEY (id)
   USING INDEX TABLESPACE mytbsp;

CREATE INDEX newtab_val_idx ON newtab (val)
   TABLESPACE mytbsp;


CREATE DATABASE newdb TABLESPACE mytbsp;