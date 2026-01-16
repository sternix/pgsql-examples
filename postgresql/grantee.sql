SELECT
    *
FROM
    information_schema.role_table_grants
WHERE
    grantee = 'user'
    AND with_hierarchy = 'YES';

SELECT
    *
FROM
    information_schema.role_table_grants
WHERE
    grantee = 'user'
    and table_name = 'tbltest';

-- bir kullanıcı bir tabloda hangi haklara sahip
-- ve bu haklar nereden gelmiş

SELECT
    grantee,
    privilege_type
FROM
    information_schema.role_table_grants
WHERE
    table_name='mytable'


\dp tbltest
