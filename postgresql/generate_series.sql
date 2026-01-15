CREATE TABLE a AS SELECT id AS a, id AS b, id AS c FROM generate_series(1, 50000000) AS id;

şeklinde bir değeri birden fazla kullanabiliriz

-----

create table perf
(
    c1 int,
    c2 text,
    c3 boolean
);


insert into perf (c1,c2,c3)
    select gen_series.id, chr( (32+random()*94)::integer), random() < 0.01
        from generate_series(1,100000) as gen_series(id)
        order by random();