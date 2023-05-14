-- SELECT

-- Выбор соответствия клиента и его транзакций

SELECT concat(cl.first_name, ' ', cl.last_name) AS client, tr.id AS transaction_id, tr.total_bonuses, tr.time
FROM (cd.clients cl INNER JOIN cd.transactions tr ON cl.id = tr.client_id)
GROUP BY client, tr.id, tr.total_bonuses, tr.time
ORDER BY client;

-- Выбор соответствия транзакции и ее позиций

SELECT tr.id AS transaction_id, con.item_id, con.quantity
FROM (cd.transactions tr INNER JOIN cd.transactions_content con ON tr.id = con.transaction_id)
GROUP BY tr.id, con.item_id, con.quantity
ORDER BY tr.id, con.quantity;

-- Подсчет количества предложений на товар

SELECT it.name, count(offer_id) as offer_count
FROM (cd.items it LEFT JOIN cd.offers_content con ON it.id = con.item_id)
GROUP BY it.name
ORDER BY offer_count;

-- Определить самую дорогую по начислению транзакцию-покупку

SELECT id, total_bonuses
FROM cd.transactions
ORDER BY total_bonuses DESC
LIMIT 1;

-- Определить среднее количество начисляемых бонусов при покупках

SELECT AVG(total_bonuses) as average_bonuses
FROM (
    SELECT total_bonuses
    FROM cd.transactions
    WHERE type = 'purchase'
) as bonuses;

-- Определить количество транзакций, проведенных успешно

SELECT count(id) AS successful_count
FROM (
    SELECT id
    FROM cd.transactions
    WHERE EXTRACT(YEAR FROM time) = '2023' and status = 'successful'
) suc_trans;

-- DELETE

-- Удалить товары, на которые нет предложений

DELETE FROM cd.items
WHERE (id, 0) IN (
    SELECT it.id as id, count(offer_id) as offer_count
    FROM (cd.items it LEFT JOIN cd.offers_content con ON it.id = con.item_id)
    GROUP BY it.id
);

-- Удалить магазины, не сделавшие предложений

DELETE FROM cd.shops
WHERE (id, 0) IN (
    SELECT sh.id as id, count(offer_id) as offer_count
    FROM (cd.shops sh LEFT JOIN cd.offers_content con ON sh.id = con.shop_id)
    GROUP BY sh.id
);

-- UPDATE

-- Повысились налоги, цены на товары дороже 50$ увеличиваются на 5%

UPDATE cd.items_info
SET price = price * 1.05
WHERE price > 50;

-- Изменился региональный код страны (+2) на (+3)

UPDATE cd.clients
SET phone = REPLACE(phone, '+2', '+3');