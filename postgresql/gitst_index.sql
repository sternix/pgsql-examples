create table gist_tablosu
(
    c1 point
);

insert into gist_tablosu values
(point'(2,12)'),
(point'(4,5)'),
(point'(6,3)'),
(point'(6,6)'),
(point'(9,10)'),
(point'(9,5)');

explain select * from gist_tablosu where c1 <@ box '(2,1),(7,4)';

create index on gist_tablosu using gist(c1);

explain select * from gist_tablosu where c1 <@ box '(2,1),(7,4)';

set enable_seqscan to off;

explain select * from gist_tablosu where c1 <@ box '(2,1),(7,4)';
