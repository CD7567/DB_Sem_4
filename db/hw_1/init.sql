CREATE TABLE IF NOT EXISTS hw (
    id INTEGER,
    height FLOAT4,
    weight FLOAT4
);

CREATE TABLE IF NOT EXISTS coins (
    dt VARCHAR(16),
    avg_price NUMERIC,
    tx_cnt NUMERIC,
    tx_vol NUMERIC,
    active_addr_cnt NUMERIC,
    symbol VARCHAR(8),
    full_nm VARCHAR(128),
    open_price NUMERIC,
    high_price NUMERIC,
    low_price NUMERIC,
    close_price NUMERIC,
    vol NUMERIC,
    market NUMERIC
);

CREATE TABLE IF NOT EXISTS cd.facilities (
   facid               INTEGER                NOT NULL, 
   name                CHARACTER VARYING(100) NOT NULL, 
   membercost          NUMERIC                NOT NULL, 
   guestcost           NUMERIC                NOT NULL, 
   initialoutlay       NUMERIC                NOT NULL, 
   monthlymaintenance  NUMERIC                NOT NULL
);


COPY hw (id, height, weight)
FROM '/docker-entrypoint-initdb.d/hw.csv'
DELIMITER ','
CSV HEADER;

COPY coins (
    dt,
    avg_price,
    tx_cnt,
    tx_vol,
    active_addr_cnt,
    symbol,
    full_nm,
    open_price,
    high_price,
    low_price,
    close_price,
    vol,
    market
)
FROM '/docker-entrypoint-initdb.d/coins.csv'
DELIMITER ','
CSV HEADER;

COPY cd.facilities (
    facid,
    name,
    membercost,
    guestcost,
    initialoutlay,
    monthlymaintenance
)
FROM '/docker-entrypoint-initdb.d/facilities.csv'
DELIMITER ','
CSV HEADER;