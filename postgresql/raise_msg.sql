create or replace function f_test () returns void
as
$$
    declare
    begin
        raise debug 'This is a DEBUG message';
        raise log 'This is a LOG message';
        raise notice 'This is an NOTICE message';
        raise warning 'This is a WARNING message';
    end;
$$ language plpgsql;

set client_min_messages = 'WARNING';
select f_test();
WARNING:  This is a WARNING message

set client_min_messages = 'NOTICE';
select f_test();
NOTICE:  This is an NOTICE message
WARNING:  This is a WARNING message

set client_min_messages = 'LOG';
select f_test();
LOG:  This is a LOG message
NOTICE:  This is an NOTICE message
WARNING:  This is a WARNING message

set client_min_messages = 'DEBUG';
=# select f_test();
DEBUG:  This is a DEBUG message
LOG:  This is a LOG message
NOTICE:  This is an NOTICE message
WARNING:  This is a WARNING message

set client_min_messages TO 'debug1';