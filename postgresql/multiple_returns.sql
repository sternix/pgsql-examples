-- birden çok değeri döndürmek için
-- default değerler ve inout zorunlu,

create or replace procedure counts(
    inout mail_count int default 0,
    inout email_count int default 0,
    inout gonderi_count int default 0,
    inout fail_count int default 0,
    inout login_count int default 0
) as
$$
begin
    select count(*) into mail_count from mails;
    select count(*) into email_count from emails;
    select count(*) into gonderi_count from gonderi;
    select count(*) into fail_count from login_failures;
    select count(*) into login_count from logins;
end;
$$
language plpgsql;


call counts();