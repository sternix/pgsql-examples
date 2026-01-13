-- Tablonun bir kolonunda değiştirilme tarihi tutmak
-- (tablo'da bir update yapıldığında o kolon'a güncel zaman yazılıyor)

create or replace function ts_row()
returns TRIGGER as
$$
BEGIN
   NEW.mod_date = now();
   RETURN NEW;
END;
$$ language plpgsql;

create table ts_test
(
        id serial primary key,
        mod_date timestamp,
        val varchar(25)
);

create trigger upd_any_table BEFORE UPDATE
   ON ts_test for each row
   EXECUTE PROCEDURE ts_row();


insert into ts_test (id , val) values (default,'dsgffdsgd')
select * from ts_test
update ts_test set val = 'dsgds'
