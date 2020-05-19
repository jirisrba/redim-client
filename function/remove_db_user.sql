create or replace function redim.remove_db_user(
    p_username text,
    p_operation_type text DEFAULT 'lock',  -- 0, lock / 1, drop
    debug    boolean DEFAULT false)
  returns void
  language plpgsql
as $$
declare
  sql text;
begin

  /* pouze operace drop, lock nema u postgresu smysl (=role)  */
  if p_operation_type = 'drop'
  then
  -- SQL command to create user
    sql := format('DROP USER %s', quote_ident(lower(p_username)));
  end if;

  -- pro debug pouze vypisuju prikazy, jinak ho provadim
  RAISE NOTICE 'drop user %s', run_sql(sql, debug);
end;
$$;
