#!/bin/bash

# Immediately exits if any error occurs during the script
# execution. If not set, an error could occur and the
# script would continue its execution.
set -o errexit

# psql connect ENV
export PGHOST=localhost
# export PGHOST=vip-dev-pgi
export PGPORT=5432
export PGDATABASE=postgres
export PGUSER=redim
export PGPASSWORD=abcd1234

# postgres 12 fix
export PGGSSENCMODE=disable


create_view() {
  psql -v ON_ERROR_STOP=1 <<-EOSQL
    \i view/redim_users.sql
    \i view/redim_roles.sql
    \i view/redim_user_roles.sql
EOSQL
}

create_func() {
  psql -v ON_ERROR_STOP=1 <<-EOSQL
     \i function/get_version.sql
     \i function/run_sql.sql
     \i function/create_db_user.sql
     \i function/update_user_profile.sql
     \i function/reset_user_password.sql
     \i function/remove_db_user.sql
     \i function/grant_role.sql
     \i function/revoke_role.sql
EOSQL
}

unit_test() {
  psql -v ON_ERROR_STOP=1 -f pg_unit_test.sql
}

# Main execution:
main() {
  create_view
  create_func
  unit_test
}

# Executes the main routine with environment variables
# passed through the command line. We don't use them in
# this script but now you know 🤓
main "$@"
