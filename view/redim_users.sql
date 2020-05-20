/*
 * REDIM_USERS
 *
 * source catalog: pg_catalog.pg_user
 * kvuli zpetne kombatibilite s Oracle je spousta hodnot NULL
 *
 */
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
