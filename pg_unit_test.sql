/*
 *  Script to test basic Postgres REDIM API calls
 *
 *  psql -h vip-dev-pgi -U redim -d postgres
 */

SET SEARCH_PATH TO "redim";

DO language plpgsql $$
DECLARE
  -- testovaci user a grant testovaci role
  v_user varchar := 'cen12345';
  v_role varchar := 'csconnect';
BEGIN
  RAISE NOTICE 'version %s', get_version();
END
$$;

SELECT role_name, role_desc FROM REDIM_ROLES;

SELECT USERNAME, TEMPLATE_NAME, IS_SSO, IS_OPEN, LAST_LOGIN
  FROM REDIM_USERS WHERE username = 'cen12345';

SELECT role_name, role_desc, database_name, '' AS area_id
FROM REDIM_USER_ROLES
WHERE username = 'cen12345';

/*
prompt Create/Drop role
--
BEGIN
  -- create role
  redim.create_role(
      p_role_name => :role,
      p_role_desc => 'Aplikační role');

  -- update role description
  redim.alter_role(
      p_role_name => :role,
      p_role_desc => 'Aplikační role přejmenovaná');

  -- drop role
  redim.drop_role(:role);
END;
/

-- personal user
prompt Cleanup user
BEGIN redim.Remove_DB_User(:username, p_operation_type => 'drop');
  EXCEPTION WHEN OTHERS THEN NULL;
END;
/

prompt REDIM_TEMPLATES:
SELECT template_name, template_desc FROM REDIM_TEMPLATES WHERE database_name = :database_name ORDER BY template_id
/


BEGIN
  -- create personal user
  redim.create_db_user(:username, :user_pwd, 0, 'DEFAULT');
  -- Update_User_Profile SSO = True
  redim.Update_User_Profile(:username, p_sso_enabled => 1);
  -- Update_User_Profile SSO=off
  redim.Update_User_Profile(:username, :user_pwd || 'AbcD432', p_sso_enabled => 0);

  -- change template
 redim.Update_User_Profile(:username, p_template_name => 'DEFAULT');
END;
/

SELECT username, template_name, is_sso FROM REDIM_USERS
  WHERE username = :username AND database_name = :database_name;


-- RESET password
BEGIN
  redim.Reset_User_Password(:username, 'Hq9i8dw6JWHq9i8dw6JW');
END;
/


prompt Grant/Revoke APP ROLE
BEGIN
  -- GRANT ROLE
  redim.grant_role(:username,'CSCONNECT');

  -- REVOKE ROLE
  redim.revoke_role(:username,'CSCONNECT');

  -- REVOKE ROLE
  redim.grant_revoke_role(:username,'CSCONNECT', p_operation_type => 'grant');
END;
/

BEGIN
  -- LOCK s p variantou 0 / 1
  redim.remove_db_user(:username, 0);

  -- drop user personal user se string varinatou p drop
  redim.Remove_DB_User(:username, p_operation_type => 'drop');
END;
/


--
-- SQL z OracleClient.cs cmd.CommandText = ..
--


SELECT role_name, role_desc FROM REDIM_ROLES WHERE template_name = :template_name AND database_name = :database_name
/

SELECT role_name, role_desc, database_name, '' AS area_id FROM REDIM_USER_ROLES WHERE user_name = :username AND database_name = :database_name
/

SELECT ur.role_name, ur.role_desc, ur.database_name, area_id
    FROM REDIM_USER_ROLES ur LEFT JOIN REDIM_ROLES r ON ur.role_name = r.role_name
  WHERE user_name = :username AND ur.database_name = :database_name
/

*/
