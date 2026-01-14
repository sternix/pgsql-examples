-- insert from select

INSERT INTO person SELECT * FROM tmp_person WHERE age < 30;

Note that the projection of the select must match the columns required for the insert.
In this case, the tmp_person table has the same columns as person.
