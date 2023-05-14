-- VIEW клиентов с сокрытием персональных данных

CREATE OR REPLACE VIEW v.v_clients_pr AS
    SELECT id,
           first_name || ' ' || last_name AS client,
           split_part(phone, '-', 1) || '-(***)-***-' || split_part(phone, '-', 4) || '-' || split_part(phone, '-', 5) AS phone,
           '*****@' || split_part(email, '@', 2) AS email,
           '**** **** **** ' || split_part(card_num, ' ', 4) AS card_number,
           sex
    FROM cd.clients;

-- VIEW продаваемых товаров с их средней ценой

CREATE OR REPLACE VIEW v.v_items_stat AS
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

-- VIEW истории кошелька

CREATE OR REPLACE VIEW v.v_wallet_history AS
    SELECT
        hist.rewrite_dttm,
        cl.id as client_id,
        tr.id AS transaction_id,
        tr.type as transaction_type,
        tr.total_bonuses,
        hist.balance AS upd_balance
    FROM (
        cd.clients cl
        RIGHT JOIN
        cd.clients_wallet_history hist ON cl.id = hist.client_id
        FULL JOIN
        cd.transactions tr ON tr.id = hist.transaction_id
    )
    ORDER BY hist.rewrite_dttm, cl.id;

-- VIEW успешных транзакций с информацией

CREATE OR REPLACE VIEW v.v_suc_trans_full AS
    SELECT
        tr.time,
        tr.id,
        tr.client_id,
        tr.type,
        tr.total_bonuses,
        con.item_id,
        con.quantity,
        con.bonus_count
    FROM (
        cd.transactions tr
        INNER JOIN
        cd.transactions_content con ON tr.id = con.transaction_id
    )
    WHERE tr.status = 'successful'
    ORDER BY tr.time, tr.id;

-- VIEW торговли магазинами

CREATE OR REPLACE VIEW v.v_shops_trading AS
    SELECT
        sh.id AS shop_id,
        sh.name AS shop_name,
        inf.item_id AS item_id,
        it.name AS item_name,
        it.manufacturer as manufacturer,
        it.vendor_code,
        it.category,
        inf.price
    FROM (
        cd.shops sh
        INNER JOIN
        cd.items_info inf ON sh.id = inf.shop_id
        INNER JOIN
        cd.items it ON it.id = inf.item_id
    )
    ORDER BY sh.id;

-- VIEW надежности клиентов

CREATE OR REPLACE VIEW v.v_cl_reliability AS
    SELECT
        row_number() OVER (
            ORDER BY
                sum(CASE WHEN hist.event_type = 'pause' THEN 1 ELSE 0 END) ASC,
                sum(CASE WHEN hist.event_type = 'leave' THEN 1 ELSE 0 END) ASC,
                id
        ) AS rank,
        cl.id,
        first_name || ' ' || last_name AS client,
        sum(CASE WHEN hist.event_type = 'pause' THEN 1 ELSE 0 END) AS pause_count,
        sum(CASE WHEN hist.event_type = 'leave' THEN 1 ELSE 0 END) AS leave_count
    FROM (
        cd.clients cl
        INNER JOIN
        cd.clients_history hist ON cl.id = hist.client_id
    )
    GROUP BY cl.id
    ORDER BY
        leave_count ASC,
        pause_count ASC,
        id;
