CREATE OR REPLACE
FUNCTION count_non_volatile_days(nm TEXT)
RETURNS INTEGER AS
$BODY$
    DECLARE
        res INTEGER;
        num INTEGER;
    BEGIN
        SELECT
            count(*)
        INTO
            num
        FROM
            coins
        WHERE
            nm = coins.full_nm
        ;

        IF num = 0 THEN
            RAISE EXCEPTION 'Crypto currency with name "{full_nm}" is absent in database!, {full_nm}'
            USING ERRCODE = '02000';
        END IF;

        SELECT
            count(dt)
        INTO
            res
        FROM
            coins
        WHERE
            low_price = high_price AND
            coins.full_nm =  nm
        ;

        RETURN res;
    END;
$BODY$
LANGUAGE plpgsql;
