create or replace function redim.grant_role(
    username text,
    role_name text,
    debug boolean DEFAULT false)
  returns void
  language plpgsql
as $$
declare
  sql text;
begin
  -- SQL command to change password
  sql := format(
      'GRANT %s TO %s',
      quote_ident(role_name),
      quote_ident(lower(username)));

  -- pro debug pouze vypisuju prikazy, jinak ho provadim
  select run_sql(sql, debug);
end;
$$;
