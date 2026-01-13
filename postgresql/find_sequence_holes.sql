SELECT
  CASE WHEN start = finish THEN start::text
       ELSE start || '-' || finish END AS gap
FROM (
  SELECT hole.id AS start, MIN(f.id)-1 AS finish
  FROM fred f, (
    SELECT id+1 AS id FROM fred f1
    WHERE NOT EXISTS (SELECT 1 FROM fred f2 WHERE f2.id = f1.id+1)
  ) AS hole
  WHERE f.id > hole.id
  GROUP BY 1
) AS wilma;


CREATE TABLE fred (
  id INTEGER PRIMARY KEY
);

INSERT INTO fred VALUES (1);
INSERT INTO fred VALUES (2);
INSERT INTO fred VALUES (3);
INSERT INTO fred VALUES (5);
INSERT INTO fred VALUES (6);
INSERT INTO fred VALUES (7);
INSERT INTO fred VALUES (10);
INSERT INTO fred VALUES (16);
INSERT INTO fred VALUES (18);
INSERT INTO fred VALUES (30);