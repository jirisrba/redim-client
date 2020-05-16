// FIXME: create procedure mozno az od verze 11

CREATE PROCEDURE redim.run_sql (
    sql_text text,
    debug boolean DEFAULT false)
  LANGUAGE plpgsql
AS $$
BEGIN
  -- execute SQL
  IF debug = true THEN
    RAISE DEBUG 'sql: %', sql_text;
  ELSE
    EXECUTE sql_text;
  END IF;

END;
$$;
