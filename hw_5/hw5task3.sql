CREATE SEQUENCE s
START 1;
CREATE OR REPLACE
FUNCTION v_new_insert()
RETURNS TRIGGER AS
$$
BEGIN
    INSERT INTO auctioneer
    SELECT nextval('s'),
    new.payload::json ->'auctioneer'->'firstname',
    new.payload::json->'auctioneer'->'lastname',
    new.payload::json->'auctioneer'->'nickname',
    new.payload::json->'auctioneer'->'email';

    INSERT INTO attachment
    SELECT currval('s'),
    new.payload::json->'attachment'->'filename',
    new.payload::json->'attachment'->'location'->'datacenter',
    new.payload::json->'attachment'->'location'->'localname';

    INSERT INTO bet
    SELECT currval('s'),
    cast(new.payload::json->'bet'->>'volume' AS NUMERIC),
    to_timestamp(0) + cast(new.payload::json->'bet'->>'ts' AS INTERVAL);

    RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER log_update
    INSTEAD OF INSERT ON v_auction_payload
    FOR EACH ROW EXECUTE FUNCTION v_new_insert();
