CREATE TYPE renk AS ENUM ('red', 'green', 'blue');

CREATE TABLE colors ( id serial primary key, color renk);

insert into colors values (default,'red');

insert into colors values (default,'yok');
ERROR:  invalid input value for enum renk: "yok"

alter type renk add value 'yellow';

alter type renk add value 'blacx';
alter type renk rename value 'blacx' to 'black';

enum'ları yada type'ları psql'den

\dT+ color2

ile görebiliriz

enum'un değerlerini
select enum_range(null::color2);

yada

select unnest(enum_range(null::color2));

şeklinde görebiliriz

