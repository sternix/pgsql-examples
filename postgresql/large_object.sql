CREATE TABLE mypictures
(
        title TEXT NOT NULL primary key,
        picture OID
);

-- pgadminde superuser olarak
INSERT INTO mypictures (title, picture) VALUES ('Red Roses', lo_import('/home/test/redroses.jpg'));
select * from mypictures
SELECT lo_export(picture, '/home/test/redroses_copy.jpg') FROM mypictures WHERE title = 'Red Roses';


--psql'de

\lo_import '/home/test/whiteroses'
INSERT INTO mypictures (title, picture) VALUES ('White Roses', :LASTOID);

SELECT * from mypictures;

\lo_export 16670 '/home/test/whiteroses_copy.jpg'

burada 16670 oid değeri

\lo_list
large object'leri listeliyor

delete işlemlerinde lo_unlink'i direk kullanmak yerine
rule yazarak (delete ve update'de) işlemleri standart sql komutları ile
yapabiliriz,

normal delete sadece satırı siliyor fakat oid değerini lo_unlink yapmak
gerekiyor,

CREATE RULE droppicture AS ON DELETE TO mypictures
DO SELECT lo_unlink( OLD.picture );

CREATE RULE reppicture AS ON UPDATE TO mypictures
DO SELECT lo_unlink( OLD.picture ) where OLD.picture <> NEW.picture;

update mypictures set picture=lo_import('/home/test/redroses_copy.jpg') where title='Red Roses';

