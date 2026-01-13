-- multi part primary key
-- birden çok primary key var

CREATE TABLE foo (
        col_one         integer,
        col_two         integer,
        col_three       text,
        col_four                text,
        PRIMARY KEY (col_one, col_two)
);

CREATE TABLE bar (
        col_a   integer,
        col_b   integer,
        col_c   text,
        FOREIGN KEY (col_a, col_b) REFERENCES foo (col_one, col_two)
);
