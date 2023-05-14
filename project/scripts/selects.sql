-- GROUP BY + HAVING

SELECT name, category, price
FROM (
    cd.items it INNER JOIN cd.items_info inf
    ON it.id = inf.item_id
)
GROUP BY shop_id, name, category, price
HAVING shop_id = 1
ORDER BY name;

-- Вывести все товары, продаваемые в Ашане

-- ORDER BY

SELECT
    concat(first_name, ' ', last_name) AS client,
    email,
    birth_date
FROM cd.clients
ORDER BY birth_date;

-- Вывести клиентов по возрасту

SELECT tr.id AS transaction_id, con.item_id, con.quantity
FROM (cd.transactions tr INNER JOIN cd.transactions_content con ON tr.id = con.transaction_id)
GROUP BY tr.id, con.item_id, con.quantity
ORDER BY tr.id, con.quantity;

-- Выбор соответствия транзакции и ее позиций

-- func OVER PARTITION BY

SELECT
    it.name AS item_name,
    sh.name AS shop_name,
    price,
    ROUND(CAST(AVG(price) OVER (PARTITION BY it.name) AS NUMERIC), 2) as avg_price
FROM (
    cd.items it
    FULL JOIN
    cd.items_info inf ON it.id = inf.item_id
    FULL JOIN cd.shops sh ON inf.shop_id = sh.id
)
ORDER BY it.name;

-- Вывести среднюю цену товаров

SELECT
    tr.id AS transaction_id,
    con.item_id,
    con.quantity,
    SUM(con.quantity) OVER (PARTITION BY tr.id) as total_quantity
FROM (
    cd.transactions tr
    INNER JOIN
    cd.transactions_content con ON tr.id = con.transaction_id
)
ORDER BY tr.id, con.quantity;

-- Соответствие транзакций с их позициями и суммарным числом позиций

-- func OVER ORDER BY

SELECT
    RANK() OVER (ORDER BY balance DESC) AS rating,
    concat(cl.first_name, ' ', cl.last_name) AS client,
    balance
FROM (
    cd.clients cl INNER JOIN cd.clients_wallet
    ON cl.id = clients_wallet.client_id
);

-- Отранжировать клиентов по количеству бонусов
