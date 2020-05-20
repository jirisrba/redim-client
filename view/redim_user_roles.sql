CREATE OR REPLACE VIEW redim.redim_user_roles
AS
  SELECT
      pg_catalog.pg_get_userbyid(m.member) as username,
      r.rolname                         as role_name,
      COALESCE(c.description, 'N/A')    as role_desc
  FROM   pg_catalog.pg_auth_members m
         JOIN pg_catalog.pg_roles r ON (m.roleid = r.oid)
    LEFT JOIN pg_catalog.pg_shdescription c ON c.objoid = r.oid
;
