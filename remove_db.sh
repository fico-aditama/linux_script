#!/bin/bash

# Set PostgreSQL connection parameters
PG_USER="fadi"
PG_DB="postgres"
PG_HOST="172.17.0.1"
PG_PASS_FILE="$HOME/.pgpass"  # Set the path to the .pgpass file
PG_DATABASE="'postgres','odoo159','odoo159.Copy11Mar24'"

# Run the SQL query to get drop statements
drop_statements=$(PGPASSFILE=$PG_PASS_FILE psql -U $PG_USER -d $PG_DB -h $PG_HOST -t -c \
  "SELECT 'drop database \"' || datname || '\";' FROM pg_database WHERE datistemplate=false AND datname not in ($PG_DATABASE);")

# Loop through the drop statements
echo "$drop_statements" | while IFS= read -r drop_statement; do
  # Print the drop statement
  echo "$drop_statement"

  # Extract the database name from the drop statement
  db_name=$(echo "$drop_statement" | awk -F'"' '{print $2}')

  # Execute the drop statement using a separate connection
  PGPASSFILE=$PG_PASS_FILE psql -U $PG_USER -d $PG_DB -h $PG_HOST -c "$drop_statement"

  # Check if the drop statement was successful before attempting to reconnect
  if [ $? -eq 0 ]; then
    echo "Database $db_name dropped successfully."
  else
    echo "Error dropping database $db_name."
  fi
done
