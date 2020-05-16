drop function IF EXISTS redim.get_version();

create or replace function redim.get_version()
  returns varchar
language plpgsql
as $$
declare
  v_ver_major integer := 20;
  v_ver_minor integer := 05;
begin
   return v_ver_major||'.'||v_ver_minor;
end;
$$;
