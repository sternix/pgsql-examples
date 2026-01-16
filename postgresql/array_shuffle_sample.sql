with a(digits) as (
    select '{1,2,3,4,5,6,7,8,9,0}'::int[]
)
select
    array_shuffle(a.digits),
    array_sample(a.digits,3)
from
    a;

-- array_shuffle, diziyi karıştırıyor,
-- array_sample, diziden istenilen kadar rastgele eleman seçiyor
