create table salary
(
        salary int,
        oldsalary int,
        approvedby varchar(25)
);

CREATE OR REPLACE FUNCTION newsal() returns TRIGGER as
$$
BEGIN
        IF NEW.salary <> OLD.salary THEN
                NEW.oldsalary = OLD.salary;
                NEW.approvedby = NULL;
        END IF;
        RETURN NEW;
END;
$$language 'plpgsql';

CREATE TRIGGER newsal BEFORE UPDATE on salary FOR EACH ROW EXECUTE PROCEDURE newsal();