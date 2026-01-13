CREATE TABLE employees
(
      name text,
      startdate date,
      enddate date
);

CREATE TABLE contractors
(
      name text,
      startdate date,
      enddate date
);

insert into employees values ('Maxine', '1/1/2002',NULL);
insert into employees values ('Dave', '1/1/2002',NULL);
insert into employees values ('Edmund', '3/12/2002',NULL);
insert into employees values ('Maggie', '4/11/2002',NULL);
insert into employees values ('Andrew', '10/2/2002',NULL);
insert into contractors values ( 'Andrew', '1/1/2002', '10/5/2002');
insert into contractors values ( 'Marcel', '2/1/2002', NULL);
insert into contractors values ( 'Carrie', '3/10/2002', '12/5/2002');
insert into contractors values ( 'Jacob', '4/7/2002', NULL);
insert into contractors values ( 'Dave', '1/1/2002', NULL);


-- birleşim kümesi
SELECT name, startdate, enddate FROM employees
UNION ALL
SELECT name, startdate, enddate FROM contractors

/* 

UNION ile UNION ALL
arasındaki fark
UNION'da aynı olan satırlardan bir tane gelir,
UNION ALL 'da tüm kayıtlar getirilir

*/

-- kesişim kümesi
SELECT name, startdate, enddate FROM employees
intersect
SELECT name, startdate, enddate FROM contractors

-- fark kümesi
SELECT name FROM employees
EXCEPT
SELECT name FROM contractors;