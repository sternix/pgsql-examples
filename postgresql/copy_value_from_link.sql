-- psql'den

set datestyle to MDY;

create table lottery ( draw_date date, winning_numbers text, mega_ball integer, multiplier integer );

copy lottery from program 'curl https://data.ny.gov/api/views/5xaw-6ayf/rows.csv?accessType=DOWNLOAD' with (header true, delimiter ',', format csv);

select 3 as var; \gset
\echo :var
select * from lottery where multiplier = :var;