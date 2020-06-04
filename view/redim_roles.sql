/*
 * redim_roles
 *
 * definice dostupnych rolí (NOLOGIN) pro personální účty
 * omezeni na roli DBA
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
    and r.rolsuper = 'f'      -- neni to Superuser role (dba)
    and r.rolname !~ '^pg_'
;
