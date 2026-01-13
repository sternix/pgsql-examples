CREATE TYPE salavgs AS (
        deptid integer,
        minsal integer,
        maxsal integer,
        avgsalary int8
);

CREATE OR REPLACE FUNCTION avgsal() RETURNS SETOF salavgs AS $$
DECLARE
        s salavgs%ROWTYPE;
        salrec RECORD;
        bucket int8;
        counter int;
BEGIN
        bucket   :=0;
        counter  :=0;
        s.maxsal :=0;
        s.minsal :=0;
        s.deptid :=0;
        FOR salrec IN SELECT salary AS salary, d.id AS department
                       FROM employee e, department d WHERE e.departmentid = d.id
                       ORDER BY d.id LOOP
        IF s.deptid = 0 THEN
                s.deptid := salrec.department;
                s.minsal := salrec.salary;
                s.maxsal := salrec.salary;
                counter  := counter + 1;
                bucket   := bucket + salrec.salary;
         ELSE
                IF s.deptid = salrec.department THEN
                   IF s.maxsal <= salrec.salary THEN
                      s.maxsal := salrec.salary;
                   END IF;
                   IF s.minsal >= salrec.salary THEN
                      s.minsal := salrec.salary;
                   END IF;
                   counter := counter + 1;
                   bucket  := bucket + salrec.salary;
                ELSE
                   s.avgsalary := bucket/counter;
                   RETURN NEXT s;
                   s.deptid := salrec.department;
                   s.minsal := salrec.salary;
                   s.maxsal := salrec.salary;
                   counter  := 1;
                   bucket   := salrec.salary;
                END IF;
             END IF;
          END LOOP;
          s.avgsalary := bucket/counter;
          RETURN NEXT s;
        RETURN;
        END
$$ LANGUAGE 'plpgsql';


CREATE or REPLACE FUNCTION avgdept() RETURNS deptavgs AS $$
DECLARE
      r deptavgs%rowtype;
      dept record;
      bucket int8;
      counter int;
BEGIN
      bucket   := 0;
      counter  := 0;
      r.maxsal := 0;
      r.minsal := 0;
      FOR dept IN SELECT sum(salary) AS salary, d.id AS department
                  FROM employee e, department d WHERE e.departmentid = d.id
                  GROUP BY department
      LOOP
         counter := counter + 1;
         bucket  := bucket + dept.salary;
         IF r.maxsal <= dept.salary OR r.maxsal = 0 THEN
            r.maxsal := dept.salary;
         END IF;
         IF r.minsal >= dept.salary OR r.minsal = 0 THEN
            r.minsal := dept.salary;
         END IF;
      END LOOP;

      r.avgsalary := bucket/counter;

      RETURN r;
   END
$$ language 'plpgsql';