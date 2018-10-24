DROP TABLE IF EXISTS products;
CREATE TABLE products(prod TEXT, onwarehouse INTEGER, price INTEGER);
ALTER TABLE products ADD PRIMARY KEY (prod);
CREATE INDEX ON products(prod);

INSERT INTO products VALUES('чай',10,25);
INSERT INTO products VALUES('капучино',10,39);
INSERT INTO products VALUES('какао',10,23);
INSERT INTO products VALUES('шоколад',10,31);

DROP TABLE IF EXISTS User_wallet;
CREATE TABLE User_wallet(kind INTEGER, number INTEGER);
ALTER TABLE User_wallet ADD PRIMARY KEY (kind);
CREATE INDEX ON User_wallet(kind);

INSERT INTO User_wallet VALUES(10,0);
INSERT INTO User_wallet VALUES(5,0);
INSERT INTO User_wallet VALUES(2,0);
INSERT INTO User_wallet VALUES(1,0);

DROP TABLE IF EXISTS Machine_wallet;
CREATE TABLE Machine_wallet(kind INTEGER, number INTEGER);
ALTER TABLE Machine_wallet ADD PRIMARY KEY (kind);
CREATE INDEX ON Machine_wallet(kind);

INSERT INTO Machine_wallet VALUES(10,10);
INSERT INTO Machine_wallet VALUES(5,10);
INSERT INTO Machine_wallet VALUES(2,10);
INSERT INTO Machine_wallet VALUES(1,10);

DROP TABLE IF EXISTS change;
CREATE TABLE change(kind INTEGER, number INTEGER);
ALTER TABLE change ADD PRIMARY KEY (kind);
CREATE INDEX ON change(kind);

INSERT INTO change VALUES(10,0);
INSERT INTO change VALUES(5,0);
INSERT INTO change VALUES(2,0);
INSERT INTO change VALUES(1,0);