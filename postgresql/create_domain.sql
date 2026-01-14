create domain email_address text not null constraint chk_email
    check(
        length(value) < 254
        and
        value ~ '^[a-zA-Z0-9._%+-]{1,64}@(?:[a-zA-Z0-9-]{1,63}\.){1,125}[a-zA-Z]{2,63}$'
    );

create table emails2(id serial primary key, email email_address);

insert into emails2 values (default,'sdfgsdfg');
ERROR:  value for domain email_address violates check constraint "chk_email" 

insert into emails2 values (default,'aaa@dfgdfg.com');
INSERT 0 1

-----

CREATE DOMAIN color VARCHAR(20) CHECK (VALUE IN ('red', 'yellow', 'blue'));

create table t2 (id serial primary key, color color);

insert into t2 values (default,'blue');
OK

insert into t2 values (default,'red');
OK

insert into t2 values (default,'black');
ERROR:  value for domain color violates check constraint "color_check"
