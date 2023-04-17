CREATE SCHEMA IF NOT EXISTS cd AUTHORIZATION postgres;

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

CREATE TABLE IF NOT EXISTS cd.members (
    memid          INTEGER                NOT NULL,
    surname        CHARACTER VARYING(200) NOT NULL,
    firstname      CHARACTER VARYING(200) NOT NULL,
    address        CHARACTER VARYING(300) NOT NULL,
    zipcode        INTEGER                NOT NULL,
    telephone      CHARACTER VARYING(20)  NOT NULL,
    recommendedby  INTEGER,
    joindate       TIMESTAMP              NOT NULL,
    
    CONSTRAINT members_pk PRIMARY KEY (memid),
    
    CONSTRAINT fk_members_recommendedby FOREIGN KEY (recommendedby)
        REFERENCES cd.members(memid) ON DELETE SET NULL
);

CREATE TABLE cd.facilities (
   facid               INTEGER                NOT NULL, 
   name                CHARACTER VARYING(100) NOT NULL, 
   membercost          NUMERIC                NOT NULL, 
   guestcost           NUMERIC                NOT NULL, 
   initialoutlay       NUMERIC                NOT NULL, 
   monthlymaintenance  NUMERIC                NOT NULL, 
   
   CONSTRAINT facilities_pk PRIMARY KEY (facid)
);

CREATE TABLE cd.bookings(
   bookid     INTEGER   NOT NULL, 
   facid      INTEGER   NOT NULL, 
   memid      INTEGER   NOT NULL, 
   starttime  TIMESTAMP NOT NULL,
   slots      INTEGER   NOT NULL,
   
   CONSTRAINT bookings_pk PRIMARY KEY (bookid),
   
   CONSTRAINT fk_bookings_facid FOREIGN KEY (facid) REFERENCES cd.facilities(facid),
   
   CONSTRAINT fk_bookings_memid FOREIGN KEY (memid) REFERENCES cd.members(memid)
);

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

COPY cd.members (
    memid,
    surname,
    firstname,
    address,
    zipcode,
    telephone,
    recommendedby,
    joindate
)
FROM '/docker-entrypoint-initdb.d/members.csv'
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

COPY cd.bookings (
    bookid,
    facid,
    memid,
    starttime,
    slots
)
FROM '/docker-entrypoint-initdb.d/bookings.csv'
DELIMITER ','
CSV HEADER;