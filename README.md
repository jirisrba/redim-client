Redim pro PostgreSQL
--------------------

username: redim
schema: redim

vytvoreni uzivatele a schematu redim se provádí `pg_create_redim_user.sql`, v principu jsou zde dva SQL prikazy:

```sql
CREATE ROLE redim
      with login password 'md5...'
      CREATEROLE INHERIT;
```

```sql
CREATE SCHEMA redim;
```

## .NET driver

drivery pro přístup z redimu na postgres je použit driver

(http://www.npgsql.org/)

## INFP REDIM_DATABASES

Definice seznam databází je společně uložena v INFP (INFTA v testu) v tabulce `REDIM_DATABASES`.

Rozlišení platformy oracle/postgres je uloženo v atributu `REDIM_DATABASES.DATABASE_TYPE`.

## Detailní karta uživatele postgres

Kod je programován tak, aby byl maximálně kombatibilní s platformou oracle.

## Popis plpgsql funkcí

- CREATE_DB_USER - vytvoření postgres uživatele
- UPDATE_USER_PROFILE - implementována pouze změna hesla
- GRANT_ROLE - grant role
- REVOKE_ROLE - revoke role
