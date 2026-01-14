SELECT avg(n)
FROM unnest(array[2, 3, 5, 2, 3, 12, 5, 3, 4]) AS n;

SELECT stddev(n)
FROM unnest(array[2, 3, 5, 2, 3, 12, 5, 3, 4]) AS n;

SELECT 
   avg(n) - stddev(n) AS lower_bound,
   avg(n) + stddev(n) AS upper_bound
FROM
   unnest(array[2, 3, 5, 2, 3, 12, 5, 3, 4]) AS n;