create table animals (
    id int generated always as identity ( cache 10 ),
    name text unique,
    primary key(id,name)
) partition by list (name);

create table animals_elephants
partition of animals
for values in ('elephant');

create table animals_cats
partition of animals
for values in ('cats');

create table animals_dogs
partition of animals
for values in ('dogs');

select pg_partition_tree('animals');
select pg_partition_ancestors('animals_dogs');

select pg_partition_root('animals_cats');

create index animals_i1 on animals (name);