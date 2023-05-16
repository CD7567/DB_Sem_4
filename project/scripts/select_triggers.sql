SELECT *
FROM cd.transactions;

SELECT *
FROM cd.clients_wallet;

SELECT *
FROM cd.clients_wallet_history;

UPDATE cd.transactions
SET status = 'aborted'
WHERE id = 12;

SELECT *
FROM cd.transactions;

SELECT *
FROM cd.clients_wallet;

SELECT *
FROM cd.clients_wallet_history;