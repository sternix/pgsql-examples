CREATE TABLE people (
        id INT PRIMARY KEY,
        name TEXT,
        email TEXT
);

CREATE FUNCTION merge_people(in_id INT, in_name TEXT, in_email TEXT)
RETURNS VOID AS
$$
BEGIN
        LOOP
                UPDATE people SET name = in_name, email=in_email WHERE id = in_id;
                IF found THEN
                        RETURN;
                END IF;

                BEGIN
                        INSERT INTO people(id,name,email) VALUES (in_id, in_name, in_email);
                        RETURN;
                        EXCEPTION WHEN unique_violation THEN
                                -- do nothing
                END;
        END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT merge_people(1, 'david', 'david@gmail.com');     -- Adds id 1
SELECT merge_people(1, 'david', 'david@hotmail.com');   -- Updates id 1
SELECT merge_people(2, 'harold', 'harold@hotmail.com'); -- Adds id 2
select * from people;

-- bunun yerine merge kullanılabilir

MERGE INTO customer_account ca USING recent_transactions t
    ON t.customer_id = ca.customer_id
WHEN MATCHED THEN
    UPDATE SET balance = balance + transaction_value
WHEN NOT MATCHED THEN
    INSERT (customer_id, balance)
    VALUES (t.customer_id, t.transaction_value);