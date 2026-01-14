create or replace function myuser3(myuser integer, out my_user_id integer, out myusername text)
returns record as $$
begin
    select user_id, username from users where user_id <= $1 into my_user_id, myusername;
return;
end $$ language 'plpgsql';