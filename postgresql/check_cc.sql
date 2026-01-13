-- kredi kartı kontrolü

CREATE OR REPLACE FUNCTION cc_check (VARCHAR) RETURNS BOOLEAN AS $$
DECLARE
    cc_num     ALIAS FOR $1;
    i          INTEGER;
    d          VARCHAR;
    weight     INTEGER;
    checksum   INTEGER := 0;
    oddness    INTEGER;
    num        INTEGER;
    tempstring VARCHAR;
BEGIN
    -- Strip out non-digits.  Oh, for an s/// construct! :)
    tempstring := '';
    FOR i IN 1..length(cc_num)
    LOOP
        d := SUBSTRING(cc_num, i, 1);
        IF d ~ '[0-9]'
        THEN
            tempstring := tempstring || d;
        END IF;
    END LOOP;
    -- Check length for reasonableness.
    IF (length(tempstring) < 13)
    THEN
        RAISE NOTICE '% is too short to be a credit card number.', cc_num;
        RETURN FALSE;
    END IF;
    -- Do a Luhn checksum.
    oddness := length(tempstring) % 2;
    FOR i IN 1 .. length(tempstring)
    LOOP
        num := SUBSTRING(tempstring, i, 1)::integer;
        IF (oddness = 0 AND i % 2 = 1)
        THEN
            num := num * 2;
        ELSIF (oddness = 1 AND i%2 = 0)
        THEN
            num := num * 2;
        END IF;
        IF num > 9
        THEN
            num := num - 9;
        END IF;
        checksum := checksum + num;
    END LOOP;
    IF checksum % 10 <> 0
    THEN
        RAISE NOTICE '% does not have a valid checksum.', cc_num;
        RETURN FALSE;
    END IF;
    IF tempstring ~ '^3[47][0-9]{13}$'
    THEN
        RAISE NOTICE '% is an American Express card.', cc_num;
    ELSIF tempstring ~ '^4[0-9]{12}([0-9]{3})?$'
    THEN
        RAISE NOTICE '% is a VISA card.', cc_num;
    ELSIF tempstring ~ '^5[1-5][0-9]{14}$'
    THEN
        RAISE NOTICE '% is a MasterCard.', cc_num;
    ELSIF tempstring ~ '^6011[0-9]{12}$'
    THEN
        RAISE NOTICE '% is a Discover card.', cc_num;
    ELSIF tempstring ~ '^3(0[0-5]|[68][0-9])[0-9]{11}$'
    THEN
        RAISE NOTICE '% is a Diners Club/Carte Blanche.', cc_num;
    ELSIF tempstring ~ '^2(014|149)\d{11}$'
    THEN
        RAISE NOTICE '% is an enRoute card.', cc_num;
    ELSIF tempstring ~ '^(3\d{4}|2131|1800)\d{11}$'
    THEN
        RAISE NOTICE '% is a JCB card.', cc_num;
    ELSIF tempstring ~ '^56(10\d\d|022[1-5])\d{10}$'
    THEN
        RAISE NOTICE '% is a BankCard.', cc_num;
    END IF;
   RETURN TRUE;
END;
$$ LANGUAGE 'plpgsql';

