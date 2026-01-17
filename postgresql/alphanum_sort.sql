/*

Alphanumeric sorting

regex ile code alanındaki varchar değeri "Adeğerin sayı olup olmadığına bakılıyor,
eğer varchar olan code alanındaki değerin regex'i doğru ise tamamı rakam içeriyorsa sayıya çevir
değilse null döndür

*/




drop table an_test
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
insert into an_test values ('D-six','D6');


select * from an_test order by code;

select
	name,
	code,
	case
		when code ~ '^[0-9]+' then code::integer
		else NULL
	end as number
from
	an_test
order by
	number, code;