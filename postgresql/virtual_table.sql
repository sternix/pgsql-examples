-- https://stackoverflow.com/questions/955167/return-setof-record-virtual-table-from-function

SELECT * FROM  
(
    VALUES
        (1::int, 2::int, 3::int),
        (3, 4, 5),
        (3, 4, 5)
) AS t(a, b, c);