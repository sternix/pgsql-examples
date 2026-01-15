-- https://twitter.com/FTisiot/status/1491018723959853059/photo/1

DROP TABLE IF EXISTS employees;

CREATE TABLE employees
(
    employee_id INT,
    employee_name VARCHAR,
    boss_id INT
);

INSERT INTO employees VALUES
    (1,'Pamela',null),
    (2,'Jon',1),
    (3,'Anna',1),
    (4,'Josh',2),
    (5,'Tom',4),
    (6,'Adele',3),
    (7,'Mary',5),
    (8,'Gareth',3),
    (9,'Giuseppe',8),
    (10,'Francesco',9);


WITH RECURSIVE emp (employee_id, employee_name, boss_name, hierarchy) AS (
    SELECT
        employee_id as employee_id,
        employee_name as employee_name,
        CAST(NULL as VARCHAR) as boss_name,
        ARRAY[employee_name] as hierarchy
    FROM employees WHERE boss_id is NULL
    UNION ALL
    SELECT
        employees.employee_id as employee_id,
        employees.employee_name as employee_name,
        emp.employee_name as boss_name,
        hierarchy || employees.employee_name as hierarchy
    FROM employees JOIN emp on employees.boss_id = emp.employee_id
)

SELECT * FROM emp;