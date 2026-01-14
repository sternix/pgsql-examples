-- lateral - yanal demek
-- https://www.cybertec-postgresql.com/en/understanding-lateral-joins-in-postgresql/

CREATE TABLE t_product AS
    SELECT   id AS product_id,
             id * 10 * random() AS price,
             'product ' || id AS product
    FROM generate_series(1, 1000) AS id;

CREATE TABLE t_wishlist
(
    wishlist_id        int,
    username           text,
    desired_price      numeric
);

INSERT INTO t_wishlist VALUES
    (1, 'hans', '450'),
    (2, 'joe', '60'),
    (3, 'jane', '1500')
;


SELECT * FROM t_product LIMIT 10;
SELECT * FROM t_wishlist;


-- pseudo-code
```
for x in wishlist
loop
      for y in products order by price desc
      loop
           found++
           if found <= 3
           then
               return row
           else
               jump to next wish
           end
      end loop
end loop
```

-- SQL hali

SELECT * FROM t_wishlist AS w,
    LATERAL (SELECT * FROM t_product AS p
             WHERE p.price < w.desired_price
             ORDER BY p.price DESC
             LIMIT 3) AS x
ORDER BY wishlist_id, price DESC;


/*

We'll go through it step by step.
The first thing you see in the FROM clause is the t_wishlist table.
What LATERAL can do now is to use entries from the wishlist to do its magic.
So for each entry in the wishlist, we pick three products.
To figure out which products we need, we can make use of w.desired_price.
In other words: It is like a "join with parameters".
The FROM-clause is the "outer loop" in our pseudo code and the LATERAL can be seen as the "inner loop".

PostgreSQL returned three entries for each wishlist, which is exactly what we wanted. The important part here is that the LIMIT-clause is inside the SELECT fed to LATERAL. Thus it limits the number of rows per wishlist, and not the overall number of rows.

*/