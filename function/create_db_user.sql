create or replace function redim.create_db_user(
    username text,
    password text,
    sso      boolean DEFAULT false, -- SSO enabled/disabled
    debug    boolean DEFAULT false)
  returns void
  language plpgsql
as $$
declare
  sql text;
begin
  -- SQL command to create user
  sql := format(
      'CREATE USER %s WITH PASSWORD %s',
      quote_ident(lower(username)),
      quote_literal(password));

  -- pro debug pouze vypisuju prikazy, jinak ho provadim
  select run_sql(sql, debug);
end;
$$;
