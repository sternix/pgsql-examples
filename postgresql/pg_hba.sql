-- admin kullanıcı ile çalıştır
-- pg_hba.conf'taki değerleri görüntüleme

select
    rule_number rule,
    type,
    database,
    user_name,
    auth_method
from
    pg_hba_file_rules
where
    database != '{replication}';

