create or replace function redim.remove_db_user(
    username text,
    debug    boolean DEFAULT false)
  returns void
  language plpgsql
as $$
declare
  sql text;
begin

  -- SQL command to create user
  sql := format('DROP USER %s', quote_ident(lower(username)));

  -- pro debug pouze vypisuju prikazy, jinak ho provadim
  select run_sql(sql, debug);
end;
$$;
