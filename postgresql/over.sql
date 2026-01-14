OVER() assigns every row a window
A "window" is aset of rows

A window can be as big as the whole table
(an empty OVER() is the whole table) or as small as just one row.

OVER() is confusing at first, so here's an example
Let's run this query that ranks students in each class by grade

create  table grades (name varchar, class int, grade int);
insert into grades values ('juan',1,93),('lucia',1,98),('raph',2,88),('chen',2,90);

name  | class | grade
-------+-------+-------
 juan  |     1 |    93
 lucia |     1 |    98
 raph  |     2 |    88
 chen  |     2 |    90

SELECT name, class, grade,
    ROW_NUMBER() OVER( PARTITION BY class ORDER BY grade DESC )
    AS rank_in_class
FROM grades

OVER(PARTITION BY class)
bize class'a göre ayrılmış iki partition veriyor
ORDER BY grade DESC ile bu partition'lar grade'e göre ters sıralanıyor (büyük önce)

sonra bu partion'lar toplanıyor, ROW_NUMBER() partition içindeki sıra numarası veriyor

name  | class | grade | rank_in_class
-------+-------+-------+---------------
 lucia |     1 |    98 |             1
 juan  |     1 |    93 |             2
 chen  |     2 |    90 |             1
 raph  |     2 |    88 |             2

sınıflardaki öğrencilerin notu üzerinden kendi sınıfları içindeki sıralaması

