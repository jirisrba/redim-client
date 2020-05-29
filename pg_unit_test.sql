/*
 *  Script to test basic Postgres REDIM API calls
 *
 *  psql -h vip-dev-pgi -U redim -d postgres
 */

SET SEARCH_PATH TO "redim";

\set p_username 'cen12345'
\set p_role_name 'csconnect'

DO language plpgsql $$
BEGIN
  RAISE NOTICE 'version %', get_version();
END $$;

-- create role csconnect
DO language plpgsql $$
begin
  create role csconnect nologin;
  exception
  when others then raise notice 'role already exists';
end $$;

-- cleanup test user
DO language plpgsql $$
declare
  p_username text := 'cen12345';
  p_user_pswd text := 'abcd1234';
begin
  begin
    RAISE NOTICE '%', remove_db_user(p_username, 'drop');
    exception
      when others then raise notice 'user not exists';
  end;

  begin
    -- create personal user
    RAISE NOTICE '%', create_db_user(p_username, p_user_pswd, '0', 'DEFAULT');

    -- Update_User_Profile SSO=off
    RAISE NOTICE '%', update_user_profile(p_username, p_user_pswd => 'AbcD4321'::text, p_sso_enabled => '0'::char(1));

    -- change template
    RAISE NOTICE '%', update_user_profile(p_username, p_template_name => 'DEFAULT');

    -- RESET password
    RAISE NOTICE '%', reset_user_password(p_username, 'Hq9i8dw6JWHq9i8dw6JW'::text);

  end;
end $$;

SELECT role_name, role_desc FROM REDIM_ROLES;

SELECT USERNAME, TEMPLATE_NAME, IS_SSO, IS_OPEN, LAST_LOGIN
  FROM REDIM_USERS WHERE username = :'p_username';

SELECT role_name, role_desc, '' AS area_id
  FROM REDIM_USER_ROLES WHERE username = :'p_username';


-- test grant revoke
DO language plpgsql $$
declare
  p_username text := 'cen12345';
begin
  -- GRANT role
  RAISE NOTICE '%', grant_role(p_username,'csconnect');

  -- REVOKE ROLE
  RAISE NOTICE '%', revoke_role(p_username,'csconnect');
end $$;

--cleanup
DO language plpgsql $$
declare
  p_username text := 'cen12345';
begin
  -- drop user personal user se string varinatou p drop
  RAISE NOTICE '%', remove_db_user(p_username, 'drop');
  exception
  when others then raise notice 'user not exists';
end $$;
