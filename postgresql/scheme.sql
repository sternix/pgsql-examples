schemaları listele
\dn
set search_path = 'beta';

tekrar geri dönmek için
set search_path = 'public';

birden çok schema tanımlamak için
set search_path = beta,public;

SHOW search_path;

\dt schema1.* - List tables inside a particular schema.
                For example: 'schema1'.

beta şemasındaki tablolar
\dt beta.*

