-- tanımlı tüm tipler

SELECT
      typname,
      typlen
FROM
      pg_type;


DROP TABLE IF EXISTS tblxxx;

CREATE TABLE tblxxx (
    id SERIAL PRIMARY KEY,
    a VARCHAR(50),
    b text,
    c int,
    d bigint,
    e float,
    f decimal,
    g timestamp,
    h timestamptz,
    i date,
    j time
);

INSERT INTO tblxxx VALUES(DEFAULT,'a','b',1,123456789,3.14, 3.15, '2021-08-04 14:53:28','2021-08-04 14:53:28-03','2021-08-04','14:53:28');
INSERT INTO tblxxx VALUES(DEFAULT,'a','b',1,123456789,3.14, 3.15, NOW(), CURRENT_TIMESTAMP, '2021-08-04',CURRENT_TIME);
INSERT INTO tblxxx VALUES(DEFAULT,'a','b',1,123456789,3.14, 3.15, CURRENT_TIMESTAMP, now(), CURRENT_DATE ,CURRENT_TIME);

SELECT * FROM tblxxx;