select
pg_column_size(row()) as empty,
pg_column_size(row(0::smallint)) as byte2,
pg_column_size(row(0::bigint)) as byte8,
pg_column_size(row(0::smallint,0::bigint)) as byte16;

/*

empty | byte2 | byte8 | byte16
-------+-------+-------+--------
    24 |    26 |    32 |     40

*/