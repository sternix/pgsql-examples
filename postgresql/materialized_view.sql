CREATE TABLE t_demo (
	id int generated always as identity primary key,
	data int,
	grp int
);

insert into t_demo values (default,1,1);

-- DROP MATERIALIZED VIEW mat_view;
CREATE MATERIALIZED VIEW mat_view AS
SELECT
	id,
    grp,
    avg(data),
    count(*)
FROM
     t_demo
GROUP BY 1;

select * from mat_view;

ALTER MATERIALIZED VIEW mat_view
     RENAME COLUMN avg TO average;

CREATE INDEX idx_average ON mat_view (average);

REFRESH MATERIALIZED VIEW mat_view;

select * from mat_view;

insert into t_demo values (default,2,2);

-- yeni veriler burada yok
select * from mat_view;

-- concurrent için gerekli
CREATE UNIQUE INDEX idx_id ON mat_view (id);

REFRESH MATERIALIZED VIEW CONCURRENTLY mat_view;


/*

materialized view'ler cache gibi
istediğimiz zaman cache'i refresh edip yenileyebiliyoruz

refresh yaptığımızda refresh bitene kadar kimse view'e erişemiyor. ( concurrent için index gerekiyor )

By default, a materialized view is created in a way that it contains the result. However, if the object is created using the NO DATA option, it is empty. Only the definition is created.

*/