drop function IF EXISTS redim.get_version();

create or replace function redim.get_version()
  returns varchar
  language plpgsql
  as $$
declare

  v_version text := 'v2020-05-29';

begin

   return v_version;

end;
$$;
