DO $$ BEGIN
    CREATE TYPE TRANS_TYPE AS ENUM ('purchase', 'gift', 'spend');
    CREATE TYPE TRANS_STATUS AS ENUM ('successful', 'aborted');
    CREATE TYPE HISTORY_EVENT_TYPE AS ENUM ('join', 'pause', 'resume', 'leave');
EXCEPTION
    WHEN duplicate_object THEN NULL;
END $$;

CREATE SCHEMA IF NOT EXISTS cd AUTHORIZATION postgres;
CREATE SCHEMA IF NOT EXISTS v AUTHORIZATION postgres;

CREATE TABLE IF NOT EXISTS cd.shops (
    id SERIAL PRIMARY KEY,
    name VARCHAR(128) UNIQUE NOT NULL,
    category VARCHAR(128) NOT NULL,
    website VARCHAR(128) NOT NULL,
    email VARCHAR(128) UNIQUE,
        CONSTRAINT website_format CHECK (website ~ '^(\w|[\.-])+\.(\w)+$'),
        CONSTRAINT email_format CHECK (email ~ '^(\w|\.)+@\w+\.\w+$')
);

CREATE TABLE IF NOT EXISTS cd.clients (
    id SERIAL PRIMARY KEY,
    card_num VARCHAR(32) UNIQUE NOT NULL,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    phone VARCHAR(32) UNIQUE NOT NULL,
    email VARCHAR(128) UNIQUE,
    age INTEGER NOT NULL,
    sex VARCHAR(32) NOT NULL,
    birth_date DATE NOT NULL,
        CONSTRAINT card_num_format CHECK (card_num ~ '^([0-9]{4} ){3}[0-9]{4}$'),
        CONSTRAINT email_format CHECK (email ~ '^(\w|\.)+@\w+\.\w+$')
);

CREATE TABLE IF NOT EXISTS cd.items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    manufacturer VARCHAR(256),
    vendor_code VARCHAR(128) UNIQUE NOT NULL,
    category VARCHAR(128) NOT NULL
);

CREATE TABLE IF NOT EXISTS cd.offers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    start_dttm TIMESTAMP NOT NULL,
    expiration_dttm TIMESTAMP NOT NULL,
    status BOOLEAN NOT NULL
);

CREATE TABLE IF NOT EXISTS cd.transactions (
    id SERIAL PRIMARY KEY,
    client_id INTEGER,
    type TRANS_TYPE NOT NULL,
    total_bonuses FLOAT NOT NULL,
    time TIMESTAMP NOT NULL,
    status TRANS_STATUS NOT NULL,
        FOREIGN KEY (client_id) REFERENCES cd.clients(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS cd.clients_history (
    client_id INTEGER,
    event_dttm TIMESTAMP NOT NULL,
    event_type HISTORY_EVENT_TYPE NOT NULL,
        FOREIGN KEY (client_id) REFERENCES cd.clients(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS cd.clients_wallet (
    client_id INTEGER,
    balance FLOAT NOT NULL DEFAULT 0,
        FOREIGN KEY (client_id) REFERENCES cd.clients(id) ON DELETE SET NULL,
        CONSTRAINT positive_balance CHECK (balance >= 0)
);

CREATE TABLE IF NOT EXISTS cd.clients_wallet_history (
    client_id INTEGER,
    transaction_id INTEGER,
    balance FLOAT NOT NULL DEFAULT 0,
    rewrite_dttm TIMESTAMP NOT NULL,
        FOREIGN KEY (client_id) REFERENCES cd.clients(id) ON DELETE SET NULL,
        FOREIGN KEY (transaction_id) REFERENCES cd.transactions(id) ON DELETE SET NULL,
        CONSTRAINT positive_balance CHECK (balance >= 0)
);

CREATE TABLE IF NOT EXISTS cd.items_info (
    item_id INTEGER,
    shop_id INTEGER,
    price FLOAT NOT NULL,
        FOREIGN KEY (item_id) REFERENCES cd.items(id) ON DELETE SET NULL,
        FOREIGN KEY (shop_id) REFERENCES cd.shops(id) ON DELETE SET NULL,
        CONSTRAINT positive_price CHECK (price > 0)
);

CREATE TABLE IF NOT EXISTS cd.offers_content (
    offer_id INTEGER,
    item_id INTEGER,
    shop_id INTEGER,
    interest FLOAT NOT NULL,
        FOREIGN KEY (offer_id) REFERENCES cd.offers(id) ON DELETE SET NULL,
        FOREIGN KEY (item_id) REFERENCES cd.items(id) ON DELETE SET NULL,
        FOREIGN KEY (shop_id) REFERENCES cd.shops(id) ON DELETE SET NULL,
        CONSTRAINT positive_interest CHECK (interest > 0)
);

CREATE TABLE IF NOT EXISTS cd.transactions_content (
    transaction_id INTEGER,
    item_id INTEGER,
    quantity INTEGER NOT NULL,
    bonus_count FLOAT NOT NULL,
        FOREIGN KEY (transaction_id) REFERENCES cd.offers(id) ON DELETE SET NULL,
        FOREIGN KEY (item_id) REFERENCES cd.items(id) ON DELETE SET NULL
);
