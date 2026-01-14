https://sql-bits.com/postgresql-working-with-enum-types/

CREATE TYPE ORDER_STATUS AS ENUM
    ('new', 'sent', 'delivered', 'cancelled');
CREATE TYPE TASK_STATUS AS ENUM
    ('new', 'in progress', 'done');


CREATE TABLE product_order (
    id SERIAL PRIMARY KEY,
    status ORDER_STATUS NOT NULL DEFAULT 'new',
    ...
);

SELECT count(*)
    FROM product_order
    WHERE status = 'new';

SELECT count(*)
    FROM product_order
    WHERE status < 'delivered';


SELECT
        t.name AS type_name,
        e.enumlabel AS element
    FROM pg_type t
    INNER JOIN pg_enum e
        ON t.oid = e.enumtypid
    WHERE t.typtype = 'e'
    ORDER BY t.name, e.enumsortorder;


ALTER TABLE ORDER_STATUS
    -- you can use AFTER rather than BEFORE
    ADD VALUE 'invalid' BEFORE 'cancelled';

ALTER TABLE ORDER_STATUS
    RENAME VALUE 'invalid' TO 'rejected';

ALTER TABLE ORDER_STATUS
    RENAME TO PRODUCT_ORDER_STATUS;


ALTER TABLE ORDER_STATUS
    ADD VALUE x,
    RENAME VALUE y TO z;

DROP TYPE ORDER_STATUS;


DROP TYPE ORDER_STATUS CASCADE;

