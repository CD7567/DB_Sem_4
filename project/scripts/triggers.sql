CREATE FUNCTION update_trans() RETURNS trigger
LANGUAGE plpgsql
AS
$$
DECLARE
    old_balance FLOAT;
    total_bonuses FLOAT := OLD.total_bonuses;
BEGIN
    SELECT balance
    INTO old_balance
    FROM cd.clients_wallet
    WHERE client_id = NEW.client_id;

    IF NEW.type != 'spend' THEN
        total_bonuses = -total_bonuses;
    END IF;

    INSERT INTO cd.clients_wallet_history (client_id, transaction_id, balance, rewrite_dttm)
    VALUES (NEW.client_id, NEW.id, old_balance + total_bonuses, now()::timestamp);

    UPDATE cd.clients_wallet
    SET balance = old_balance + total_bonuses
    WHERE client_id = NEW.client_id;

    RETURN NEW;
END;
$$;

CREATE OR REPLACE TRIGGER abort_trans
AFTER UPDATE ON cd.transactions
FOR EACH ROW
WHEN (OLD.status = 'successful' AND NEW.status = 'aborted')
EXECUTE PROCEDURE update_trans();