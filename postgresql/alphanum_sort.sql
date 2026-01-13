/*

Alphanumeric sorting
(mantık basit regex ile değerin sayı olup olmadığına bakılıyor, eğer sayı
değilse NULL olarak değerlendiriyor)

*/

create table an_test
(
        name varchar(25),
        code varchar(25)
);

insert into an_test values ('one','1');
insert into an_test values ('eleven','11');
insert into an_test values ('three','3');
insert into an_test values ('five','5');
insert into an_test values ('seven','7');
insert into an_test values ('nine','9');
insert into an_test values ('A-two','A1');
insert into an_test values ('A-four','A4');
insert into an_test values ('C-ten','C10');
insert into an_test values ('C-eight','C8');
insert into an_test values ('B-six','D6');


select * from an_test order by code;

select name, code from
        ( select *,
                (case when code ~ '^[0-9]+'
                        then code::integer
                else NULL
                        end) as number
        from an_test ) foo
order by number, code;