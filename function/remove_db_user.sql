create or replace function redim.remove_db_user(
    p_username text,
    p_operation_type text DEFAULT 'lock',  -- 0, lock / 1, drop
    debug    boolean DEFAULT false)
  returns void
  language plpgsql
  as $$
declare
  sql text;
  v_username text := lower(p_username);
begin

  -- assert lock nebo drop user
  if p_operation_type not in ('lock', 'drop') then
    RAISE EXCEPTION 'Invalid operation type';
  end if;

  /* pouze operace drop, lock nema u postgresu smysl (lock=role)  */
  if p_operation_type = 'drop' then
  -- SQL command to create user
    sql := format('DROP USER %s', quote_ident(v_username));
  else
    RAISE EXCEPTION 'Lock user is not supported';
  end if;

  -- pro debug pouze vypisuju prikazy, jinak ho provadim
  EXECUTE run_sql(sql, debug);

  RAISE NOTICE 'user % dropped', v_username;

end;
$$;
