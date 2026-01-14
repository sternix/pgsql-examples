create table empl (
    name text primary key,
	-- burada self-referential foreign key olarak boss primary key olan name'e bakıyor
    boss text null references empl on update cascade on delete cascade default null
);

insert into empl values ('Paul',null);
insert into empl values ('Luke','Paul');
insert into empl values ('Kate','Paul');
insert into empl values ('Marge','Kate');
insert into empl values ('Edith','Kate');
insert into empl values ('Pam','Kate');
insert into empl values ('Carol','Luke');
insert into empl values ('John','Luke');
insert into empl values ('Jack','Carol');
insert into empl values ('Alex','Carol');

with recursive t(level,path,boss,name) as (
        select 0,name,boss,name from empl where boss is null
    union
        select
            level + 1,
            path || ' > ' || empl.name,
            empl.boss,
            empl.name
        from
            empl join t
                on empl.boss = t.name
) select * from t order by path;