CREATE TABLE customers (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT
);

ALTER TABLE customers REPLICA IDENTITY USING INDEX customers_pkey;

INSERT INTO customers (name) VALUES ('joe'), ('bob'), ('sue');