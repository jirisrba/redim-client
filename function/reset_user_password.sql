create or replace function redim.reset_user_password(
    username text,
    password text,
    debug boolean DEFAULT false)
  returns void
  language plpgsql
as $$
declare
  sql text;
  v_username text := lower(username);
begin

  -- SQL command to change password
  sql := format(
      'ALTER USER %s WITH PASSWORD %s',
      quote_ident(v_username),
      quote_literal(password));

  -- pro debug pouze vypisuju prikazy, jinak ho provadim
  select run_sql(sql, debug);

end;
$$;
