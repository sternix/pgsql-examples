select
    octet_length('PostgreSQL'::varchar(1)) as vc1,
    octet_length('PostgreSQL'::varchar(5)) as vc5,
    octet_length('PostgreSQL'::varchar(15)) as vc15,
    octet_length('PostgreSQL'::char(1)) as c1,
    octet_length('PostgreSQL'::char(5)) as c5,
    octet_length('PostgreSQL'::char(15)) as c15;

vc1 | vc5 | vc15 | c1 | c5 | c15
-----+-----+------+----+----+-----
   1 |   5 |   10 |  1 |  5 |  15

-- char her halükarda 15 kullanıyor