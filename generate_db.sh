#!/bin/bash

# Set PostgreSQL connection parameters
PG_USER="fadi"
PG_DB="postgres"
PG_HOST="172.17.0.1"
PG_PASS_FILE="$HOME/.pgpass"  # Set the path to the .pgpass file

# Loop to generate 100 databases based on datetime
for ((i=1; i<=100000; i++)); do
  # Generate a unique database name using datetime
  db_name="db_$(date +'%Y%m%d%H%M%S')_$i"

  # Run the SQL query to create a new database
  create_db_statement="CREATE DATABASE \"$db_name\";"
  PGPASSFILE=$PG_PASS_FILE psql -U $PG_USER -d $PG_DB -h $PG_HOST -c "$create_db_statement"

  echo "Created database: $db_name"
done
