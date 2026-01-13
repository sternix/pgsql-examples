create table content
(
        content_id      integer,
        material_id     integer,
        percentage      text
);

create table material
(
        material_id     integer,
        name            text
);

insert into material values (1,'COTTON');
insert into material values (2,'POLYESTER');
insert into material values (3,'NYLON');
insert into material values (4,'SPANDEX');
insert into content values (1,1,'100%');
insert into content values (2,2,'63.5%');
insert into content values (2,3,'31.5%');
insert into content values (2,4,'5%');

select * from content;
select * from material;

create function xstr_append( text, text ) returns text as '
begin
  if $1 isnull then
    return $2;
  else
    return $1 || '' '' || $2;
  end if;
end;' language 'plpgsql';

create aggregate xstr_concat ( basetype = text, sfunc = xstr_append, stype = text);

select xstr_concat( c.percentage || ' ' || m.name )
from content c, material m
where c.material_id = m.material_id
group by c.content_id;