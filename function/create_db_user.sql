create or replace function redim.create_db_user(
    p_username text,
    p_user_pswd text DEFAULT null,
    p_sso_enabled      char(1) DEFAULT null, -- SSO enabled/disabled
    p_template_name text DEFAULT NULL,
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
      quote_ident(lower(p_username)),
      quote_literal(p_user_pswd));

  -- pro debug pouze vypisuju prikazy, jinak ho provadim
  RAISE NOTICE 'create user %s', run_sql(sql, debug);
end;
$$;
