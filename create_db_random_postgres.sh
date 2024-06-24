#!/bin/bash

for i in {1..100}; do
    # Generate a random database name
    db_name="prefix_$i"

    # Create the database using psql
    psql -h localhost -U your_username -d postgres -c "CREATE DATABASE \"$db_name\";"
    
    # Optionally, you can perform additional actions for each database here
    
    echo "Created database: $db_name"
done


DO $$
DECLARE
    i integer := 1;
BEGIN
    WHILE i <= 100 LOOP
        -- Generate a random database name
        -- You can replace 'prefix' with your desired naming convention
        -- For example: 'db_' || i
        -- Make sure to adjust the naming logic to ensure uniqueness
        DECLARE
            db_name text := 'odoo_' || i;
        BEGIN
            -- Create the database
            EXECUTE 'CREATE DATABASE ' || quote_ident(db_name);
            
            -- Optionally, you can perform additional actions for each database here
            
            RAISE NOTICE 'Created database %', db_name;
        END;
        
        i := i + 1;
    END LOOP;
END $$;
