-- bilgi için, employees tablosu yok

WITH new_employees AS (
    SELECT * FROM (VALUES
        ('George', 'Sales',    'Manager',   1000),
        ('Jane',   'R&D',      'Developer', 1200)
    ) AS t(
         name,      department, role,       salary
    )
)
INSERT INTO employees (name, department, role, salary)
SELECT name, department, role, salary
FROM new_employees
ON CONFLICT (name) DO UPDATE SET
    department = EXCLUDED.department,
    role = EXCLUDED.role,
    salary = EXCLUDED.salary
RETURNING *;