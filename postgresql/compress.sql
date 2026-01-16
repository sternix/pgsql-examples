create table tbltoast (
    c1 jsonb compression lz4,
    c2 varchar(100) compression pglz
);

-- kolon başına sıkıştırma algoritması seçebiliriz