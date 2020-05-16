--
-- Create ROLE REDIM OWNER
--

-- CS: psql -h vip-dev-pgi -U redim -d postgres
-- docker: psql -h localhost -U redim -d postgres
-- docker-compose up

-- TODO: nahradit redim za redim_user po vzoru oracle ?

set client_min_messages = 'debug';

DROP SCHEMA IF EXISTS redim cascade;
CREATE SCHEMA redim;

-- DROP OWNED BY redim;
-- DROP ROLE IF EXISTS redim;

do $$
begin
  if not exists ( select from pg_catalog.pg_roles where rolname = 'redim' ) then
    create role redim
      with login password 'md513709be8f12250590dbaf606a8461cfd'
      CREATEROLE INHERIT
      valid until 'infinity';
    raise notice 'redim created';
  else
    raise notice 'redim is already exists';
    ALTER USER redim password 'md513709be8f12250590dbaf606a8461cfd';
  end if;
end $$;

-- setup password if create failed due to role existence


GRANT ALL ON SCHEMA redim TO redim;
GRANT ALL ON ALL TABLES IN SCHEMA redim TO redim;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA redim TO redim;
-- GRANT EXECUTE ON ALL PROCEDURES IN SCHEMA redim TO redim;  -- PG11+ only
