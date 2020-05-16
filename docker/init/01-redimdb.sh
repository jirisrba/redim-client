#!/bin/bash

# Immediately exits if any error occurs during the script
# execution. If not set, an error could occur and the
# script would continue its execution.
set -o errexit

# Performs the initialization in the already-started PostgreSQL
# using the preconfigured POSTGRE_USER user.
init_user() {
  psql -v ON_ERROR_STOP=1 --username "$POSTGRE_USER" -f pg_create_redim_user.sql
}

create_view() {
  psql -v ON_ERROR_STOP=1 --username "$POSTGRE_USER" -f pg_view.sql
}

create_func() {
  psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
     \i get_version.sql
     \i run_sql.sql
     \i create_db_user.sql
     \i remove_db_user.sql
     \i grant_role.sql
     \i revoke_role.sql
EOSQL
}

unit_test() {
  psql -v ON_ERROR_STOP=1 --username "$POSTGRE_USER" -f pg_unit_test.sql
}

# Main execution:
# - runs the SQL code to create user and database
# - create view and function
# - run unit test
main() {
  init_user
  create_view
  create_func
  unit_test
}

# Executes the main routine with environment variables
# passed through the command line. We don't use them in
# this script but now you know 🤓
main "$@"
