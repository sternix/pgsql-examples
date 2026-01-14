-- keywordleri listeliyor

select * from pg_get_keywords();

-- keyword'leri çift tırnak içinde kullanabiliyoruz

create table "user" ("user" int);
select * from "user";

-- çalışıyor