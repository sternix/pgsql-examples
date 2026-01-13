create table aamaster
(
        id serial primary key,
        master varchar(25)
);

create table aaslave
(
        id serial primary key,
        master_id bigint references aamaster(id),
        slave varchar(25)
);


select
        r.relname as "Table",
        c.conname as "Constraint Name",
        contype as "Constraint Type", conkey as "Key Columns",
        confkey as "Foreign Columns", consrc as "Source"
from pg_class r inner join pg_constraint c on (r.oid = c.conrelid )
where
        relname = 'aaslave';