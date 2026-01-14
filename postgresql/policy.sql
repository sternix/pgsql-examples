CREATE TABLE clients (
    id serial primary key,
    account_name text not null unique,
    account_manager text not null
);

CREATE USER peter;

CREATE USER joanna;

CREATE USER bill;

GRANT all on table clients to peter, joanna, bill;

GRANT all on sequence clients_id_seq to peter, joanna, bill;

INSERT INTO clients (account_name, account_manager)
    values ('initrode', 'peter'), ('initech', 'bill'), ('chotchkie''s', 'joanna');

CREATE POLICY just_own_clients
    on clients
    for all
    to public
    using ( account_manager = current_user );

ALTER TABLE clients ENABLE ROW LEVEL SECURITY;

DROP POLICY just_own_clients on clients;

CREATE POLICY just_own_clients
    on clients
    for all
    to public
    using ( account_manager = current_user )
    with check ( account_manager in ( 'bill', current_user ) );