create or replace function redim.reset_user_password(
    p_username text,
    p_user_pswd text,
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
      'ALTER USER %s WITH PASSWORD %s',
      quote_ident(v_username),
      quote_literal(p_user_pswd));

  -- pro debug pouze vypisuju prikazy, jinak ho provadim
    EXECUTE run_sql(sql, debug);

    RAISE NOTICE '% password changed', v_username;

end;
$$;
