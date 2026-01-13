negatif olan r_value'leri pozitif'e çeviriyor


CREATE TABLE payments
(
        r_date_payment TIMESTAMP,
        r_description VARCHAR(50),
        r_value numeric (12,2)
);

INSERT INTO payments VALUES(CURRENT_TIMESTAMP, 'a', '12.50');
INSERT INTO payments VALUES(CURRENT_TIMESTAMP, 'b', '11.75');
INSERT INTO payments VALUES(CURRENT_TIMESTAMP, 'c', '-99.99');

CREATE OR REPLACE FUNCTION my_proc(TIMESTAMP)
RETURNS SETOF payments
AS '
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN SELECT * FROM payments WHERE r_date_payment BETWEEN $1 AND CURRENT_TIMESTAMP
    LOOP
       IF rec.r_value < 0 THEN
           rec.r_value = rec.r_value*-1;
       END IF;
       RETURN NEXT rec; /* Each RETURN NEXT command returns a row */
    END LOOP;
    RETURN;
END;
' LANGUAGE 'plpgsql';


select * from payments;
SELECT * FROM my_proc('30/11/2013');
SELECT * FROM my_proc('30.11.2013');
SELECT * FROM my_proc('30-11-2013');