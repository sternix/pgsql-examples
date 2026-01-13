-- type'a yeni bir kolon eklemek


CREATE TYPE kisi AS (id bigint, adi varchar(25) , soyadi varchar(25) );
ALTER TYPE kisi ADD ATTRIBUTE email varchar(255)
ALTER TYPE kisi DROP ATTRIBUTE email
ALTER TYPE kisi ALTER ATTRIBUTE email type int;

create or replace function get_kisiler() returns setof kisi as $$
declare
        k kisi;
begin
        for k in select * from tbltest
        loop
                --k.email = 1;
                return next k;
        end loop;
        return;
end;
$$ language plpgsql;


select * from get_kisiler();