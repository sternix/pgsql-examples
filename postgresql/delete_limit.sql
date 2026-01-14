WITH rows AS (
  SELECT
    something
  FROM
    big_table
  LIMIT 10
)
DELETE FROM big_table
WHERE something IN (SELECT something FROM rows)
;

ile

DELETE FROM big_table LIMIT 10000;

gibi delete'e limit koyabiliriz.