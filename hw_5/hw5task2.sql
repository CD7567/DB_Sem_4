CREATE OR REPLACE FUNCTION serial_generator(
    s INTEGER,
    l INTEGER
)
RETURNS TABLE (serial_generator INT) AS
$$
begin
    RETURN QUERY
        WITH RECURSIVE t(n) AS (
            VALUES (s)
            UNION
            SELECT
                n + 1
            FROM
                t
            WHERE
                n < l
        )
        SELECT n AS serial_generator
        FROM t
        WHERE n >= s AND n < l;
END;
$$
LANGUAGE plpgsql;
