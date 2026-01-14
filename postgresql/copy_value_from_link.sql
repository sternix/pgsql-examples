-- psql'den

set datestyle to MDY;

create table lottery ( draw_date date, winning_numbers text, mega_ball integer, multiplier integer );

copy lottery from program 'curl https://data.ny.gov/api/views/5xaw-6ayf/rows.csv?accessType=DOWNLOAD' with (header true, delimiter ',', format csv);

select 3 as var; \gset
\echo :var
select * from lottery where multiplier = :var;


-------

bir programın çıktısı olan bir csv'yi kullanmak

set datestyle to ymd;

DROP TABLE IF EXISTS ticker;

CREATE TABLE ticker
(
    day date,
    open float,
    high float,
    low float,
    close float,
    adj_close float,
    volume float
);

\copy ticker FROM PROGRAM 'curl "https://query1.finance.yahoo.com/v7/finance/download/TSLA"' WITH CSV HEADER

