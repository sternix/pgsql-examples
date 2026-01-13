/*

burada dikkatimi çeken aynı oturumda temp table varsa
exception veriyormuş,

selectten sonra
select * from tmpopeninghours;
yaptığımızda tablodan veri alınabiliyor

https://stackoverflow.com/questions/955167/return-setof-record-virtual-table-from-function

*/

CREATE TYPE storeopeninghours_tostring_rs AS (
    colone text,
    coltwo text,
    colthree text
);

CREATE OR REPLACE FUNCTION storeopeninghours_tostring()
    RETURNS setof storeopeninghours_tostring_rs
AS
$$
DECLARE
  returnrec storeopeninghours_tostring_rs;
BEGIN
    BEGIN
        CREATE TEMPORARY TABLE tmpopeninghours (
            colone text,
            coltwo text,
            colthree text
        );
    EXCEPTION WHEN OTHERS THEN
        -- TRUNCATE if the table already exists within the session.
        TRUNCATE TABLE tmpopeninghours;
    END;

    insert into tmpopeninghours VALUES ('1', '2', '3');
    insert into tmpopeninghours VALUES ('3', '4', '5');
    insert into tmpopeninghours VALUES ('3', '4', '5');

    FOR returnrec IN SELECT * FROM tmpopeninghours
    LOOP
        RETURN NEXT returnrec;
    END LOOP;
END;
$$
LANGUAGE plpgsql;

-- select * from storeopeninghours_tostring() 