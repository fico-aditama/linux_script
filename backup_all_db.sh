#!/bin/bash

# Konfigurasi database
DB_HOST="172.17.0.1"
DB_USER="root"
DB_PASSWORD="debian"
DB_NAME="smp5_slim"

# Mendapatkan daftar tabel dari database
tables=$(mysql -h $DB_HOST -u $DB_USER -p$DB_PASSWORD $DB_NAME -e "SHOW TABLES" | tail -n +2)

# Loop untuk setiap tabel
for table in $tables; do
    # Membuat dump ke file SQL
    mysqldump -h $DB_HOST -u $DB_USER -p$DB_PASSWORD $DB_NAME $table > $table.sql
    echo "Tabel $table berhasil didump ke $table.sql"
done

