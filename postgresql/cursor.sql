-- Temel cursor kullanımı

BEGIN
DECLARE myportal CURSOR FOR select * from pg_database
FETCH ALL in myportal
CLOSE myportal
END