SELECT
	a.attname,
	t.typname,
	t.typalign,
	t.typlen
FROM pg_class c
	JOIN pg_attribute a ON (a.attrelid = c.oid)
	JOIN pg_type t ON (t.oid = a.atttypid)
WHERE 
	c.relname = 'TABLO_ADI'
	AND a.attnum >= 0
ORDER BY a.attnum;


/*

typealign değerleri
https://www.postgresql.org/docs/current/catalog-pg-type.html

c = char alignment, i.e., no alignment needed.
s = short alignment (2 bytes on most machines).
i = int alignment (4 bytes on most machines).
d = double alignment (8 bytes on many machines, but by no means all).

varchar alanları sonra doğru koyulmalı

alter table ile alter column ile veri tipi değiştirildiğinden
alignmenttan dolayı tablo baştan oluşturulur,
diğer veritabanlarının aksine postgresql'de araya kolon ekleme özelliği yok

*/