inherit

CREATE TABLE users (username text, email text);
CREATE TABLE simple_users () INHERITS (users);
ALTER TABLE simple_users ADD COLUMN password text;


CREATE TABLE users (username text, email text);
CREATE TABLE simple_users () INHERITS (users);
CREATE TABLE users_with_password (password text) INHERITS (users);