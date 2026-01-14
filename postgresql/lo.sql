SELECT lo_import('/tmp/file.txt');

CREATE TABLE t_file (name text, oid_number oid);

INSERT INTO t_file VALUES ('/tmp/file.txt', lo_import('/tmp/file.txt')) RETURNING *;

SELECT * FROM pg_largeobject WHERE loid = 98437 ORDER BY pageno;

SELECT lo_unlink(98432);