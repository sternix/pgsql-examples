-- create a million random numbers and strings
CREATE TABLE items AS
  SELECT
    (random()*1000000)::integer AS n,
    md5(random()::text) AS s
  FROM
    generate_series(1,1000000);

-- inform planner of big table size change
VACUUM ANALYZE;