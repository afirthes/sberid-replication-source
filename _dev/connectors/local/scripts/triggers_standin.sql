CREATE OR REPLACE FUNCTION update_change_source()
RETURNS TRIGGER AS $$
BEGIN
IF NEW.change_source IS NULL THEN
    NEW.change_source = 'STANDIN';
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION create_change_source_triggers(schema_name text)
    RETURNS VOID AS $$
DECLARE
tbl_name text;
BEGIN
    FOR tbl_name IN SELECT table_name FROM information_schema.tables WHERE table_schema = schema_name LOOP
        EXECUTE format('ALTER TABLE %I.%I ADD COLUMN IF NOT EXISTS change_source TEXT default ''PRIMARY'';', schema_name, tbl_name);
        EXECUTE format('DROP TRIGGER IF EXISTS trigger_change_source_%s on %I.%I', tbl_name, schema_name, tbl_name);
        EXECUTE format('CREATE TRIGGER trigger_change_source_%s BEFORE INSERT OR UPDATE OR DELETE ON %I.%I FOR EACH ROW EXECUTE FUNCTION update_change_source()', tbl_name, schema_name, tbl_name);
    END LOOP;
END
$$ LANGUAGE plpgsql;

SELECT create_change_source_triggers('public');