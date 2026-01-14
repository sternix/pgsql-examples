-- PostgreSQL uuid

select gen_random_uuid();

CREATE TABLE has_uuid_pkey (
   id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
   ...
);

CREATE UNLOGGED TABLE test_uuid (
   id uuid DEFAULT gen_random_uuid() PRIMARY KEY
);