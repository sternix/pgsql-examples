create collation seasons (
    provider = icu,
    locale = 'en',
    rules = '& W < Sp < Su < A'
);

with seasons(name) as (
    values ('Summer'),('Winter'),('Spring'),('Autumn')
)
select * from seasons order by name collate seasons;

 name
--------
 Winter
 Spring
 Summer
 Autumn

istediğimiz sıralamayı verebiliyoruz