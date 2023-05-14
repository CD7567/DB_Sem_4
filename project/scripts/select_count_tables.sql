SELECT
    'clients' AS table_name,
    count(*) AS cnt
FROM
    cd.clients

UNION ALL

SELECT
    'shops' AS table_name,
    count(*) AS cnt
FROM
    cd.shops

UNION ALL

SELECT
    'items' AS table_name,
    count(*) AS cnt
FROM
    cd.items

UNION ALL

SELECT
    'items_info' AS table_name,
    count(*) AS cnt
FROM
    cd.items_info

UNION ALL

SELECT
    'offers' AS table_name,
    count(*) AS cnt
FROM
    cd.offers

UNION ALL

SELECT
    'offers_content' AS table_name,
    count(*) AS cnt
FROM
    cd.offers_content

UNION ALL

SELECT
    'transactions' AS table_name,
    count(*) AS cnt
FROM
    cd.transactions

UNION ALL

SELECT
    'transactions_content' AS table_name,
    count(*) AS cnt
FROM
    cd.transactions_content

UNION ALL

SELECT
    'clients_history' AS table_name,
    count(*) AS cnt
FROM
    cd.clients_history

UNION ALL

SELECT
    'clients_wallet' AS table_name,
    count(*) AS cnt
FROM
    cd.clients_wallet

UNION ALL

SELECT
    'clients_wallet_history' AS table_name,
    count(*) AS cnt
FROM
    cd.clients_wallet_history;