-- Композитный тип для добавления товаров в предложение

CREATE TYPE OFFER_ITEM AS (
    item_id INTEGER,
    shop_id INTEGER,
    interest FLOAT
);

-- Процедура регистрации новой проведенной транзакции

CREATE OR REPLACE PROCEDURE register_transaction(upd_client_id INTEGER, type TRANS_TYPE, total_bonuses FLOAT, upd_time TIMESTAMP)
LANGUAGE plpgsql
AS
$$
DECLARE
    old_balance INTEGER;
    ins_trans_id INTEGER;
BEGIN
    SELECT balance
    INTO old_balance
    FROM cd.clients_wallet
    WHERE client_id = upd_client_id;

    INSERT INTO cd.transactions (client_id, type, total_bonuses, time, status)
    VALUES (upd_client_id, type, total_bonuses, upd_time, 'successful');

    SELECT currval(pg_get_serial_sequence('cd.transactions','id'))
    INTO ins_trans_id;

    IF type = 'spend' THEN
        total_bonuses = -total_bonuses;
    END IF;

    INSERT INTO cd.clients_wallet_history (client_id, transaction_id, balance, rewrite_dttm)
    VALUES (upd_client_id, ins_trans_id, old_balance + total_bonuses, upd_time);

    UPDATE cd.clients_wallet
    SET balance = old_balance + total_bonuses
    WHERE client_id = upd_client_id;

END;
$$;

-- Процедура регистрации нового предложения

CREATE OR REPLACE PROCEDURE register_offer(off_name VARCHAR(256), start_dttm TIMESTAMP, expiration_dttm TIMESTAMP, items OFFER_ITEM[])
LANGUAGE plpgsql
AS
$$
DECLARE
    status BOOLEAN := start_dttm < now()::timestamp;
    ins_offer_id INTEGER;
BEGIN
    INSERT INTO cd.offers (name, start_dttm, expiration_dttm, status)
    VALUES (off_name, start_dttm, expiration_dttm, status);

    SELECT currval(pg_get_serial_sequence('cd.offers','id'))
    INTO ins_offer_id;

    INSERT INTO cd.offers_content (offer_id, item_id, shop_id, interest)
        SELECT ins_offer_id, *
        FROM unnest(items);

END;
$$;