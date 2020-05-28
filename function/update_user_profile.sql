create or replace function redim.update_user_profile(
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

  -- SSO on
  if p_sso_enabled = '1' then
    RAISE EXCEPTION 'This SSO is not implemented';
  end if;

  if p_user_pswd is not null then
    sql := format(
        'ALTER USER %s WITH PASSWORD %s',
        quote_ident(lower(p_username)),
        quote_literal(p_user_pswd));

    -- pro debug pouze vypisuju prikazy, jinak ho provadim
    EXECUTE run_sql(sql, debug);
  end if;

end;
$$;
