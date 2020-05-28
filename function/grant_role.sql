create or replace function redim.grant_role(
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
  sql := format('GRANT %s TO %s',
            quote_ident(p_role_name),
            quote_ident(lower(p_username)));

  -- pro debug pouze vypisuju prikazy, jinak ho provadim
  EXECUTE run_sql(sql, debug);
end;
$$;
