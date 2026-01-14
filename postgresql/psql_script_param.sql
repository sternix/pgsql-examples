-- https://mydbanotebook.org/psql_tips_all.html

sorgudaki paramtetrelere psql --set ile değer vermek

query.sql
```
select * from tbltest where id = :id;
```

psql -d test --set id=12 -f query.sql

string parametreler için '' tırnak kullanılır
select * from test where value = :'var';

------

#!/bin/sh

psql -d test -U user --set tbl=tbltest -f x.sql

x.sql
=BEGIN
select * from :tbl
=END
