https://it.badykov.com/blog/2022/09/12/simple-and-usefull-postgresql-features/

Common Table Expression

A common table expression is a temporary result set which you can reference within another SQL statement including SELECT, INSERT, UPDATE or DELETE.

Common Table Expressions are temporary in the sense that they only exist during the execution of the query.

The following shows the syntax of creating a CTE:

WITH cte_name (column_list) AS (
    CTE_query_definition
)
statement;

Common Table Expressions or CTEs are typically used to simplify complex joins and subqueries in PostgreSQL.

The following statement illustrates how to join a CTE with a table:

WITH cte_rental AS (
    SELECT staff_id,
        COUNT(rental_id) rental_count
    FROM   rental
    GROUP  BY staff_id
)
SELECT s.staff_id,
    first_name,
    last_name,
    rental_count
FROM staff s
    INNER JOIN cte_rental USING (staff_id);

In this example:

First, the CTE returns a result set that includes staff id and the number of rentals. Then, join the staff table with the CTE using the staff_id column.
