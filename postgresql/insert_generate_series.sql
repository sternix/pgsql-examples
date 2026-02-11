-- https://www.cybertec-postgresql.com/en/super-fast-aggregations-in-postgresql-19/


CREATE TABLE t_category (
	category_id		int4	PRIMARY KEY,
	category_name		text
);

INSERT INTO t_category VALUES
(0, 'Shoes'),
(1, 'Shirts'),
(2, 'Car'),
(3, 'Bike');

CREATE TABLE t_color (
	color_id		int4	PRIMARY KEY,
	color_name		text
);

INSERT INTO t_color VALUES
	(0, 'Red'), (1, 'Green'),
	(2, 'Yellow'), (3, 'Blue');


CREATE TABLE t_product (
	category_id		int4	REFERENCES t_category (category_id),
	color_id		int4	REFERENCES t_color (color_id),
	whatever		text
);


INSERT INTO t_product
	SELECT	id % 4, (id * random())::int4 % 4, md5(id::text)
	FROM	generate_series(1, 200000) AS id;



create table tblgen
(
	a int,
	b int,
	c text
);


insert into tblgen
	select
		id % 4,
		(id * random())::int4 % 4,
		md5(id::text)
	from
		generate_series(1, 200) as id;




