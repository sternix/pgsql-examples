SELECT COALESCE(NULL, NULL, 'first non null', null, null, 'second non null');

coalesce
--------
'first non null'


SELECT COALESCE(NULL, NULL, 'HELLO WORLD');

coalesce
--------
'HELLO WORLD'