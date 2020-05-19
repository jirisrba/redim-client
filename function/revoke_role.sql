create or replace function redim.revoke_role(
    p_username text,
    p_role_name text,
    debug boolean DEFAULT false)
  returns void
  language plpgsql
as $$
declare
  sql text;
begin
  -- SQL command to change password
  sql := format(
      'REVOKE %s FROM %s',
      quote_ident(p_role_name),
      quote_ident(lower(p_username)));

  -- pro debug pouze vypisuju prikazy, jinak ho provadim
  RAISE NOTICE 'revoke role %s', run_sql(sql, debug);
END $$;
