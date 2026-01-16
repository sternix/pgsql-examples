-- tablodaki dublicate alanları silmek istiyoruz,
-- fakat hangisinin silinmesi gerektiğine biz karar vermiyoruz

create table t(id int);

insert into t values (1),(2),(3),(3),(5),(6),(6)
returning *;

delete from t
where
    ctid in (
        select
            any_value(ctid)
        from
            t
        group by id
            having count(*) >= 2
);

-- bu işlemde örneğin 4 tane olandan 1 tane siliyor,
-- işlem hiç delete kalmayana kadar tekrarlanmalı
