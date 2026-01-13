only ifadesi sadece dad tablosuna insert edilen kayıtların silinmesini
sağlıyor

create table dad
(
        id serial primary key,
        name varchar(25)
);

create table kid1
(
        kid1 varchar(25)
) inherits (dad);

create table kid2
(
        kid2 varchar(25)
) inherits (dad);



insert into dad values (default,'dsfgd')
select * from dad;
insert into kid1 values (default,'dsfgd','sdfgfdsg')
select * from kid1;

insert into kid2 values (default,'dsfgd','sdfgfdsg')
select * from kid2;
delete from only dad where id = 1