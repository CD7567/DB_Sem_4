SELECT *
FROM cd.transactions;

--
SELECT *
FROM cd.clients_wallet;

--
SELECT *
FROM cd.clients_wallet_history;

--
CALL register_transaction(1, 'gift', 10, now()::TIMESTAMP);

--
CALL register_transaction(1, 'spend', 10, now()::TIMESTAMP);

--
SELECT *
FROM cd.transactions;

--
SELECT *
FROM cd.clients_wallet;

--
SELECT *
FROM cd.clients_wallet_history;




--
SELECT *
FROM cd.offers;

--
SELECT *
FROM cd.offers_content;

--
CALL register_offer(
    'sample_offer', 
    now()::TIMESTAMP, 
    now()::TIMESTAMP, 
    ARRAY [
        (1, 1, 0.1)::OFFER_ITEM,
        (2, 1, 0.1)::OFFER_ITEM
    ]
);

--
SELECT *
FROM cd.offers;

--
SELECT *
FROM cd.offers_content;