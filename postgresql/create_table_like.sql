create table tbltest(id serial primary key, adi varchar(25), soyadi varchar(25));

create table tblt2 (like tbltest);
ile sadece schema oluşturuluyor

fakat

create table tblt3 (like tbltest including all);

ile bire bir tablo oluşturuluyor