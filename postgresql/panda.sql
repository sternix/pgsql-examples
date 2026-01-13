-- sonuç ta panda gibi bişi çıkıyor

select * from
(select array_to_string(array_agg(CASE WHEN (power((xx.x-25),2)/130+power((yy.y-25),2)/130)=1 THEN '$' WHEN (sqrt(power(xx.x-20,2)+power(yy.y-20,2)))<2 THEN '#' WHEN (sqrt(power(xx.x-20,2)+power(yy.y-30,2)))<2 THEN '#' WHEN (sqrt(power(xx.x-29,2)+power(yy.y-25,2)))<4 THEN '#' WHEN (power((xx.x-10),2)/40+power((yy.y-10),2)/40)=1 THEN '$' WHEN (power((xx.x-10),2)/40+power((yy.y-40),2)/40=1) THEN '$' ELSE ' ' END),' ') as cartoon from
(select generate_series(1,40) as x) as xx,(select generate_series(1,50) as y) as yy group by xx.x order by xx.x) as co_ord;

