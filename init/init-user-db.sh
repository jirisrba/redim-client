#!/bin/bash
set -o errexit

# create redim user
psql -v ON_ERROR_STOP=1 \
  --username "$POSTGRE_USER" \
  --dbname "$POSTGRES_DB" \
  -f pg_create_redim_user.sql
