
/*
 * REDIM_USERS
 *
 * source catalog: pg_catalog.pg_user
 * kvuli zpetne kombatibilite s Oracle je spousta hodnot NULL
 *
 */

-- drop view nutny kvuli pretypovani NULL::text
drop view IF EXISTS redim.redim_users;
drop view IF EXISTS redim.redim_roles;
drop view IF EXISTS redim.redim_user_roles;
drop view IF EXISTS redim.redim_templates;


CREATE OR REPLACE VIEW redim.redim_users
AS
  SELECT
      u.usename   AS username,
      'DEFAULT'::text     AS TEMPLATE_NAME,
      NULL::text  AS PROFILE_NAME,
      0::smallint AS IS_SSO,
      1::smallint AS IS_OPEN,
      u.valuntil  AS EXPIRY_DATE,
      NULL::text  AS LOCK_DATE,
      NULL::text  AS LAST_LOGIN,
      CASE
        WHEN u.usename ~ '^[a-zA-Z]{1,3}\d{4,}$' THEN 1
        ELSE 0
      END         AS IS_CEN
  FROM
     pg_catalog.pg_user u
;

/*
 * redim_roles
 *
 * definice dostupnych rolí (NOLOGIN) pro personální účty
 * omezeni pouze na roli DBA
 */
CREATE OR REPLACE VIEW redim.redim_roles
AS
  SELECT
    r.rolname          as role_name,
    description        as role_desc,
    'DEFAULT'::text    as template_name,
    'XNA'::text        as area_id
  from
          pg_catalog.pg_roles r
    LEFT JOIN pg_catalog.pg_shdescription c ON c.objoid = r.oid
  WHERE r.rolcanlogin = 'f'
    and r.rolname !~ '^pg_'
    and r.rolname not in ('DBA')
;

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

CREATE OR REPLACE VIEW redim.redim_templates
AS
  SELECT
      0::smallint      as template_id,
      'DEFAULT'::text  as template_name,
      'DB uživatel'::text as template_desc
;
