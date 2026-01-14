-- https://blog.yo1.dog/updating-enum-values-in-postgresql-the-safe-and-easy-way/

rename the existing type

ALTER TYPE status_enum RENAME TO status_enum_old;

create the new type

CREATE TYPE status_enum AS ENUM('queued', 'running', 'done');

update the columns to use the new type

ALTER TABLE job ALTER COLUMN job_status TYPE status_enum USING job_status::text::status_enum;

remove the old type

DROP TYPE status_enum_old;
