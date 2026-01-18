-- In PostgreSQL, Arrays are 1-based. The first item has index is 1.

-- Declaring an Array

SELECT integer[];
SELECT integer[3];
SELECT integer[][];
SELECT integer[3][3];
SELECT integer ARRAY;
SELECT integer ARRAY[3];

-- Creating an Array

SELECT '{0,1,2}';
SELECT '{{0,1},{1,2}}';
SELECT ARRAY[0,1,2];
SELECT ARRAY[ARRAY[0,1],ARRAY[1,2]];

-- Accessing an Array

-- By default PostgreSQL uses a one-based numbering convention for arrays,
-- that is, an array of n elements starts with array[1] and ends with array[n].

--accesing a spefific element
WITH arr AS (SELECT ARRAY[0,1,2] int_arr) SELECT int_arr[1] FROM arr;

/*

int_arr
---------
        0
(1 row)

*/

--slicing an array

WITH arr AS (SELECT ARRAY[0,1,2] int_arr) SELECT int_arr[1:2] FROM arr;

/*

int_arr
---------
    {0,1}
(1 row)

*/

-- Getting information about an array

--array dimensions (as text)
with arr as (select ARRAY[0,1,2] int_arr) select array_dims(int_arr) from arr;

/*

array_dims
------------
       [1:3]
(1 row)

*/

--length of an array dimension
 WITH arr AS (SELECT ARRAY[0,1,2] int_arr) SELECT array_length(int_arr,1) FROM arr;

/*

 array_length
 --------------
              3
 (1 row)

 */

--total number of elements across all dimensions
 WITH arr AS (SELECT ARRAY[0,1,2] int_arr) SELECT cardinality(int_arr) FROM arr;

/*

 cardinality
 -------------
             3
 (1 row)

*/

-------

CREATE TABLE people_cars (
    id serial primary key NOT NULL,
    person varchar(50) NOT NULL,
    cars text[] -- yada cars text array
);

insert into people_cars values (default,'kisi1',array['a','b','c'])

select * from people_cars;

update people_cars set cars = array_append(cars,'d') where id = 1;

select * from people_cars;

update people_cars set cars = array_remove(cars,'b') where id = 1;

select * from people_cars;

update people_cars set cars = array_replace(cars,'a','x') where id = 1;

select * from people_cars;

-------

create table urunler (
    isim text,
    kategori text[]
);

insert into urunler values ('Samsung x',array['elektronik','telefon','samsung']);
insert into urunler values ('HP 123',array['elektronik','yazıcı','samsung']);

select kategori[2] from urunler;


select kategori[566] from urunler;

hata vermiyor