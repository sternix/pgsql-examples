1. How to find the largest table in the postgreSQL database?

SELECT relname, relpages FROM pg_class ORDER BY relpages DESC;

top 10 largest tables
SELECT relname, relpages FROM pg_class ORDER BY relpages DESC limit 10;

2. How to calculate postgreSQL database size in disk ?

SELECT pg_database_size('test');

SELECT pg_size_pretty(pg_database_size('test'));

3. How to calculate postgreSQL table size in disk ?
tablonun indexler keyler, bağımlı olduğu tüm neslerle birlikte boyutunu verir

SELECT pg_size_pretty(pg_total_relation_size('test'));

How to find size of the postgreSQL table ( not including index ) ?
sadece tablo (indexler dahil değil)
SELECT pg_size_pretty(pg_relation_size('big_table'));

4. How to view the indexes of an existing postgreSQL table ?
\d table_name

INSERT INTO numbers (num) VALUES ( generate_series(1,1000));

5. How to count total number of rows in a postgreSQL table ?

tüm kayıt sayısını getirir
select count(*) from table;

col_name adlı kolondaki null kayıtların sayısı hariç getitir,
select count(col_name) from table;

distinct olan kayıtların sayısını verir
select count(distinct col_name) from table;

sütundaki en büyük değeri verir
select max(col_name) from table;

en büyükten bir önceki büyük sayıyı verir
SELECT MAX(num) from number_table where num  < ( select MAX(num) from number_table );

sütundaki en küçük değeri verir
select min(col_name) from table;

en küçük değerden büyük değeri verir
SELECT MIN(num) from number_table where num > ( select MIN(num) from number_table );

