-- !!! Для применения этого скрипта нужно удалить папку postgres-data-source. !!!

CREATE TABLE customers (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT
);

CREATE TABLE table_a (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    correlation TEXT,
    b_id INT,
    c_id INT
);

CREATE TABLE table_b (
     id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     correlation TEXT,
     a_id INT NOT NULL,
     c_id INT
);

CREATE TABLE table_c (
     id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     correlation TEXT,
     a_id INT NOT NULL,
     b_id INT NOT NULL
);

ALTER TABLE table_a ADD CONSTRAINT fk_b_table FOREIGN KEY(b_id) REFERENCES table_b(id);
ALTER TABLE table_a ADD CONSTRAINT fk_c_table FOREIGN KEY(c_id) REFERENCES table_c(id);

ALTER TABLE table_b ADD CONSTRAINT fk_a_table FOREIGN KEY(a_id) REFERENCES table_a(id);
ALTER TABLE table_b ADD CONSTRAINT fk_c_table FOREIGN KEY(c_id) REFERENCES table_c(id);

ALTER TABLE table_c ADD CONSTRAINT fk_a_table FOREIGN KEY(a_id) REFERENCES table_a(id);
ALTER TABLE table_c ADD CONSTRAINT fk_b_table FOREIGN KEY(b_id) REFERENCES table_b(id);

CREATE TABLE sink_table_a (
                         id INT PRIMARY KEY,
                         correlation TEXT,
                         b_id INT,
                         c_id INT
);

CREATE TABLE sink_table_b (
                         id INT PRIMARY KEY,
                         correlation TEXT,
                         a_id INT NOT NULL,
                         c_id INT
);

CREATE TABLE sink_table_c (
                         id INT PRIMARY KEY,
                         correlation TEXT,
                         a_id INT NOT NULL,
                         b_id INT NOT NULL
);

ALTER TABLE sink_table_a ADD CONSTRAINT fk_b_table FOREIGN KEY(b_id) REFERENCES sink_table_b(id);
ALTER TABLE sink_table_a ADD CONSTRAINT fk_c_table FOREIGN KEY(c_id) REFERENCES sink_table_c(id);

ALTER TABLE sink_table_b ADD CONSTRAINT fk_a_table FOREIGN KEY(a_id) REFERENCES sink_table_a(id);
ALTER TABLE sink_table_b ADD CONSTRAINT fk_c_table FOREIGN KEY(c_id) REFERENCES sink_table_c(id);

ALTER TABLE sink_table_c ADD CONSTRAINT fk_a_table FOREIGN KEY(a_id) REFERENCES sink_table_a(id);
ALTER TABLE sink_table_c ADD CONSTRAINT fk_b_table FOREIGN KEY(b_id) REFERENCES sink_table_b(id);

CREATE TABLE sink_customers (
    id INT PRIMARY KEY,
    name TEXT
);

ALTER TABLE customers REPLICA IDENTITY USING INDEX customers_pkey;

INSERT INTO customers (name) VALUES ('joe'), ('bob'), ('sue');

