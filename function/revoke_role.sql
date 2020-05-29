create or replace function redim.revoke_role(
    p_username text,
    p_role_name text,
    debug boolean DEFAULT false)
  returns void
  language plpgsql
as $$
declare
  sql text;
  v_username text := lower(p_username);
begin
  -- SQL command to change password
  sql := format(
      'REVOKE %s FROM %s',
      quote_ident(p_role_name),
      quote_ident(v_username));

  -- pro debug pouze vypisuju prikazy, jinak ho provadim
  EXECUTE run_sql(sql, debug);

  RAISE NOTICE 'role % revoked from %', p_role_name, v_username;
END $$;
