create or replace function myuser2(myuser integer, out my_user_id integer, out myusername text) returns setof record as $$
declare
    foo record;
begin
    for foo in select user_id, username from users where user_id <= $1 loop
        my_user_id=foo.user_id;
        myusername=foo.username;
        return next;
    end loop;
    
    return;
end $$ language 'plpgsql';