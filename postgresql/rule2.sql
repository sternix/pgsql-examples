CREATE TABLE test_table (
      field1 char(1) NOT NULL,
      field2 SERIAL,
      field3 INTEGER DEFAULT 1,
      field4 VARCHAR(24) DEFAULT '(default value)',
      CONSTRAINT testdb_pkey PRIMARY KEY (field2)
);

CREATE VIEW test_table_v AS
SELECT field1, field3, field4 FROM test_table;

CREATE RULE test_table_rd AS ON DELETE TO test_table_v DO INSTEAD
DELETE FROM test_table WHERE field1 = old.field1;

CREATE RULE test_table_ri AS ON INSERT TO test_table_v DO INSTEAD
INSERT INTO test_table (field1, field3, field4)
VALUES (new.field1, new.field3, new.field4);

CREATE RULE test_table_ru AS ON UPDATE TO test_table_v DO INSTEAD
UPDATE test_table SET
field1 = new.field1, field3 = new.field3, field4 = new.field4
WHERE field1 = old.field1;

INSERT INTO test_table VALUES ('A');
INSERT INTO test_table_v VALUES ('B');

ALTER TABLE test_table_v ALTER field3 SET DEFAULT 1;
ALTER TABLE test_table_v ALTER field4 SET DEFAULT '(default value)';