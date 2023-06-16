-- !!! Для применения этого скрипта нужно удалить папку postgres-data-source. !!!

CREATE TABLE customers (
    id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name TEXT
);

CREATE TABLE table_a (
    id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    correlation TEXT,
    b_id INT,
    c_id INT
);

CREATE TABLE table_b (
     id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
     correlation TEXT,
     a_id INT NOT NULL,
     c_id INT
);

CREATE TABLE table_c (
     id INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
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

INSERT INTO customers (name) VALUES ('joe'), ('bob'), ('sue');

CREATE OR REPLACE FUNCTION update_change_source()
    RETURNS TRIGGER AS $$
BEGIN
    IF NEW.change_source IS NULL THEN
        NEW.change_source = 'PRIMARY';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION create_change_source_triggers(schema_name text)
    RETURNS VOID AS $$
DECLARE
    tbl_name text;
BEGIN
FOR tbl_name IN SELECT table_name FROM information_schema.tables WHERE table_schema = schema_name
                                                                   AND tbl_name <> 'databasechangelog'
                                                                   AND tbl_name <> 'databasechangeloglock'
        LOOP
            EXECUTE format('ALTER TABLE %I.%I ADD COLUMN IF NOT EXISTS change_source TEXT default ''PRIMARY'';', schema_name, tbl_name);
            EXECUTE format('DROP TRIGGER IF EXISTS trigger_change_source_%s on %I.%I', tbl_name, schema_name, tbl_name);
            EXECUTE format('CREATE TRIGGER trigger_change_source_%s BEFORE INSERT OR UPDATE ON %I.%I FOR EACH ROW EXECUTE FUNCTION update_change_source()', tbl_name, schema_name, tbl_name);
        END LOOP;
END
$$ LANGUAGE plpgsql;

SELECT create_change_source_triggers('public');