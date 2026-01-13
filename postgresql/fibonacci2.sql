WITH RECURSIVE generator_fibo(p,n) AS (
    SELECT 0,1
    UNION ALL
    SELECT n,p + n
        FROM generator_fibo
    WHERE n < 100
) SELECT p FROM generator_fibo;
